<%@ page language="java" import="java.util.*" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />

<%
//20060612 - kcong - change cellpadding to 3 instead of 2
//20060714 - lpteh - To cater for English Version.
//20060728 - lpteh - To cater for Medical Only Version.
//20061009 - Norhidayah - add parameter MC_cert : To cater for MC certificate version .
//20260422 - Verlynn - Update Important Notice Point 5 : remove Complaints Mgmt Unit column, 2-col layout (FMOS+BNMLINK), OFS->FMOS

String sCheckdigit 		= common.setNullToString(request.getParameter("checkdigit"));
String sLanguage		= common.setNullToString(request.getParameter("language"));
String sCheckMedical	= common.setNullToString(request.getParameter("checkmedical"));
String sMC_cert			= common.setNullToString(request.getParameter("MC_cert"));
String sCHECK_IND		= common.setNullToString(request.getParameter("check_ind"));
String sCLS_IND			= common.setNullToString(request.getParameter("cls_ind"));

%>
<html>
<br/><br/>
<table cellspacing="0" cellpadding="3" width="100%" border="0">
	<tr>
		<td width="100%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>e-ASC </b></font><font face="Verdana, Arial, Helvetica, sans-serif" size="1">&nbsp;&nbsp;&nbsp;<b><%=common.stringToHTMLString(sCheckdigit)%></b></font></td>
	</tr>
