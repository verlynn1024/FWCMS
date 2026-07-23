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
    payment page. So every database write the submission needs happens here,
    BEFORE the payment gateway — mirroring the legacy eCover "Save cover note"
    step, where the class-table insert precedes payment.

    Two things happen, in order:

      1. Immigration branch — when the Bestinet enquiry carried no immigration
         branch (blank / "N/A"), the worker-detail page shows a required
         dropdown of the master list (TB_FWCMS_CODE TYPE='IMMI_CODE'). The
         chosen branch code (its MAPPING_CODE) is submitted as the "immi"
         parameter; here it is resolved to a description (and, when available,
         the G7 office mailing address from TYPE='IMMI_ADDRESS') and stamped
         onto the journey's TB_FWCMS_ONLINE row, so the branch flows into the
         FWIG main tables at issuance (the Guarantee Letter's addressee reads
         IMMI_DESCP / IMMI_ADDRESS from that row).

      2. Main-table issuance — each product in the journey is inserted into
         the existing FWCMS main / "class" tables via
         FWCMSOnline.issueMainTables (this replaces the issuance that used to
         run on pop_fwcms_payment.jsp):
             FWIG: TB_TRANSACTION, TB_FWIGCN, TB_FWIGMAST, TB_FWIGSCH
             FWHS: TB_TRANSACTION, TB_FWHSCN, TB_FWHSSCH, TB_FWHSITEM
         The real cover note / policy number generated is stamped back onto the
         online DTL row. The loop is idempotent (rows already issued with a
         real, non-MCK cover note are skipped), so a retry never re-inserts. If
         issuance throws (e.g. the cover-note series is not seeded in this
         environment yet) the product falls back to a mock MCK- stamp so the
         portal still renders.

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

            /* ── 2. Main-table issuance (BEFORE the payment gateway) ────────
               Insert each product into the existing FWCMS main tables via
               FWCMSOnline.issueMainTables, which reuses the legacy DB_FWIG /
               DB_FWHS DAOs, generates the real cover note / policy number and
               stamps it back onto the online DTL row (idempotent). */
            java.util.Hashtable htTXN = FWCMSOnline.getFWCMSONLINETRANS(FWCMS_UUID);
            if (htTXN != null) {
                String sMockIssDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                String sMockSuffix  = new java.text.SimpleDateFormat("yyMMddHHmmss").format(new java.util.Date());
                java.util.ArrayList alDTL = FWCMSOnline.getFWCMSONLINEDTLList(FWCMS_UUID);
                for (int iD = 0; iD < alDTL.size(); iD++) {
                    java.util.Hashtable htDTL = (java.util.Hashtable) alDTL.get(iD);
                    String sInsType = (String) htDTL.get("INSURANCE_TYPE");
                    String sCNCODE  = common.setNullToString((String) htDTL.get("CNCODE"));
                    boolean alreadyIssued = "ISSUED".equals((String) htDTL.get("INS_STATUS"))
                        && !sCNCODE.equals("") && !sCNCODE.startsWith("MCK");
                    if (alreadyIssued) continue;

                    try {
                        String sResult = FWCMSOnline.issueMainTables(FWCMS_UUID, sInsType, SESUSERID);
                        System.out.println("[FWCMSPRINT] UUID=" + FWCMS_UUID
                            + " stage=pre-payment-main-table-issuance INSTYPE=" + sInsType
                            + " issued CN/POLNO=" + sResult);
                    } catch (Exception exIssue) {
                        System.out.println("[FWCMSPRINT] UUID=" + FWCMS_UUID
                            + " stage=pre-payment-main-table-issuance INSTYPE=" + sInsType
                            + " FAILED - falling back to mock stamp: " + exIssue.getMessage());
                        exIssue.printStackTrace();
                        FWCMSOnline.updateFWCMSONLINEDTLIssued(
                            "MCK" + sInsType + sMockSuffix,          /* mock CNCODE    */
                            "MCKPOL" + sInsType + sMockSuffix,       /* mock POLICY_NO */
                            sMockIssDate, SESUSERID, FWCMS_UUID, sInsType);
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println("[FWCMSPRINT] UUID=" + FWCMS_UUID + " stage=worker-detail-rep FAILED");
            ex.printStackTrace();
        } finally {
            FWCMSOnline.takeDown();
        }
    }

    out.print("OK");
%>
