<%-- ============================================================
     pop_fwcms_issue_quotation.jsp
     Liberty Insurance Bestinet Online Portal

     POST-PAYMENT QUOTATION ISSUANCE — the FWCMS main-table
     ("class" table) issue-quotation call.

     Runs ONLY after a successful payment. For every product of the
     journey it issues the quotation into the FWCMS main tables
     (TB_TRANSACTION, TB_FWIGCN/MAST/SCH, TB_FWHSCN/SCH/ITEM) and
     generates its quotation cover-note number (CNCODE) by driving the
     legacy DAOs FWIG.java (DB_FWIG) and FWHS.java (DB_FWHS) through the
     FWCMSOnline controller (which holds them as beans). The cover-note
     number is produced by the EASCManager float generator both DAOs
     inherit —
         DB_FWHS.getCoverNoteFloat2(PRINCIPLE, ACCODE, "SAVE", "4", "FWHS")
         DB_FWIG.getCoverNoteFloat2(PRINCIPLE, ACCODE, "SAVE", "4", "FWIG")
     (TB_NON_FLOAT_TRANS float + TB_KIMB_NMRUNNO running number) — the
     same quotation cover-note number the legacy quotation preview flow
     (pop_quoFWHS_pdfpreview_rep.jsp) generates.

     Designed to be <jsp:include>d from pop_fwcms_payment_result.jsp
     AFTER the payment PAID stamp: it shares request/session, emits no
     markup, and manages its own DB connection. The journey UUID and
     acting user are read from the session (same source the result page
     uses), so nothing needs to be passed in.

     Idempotent: a product already issued with a real (non-MCK) cover
     note is skipped, so a page reload never re-issues or re-numbers.
     If issuance throws (e.g. the float / running-number rows are not
     seeded in this environment) the product falls back to an MCK- mock
     stamp so the portal still renders; the MCK- prefix makes fallbacks
     easy to find and purge.
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="commonIQ"     scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="FWCMSOnlineIQ" scope="page" class="com.rexit.easc.FWCMSOnline" />
<%
    /* Acting user + journey UUID — same session keys the result page reads. */
    String IQ_USERID = commonIQ.setNullToString((String) session.getAttribute("SESUSERID"));
    String IQ_UUID   = commonIQ.setNullToString((String) session.getAttribute("SES_FWCMS_ONLINE_UUID"));

    if (!IQ_UUID.equals(""))
    {
        try
        {
            FWCMSOnlineIQ.makeConnection();
            java.util.Hashtable htTXNiq = FWCMSOnlineIQ.getFWCMSONLINETRANS(IQ_UUID);

            if (htTXNiq != null)
            {
                String sIssDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                String sSuffix  = new java.text.SimpleDateFormat("yyMMddHHmmss").format(new java.util.Date());

                /* ── issue every product's quotation into the main tables ── */
                java.util.ArrayList alDTLiq = FWCMSOnlineIQ.getFWCMSONLINEDTLList(IQ_UUID);
                for (int iD = 0; iD < alDTLiq.size(); iD++)
                {
                    java.util.Hashtable htDTLiq = (java.util.Hashtable) alDTLiq.get(iD);
                    String sInsType = (String) htDTLiq.get("INSURANCE_TYPE");   /* I = FWIG, H = FWHS */
                    String sCNCODE  = commonIQ.setNullToString((String) htDTLiq.get("CNCODE"));

                    boolean alreadyIssued = "ISSUED".equals((String) htDTLiq.get("INS_STATUS"))
                        && !sCNCODE.equals("") && !sCNCODE.startsWith("MCK");
                    if (alreadyIssued) continue;

                    try {
                        /* issueMainTables drives FWIG.java / FWHS.java (DB_FWIG /
                           DB_FWHS) — inserts the class-table rows, generates the
                           quotation cover-note number via getCoverNoteFloat2 and
                           stamps it back onto the online DTL row. */
                        String sResult = FWCMSOnlineIQ.issueMainTables(IQ_UUID, sInsType, IQ_USERID);
                        System.out.println("[FWCMSPRINT] UUID=" + IQ_UUID
                            + " stage=post-payment-quotation-issuance INSTYPE=" + sInsType
                            + " issued quotation CN=" + sResult);
                    } catch (Exception exIssue) {
                        System.out.println("[FWCMSPRINT] UUID=" + IQ_UUID
                            + " stage=post-payment-quotation-issuance INSTYPE=" + sInsType
                            + " FAILED - falling back to mock stamp: " + exIssue.getMessage());
                        exIssue.printStackTrace();
                        FWCMSOnlineIQ.updateFWCMSONLINEDTLIssued(
                            "MCK" + sInsType + sSuffix,        /* mock CNCODE    */
                            "MCKPOL" + sInsType + sSuffix,     /* mock POLICY_NO */
                            sIssDate, IQ_USERID, IQ_UUID, sInsType);
                    }
                }

                /* ── close the journey once the products exist and payment is
                   confirmed: TRANS_STATUS='S' / PURCHASE_STATUS='ISSUED' ── */
                java.util.ArrayList alDTLdone = FWCMSOnlineIQ.getFWCMSONLINEDTLList(IQ_UUID);
                boolean bAllIssued = alDTLdone.size() > 0;
                if (bAllIssued && !"S".equals((String) htTXNiq.get("TRANS_STATUS")))
                {
                    FWCMSOnlineIQ.updateFWCMSONLINETRANSStatus("S", "ISSUED", IQ_USERID, IQ_UUID);
                }
            }
        }
        catch (Exception exIQ)
        {
            System.out.println("[FWCMSPRINT] UUID=" + IQ_UUID
                + " stage=post-payment-quotation-issuance FAILED");
            exIQ.printStackTrace();
        }
        finally
        {
            FWCMSOnlineIQ.takeDown();
        }
    }
%>