</table>
<%
if(sLanguage.equals("E"))
{
%>
<table cellspacing="0" cellpadding="3" width="100%" border="1">
	<tr>
		<td colspan="5" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>IMPORTANT NOTICE</b></font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">1.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The Insured shall read this Policy carefully, and if any error or misdescription be found herein, or if the cover is not in accordance with the wishes of the Insured, advice should at once be given to the Company and the Policy returned for alteration.
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">2.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Duty of Disclosure - If you fail to disclose to us fully and faithfully, all the facts which you know or ought to know, or if you misrepresented any facts to us before Contract was entered into, we may void this Policy. You must observe and fulfil the Terms, Conditions, Endorsements, Clauses or Warranties of the Policy.
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">3.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Any changes in the information given must be reported to the Company immediately otherwise the Company may reserve the right to decline all liability.
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">4.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">In the event of any occurrence which might give rise to a claim, notice should be given immediately to the nearest Branch Office or your Servicing Agent followed by such further steps, as are required by the Conditions of the Policy.
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">5.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Insured who is not satisfied with the course of the action or decision of the Company, may seek redress or assistance with the Ombudsman for Financial Services ( OFS ) or alternatively to approach Bank Negara Malaysia's Jabatan Konsumer dan Amalan Pasaran (Consumer and Market Conduct Department), addressed below:
		</font></td>
	</tr>
	<tr>
		<td width="2%"></td>
		<td width="7%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">a.</font></td>
		<td width="26%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Ombudsman for Financial Services ( OFS )<br>Level 14, Main Block<br>Menara Takaful Malaysia<br>No.4,Jalan Sultan Sulaiman<br>50000 Kuala Lumpur<br><br>Tel   :  +603 2272 2811<br>Fax  :  +603 2272 1577</font></td>
		<td width="7%"align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">b.</font></td>
		<td width="48%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Ombudsman Perkhidmatan Kewangan ( OFS )<br>Tingkat 14, Blok Utama<br>Menara Takaful Malaysia<br>No.4 Jalan Sultan Sulaiman<br>50000 Kuala Lumpur<br><br>Tel   :  +603 2272 2811<br>Fax  :  +603 2272 1577</font></td>
	</tr>
</table>
<%
}
else if(sCheckMedical.equals("true"))
{
%>
<table tablefitpage="on" cellspacing="0" cellpadding="3" width="100%" border="1">
	<tr>
		<td colspan="5" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>IMPORTANT NOTICE / </b><i>NOTIS PENTING</i></font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">1.</font></td>
		<td width="98%" align="justify" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The Policyholder / Insured Person shall read this Policy carefully, and if any error or misdescription be found herein, or if the cover is not in accordance with the wishes of the Policyholder / Insured Person, advice should at once be given to the Company and the Policy returned for alteration.<br>
		<i>Pemegang Polisi / Orang Yang Diinsuranskan hendaklah membaca Polisi ini dengan teliti, dan jika terdapat kesilapan atau keterangan yang salah, atau jika nota perlindungan tidak memenuhi kehendak Pemegang Polisi / Orang Yang Diinsuranskan, dengan kadar segera memberitahu kepada Syarikat dan mengembalikan Polisi untuk membuat pembetulan sewajarnya.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">2.</font></td>
		<td width="98%" align="justify" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Duty of Disclosure - If you fail to disclose to us fully and faithfully, all the facts which you know or ought to know, or if you misrepresented any facts to us before Contract was entered into, we may void this Policy. You must observe and fulfil the Terms, Conditions, Endorsements, Clauses or Warranties of the Policy.<br>
		<i>Kewajipan Pendedahan - Jika anda gagal mendedahkan kepada kami secara penuh dan jujur, semua fakta yang anda tahu atau sepatutnya tahu, atau jika anda salah nyatakan mana-mana fakta kepada kami sebelum Kontrak dikuatkuasakan, kami boleh membatalkan Polisi ini. Anda mestilah mematuhi dan memenuhi Terma, Syarat, Endorsemen, Fasal atau Waranti Polisi.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">3.</font></td>
		<td width="98%" align="justify" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Any changes in the information given must be reported to the Company immediately otherwise the Company may reserve the right to decline all liability.<br>
		<i>Sebarang pertukaran informasi diberi mesti dilaporkan kepada Syarikat serta merta, jika tidak Syarikat berhak menolak sebarang liabiliti.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">4.</font></td>
		<td width="98%" align="justify" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">In the event of any occurrence which might give rise to a claim, notice should be given immediately to the nearest Branch Office or your Servicing Agent followed by such further steps, as are required by the Conditions of the Policy.<br>
		<i>Jika berlaku apa-apa kejadian di mana suatu tuntutan boleh dibuat, notis hendaklah diberikan dengan serta merta kepada pejabat cawangan yang berdekatan atau agen perkhidmatan diikuti dengan langkah-langkah yang diperlukan seperti tercatat di dalam Syarat-Syarat Polisi.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">5.</font></td>
		<td width="98%" align="justify" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The above coverage is subject to the terms and conditions of the original policy and written term of acceptance.<br>
		<i>Perlindungan yang tersebut di atas adalah tertakluk kepada terma-terma dan syarat-syarat  yang terkandung dalam polisi asal dan penerimaan terma secara bertulis.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">6.</font></td>
		<td width="98%" align="justify" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">If there is any conflict or inconsistency between any of the contents of this document and the contents of a version of this same document issued or printed in any other language, the contents of this document issued and printed in the English language shall prevail.<br>
		<i>Sekiranya terdapat sebarang percanggahan atau ketidaksejajaran di dalam kandungan dokumen ini dengan kandungan versi yang sama, yang diisu dan dicetak dalam bahasa lain, hendaklah dirujuk kepada versi Bahasa Inggeris.</i><br>
		</font></td>
	</tr>
		<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">7.</font></td>
		<td width="98%" align="justify" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Any Policyholder / Insured who is not satisfied with the course of the action or decision of the Company, may seek redress or assistance with the Ombudsman for Financial Services ( OFS ) or alternatively to approach Bank Negara Malaysia's Jabatan Konsumer dan Amalan Pasaran (Consumer and Market Conduct Department), addressed below:<br>
		<i>Pemegang Polisi / Pihak Diinsuranskan yang tidak berpuas hati dengan segala tindakan atau keputusan Syarikat boleh memperolehi rujukan atau bantuan dengan Biro Pengantara Kewangan atau seterusnya menghadap kepada Jabatan Konsumer dan Amalan Pasaran , Bank Negara Malaysia, seperti alamat di bawah:</i><br>
		</font></td>
	</tr>
	<tr>
		<td width="2%"></td>
		<td width="7%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">a.</font></td>
		<td width="26%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Ombudsman for Financial Services ( OFS )<br>Level 14, Main Block<br>Menara Takaful Malaysia<br>No.4,Jalan Sultan Sulaiman<br>50000 Kuala Lumpur<br><br>Tel   :  +603 2272 2811<br>Fax  :  +603 2272 1577</font></td>
		<td width="7%"align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">b.</font></td>
		<td width="48%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Ombudsman Perkhidmatan Kewangan ( OFS )<br>Tingkat 14, Blok Utama<br>Menara Takaful Malaysia<br>No.4 Jalan Sultan Sulaiman<br>50000 Kuala Lumpur<br><br>Tel   :  +603 2272 2811<br>Fax  :  +603 2272 1577</font></td>
	</tr>
</table>
<%
}
else if(sMC_cert.equals("true"))
{
%>
<table cellspacing="0" cellpadding="3" width="100%" border="1">
	<tr>
		<td colspan="100" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>IMPORTANT NOTICE</b></font></td>
	</tr>
	<tr>
		<td colspan="3" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.</font></td>
		<td colspan="97" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">The Insured shall read this Marine Certificate/Policy carefully, and if any error or misdescription be found herein, or if the cover is not in accordance with the wishes of the Insured, advice should at once be given to the Company and the Marine Certificate/Policy returned for alteration.</font></td>
	</tr>
	<tr>
		<td colspan="3" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">2.</font></td>
		<td colspan="97" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Duty of Disclosure - If you fail to disclose to us fully and faithfully, all the facts which you know or ought to know, or if you misrepresented any facts to us before Contract was entered into, we may void this Marine Certificate/Policy. You must observe and fulfil the Terms, Conditions, Endorsements, Clauses or Warranties of the Marine Certificate/Policy.</font></td>
	</tr>
	<tr>
		<td colspan="3" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">3.</font></td>
		<td colspan="97" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Any changes in the information given must be reported to the Company immediately otherwise the Company may reserve the right to decline all liability.</font></td>
	</tr>
	<tr>
		<td colspan="3" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">4.</font></td>
		<td colspan="97" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">In the event of any occurrence which might give rise to a claim, notice should be given immediately to the nearest Branch Office or your Servicing Agent followed by such further steps, as are required by the Conditions of the Marine Certificate/Policy.</font></td>
	</tr>
	<tr>
		<td colspan="3" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">5.</font></td>
		<td colspan="97" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Insured who is not satisfied with the course of the action or decision of the Company, may seek redress or assistance with the Ombudsman for Financial Services ( OFS ) or alternatively to approach Bank Negara Malaysia's Jabatan Konsumer dan Amalan Pasaran (Consumer and Market Conduct Department), addressed below:</font></td>
	</tr>
	<tr>
		<td colspan="10" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
		<td colspan="5" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">a.</font></td>
		<td colspan="35" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Ombudsman for Financial Services ( OFS )<br>Level 14, Main Block<br>Menara Takaful Malaysia<br>No.4,Jalan Sultan Sulaiman<br>50000 Kuala Lumpur<br><br>Tel   :  +603 2272 2811<br>Fax  :  +603 2272 1577</font></td>
		<td colspan="5" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">b.</font></td>
		<td colspan="45" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Laman Informasi Nasihat dan Khidmat (BNMLINK)<br>Bank Negara Malaysia<br>4th Floor, Podium Bangunan AICB,<br>No. 10, Jalan Dato' Onn,<br>50480 Kuala Lumpur.<br><br>Tel. No.: 03-2698 8044 (General Line) / 1-300-88-5465 (BNMLINK)<br>Fax : +603 2174 1515<br>e-Link : bnmlink.bnm.gov.my<br>email address: bnmlink@bnm.gov.my<br>Website : www.bnm.gov.my</font></td>
	</tr>
</table>
<table cellspacing="0" cellpadding="3" width="100%" border="1">
	<tr>
		<td colspan="100" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">This Insurance is subject to English Law.<br></font></td>
	</tr>
	<tr>
		<td colspan="100" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">IMPORTANT</font></td>
	</tr>
	<tr>
		<td colspan="100" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">PROCEDURE IN THE EVENT OF LOSS OR DAMAGE FOR WHICH THE COMPANY MAY BE LIABLE<br><br></font></td>
	</tr>
	<tr>
		<td colspan="100" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">LIABLITY OF CARRIERS, BAILEES OR OTHER THIRD PARTIES<br><br></font></td>
	</tr>
	<tr>
		<td colspan="100" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">It is the duty of the Assured and their Agents, in all cases, to take such measures as may be reasonable for the purpose of averting or minimizing a loss and to ensure that  all rights against Carriers, Bailees or other third  parties are properly preserved and exercised. In particular, the Assured or their Agents are required: -</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">To claim immediately on the Carriers, Port Authorities or other Bailee for any missing packages.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">2.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">In no circumstances, except under protest, to give clean receipts where goods are in doubtful condition.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">3.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">When delivery is made by Container, to ensure that container and its seal are examined immediately by this responsible official. the carriers or other Bailees for any actual loss or damage found at such survey.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">4.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">To apply immediately for survey by Carriers or other Bailee's Representatives, if any loss or damage be apparent and claim on the carriers or other Bailees for any actual loss or damage found at such survey.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">5.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">To give notice in writing to the Carriers or other Bailees within 3 days of delivery if the loss or damage was not apparent at the time of taking delivery.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">NOTE: - The Consignees or their Agents are recommended to make themselves familiar with the regulations of the Port Authorities at the port of discharge<br></font></td>
	</tr>
	<tr>
		<td colspan="100" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">SURVEY AND CLAIM SETTLEMENT</font></td>
	</tr>
	<tr>
		<td colspan="100" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">In the event of loss or damage which may result in a claim under this insurance, immediate notice of such loss or damage should be given to and a Survey Report obtained from the Office or Agent nominated herein. In the event of any claim arising under this insurance, Request for settlement should be made to the Office or Agent nominated herein<br></font></td>
	</tr>
	<tr>
		<td colspan="100" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">DOCUMENTATION OF CLAIMS</font></td>
	</tr>
	<tr>
		<td colspan="100" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">To enable claims to be dealt with promptly, the Assured or their Agents are advised to submit all available supporting documents without Delay including when applicable: -<br></font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Original Marine Cargo Certificate/Policy.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">2.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Original or copy of shipping invoices, together with shipping specification and/or weight notes.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">3.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Original Bill of Lading and/or other contract of carriage.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">4.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Survey Report or other documentary evidence to show the extent of the loss or damage.</font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">5.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Landing account and weight notes at final destination. </font></td>
	</tr>
	<tr>
		<td colspan="7" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">6.</font></td>
		<td colspan="93" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Correspondence exchanged with the Carriers and other Parties regarding their liability for the loss Or damage.<br></font></td>
	</tr>
	<tr>
		<td colspan="100" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br>NOTE:&nbsp;&nbsp;&nbsp;Failure to comply with any requirements will prejudice any claim under this certificate/policy.</font></td>
	</tr>
</table>

<%
}
else
{
%>
<%if(sCHECK_IND.equals("Y")){%>
<table cellspacing="0" cellpadding="3" width="100%" border="1">
	<tr>
		<td colspan="7" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>IMPORTANT NOTICE / </b><i>NOTIS PENTING</i></font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">1.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The Insured shall read this Policy carefully, and if any error or misdescription be found herein, or if the cover is not in accordance with the wishes of the Insured, advice should at once be given to the Company and the Policy returned for alteration.<br>
		<i>Pihak Diinsuranskan hendaklah membaca Polisi ini dengan teliti, dan jika terdapat kesilapan atau keterangan yang salah, atau jika nota perlindungan tidak memenuhi kehendak Pihak Diinsuranskan, Pihak Diinsuranskan hendaklah memberitahu kepada Syarikat dan mengembalikan Polisi untuk membuat pembetulan sewajarnya.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">2.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Duty of Disclosure - STATEMENT PURSUANT TO FINANCIAL SERVICES ACT 2013, Section 129 Schedule 9, Para 5: It is the duty of the customer to take reasonable care not to make a misrepresentation to the licensed insurer when answering any question which the insurer may request that are relevant to the decision of the insurer whether to accept the risk or not and the rates and terms to be applied.<br>
 		<i>KEWAJIPAN PENDEDAHAN - Menurut Akta Perkhidmatan Kewangan 2013, Seksyen 129, Jadual 9, Perenggan 5: Adalah menjadi kewajipan pengguna untuk mengambil penjagaan munasabah untuk tidak membuat salah nyataan kepada penanggung insurans berlesen semasa menjawab apa-apa soalan yang diperlukan yang berkaitan dengan keputusan penanggung insurans samada untuk menerima atau tidak risiko dan kadar dan terma yang hendak dipakai.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">3.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Any changes in the information given must be reported to the Company immediately otherwise the Company may resume the right to decline all liability.<br>
		<i>Sebarang pertukaran informasi diberi mesti dilaporkan kepada Syarikat serta merta, jika tidak Syarikat berhak menolak sebarang liabiliti.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">4.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">In the event of any occurrence which might give rise to a claim, notice should be given immediately to the nearest Branch Office or your Servicing Agent followed by such further steps, as are required by the Conditions of the Policy.<br>
		<i>Jika berlaku apa-apa kejadian di mana suatu tuntutan boleh dibuat, notis hendaklah diberikan dengan serta merta kepada pejabat cawangan yang berdekatan atau agen perkhidmatan diikuti dengan langkah-langkah yang diperlukan seperti tercatat di dalam Syarat-Syarat Polisi.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">5.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Insured who is not satisfied with the course of the action or decision of the Company, may seek redress or assistance with the Financial Markets Ombudsman Service (FMOS) or alternatively to approach Bank Negara Malaysia's BNMLINK addressed below: <br>
		<i>Pihak Diinsuranskan yang tidak berpuas hati dengan tindakan atau keputusan Syarikat boleh mendapatkan pembelaan atau bantuan daripada Financial Markets Ombudsman Service (FMOS) atau melayari BNMLINK, Bank Negara Malaysia yang beralamat seperti di bawah: </i><br>
		</font></td>
	</tr>
	<tr>
	    <td width="2%"></td>
	    <td width="49%" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">a.&nbsp;&nbsp; Financial Markets Ombudsman Service (FMOS)<br>&nbsp;&nbsp;&nbsp;&nbsp;(Formerly known as Ombudsman for Financial Services)<br>&nbsp;&nbsp;&nbsp;&nbsp;Company No.: 200401025885<br>&nbsp;&nbsp;&nbsp;&nbsp;General Line: +603 2272 2811<br>&nbsp;&nbsp;&nbsp;&nbsp;Address: Level 14, Main Block,<br>&nbsp;&nbsp;&nbsp;&nbsp;Menara Takaful Malaysia, No 4, Jalan Sultan Sulaiman,<br>&nbsp;&nbsp;&nbsp;&nbsp;50000 Kuala Lumpur<br>&nbsp;&nbsp;&nbsp;&nbsp;Website: www.fmos.org.my</font></td>
	    <td width="49%" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">b.&nbsp;&nbsp; BNMLINK<br>&nbsp;&nbsp;&nbsp;&nbsp;Bank Negara Malaysia<br>&nbsp;&nbsp;&nbsp;&nbsp;4th Floor, Podium Bangunan AICB,<br>&nbsp;&nbsp;&nbsp;&nbsp;No. 10, Jalan Dato' Onn,<br>&nbsp;&nbsp;&nbsp;&nbsp;50480 Kuala Lumpur.<br>&nbsp;&nbsp;&nbsp;&nbsp;e-Link: bnm.gov.my/BNMLINK<br>&nbsp;&nbsp;&nbsp;&nbsp;Website: www.bnm.gov.my</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">6.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Liberty General Insurance Berhad is a member of PIDM. The benefit(s) payable under this eligible policy is protected by PIDM up to limits. Please refer to PIDM's TIPS Brochure or contact Liberty General Insurance Berhad or PIDM (visit www.pidm.gov.my).<br>
		<i>Liberty General Insurance Berhad adalah ahli PIDM. Manfaat-manfaat yang dibayar di bawah polisi yang layak ini adalah dilindungi oleh PIDM sehingga had perlindungan. Sila rujuk Brosur Sistem Perlindungan Manfaat Takaful dan Insurans PIDM atau hubungi Liberty General Insurance Berhad atau PIDM (layari www.pidm.gov.my).</i><br>
		</font></td>
	</tr>
	<!-- <tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1"></font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The benefit(s) payable under this eligible policy is protected by PIDM up to limits. Please refer to PIDM's TIPS Brochure or contact Liberty General Insurance Berhad or PIDM (visit www.pidm.gov.my).<br>
		<i>Manfaat-manfaat yang dibayar dibawah polisi yang layak ini adalah dilindungi oleh PIDM sehingga had perlindungan. Sila rujuk Brosur Sistem Perlindungan Manfaat Takaful dan Insurans PIDM atau hubungi Liberty General Insurance Berhad atau PIDM (layari www.pidm.gov.my).</i><br>
		</font></td>
	</tr> -->
</table>
<%
}else if(sCHECK_IND.equals("F")){
%>
<table cellspacing="0" cellpadding="3" width="100%" border="1">
	<tr>
		<td colspan="5" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>IMPORTANT NOTICE / </b><i>NOTIS PENTING</i></font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">1.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The Insured shall read this Policy carefully, and if any error or misdescription be found herein, or if the cover is not in accordance with the wishes of the Insured, advice should at once be given to the Company and the Policy returned for alteration.<br>
		<i>Pihak Diinsuranskan hendaklah membaca Polisi ini dengan teliti, dan jika terdapat kesilapan atau keterangan yang salah, atau jika nota perlindungan tidak memenuhi kehendak Pihak Diinsuranskan, Pihak Diinsuranskan hendaklah memberitahu kepada Syarikat dan mengembalikan Polisi untuk membuat pembetulan sewajarnya.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">2.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Duty of Disclosure - STATEMENT PURSUANT TO FINANCIAL SERVICES ACT 2013, Section 129 Schedule 9, Para 5: It is the duty of the customer to take reasonable care not to make a misrepresentation to the licensed insurer when answering any question which the insurer may request that are relevant to the decision of the insurer whether to accept the risk or not and the rates and terms to be applied.<br>
		<i>KEWAJIPAN PENDEDAHAN - Menurut Akta Perkhidmatan Kewangan 2013, Seksyen 129, Jadual 9, Perenggan 5: Adalah menjadi kewajipan pengguna untuk mengambil penjagaan munasabah untuk tidak membuat salah nyataan kepada penanggung insurans berlesen semasa menjawab apa-apa soalan yang diperlukan yang berkaitan dengan keputusan penanggung insurans samada untuk menerima atau tidak risiko dan kadar dan terma yang hendak dipakai.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">3.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Any changes in the information given must be reported to the Company immediately otherwise the Company may resume the right to decline all liability.<br>
		<i>Sebarang pertukaran informasi diberi mesti dilaporkan kepada Syarikat serta merta, jika tidak Syarikat berhak menolak sebarang liabiliti.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">4.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">In the event of any occurrence which might give rise to a claim, notice should be given immediately to the nearest Branch Office or your Servicing Agent followed by such further steps, as are required by the Conditions of the Policy.<br>
		<i>Jika berlaku apa-apa kejadian di mana suatu tuntutan boleh dibuat, notis hendaklah diberikan dengan serta merta kepada pejabat cawangan yang berdekatan atau agen perkhidmatan diikuti dengan langkah-langkah yang diperlukan seperti tercatat di dalam Syarat-Syarat Polisi.</i>
		</font></td>
	</tr>
	<%if(sCLS_IND.equals("Y")){%>		
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">5.</font></td>	
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">In the event of a conflict or discrepancy between the provisions of the English text of any of the Contract documents and any translation thereof, the English text shall prevail.<br>
		<i>Sekiranya berlaku konflik atau percanggahan berhubung peruntukan teks Bahasa Inggeris dengan mana-mana Dokumen Kontrak dan apa-apa terjemahannya, maka teks Bahasa Inggeris akan diguna pakai.</i>
		</font></td>	
	</tr>	
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">6.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Insured who is not satisfied with the course of the action or decision of the Company, may seek redress or assistance with the Ombudsman for Financial Services ( OFS ) or alternatively to approach Bank Negara Malaysia's Laman Informasi dan Nasihat (LINK), addressed below:<br>
		<i>Pihak Yang Diinsuranskan yang tidak berpuas hati dengan segala tindakan atau keputusan Syarikat boleh memperolehi rujukan atau bantuan dengan Biro Pengantaraan Kewangan atau seterusnya menghadap kepada Bahagian Perkhidmatan Pelanggan Bank Negara Malaysia, seperti alamat tertakluk di bawah:</i><br>
		</font></td>
	</tr>
	<%}else{%>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">5.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Insured who is not satisfied with the course of the action or decision of the Company, may seek redress or assistance with the Ombudsman for Financial Services ( OFS ) or alternatively to approach Bank Negara Malaysia's Laman Informasi dan Nasihat (LINK), addressed below:<br>
		<i>Pihak Yang Diinsuranskan yang tidak berpuas hati dengan segala tindakan atau keputusan Syarikat boleh memperolehi rujukan atau bantuan dengan Biro Pengantaraan Kewangan atau seterusnya menghadap kepada Bahagian Perkhidmatan Pelanggan Bank Negara Malaysia, seperti alamat tertakluk di bawah:</i><br>
		</font></td>
	</tr>
	<%}%>
	<tr>
		<td width="2%"></td>
		<td width="7%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">a.</font></td>
		<td width="26%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Ombudsman Perkhidmatan Kewangan ( OFS )<br>Tingkat 14, Blok Utama<br>Menara Takaful Malaysia<br>No.4 Jalan Sultan Sulaiman<br>50000 Kuala Lumpur<br><br>Tel   :  +603 2272 2811<br>Fax  :  +603 2272 1577</font></td>
		<td width="7%"align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">b.</font></td>
		<td width="48%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Laman Informasi Nasihat dan Khidmat (BNMLINK)<br>Bank Negara Malaysia<br>4th Floor, Podium Bangunan AICB,<br>No. 10, Jalan Dato' Onn,<br>50480 Kuala Lumpur.<br><br>Tel. No.: 03-2698 8044 (General Line) / 1-300-88-5465 (BNMLINK)<br>Fax : +603 2174 1515<br>e-Link : bnmlink.bnm.gov.my<br>email address: bnmlink@bnm.gov.my<br>Website : www.bnm.gov.my</font></td>
	</tr>
</table>
<%
}else if(sCHECK_IND.equals("H")){
%>
<table tablefitpage="on" cellspacing="0" cellpadding="3" width="100%" border="1">
	<tr>
		<td colspan="7" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>IMPORTANT NOTICE / </b><i>NOTIS PENTING</i></font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">1.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The Insured shall read this Policy carefully, and if any error or misdescription be found herein, or if the cover is not in accordance with the wishes of the Insured, advice should at once be given to the Company and the Policy returned for alteration.<br>
		<i>Pihak Diinsuranskan hendaklah membaca Polisi ini dengan teliti, dan jika terdapat kesilapan atau keterangan yang salah, atau jika nota perlindungan tidak memenuhi kehendak Pihak Diinsuranskan, Pihak Diinsuranskan hendaklah memberitahu kepada Syarikat dan mengembalikan Polisi untuk membuat pembetulan sewajarnya.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">2.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Duty of Disclosure - STATEMENT PURSUANT TO FINANCIAL SERVICES ACT 2013, Section 129 Schedule 9, Para 5: It is the duty of the customer to take reasonable care not to make a misrepresentation to the licensed insurer when answering any question which the insurer may request that are relevant to the decision of the insurer whether to accept the risk or not and the rates and terms to be applied.<br>
		<i>KEWAJIPAN PENDEDAHAN - Menurut Akta Perkhidmatan Kewangan 2013, Seksyen 129, Jadual 9, Perenggan 5: Adalah menjadi kewajipan pengguna untuk mengambil penjagaan munasabah untuk tidak membuat salah nyataan kepada penanggung insurans berlesen semasa menjawab apa-apa soalan yang diperlukan yang berkaitan dengan keputusan penanggung insurans samada untuk menerima atau tidak risiko dan kadar dan terma yang hendak dipakai.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">3.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Any changes in the information given must be reported to the Company immediately otherwise the Company may resume the right to decline all liability.<br>
		<i>Sebarang pertukaran informasi diberi mesti dilaporkan kepada Syarikat serta merta, jika tidak Syarikat berhak menolak sebarang liabiliti.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">4.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">In the event of any occurrence which might give rise to a claim, notice should be given immediately to the nearest Branch Office or your Servicing Agent followed by such further steps, as are required by the Conditions of the Policy.<br>
		<i>Jika berlaku apa-apa kejadian di mana suatu tuntutan boleh dibuat, notis hendaklah diberikan dengan serta merta kepada pejabat cawangan yang berdekatan atau agen perkhidmatan diikuti dengan langkah-langkah yang diperlukan seperti tercatat di dalam Syarat-Syarat Polisi.</i>
		</font></td>
	</tr> 
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">5.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Insured who is not satisfied with the course of the action or decision of the Company, may seek redress or assistance with the Financial Markets Ombudsman Service (FMOS) or alternatively to approach Bank Negara Malaysia's BNMLINK addressed below:<br>
		<i>Pihak Diinsuranskan yang tidak berpuas hati dengan tindakan atau keputusan Syarikat boleh mendapatkan pembelaan atau bantuan daripada Financial Markets Ombudsman Service (FMOS) atau melayari BNMLINK, Bank Negara Malaysia yang beralamat seperti di bawah:</i>
		</font></td>
	</tr>
	<tr>
	    <td width="2%"></td>
	    <td width="49%" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">a.&nbsp;&nbsp; Financial Markets Ombudsman Service (FMOS)<br>&nbsp;&nbsp;&nbsp;&nbsp;(Formerly known as Ombudsman for Financial Services)<br>&nbsp;&nbsp;&nbsp;&nbsp;Company No.: 200401025885<br>&nbsp;&nbsp;&nbsp;&nbsp;General Line: +603 2272 2811<br>&nbsp;&nbsp;&nbsp;&nbsp;Address: Level 14, Main Block,<br>&nbsp;&nbsp;&nbsp;&nbsp;Menara Takaful Malaysia, No 4, Jalan Sultan Sulaiman,<br>&nbsp;&nbsp;&nbsp;&nbsp;50000 Kuala Lumpur<br>&nbsp;&nbsp;&nbsp;&nbsp;Website: www.fmos.org.my</font></td>
	    <td width="49%" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">b.&nbsp;&nbsp; BNMLINK<br>&nbsp;&nbsp;&nbsp;&nbsp;Bank Negara Malaysia<br>&nbsp;&nbsp;&nbsp;&nbsp;4th Floor, Podium Bangunan AICB,<br>&nbsp;&nbsp;&nbsp;&nbsp;No. 10, Jalan Dato' Onn,<br>&nbsp;&nbsp;&nbsp;&nbsp;50480 Kuala Lumpur.<br>&nbsp;&nbsp;&nbsp;&nbsp;e-Link: bnm.gov.my/BNMLINK<br>&nbsp;&nbsp;&nbsp;&nbsp;Website: www.bnm.gov.my</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">6.</font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Liberty General Insurance Berhad is a member of PIDM. The benefit(s) payable under this eligible policy is protected by PIDM up to limits. Please refer to PIDM's TIPS Brochure or contact Liberty General Insurance Berhad or PIDM (visit www.pidm.gov.my).<br>
		<i>Liberty General Insurance Berhad adalah ahli PIDM. Manfaat-manfaat yang dibayar di bawah polisi yang layak ini adalah dilindungi oleh PIDM sehingga had perlindungan. Sila rujuk Brosur Sistem Perlindungan Manfaat Takaful dan Insurans PIDM atau hubungi Liberty General Insurance Berhad atau PIDM (layari www.pidm.gov.my).</i><br>
		</font></td>
	</tr>
	<!-- <tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1"></font></td>
		<td width="98%" align="left" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The benefit(s) payable under this eligible policy is protected by PIDM up to limits. Please refer to PIDM's TIPS Brochure or contact Liberty General Insurance Berhad or PIDM (visit www.pidm.gov.my).<br>
		<i>Manfaat-manfaat yang dibayar dibawah polisi yang layak ini adalah dilindungi oleh PIDM sehingga had perlindungan. Sila rujuk Brosur Sistem Perlindungan Manfaat Takaful dan Insurans PIDM atau hubungi Liberty General Insurance Berhad atau PIDM (layari www.pidm.gov.my).</i><br>
		</font></td>
	</tr> -->
</table>
<%
}else{
%>
<table cellspacing="0" cellpadding="3" width="100%" border="1">
	<tr>
		<td colspan="5" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>IMPORTANT NOTICE / </b><i>NOTIS PENTING</i></font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">1.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">The Insured shall read this Policy carefully, and if any error or misdescription be found herein, or if the cover is not in accordance with the wishes of the Insured, advice should at once be given to the Company and the Policy returned for alteration.<br>
		<i>Pihak Diinsuranskan hendaklah membaca Polisi ini dengan teliti, dan jika terdapat kesilapan atau keterangan yang salah, atau jika nota perlindungan tidak memenuhi kehendak Pihak Diinsuranskan, Pihak Diinsuranskan hendaklah memberitahu kepada Syarikat dan mengembalikan Polisi untuk membuat pembetulan sewajarnya.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">2.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Duty of Disclosure - If you fail to disclose to us fully and faithfully, all the facts which you know or ought to know, or if you misrepresented any facts to us before Policy was entered into, we may void this Policy. You must observe and fulfil the Terms, Conditions, Endorsements, Clauses or Warranties of the Policy.<br>
		<i>Kewajipan Pendedahan - Jika anda gagal mendedahkan kepada kami secara penuh dan jujur, semua fakta yang anda tahu atau sepatutnya tahu, atau jika anda salah nyatakan mana-mana fakta kepada kami sebelum Polisi dikuatkuasakan, kami boleh membatalkan Polisi ini. Anda mestilah mematuhi dan memenuhi Terma, Syarat, Endorsemen, Fasal atau Waranti Polisi.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">3.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Any changes in the information given must be reported to the Company immediately otherwise the Company may resume the right to decline all liability.<br>
		<i>Sebarang pertukaran informasi diberi mesti dilaporkan kepada Syarikat serta merta, jika tidak Syarikat berhak menolak sebarang liabiliti.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">4.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">In the event of any occurrence which might give rise to a claim, notice should be given immediately to the nearest Branch Office or your Servicing Agent followed by such further steps, as are required by the Conditions of the Policy.<br>
		<i>Jika berlaku apa-apa kejadian di mana suatu tuntutan boleh dibuat, notis hendaklah diberikan dengan serta merta kepada pejabat cawangan yang berdekatan atau agen perkhidmatan diikuti dengan langkah-langkah yang diperlukan seperti tercatat di dalam Syarat-Syarat Polisi.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">5.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">If there is any conflict or inconsistency between any of the contents of this document and the contents of a version of this same document issued or printed in any other language, the contents of this document issued and printed in the English language shall prevail.<br>
		<i>Sekiranya terdapat sebarang percanggahan atau ketidaksejajaran di dalam kandungan dokumen ini dengan kandungan versi yang sama, yang diisu dan dicetak dalam bahasa lain, hendaklah dirujuk kepada versi Bahasa Inggeris.</i>
		</font></td>
	</tr>
	<tr>
		<td width="2%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">6.</font></td>
		<td width="98%" align="left" colspan="4"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Insured who is not satisfied with the course of the action or decision of the Company, may seek redress or assistance with the Ombudsman for Financial Services ( OFS ) or alternatively to approach Bank Negara Malaysia's Jabatan Konsumer dan Amalan Pasaran (Consumer and Market Conduct Department), addressed below:<br>
		<i>Pihak Diinsuranskan yang tidak berpuas hati dengan segala tindakan atau keputusan Syarikat boleh memperolehi rujukan atau bantuan dengan Biro Pengantara Kewangan atau seterusnya menghadap kepada Jabatan Konsumer dan Amalan Pasaran , Bank Negara Malaysia, seperti alamat di bawah:</i><br>
		</font></td>
	</tr>
	<tr>
		<td width="2%"></td>
		<td width="7%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">a.</font></td>
		<td width="26%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Ombudsman for Financial Services ( OFS )<br>Level 14, Main Block<br>Menara Takaful Malaysia<br>No.4,Jalan Sultan Sulaiman<br>50000 Kuala Lumpur<br><br>Tel   :  +603 2272 2811<br>Fax  :  +603 2272 1577</font></td>
		<td width="7%"align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">b.</font></td>
		<td width="48%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Laman Informasi Nasihat dan Khidmat (BNMLINK)<br>Bank Negara Malaysia<br>4th Floor, Podium Bangunan AICB,<br>No. 10, Jalan Dato' Onn,<br>50480 Kuala Lumpur.<br><br>Tel. No.: 03-2698 8044 (General Line) / 1-300-88-5465 (BNMLINK)<br>Fax : +603 2174 1515<br>e-Link : bnmlink.bnm.gov.my<br>email address: bnmlink@bnm.gov.my<br>Website : www.bnm.gov.my</font></td>
	</tr>
</table>
	<%}%>	
<%}%>
</html>