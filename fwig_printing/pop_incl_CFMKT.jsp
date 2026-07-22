<%@ page language="java" import="java.util.*" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<%
	String TYPE 	    = common.setNullToString(request.getParameter("CNTYPE"));
	String CFMKT_IND    = common.setNullToString(request.getParameter("CFMKT_IND"));
	String CONTACT_TYPE = common.setNullToString(request.getParameter("CONTACT_TYPE"));
	String CNCODE 	    = common.setNullToString(request.getParameter("CNCODE"));
	String NAME 	    = common.setNullToString(request.getParameter("NAME"));
	String VEHNO 	    = common.setNullToString(request.getParameter("VEHNO"));
	String GUARANTEE 	= common.setNullToString(request.getParameter("GUARANTEE"));

	if (!CNCODE.equals(""))
	{
		if (CNCODE.startsWith("08"))
			CNCODE = CNCODE.substring(2, CNCODE.length());
	}
	
%>
<html>
	<table cellspacing="0" cellpadding="0" width="100%" border="0">
	
 	<%if(!GUARANTEE.equals("Y")){%>
		<tr>
			<td colspan ="6" height="150" >
			&nbsp;
				<!-- img src="../common/jpg/getjpg.jsp?fn=/kib.jpg" height="40" width="135" -->
			</td>
		</tr>
	<%}%>
		<tr>
	  		<td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="27%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
		<tr>
		    <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"></font></td>
			<td align="left" colspan="5" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>INSURED NAME : <%=NAME%></b></font></td>
		</tr>
		<%if(TYPE.equals("MOTOR")){%>
		<tr>
	  		<td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="27%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
		<tr>
		    <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"></font></td>
			<td align="left" colspan="5" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>VEHICLE NUMBER : <%=VEHNO%></b></font></td>
		</tr>
		<%}%>
		<tr>
	  		<td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="27%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  	    <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"></font></td>
			<td align="left" colspan="5" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>COVER NOTE NO : <%=CNCODE%></b></font></td>
		</tr>
	</table>

