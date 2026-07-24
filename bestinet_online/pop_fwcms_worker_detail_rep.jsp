<%@ page language="java" import="java.util.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="FWCMSOnline" scope="page" class="com.rexit.easc.FWCMSOnline" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />
<%--
    ════════════════════════════════════════════════════════════════════
    pop_fwcms_worker_detail_rep.jsp — data-handling endpoint for the FWCMS
    worker-detail page (pop_fwcms_worker_detail.jsp).

    The worker-detail page is a pure view: it reads session state and renders
    the merged FWIG/FWHS worker tables, the premium summary and the
    immigration-branch dropdown, but persists nothing itself. When the agent
    ticks the declaration and clicks "Make Payment", the page POSTs here FIRST
    (an AJAX call), and only on this handler's "OK" does it redirect to the
    payment page.

    This endpoint now writes ONLY tracking state — it does NOT generate the
    insurance quotation. Under the business rule, the quotation (the FWCMS
    main / "class" tables) is created only AFTER payment succeeds; that step
    moved to pop_fwcms_generate_quotation.jsp, invoked from
    pop_fwcms_payment_result.jsp on payment SUCCESS.

    What still happens here (BEFORE the payment gateway):

      Immigration branch — when the Bestinet enquiry carried no immigration
         branch (blank / "N/A"), the worker-detail page shows a required
         dropdown of the master list (TB_FWCMS_CODE TYPE='IMMI_CODE'). The
         chosen branch code (its MAPPING_CODE) is submitted as the "immi"
         parameter; here it is resolved to a description (and, when available,
         the G7 office mailing address from TYPE='IMMI_ADDRESS') and stamped
         onto the journey's TB_FWCMS_ONLINE row. This must be captured before
         payment so the branch is available when the FWIG quotation tables are
         generated post-payment (the Guarantee Letter's addressee reads
         IMMI_DESCP / IMMI_ADDRESS from that row).

    Response body (plain text, read by the caller's AJAX handler):
        OK      — safe to proceed to the payment page
        LOGOUT  — no valid session; caller should redirect to logout
    Persistence failures are non-blocking (logged, then "OK") so a data-write
    hiccup never traps the agent on the worker-detail page.
    ════════════════════════════════════════════════════════════════════
--%>
<%
    String SESUSERID  = common.setNullToString((String) session.getAttribute("SESUSERID"));
    if (SESUSERID.equals("")) {
        out.print("LOGOUT");
        return;
    }

    String FWCMS_UUID = common.setNullToString((String) session.getAttribute("SES_FWCMS_ONLINE_UUID"));

    /* Selected immigration branch (MAPPING_CODE) from the worker-detail
       dropdown. Blank when the submission carries no FWIG product, or when
       Bestinet already supplied a branch and the agent left it unchanged and
       the field was not required — either way there is simply nothing to
       re-stamp. */
    String immiCode = common.setNullToString(request.getParameter("immi")).trim();
    if (immiCode.equalsIgnoreCase("N/A")) immiCode = "";

    /* FWCMS principle — '08' across the portal (see the printing modules). */
    final String INSCODE = "08";

    if (!FWCMS_UUID.equals("")) {
        try {
            FWCMSOnline.makeConnection();

            /* ── 1. Persist the chosen immigration branch (if any) ──────────
               Resolve the branch description from the master list already in
               session (SES_IMMI_LIST: Vector of String[]{ MAPPING_CODE, DESCP }),
               falling back to a direct lookup. The G7 mailing address is
               resolved separately from TYPE='IMMI_ADDRESS'; both writes are
               best-effort and never block the flow. */
            if (!immiCode.equals("")) {
                /* Validate the submitted code against the master list already in
                   session and take its description from there. Only a code that
                   matches a known branch is accepted, so the raw-SQL address
                   lookup below never sees arbitrary POST input. */
                String immiDescp = "";
                boolean immiKnown = false;
                Vector vImmiList = (Vector) session.getAttribute("SES_IMMI_LIST");
                if (vImmiList != null) {
                    for (int i = 0; i < vImmiList.size(); i++) {
                        String[] branch = (String[]) vImmiList.elementAt(i);
                        if (branch != null && branch.length >= 2
                                && immiCode.equals(common.setNullToString(branch[0]))) {
                            immiDescp = common.setNullToString(branch[1]);
                            immiKnown = true;
                            break;
                        }
                    }
                }

                if (immiKnown) {
                    /* G7 office mailing address for the Guarantee Letter's
                       addressee (TYPE='IMMI_ADDRESS', CODE = the branch code);
                       best-effort — absent in environments not seeded for G7,
                       where the FWIG print falls back to IMMI_DESCP. */
                    String immiAddress = "";
                    try {
                        String sql = "SELECT DESCP FROM TB_FWCMS_CODE WHERE INSCODE='" + INSCODE
                                   + "' AND CODE='" + immiCode + "' AND TYPE='IMMI_ADDRESS' WITH UR";
                        DB_Contact.makeConnection();
                        DB_Contact.executeQuery(sql);
                        while (DB_Contact.getNextQuery()) {
                            immiAddress = common.setNullToString(DB_Contact.getColumnString("DESCP"));
                        }
                    } catch (Exception exAddr) {
                        System.out.println("[FWCMSPRINT] UUID=" + FWCMS_UUID
                            + " stage=immi-address-lookup FAILED: " + exAddr.getMessage());
                    } finally {
                        DB_Contact.takeDown();
                    }

                    FWCMSOnline.updateFWCMSONLINETRANSImmi(immiCode, immiDescp, SESUSERID, FWCMS_UUID);
                    if (!immiAddress.equals("")) {
                        FWCMSOnline.updateFWCMSONLINETRANSImmiAddress(immiAddress, SESUSERID, FWCMS_UUID);
                    }
                    System.out.println("[FWCMSPRINT] UUID=" + FWCMS_UUID
                        + " stage=immi-stamp IMMI_CODE=" + immiCode + " IMMI_DESCP=" + immiDescp);
                } else {
                    System.out.println("[FWCMSPRINT] UUID=" + FWCMS_UUID
                        + " stage=immi-stamp SKIPPED - submitted branch not in master list: " + immiCode);
                }
            }

            /* ── 2. Quotation generation moved to AFTER payment ─────────────
               The insurance quotation (the FWCMS main / "class" tables) is NO
               LONGER generated here. Per the business rule, quotation records
               must be created only after payment succeeds, so issuance now runs
               post-payment in pop_fwcms_generate_quotation.jsp (invoked from
               pop_fwcms_payment_result.jsp on payment SUCCESS). This endpoint
               keeps ONLY the TB_FWCMS_ONLINE tracking write above (the chosen
               immigration branch), which must be captured before payment so it
               flows into the FWIG quotation tables at generation time. */
        } catch (Exception ex) {
            System.out.println("[FWCMSPRINT] UUID=" + FWCMS_UUID + " stage=worker-detail-rep FAILED");
            ex.printStackTrace();
        } finally {
            FWCMSOnline.takeDown();
        }
    }

    out.print("OK");
%>
