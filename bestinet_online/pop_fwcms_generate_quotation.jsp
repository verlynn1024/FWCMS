<%@ page language="java" import="java.util.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="FWCMSOnline" scope="page" class="com.rexit.easc.FWCMSOnline" />
<jsp:useBean id="FWCMSQuotation" scope="page" class="com.rexit.easc.FWCMSQuotation" />
<%--
    ════════════════════════════════════════════════════════════════════
    pop_fwcms_generate_quotation.jsp — dedicated post-payment quotation
    generation endpoint.

    This is the ONE place the FWCMS insurance quotation is created, and it
    runs ONLY after payment has succeeded (the new business rule). It replaces
    the pre-payment issuance that used to run in
    pop_fwcms_worker_detail_rep.jsp before the payment gateway.

    Responsibilities (all delegated to the FWCMSQuotation controller, which
    reuses the legacy DB_FWIG / DB_FWHS issuance logic — no new class-table
    SQL is written here):

      1. Generate the quotation number  — reusable running number Q00001…
                                           (DB_RunningNo / TB_RUNNING_NO)
      2. Generate the cover-note number — reused legacy generators
                                           (DB_FWIG.getFWorkerNo / DB_FWHS.getREFNO)
      3. Insert all quotation tables    — FWIG: TB_TRANSACTION, TB_FWIGCN,
                                           TB_FWIGMAST, TB_FWIGSCH
                                           FWHS: TB_TRANSACTION, TB_FWHSCN,
                                           TB_FWHSSCH, TB_FWHSITEM
                                           (one commit / rollback per product)
      4. Return the generated quotation information.

    Guard: the journey's payment must be confirmed (TB_FWCMS_ONLINE
    PAYMENT_STATUS='PAID') before anything is generated, so a quotation is
    never created for an unpaid journey even if this endpoint is hit directly.
    Generation is idempotent (products already issued with a real, non-MCK
    cover note are skipped), so a reload or a duplicate gateway callback never
    double-inserts.

    Invocation:
      - pop_fwcms_payment_result.jsp calls the FWCMSQuotation bean directly on
        payment success (the recommended in-process invocation point);
      - a real payment-gateway callback may instead hit this endpoint over
        HTTP once it has stamped the payment PAID — both converge on the same
        FWCMSQuotation.generateQuotation logic.

    Response body (plain text):
        OK <n>   — n product quotation(s) generated / already present
        NOPAY    — payment not confirmed; nothing generated
        NOUUID   — no journey in session
        LOGOUT   — no valid session
        ERROR    — generation failed (details in the server log)
    ════════════════════════════════════════════════════════════════════
--%>
<%
    String SESUSERID  = common.setNullToString((String) session.getAttribute("SESUSERID"));
    if (SESUSERID.equals("")) {
        out.print("LOGOUT");
        return;
    }

    String FWCMS_UUID = common.setNullToString((String) session.getAttribute("SES_FWCMS_ONLINE_UUID"));
    if (FWCMS_UUID.equals("")) {
        out.print("NOUUID");
        return;
    }

    try {
        /* ── Payment guard — quotation only after a confirmed payment ──── */
        FWCMSOnline.makeConnection();
        java.util.Hashtable htTXN = FWCMSOnline.getFWCMSONLINETRANS(FWCMS_UUID);
        boolean bPaid = htTXN != null && "PAID".equals((String) htTXN.get("PAYMENT_STATUS"));
        FWCMSOnline.takeDown();

        if (!bPaid) {
            System.out.println("[FWCMSQUOT] UUID=" + FWCMS_UUID
                + " stage=generate-quotation SKIPPED - payment not confirmed");
            out.print("NOPAY");
            return;
        }

        /* ── Generate (idempotent) ─────────────────────────────────────── */
        java.util.ArrayList alQuotations = FWCMSQuotation.generateQuotation(FWCMS_UUID, SESUSERID);
        System.out.println("[FWCMSQUOT] UUID=" + FWCMS_UUID
            + " stage=generate-quotation DONE - " + alQuotations.size() + " product(s)");

        out.print("OK " + alQuotations.size());
    } catch (Exception ex) {
        System.out.println("[FWCMSQUOT] UUID=" + FWCMS_UUID + " stage=generate-quotation FAILED");
        ex.printStackTrace();
        out.print("ERROR");
    }
%>
