<!--*********************************************************************
* Date			Programmer			Remarks
* -----------------------------------------------------------------------
* 10/08/2006	lfwong				Added sType , checking for Certificate or Schedule printing
***********************************************************************-->

<%@ page language="java" import="java.util.*" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />

<%
//20060605 - kcong - To include the proposal date printing.
//20060620 - hgong - To cater for the printing of Signature all in same page.
//20060714 - lpteh - To cater for English Version.

String sIssuedby 		= common.setNullToString(request.getParameter("issuedby"));
String sPrevpol			= common.setNullToString(request.getParameter("prevpol"));
String sIssdate		 	= common.setNullToString(request.getParameter("issdate"));
String sIsstime			= common.setNullToString(request.getParameter("isstime"));
String spropdate		= common.setNullToString(request.getParameter("propdate"));
String sLanguage		= common.setNullToString(request.getParameter("language"));
String sType			= common.setNullToString(request.getParameter("type"));
String PRINCIPLE    	= common.setNullToString((String) session.getAttribute("SES_PRINCIPLE"));
String specialAgent		= common.setNullToString(request.getParameter("specialAgent"));
String masterpol		= common.setNullToString(request.getParameter("masterpol"));
String FWCMSREFNO		= common.setNullToString(request.getParameter("FWCMSREFNO"));
String CATEGORYMSG 		= common.setNullToString((String)session.getAttribute("CATEGORYMSG"));

if(spropdate.equals(""))
	spropdate	= sIssdate;
%>

<html>
<%
if(sLanguage.equals("E"))
{
%>
<table tablefitpage="on" cellspacing="0" cellpadding="3" width="100%" border="1">
	<%if(!sType.equals("C")){%>
	<tr>
		<td width="30%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Replacing Cover Note No.</font></td>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>-</b></font></td>
		<% if (specialAgent.equals("Y")) { %>
		<td width="25%" valign="top" rowspan="5"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&nbsp;</font></td>
		<% }else{ %>
		<td width="25%" valign="top" rowspan="5"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Issued By<br><br><b><%=common.stringToHTMLString2(sIssuedby)%></b></font></td>
		<% } %>
		<td width="25%" valign="top" rowspan="5" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">This is a computer generated document and it does not require a signature. This document shall not be invalidated solely on the ground that it is not signed. <br> <i>Dokumen ini adalah cetakan komputer dan ia tidak memerlukan tandatangan. Dokumen ini tidak boleh dibatalkan atas alasan ia tidak ditandatangani.</i></font></td>
	</tr>
	<tr>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Previous Policy No.</font></td>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sPrevpol==""?"-" : sPrevpol)%></b></font></td>
	</tr>
	<tr>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Date of Proposal or Declaration<br><i>Tarikh Cadangan  atau Pengisytiharan</i></font></td>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(spropdate)%></b></font></td>
	</tr>
	<tr>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Date of Proposal or Declaration</font></td>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(spropdate)%></b></font></td>
	</tr>	
	<tr>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Date of Issue / Time</font></td>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sIssdate)%> / <%=common.stringToHTMLString(sIsstime)%></b></font></td>		
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td></td>
	</tr>
	<%}else{%>
	
	<tr>
		<td width="30%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Date of Issue / Time</font></td>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sIssdate)%> / <%=common.stringToHTMLString(sIsstime)%></b></font></td>
		<% if (specialAgent.equals("Y")) { %>
		<td width="25%" valign="top" rowspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&nbsp;</font></td>
		<% }else{ %>
		<td width="25%" valign="top" rowspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Issued By<br><br><b><%=common.stringToHTMLString2(sIssuedby)%></b></font></td>
		<% } %>
		<td width="25%" valign="top" rowspan="2" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">This is a computer generated document and it does not require a signature. This document shall not be invalidated solely on the ground that it is not signed. <br> <i>Dokumen ini adalah cetakan komputer dan ia tidak memerlukan tandatangan. Dokumen ini tidak boleh dibatalkan atas alasan ia tidak ditandatangani.</i></font></td>
	</tr>
	<tr>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b></b></font></td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
		<td></td>
	</tr>
	
	<%}%>
</table>
<%}else{%>
<table tablefitpage="on" cellspacing="0" cellpadding="3" width="100%" border="1" wrap="off">
	<tr>
		<td width="30%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Replacing Cover Note No.<br><i>Gantian No. Nota Perlindungan</i></font></td>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>-</b></font></td>
		<% if (specialAgent.equals("Y")) { %>
		<td width="25%" valign="top" rowspan="5"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&nbsp;</font></td>
		<% }else{ %>
		<td width="25%" valign="top" rowspan="5"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Issued By / <i>Dikeluarkan Oleh</i><br><br><b><%=common.stringToHTMLString2(sIssuedby)%></b></font></td>
		<% } %>
		<td width="25%" valign="top" rowspan="5" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" align="left">For /<i>untuk                                         <br><b>Liberty General Insurance Berhad</b></i><br><br><img src="../common/jpg/getjpg.jsp?fn=/Liberty_Auto_Signature.png"><br>_____________________________<br><b>Authorised Signature /<br><i>Tandatangan Yang Diberi Kuasa</i></b></font></td>
	</tr>
	<tr>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Master Policy No.<br><i>No. Polisi Induk</i></font></td>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(masterpol)%></b></font></td>
	</tr>
	<tr>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">FWCMS Reference No.<br><i>No. Rujukan FWCMS</i></font></td>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(FWCMSREFNO)%></b></font></td>
	</tr>
	<tr>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Date of Proposal or Declaration<br><i>Tarikh Cadangan  atau Pengisytiharan</i></font></td>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(spropdate)%></b></font></td>
	</tr>
	<tr>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Date of Issue / Time<br><i>Tarikh Dikeluarkan / Waktu</i></font></td>
		<td width="20%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sIssdate)%> / <%=common.stringToHTMLString(sIsstime)%></b></font></td>		
	</tr>
</table>
<%-- <% if(CATEGORYMSG.equals("NON-MOTOR CONFIRMATION SLIP")) {%>
<table>
	  <tr>
	  	<td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><U>PIDM Call for Action Statement</U><br><br>
	  	The benefit(s) payable under this eligible policy is protected by PIDM up to limits. Please refer to PIDM's TIPS Brochure or contact Liberty General Insurance Berhad or PIDM (visit www.pidm.gov.my).<br>
	  	Manfaat-manfaat yang dibayar dibawah polisi yang layak ini adalah dilindungi oleh PIDM sehingga had perlindungan. Sila rujuk Brosur Sistem Perlindungan Manfaat Takaful dan Insurans PIDM atau hubungi Liberty General Insurance Berhad atau PIDM (layari www.pidm.gov.my).
	  </tr>
</table>
<%} %> --%>
<%}%>
</html>