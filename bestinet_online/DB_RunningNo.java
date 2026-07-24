package com.rexit.easc;

import java.sql.*;

/**
 * DB_RunningNo — reusable running-number generator.
 *
 * A single, generic sequence generator so callers no longer have to invent a
 * per-feature numbering scheme (e.g. appending "-01" / "-02" to an ITR number
 * to distinguish the products under one enquiry). Each series is a row in
 * TB_RUNNING_NO keyed by (INSCODE, SERIES); the row is read and incremented
 * under a FOR UPDATE lock so concurrent callers never collide, and it is
 * auto-seeded (INSERT … RUNNO=1) on first use, so no manual seeding is needed
 * for a fresh series.
 *
 * The number is formatted as PREFIX + zero-padded(counter), so
 *     next("08", "FWCMSQREF", "Q", 5)  ->  Q00001, Q00002, …
 *
 * This mirrors the locking / auto-seed pattern the legacy cover-note
 * generators already use (DB_FWHS.getREFNO on TB_CNSERIES,
 * DB_FWIG.getFWorkerNo on TB_FWORKERNO_RUNNO) but is decoupled from any one
 * feature so it can back the FWCMS quotation reference today and any other
 * running number tomorrow.
 *
 * Deployment prerequisite (data, not code):
 *     CREATE TABLE TB_RUNNING_NO (
 *         INSCODE VARCHAR(4)  NOT NULL,
 *         SERIES  VARCHAR(32) NOT NULL,
 *         RUNNO   VARCHAR(20),
 *         PRIMARY KEY (INSCODE, SERIES)
 *     );
 */
public class DB_RunningNo extends EASCManager {

	public DB_RunningNo(){
	}

	/**
	 * Allocate the next number in a series on THIS bean's already-open
	 * connection/transaction, so the increment can commit or roll back
	 * together with the caller's own work. The caller owns the connection
	 * lifecycle (makeConnection / setAutoCommitOff / conCommit / takeDown).
	 *
	 * @param INSCODE principal / institution code (e.g. "08")
	 * @param SERIES  logical series name (e.g. "FWCMSQREF")
	 * @param PREFIX  literal prefix stamped in front of the number (e.g. "Q")
	 * @param WIDTH   zero-padded width of the numeric part (e.g. 5 -> 00001)
	 * @return PREFIX + zero-padded counter, never blank
	 */
	public String next(String INSCODE, String SERIES, String PREFIX, int WIDTH) throws Exception {

		int    iCounter = 0;
		String NEXT_NO  = "";

		String strSQL = "SELECT RUNNO FROM TB_RUNNING_NO WHERE INSCODE=? AND SERIES=? "+
						"FOR UPDATE WITH RS";
		pstmt = myConn.prepareStatement(strSQL);
		pstmt.setString(1, INSCODE);
		pstmt.setString(2, SERIES);

		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			NEXT_NO = setNullToString(rs.getString("RUNNO"));
		}

		if (!NEXT_NO.equals("")) {
			iCounter = Integer.parseInt(NEXT_NO.trim()) + 1;

			strSQL = "UPDATE TB_RUNNING_NO SET RUNNO=? WHERE INSCODE=? AND SERIES=?";
			pstmt = myConn.prepareStatement(strSQL);
			pstmt.setString(1, String.valueOf(iCounter));
			pstmt.setString(2, INSCODE);
			pstmt.setString(3, SERIES);
			RowsAffected = pstmt.executeUpdate();
			pstmt.close();

			if (RowsAffected > 0) {
				pstmt2 = new PreparedStatementLogable(myConn, strSQL);
				pstmt2.setString(1, String.valueOf(iCounter));
				pstmt2.setString(2, INSCODE);
				pstmt2.setString(3, SERIES);
				insertSQLLog2("SQL", pstmt2.toString(), "", "", "", "");
			}
		} else {
			/* first use of this series — auto-seed the row at 1 */
			iCounter = 1;

			strSQL = "INSERT INTO TB_RUNNING_NO (INSCODE,SERIES,RUNNO) VALUES (?,?,?)";
			pstmt = myConn.prepareStatement(strSQL);
			pstmt.setString(1, INSCODE);
			pstmt.setString(2, SERIES);
			pstmt.setString(3, String.valueOf(iCounter));
			pstmt.executeUpdate();
			pstmt.close();

			pstmt2 = new PreparedStatementLogable(myConn, strSQL);
			pstmt2.setString(1, INSCODE);
			pstmt2.setString(2, SERIES);
			pstmt2.setString(3, String.valueOf(iCounter));
			insertSQLLog2("SQL", pstmt2.toString(), "", "", "", "");
		}

		return PREFIX + padLeft(iCounter, WIDTH);
	}

	/**
	 * Convenience wrapper that opens this bean's own connection, allocates the
	 * next number in its own short transaction, commits it and closes down —
	 * so a caller that only needs a number does not have to manage a
	 * connection. NOTE: because the number commits on its own, a later
	 * rollback of the caller's unrelated work leaves a gap in the series;
	 * gaps are expected and acceptable for a running number.
	 */
	public String nextCommitted(String INSCODE, String SERIES, String PREFIX, int WIDTH) throws Exception {
		String sResult = "";
		try {
			makeConnection();
			setAutoCommitOff();
			sResult = next(INSCODE, SERIES, PREFIX, WIDTH);
			conCommit();
		} catch (Exception ex) {
			try { rollBack(); } catch (Exception ignore) {}
			throw ex;
		} finally {
			try { setAutoCommitOn(); } catch (Exception ignore) {}
			takeDown();
		}
		return sResult;
	}

	/* left-pad the counter to WIDTH digits (no truncation once it overflows). */
	private String padLeft(int iValue, int iWidth) {
		String s = String.valueOf(iValue);
		if (s.length() >= iWidth) return s;
		StringBuilder sb = new StringBuilder();
		for (int i = s.length(); i < iWidth; i++) sb.append('0');
		return sb.append(s).toString();
	}
}
