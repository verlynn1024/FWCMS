package com.rexit.easc;

import java.util.*;
import java.text.*;

/**
 * FWCMSQuotation — post-payment quotation generator (thin controller).
 *
 * Business rule: an insurance quotation (the FWCMS "class" tables) must be
 * created ONLY after payment has succeeded. This bean is the single place
 * that generation happens; it is invoked from the payment-result / gateway
 * callback path once payment is confirmed (see pop_fwcms_generate_quotation.jsp
 * and pop_fwcms_payment_result.jsp).
 *
 * It adds NO class-table SQL of its own. For each product in a journey it:
 *   1. generates the quotation number — a reusable running number Q00001…
 *      via DB_RunningNo (replacing the old ITR-with-"-0*"-suffix scheme);
 *   2. generates the cover-note number and inserts every quotation table by
 *      delegating to the existing legacy issuance logic in FWCMSOnline
 *      (issueMainTables -> DB_FWIG / DB_FWHS), which already reuses the
 *      legacy cover-note generators (DB_FWIG.getFWorkerNo for FWIG, the
 *      equivalent DB_FWHS.getREFNO for FWHS) and commits/rolls back all of a
 *      product's inserts as one transaction;
 *   3. returns the generated quotation information for display.
 *
 * The TB_FWCMS_ONLINE* tracking tables and the UUID linkage are untouched —
 * they were already written when the user entered from Bestinet.
 */
public class FWCMSQuotation {

	public FWCMSQuotation(){
	}

	private common comm = new common();

	/* Running-number series backing the FWCMS quotation reference (Q00001…).
	   INSCODE 08 is the portal principal; a single global SERIES gives every
	   quotation its own number regardless of product/journey. */
	public  static final String QREF_INSCODE = "08";
	public  static final String QREF_SERIES  = "FWCMSQREF";
	public  static final String QREF_PREFIX  = "Q";
	public  static final int    QREF_WIDTH   = 5;

	private SimpleDateFormat fmtDb   = new SimpleDateFormat("yyyyMMdd");
	private SimpleDateFormat fmtDisp = new SimpleDateFormat("dd MMM yyyy");

	/**
	 * Generate the quotation records for every product in a journey.
	 *
	 * Idempotent: a product already carrying a real (non-MCK) class-table key
	 * is not re-issued — its existing quotation is returned — so a reload or a
	 * duplicate gateway callback never double-inserts or burns a second
	 * quotation number for that product.
	 *
	 * @return an ArrayList of Hashtable rows, one per product, each with
	 *         CLASS, INSURANCE_TYPE, QUOTATION_NO, CNCODE, POLNO, PERIOD.
	 */
	public ArrayList generateQuotation(String UUID, String USERID) throws Exception {

		ArrayList alQuotations = new ArrayList();
		if (UUID == null || UUID.trim().equals("")) return alQuotations;

		FWCMSOnline online = new FWCMSOnline();
		DB_RunningNo runno = new DB_RunningNo();

		try {
			online.makeConnection();

			Hashtable htTXN = online.getFWCMSONLINETRANS(UUID);
			if (htTXN == null) {
				throw new Exception("generateQuotation: journey not found UUID=" + UUID);
			}

			ArrayList alDTL = online.getFWCMSONLINEDTLList(UUID);
			for (int i = 0; i < alDTL.size(); i++) {
				Hashtable htDTL = (Hashtable) alDTL.get(i);
				String sInsType = comm.setNullToString((String) htDTL.get("INSURANCE_TYPE"));
				String sCNCODE  = comm.setNullToString((String) htDTL.get("CNCODE"));

				boolean alreadyIssued = "ISSUED".equals((String) htDTL.get("INS_STATUS"))
						&& !sCNCODE.equals("") && !sCNCODE.startsWith("MCK");

				String sUKEY;
				String sQREF;
				if (alreadyIssued) {
					/* already generated on an earlier confirmed payment */
					sUKEY = sCNCODE;
					sQREF = readQuotationRef(online, sInsType, sUKEY);
					System.out.println("[FWCMSQUOT] UUID=" + UUID + " INSTYPE=" + sInsType
						+ " stage=already-issued CNCODE=" + sUKEY + " QUOTNO=" + sQREF);
				} else {
					/* 1. quotation number — reusable running number Q00001… */
					sQREF = runno.nextCommitted(QREF_INSCODE, QREF_SERIES, QREF_PREFIX, QREF_WIDTH);
					/* 2. cover-note number + all quotation-table inserts (reused
					      legacy logic; one commit / rollback per product) */
					sUKEY = online.issueMainTables(UUID, sInsType, USERID, sQREF);
					System.out.println("[FWCMSQUOT] UUID=" + UUID + " INSTYPE=" + sInsType
						+ " stage=generated QUOTNO=" + sQREF + " CNCODE=" + sUKEY);
				}

				alQuotations.add(buildInfo(online, sInsType, sUKEY, sQREF));
			}
		} finally {
			online.takeDown();
		}

		return alQuotations;
	}

	/* Assemble the display row for one generated product, reading the issued
	   cover note / policy number and period of cover back from the class
	   tables through the same reads the printing module uses. */
	private Hashtable buildInfo(FWCMSOnline online, String sInsType, String sUKEY, String sQREF) throws Exception {
		Hashtable htPol = sInsType.equals("I")
			? online.getFWIGPrintData(sUKEY)
			: online.getFWHSPrintData(sUKEY);

		Hashtable htRow = new Hashtable();
		htRow.put("CLASS",          sInsType.equals("I") ? "FWIG" : "FWHS");
		htRow.put("INSURANCE_TYPE", sInsType);
		htRow.put("QUOTATION_NO",   comm.setNullToString(sQREF));
		htRow.put("CNCODE", htPol == null ? comm.setNullToString(sUKEY)
										  : comm.setNullToString((String) htPol.get("CNCODE")));
		htRow.put("POLNO",  htPol == null ? "" : comm.setNullToString((String) htPol.get("POLNO")));
		htRow.put("PERIOD", htPol == null ? "" : formatPeriod(htPol));
		return htRow;
	}

	/* Recover the quotation reference already stored on an issued product
	   (TB_FWIGSCH / TB_FWHSSCH FWCMSREFNO) for the idempotent path. */
	private String readQuotationRef(FWCMSOnline online, String sInsType, String sUKEY) throws Exception {
		Hashtable htPol = sInsType.equals("I")
			? online.getFWIGPrintData(sUKEY)
			: online.getFWHSPrintData(sUKEY);
		return htPol == null ? "" : comm.setNullToString((String) htPol.get("FWCMSREFNO"));
	}

	/* "dd MMM yyyy – dd MMM yyyy" from the CHAR(8) yyyyMMdd cover period. */
	private String formatPeriod(Hashtable htPol) {
		try {
			String sEff = comm.setNullToString((String) htPol.get("EFFDATE"));
			String sExp = comm.setNullToString((String) htPol.get("EXPDATE"));
			if (!sEff.equals("") && !sExp.equals("")) {
				return fmtDisp.format(fmtDb.parse(sEff)) + " – " + fmtDisp.format(fmtDb.parse(sExp));
			}
		} catch (Exception ignore) {}
		return "";
	}
}
