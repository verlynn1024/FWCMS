<%@ page language="java" import="java.util.*" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />

<%
//20060612 - kcong - To remove the page break.
//20060714 - lpteh - To cater for English Version.
//20061017 - kcong - Change font to 'COURIER'.

Vector vNarration 		= (Vector) session.getAttribute("SES_vNARRATION");
String fontface = "COURIER";
//nulling session values after retreiving
session.setAttribute("SES_vClause_Warr",null);
session.removeAttribute("SES_vClause_Warr");
//nulling end
String sLanguage		= common.setNullToString(request.getParameter("language"));
String sMedical			= common.setNullToString(request.getParameter("medical"));
String WITHHEADER		= common.setNullToString(request.getParameter("WITHHEADER"));
%>

<html>

<%
if(WITHHEADER.equals("NO"))
{
%>
	<table width="100%" border="1" cellspacing="0" cellpadding="3" tablefitpage="on" >
	<tr>
		<td bordercolor="#FFFFFF" width="100%" align="left" colspan="2"><font face="<%=fontface%>" size="2">The following endorsements, warranties, clauses or extensions are not applicable unless indicated in the Policy Schedule, in which case the endorsement(s), warranty(ies) , clause(s) or extension(s)  so indicated shall be deemed to form part of the policy<br><i>Endorsemen, waranti, fasal atau tambahan adalah tidak digunapakai kecuali dinyatakan di dalam Jadual Polisi, di mana endorsemen, waranti, fasal atau tambahan yang dinyata akan dianggap membentuk sebahagian daripada polisi</i></font></td>
	</tr>

	<tr>
		<td bordercolor="#FFFFFF" width="12%" align="justify"><font face="<%=fontface%>" size="2">Code / <i>Kod</i></font></td>
		<td bordercolor="#FFFFFF" width="88%" align="justify"><font face="<%=fontface%>" size="2">Description / <i>Deskripsi</i></font></td>
	</tr>
<%
}
else if(sLanguage.equals("E"))
{
%>
	<table width="100%" border="1" cellspacing="0" cellpadding="3" wrap="off" >
	<tr>
		<th bordercolor="#FFFFFF" width="100%" align="left" colspan="2"><font face="<%=fontface%>" size="2">The following endorsements, warranties, clauses or extensions are not applicable unless indicated in the Policy Schedule, in which case the endorsement(s), warranty(ies), clause(s) or extension(s) so indicated shall be deemed to form part of the policy</font></th>
	</tr>
	<tr>
		<th bordercolor="#FFFFFF" width="12%" align="justify"><font face="<%=fontface%>" size="2">Code</font></th>
		<th bordercolor="#FFFFFF" width="88%" align="justify"><font face="<%=fontface%>" size="2">Description</font></th>
	</tr>
<%
}
else
{
	if(sMedical.equalsIgnoreCase("Y"))
	{
%>	
	<table width="100%" border="1" cellspacing="0" cellpadding="3" wrap="off" >
	<tr>
		<th bordercolor="#FFFFFF" width="100%" align="left" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Subject to the following Clauses / Warranties / Endorsements attached hereto: -<br><i>Tertakluk kepada Fasal / Waranti / Endorsemen berikut yang disertakan bersama ini : -</i></font></th>
	</tr>
	
	<tr>
		<th bordercolor="#FFFFFF" width="12%" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Code / <i>Kod</i></font></th>
		<th bordercolor="#FFFFFF" width="88%" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Description / <i>Deskripsi</i></font></th>
	</tr>
<%
	}
	else
	{
%>
	<table width="100%" border="1" cellspacing="0" cellpadding="3" wrap="off" >
	<tr>
		<th bordercolor="#FFFFFF" width="100%" align="left" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">The following endorsements, warranties, clauses or extensions are not applicable unless indicated in the Policy Schedule, in which case the endorsement(s), warranty(ies) , clause(s) or extension(s)  so indicated shall be deemed to form part of the policy<br><i>Endorsemen, waranti, fasal atau tambahan adalah tidak digunapakai kecuali dinyatakan di dalam Jadual Polisi, di mana endorsemen, waranti, fasal atau tambahan yang dinyata akan dianggap membentuk sebahagian daripada polisi</i></font></th>
	</tr>

	<tr>
		<th bordercolor="#FFFFFF" width="12%" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Code / <i>Kod</i></font></th>
		<th bordercolor="#FFFFFF" width="88%" align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Description / <i>Deskripsi</i></font></th>
	</tr>
<%	
	}

}
%>
<%if(vNarration!=null && vNarration.size()>0){%>
<%
if(vNarration!=null)
{
	for(int i=0; i<vNarration.size(); i++)
	{
		Vector vItemNo			= (Vector) vNarration.elementAt(i);
		String sCode			= (String) vItemNo.elementAt(0);
		String sDescp			= (String) vItemNo.elementAt(1);
		String sNarration		= (String) vItemNo.elementAt(2);
		
		if(!sCode.equals(""))
		{
			if(sMedical.equalsIgnoreCase("Y"))
			{
%>
				<tr>
					<td bordercolor="#FFFFFF" width="12%" align="justify" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif"  size="2"><b><%=common.stringToHTMLString(sCode)%></b></font></td>
					<td bordercolor="#FFFFFF" width="88%" align="justify" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sDescp)%><br><%=common.stringToHTMLString2(sNarration)%></b></font></td>
				</tr>
<%			}
			else
			{
%>
				<tr>
					<td bordercolor="#FFFFFF" width="12%" align="justify" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif"  size="2"><%=common.stringToHTMLString(sCode)%></font></td>
					<td bordercolor="#FFFFFF" width="88%" align="justify" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif"  size="2"><%=common.stringToHTMLString2(sDescp)%><br><%=common.stringToHTMLString2(sNarration)%></font></td>
				</tr>
<%			}
		}
	}
}
%>
</table>

<%}%>
</html>