<%if(CONTACT_TYPE.equals("B")){%>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="27%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="center" colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><u><b>PRIVACY CLAUSE</b></u></font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>1.0</b></font></td>
            <td align="left" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>PRIVACY CLAUSE</b></font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.1</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">You hereby irrevocably consent, represent, authorise and confirm to Liberty General Insurance Berhad(hereinafter referred to as "the Company") that you have duly obtained the consent of your directors, shareholders, authorised signatories, and employees or such other persons who are insured under the Insurance Policy (collectively 'Third Parties'), for the Company to:</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td colspan="4" align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&nbsp;&nbsp;&nbsp;a.&nbsp;&nbsp;&nbsp;provide the information required by the Company for use in accordance with this Insurance Policy; and</font></td>
        </tr>
        <tr>
            <td  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td colspan="4" align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&nbsp;&nbsp;&nbsp;b.&nbsp;&nbsp;&nbsp;provide the said directors, shareholders, authorised signatories, officers, employees, and other persons with information on <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   the Company's products, services and/or offers which may be of interest and/or financial benefit to them,</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">at the Company's sole discretion, without further reference to you.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.2</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">You agree to undertake the responsibility to update the Company in writing should there be any change to the personal and financial information relating to the Third Parties.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.3</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">The Company reserves the right to amend this Section from time to time at the Company's sole discretion by providing notice to you. </font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.4</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">In the event you have any enquiries or complaints concerning this Privacy Clause or the Third Parties wish to communicate their change in marketing preference, you or the Third Parties may contact the Company as per below details or you may contact the Company's nearest branch to you:</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="57%" valign="top" colspan="3" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br><b>Customer Service Executive, Customer Contact Centre</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br><b>Telephone No</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br><b>E-Mail</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;Liberty</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 300 88 8990</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@libertyinsurance.com.my</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;AmAssurance</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 800 88 6333</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@amassurance.com.my</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%"  valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;Kurnia Insurans</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%"  valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 800 88 3833</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%"  valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@kurnia.com</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
    </table>
<%}else if(CFMKT_IND.equals("Y")){%>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="27%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="center" colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>PRIVACY CLAUSE</b></font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>1.0</b></font></td>
            <td align="left" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>PRIVACY CLAUSE</b></font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.1</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">You confirm that you have read, understood and agree to be bound by the Privacy Notice of Liberty General Insurance Berhad (herein after referred to as "the Company") which is available at our website and the clauses herein, as may relate to the processing of your personal information. For the avoidance of doubt, you agree that the said Privacy Notice shall be deemed to be incorporated by reference into this Insurance Policy. </font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.2</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">In the event you provide personal and/or financial information relating to third parties, including information relating to your next-of-kin and dependents, for the purpose of operating the Insurance Policy with the Company or otherwise subscribing to the Company products and services, you:</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">a.</font></td>
            <td align="justify" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">confirm that you have obtained their consent or are otherwise entitled to provide the information to the Company and for the Company to use it in accordance with this Insurance Policy;</font></td>
        </tr>
        <tr>
            <td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">b.</font></td>
            <td align="justify" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">agree to ensure that the personal and financial information of the said third parties is accurate  and update the Company in writing in the event of any change to the said personal and financial information;and</font></td>
        </tr>
        <tr>
            <td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">c.</font></td>
            <td align="justify" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">agree to the Company's right to terminate the Insurance Policy should such consent be withdrawn by any of the said third parties</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.3</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Even after you have provided the Company with any information, you have the option to withdraw the consent given earlier. In such instances, the Company will have the right to not provide or discontinue the provision of the Insurance Policy that is/are linked with such information.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.4</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">You agree that the Company and its related companies may contact you about products and services and offers, which the Company and its related companies believe may be of interest to you, through various channels of communication.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.5</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">In the event you do not wish to consent to use your  personal data to receive marketing of products and services by the Company and its related companies, you or the Third Parties may contact the Company as per below details or you may contact the Company's nearest Branch to you:</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="57%" valign="top" colspan="3" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br><b>Customer Service Executive, Customer Contact Centre</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br><b>Telephone No</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br><b>E-Mail</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;Liberty</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 300 88 8990</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@libertyinsurance.com.my</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;AmAssurance</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 800 88 6333</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@amassurance.com.my</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%"  valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;Kurnia Insurans</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%"  valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 800 88 3833</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%"  valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@kurnia.com</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.6</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">The Company reserves the right to amend this Section from time to time at the Company's sole discretion by providing notice to you.</font></td>
        </tr>
    </table>
<%}else if(CFMKT_IND.equals("N") || CFMKT_IND.equals("")){%>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="27%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="center" colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>PRIVACY CLAUSE</b></font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>1.0</b></font></td>
            <td align="left" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>PRIVACY CLAUSE</b></font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.1</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">You confirm that you have read, understood and agree to be bound by the Privacy Notice of Liberty General Insurance Berhad (herein after referred to as "the Company") which is available at our website and the clauses herein, as may relate to the processing of your personal information. For the avoidance of doubt, you agree that the said Privacy Notice shall be deemed to be incorporated by reference into this Insurance Policy. </font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.2</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">In the event you provide personal and/or financial information relating to third parties, including information relating to your next-of-kin and dependents, for the purpose of operating the Insurance Policy with the Company or otherwise subscribing to the Company products and services, you:</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">a.</font></td>
            <td align="justify" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">confirm that you have obtained their consent or are otherwise entitled to provide the information to the Company and for the Company to use it in accordance with this Insurance Policy;</font></td>
        </tr>
        <tr>
            <td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">b.</font></td>
            <td align="justify" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">agree to ensure that the personal and financial information of the said third parties is accurate and update the Company in writing in the event of any change to the said personal and financial information; and</font></td>
        </tr>
        <tr>
            <td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">c.</font></td>
            <td align="justify" colspan="3" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">agree to the Company's right to terminate the Insurance Policy should such consent be withdrawn by any of the said third parties</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.3</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">You do not agree that the Company and its related companies may contact you about products and services and offers, which the Company and its related companies believe may be of interest to you, through various channels of communication.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.4</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">In the event you wish to consent to use your  personal data to receive marketing of products and services by the Company and its related companies, you or the Third Parties may contact the Company as per below details or you may contact the Company's nearest Branch to you:</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="57%" valign="top" colspan="3" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br><b>Customer Service Executive, Customer Contact Centre</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br><b>Telephone No</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br><b>E-Mail</b></font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;Liberty</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 300 88 8990</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@libertyinsurance.com.my</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;AmAssurance</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 800 88 6333</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@amassurance.com.my</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>&nbsp;Kurnia Insurans</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="15%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>1 800 88 3833</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="27%" valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><br>customer@kurnia.com</font><br><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="white">.</font></td>
            <td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
        </tr>
        <tr>
            <td align="justify"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
            <td align="left"  valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1.5</font></td>
            <td align="justify" colspan="4" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">The Company reserves the right to amend this Section from time to time at The Company's sole discretion by providing notice to you.</font></td>
        </tr>
    </table>
<%}%>
	<!-- <table cellspacing="0" cellpadding="2" width="100%" border="0" align="right">
		<tr>
	  		<td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="27%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top" colspan="3" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5"><b>Customer Service Executive, Customer Contact Centre</b></font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">Telephone No</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">E-Mail</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">Liberty General Insurance</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">1-300-88-8990</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">customer@libertyinsurance.com.my</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">AmAssurance</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">1-800-88-6333</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">customer@amassurance.com.my</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">Kurnia Insurans</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">1-800-88-3833</font></td>
	  		<td valign="top" bordercolor="#000000" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5">customer@kurnia.com</font></td>
	  		<td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	</table> -->
	
 	<table cellspacing="0" cellpadding="0" width="100%" border="0">
		<tr>
	  		<td width="6%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="7%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="15%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="27%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  		<td width="30%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr> 
	  	<%if(TYPE.equals("MOTOR")){%>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
	  	<tr>
	  		<td colspan="6" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="1.5" color="white">.</font></td>
	  	</tr>
		<tr>
			<td colspan="6" >
				<img src="../common/jpg/getjpg.jsp?fn=/kib-address.jpg" >
			</td>
		</tr>
	 <%}%> 
	</table>
</html>