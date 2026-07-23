<%@ page language="java" import="java.util.*,java.util.Date,java.text.SimpleDateFormat,java.text.DecimalFormat" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB_Template" scope="page" class="com.rexit.easc.DB_Template" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />

<%
	String CNCODE			= "";
    String ISSUEDBY			= "";

	String PRINCIPLE		= "";	
	String ISSTIME			= "";
	String CHECKDIGIT		= "";
	String ALLDIGIT			= "";

    // TB_FWCSCN
    String UKEY						= "";
    String USERID					= "";
	String NAME						= "";
	String ADDRESS_1				= "";
	String ADDRESS_2				= "";
	String ADDRESS_3				= "";
	String ADDRESS_4				= "";
	String ACCODE					= "";
	String POSTCODE					= "";
	String PREVPOL					= "";
	String ISSDATE					= "";	
	String EFFDATE					= "";
	String EXPDATE					= "";
	String CLASS					= "";
	String ENDORSE_NO				= "";
	String STATUS					= "";
	String CNTYPE					= "";

    // TB_USER
    String AGENCY_NAME 				= "";
    String USER_ADDRESS_1 			= "";
    String USER_ADDRESS_2 			= "";
    String USER_ADDRESS_3 			= "";
    String USER_ADDRESS_4 			= "";
    String USER_TEL_NO_HOME     	= "";
    String USER_TEL_NO_OFFICE   	= "";
    String USER_FAX_NO_HOME     	= "";
    String USER_FAX_NO_OFFICE   	= "";
    String USER_MOBILE_NO	    	= "";
    String USER_NAME				= "";
    String ID						= "";
    String ACUSERID					= "";
    String ACCODEID					= "";
    // TB_USER
    
    //TB_AGENT_AM
    String INTERMEDIARY_IND			= "";
    //TB_AGENT_AM
    
	String CATEGORYMSG 				= "";
	String CATEGORYMSG1				= "";
	String REF_MAINPAGE				= "";
	String REF_MAINPAGE1			= "";
	String REPLACECN				= "";
	String GSTPREM					= "";
	
    SimpleDateFormat timestampFormat 	= new SimpleDateFormat("yyyyMMddHHmmss");
    SimpleDateFormat timestampFormat2 	= new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat timestampFormat3 	= new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat timestampFormat4 	= new SimpleDateFormat("hh:mm:ssa");
    SimpleDateFormat timestampFormat5 	= new SimpleDateFormat("dd-MM-yyyy / hh:mm:ssa");
    SimpleDateFormat checkdigitformat 	= new SimpleDateFormat("MMdd");
    DecimalFormat df = new DecimalFormat("00");

    String printOption = common.setNullToString(request.getParameter("option"));
%>

<%
		String TYPE = common.setNullToString(request.getParameter("TYPE"));
		
	    if (TYPE.equals("GRAB"))
	    {
	        CNCODE = common.setNullToString(request.getParameter("CNCODE"));
	    }
	    else
	    {
	        CNCODE = common.setNullToString((String)session.getAttribute("SESCNCODE"));
	    }
	    
		session.setAttribute("SESCNCODE",CNCODE);
%>

<%
        String SQL = "SELECT * FROM TB_FWHSCN WHERE UKEY = '" + CNCODE + "' WITH UR";
        DB_Template.makeConnection();
        DB_Template.executeQuery(SQL);
        while(DB_Template.getNextQuery())
        {
        	UKEY				= common.setNullToString(DB_Template.getColumnString("UKEY"));
        	USERID				= common.setNullToString(DB_Template.getColumnString("USERID"));
        	PRINCIPLE			= common.setNullToString(DB_Template.getColumnString("PRINCIPLE"));
            NAME         		= common.setNullToString(DB_Template.getColumnString("NAME"));
            ADDRESS_1      		= common.setNullToString(DB_Template.getColumnString("ADDRESS_1"));
            ADDRESS_2      		= common.setNullToString(DB_Template.getColumnString("ADDRESS_2"));
            ADDRESS_3      		= common.setNullToString(DB_Template.getColumnString("ADDRESS_3"));
            ADDRESS_4      		= common.setNullToString(DB_Template.getColumnString("ADDRESS_4"));
            ACCODE				= common.setNullToString(DB_Template.getColumnString("ACCODE"));
			CNCODE				= common.setNullToString(DB_Template.getColumnString("CNCODE"));
			POSTCODE			= common.setNullToString(DB_Template.getColumnString("POSTCODE"));
			PREVPOL				= common.setNullToString(DB_Template.getColumnString("PREVPOL"));
			ISSDATE				= common.setNullToString(DB_Template.getColumnString("ISSDATE"));
			EFFDATE				= common.setNullToString(DB_Template.getColumnString("EFFDATE"));
			EXPDATE				= common.setNullToString(DB_Template.getColumnString("EXPDATE"));
			CLASS				= common.setNullToString(DB_Template.getColumnString("CLASS"));
			ISSTIME				= common.setNullToString(DB_Template.getColumnString("CNTIME"));
			ENDORSE_NO			= common.setNullToString(DB_Template.getColumnString("ENDORSE_NO"));
			STATUS				= common.setNullToString(DB_Template.getColumnString("STATUS"));
			CNTYPE				= common.setNullToString(DB_Template.getColumnString("CNTYPE"));
			REPLACECN			= common.setNullToString(DB_Template.getColumnString("REPLACECN"));
        }
		DB_Template.takeDown();
		
		SQL = "SELECT * FROM TB_AGENT_AM WHERE ACCODE = '"+ACCODE+"'WITH UR";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		while(DB_Template.getNextQuery())
		{
			INTERMEDIARY_IND =common.setNullToString(DB_Template.getColumnString("INTERMEDIARY_IND"));
			
		}
		DB_Template.takeDown();
		
		String ORI_CNCODE = common.getKey(CNCODE,"-");
		SQL = "SELECT * FROM TB_USER_AM WHERE USERID = '" + USERID + "' WITH UR";
        DB_Template.makeConnection();
        DB_Template.executeQuery(SQL);
        while(DB_Template.getNextQuery())
        {
            AGENCY_NAME         = common.setNullToString(DB_Template.getColumnString("AGENCY_NAME"));
            USER_ADDRESS_1      = common.setNullToString(DB_Template.getColumnString("USER_ADDRESS_1"));
            USER_ADDRESS_2      = common.setNullToString(DB_Template.getColumnString("USER_ADDRESS_2"));
            USER_ADDRESS_3      = common.setNullToString(DB_Template.getColumnString("USER_ADDRESS_3"));
            USER_ADDRESS_4      = common.setNullToString(DB_Template.getColumnString("USER_ADDRESS_4"));

            USER_TEL_NO_HOME    = common.setNullToString(DB_Template.getColumnString("TEL_NO_HOME"));
            USER_TEL_NO_OFFICE  = common.setNullToString(DB_Template.getColumnString("TEL_NO_OFFICE"));
            USER_FAX_NO_HOME    = common.setNullToString(DB_Template.getColumnString("FAX_NO_HOME"));
            USER_FAX_NO_OFFICE  = common.setNullToString(DB_Template.getColumnString("FAX_NO_OFFICE"));
            USER_NAME        	= common.setNullToString(DB_Template.getColumnString("USER_NAME"));
            USER_MOBILE_NO     	= common.setNullToString(DB_Template.getColumnString("MOBILE_NO"));
        }
		DB_Template.takeDown();

		
        ISSUEDBY	= USER_NAME+"<br>"+AGENCY_NAME+"<br>"+USER_ADDRESS_1+"<br>"+USER_ADDRESS_2+"<br>"+USER_ADDRESS_3+"<br>"+USER_ADDRESS_4+"<br> Tel : "+USER_TEL_NO_OFFICE+"<br> Fax : "+USER_FAX_NO_OFFICE;
%>

<%
		if(!ISSDATE.equals(""))
            ISSDATE = timestampFormat2.format(timestampFormat3.parse(ISSDATE));

        if(!EFFDATE.equals(""))
            EFFDATE = timestampFormat2.format(timestampFormat3.parse(EFFDATE));

        if(!EXPDATE.equals(""))
            EXPDATE = timestampFormat2.format(timestampFormat3.parse(EXPDATE));
        
%>

<%
		CATEGORYMSG		= "ENDORSEMENT SCHEDULE";
		CATEGORYMSG1	= "JADUAL ENDORSEMEN";
		REF_MAINPAGE	= "UW-NM-F083";
		REF_MAINPAGE1	= "REV : A";

		ALLDIGIT	= CNCODE.substring(CNCODE.length()-2,CNCODE.length())+"*"+checkdigitformat.format(timestampFormat2.parseObject(ISSDATE))+"*"+CLASS;	
		CHECKDIGIT	= common.jumbleAlternate(ALLDIGIT);
		
		session.setAttribute("CATEGORYMSG",CATEGORYMSG);
		session.setAttribute("CATEGORYMSG1",CATEGORYMSG1);
		
		//generate print information
	    String sCounter = "";
	    String sSAVETIME = timestampFormat.format(new Date());
	    if (TYPE.equals("GRAB"))
	    {
	        DB_Contact.makeConnection();
	        sCounter = DB_Contact.getNextCounterNo(UKEY,"FWHS",sSAVETIME,CHECKDIGIT,"EP");
	        DB_Contact.takeDown();
	    }
	    session.setAttribute("SES_PRINCIPLE",PRINCIPLE);
%>
<%
	//rajesh 20080325
	String ISS_CNTIME1		= "";
	java.util.Date d1= timestampFormat2.parse(EFFDATE);
	java.util.Date d2= timestampFormat2.parse(ISSDATE);

	if(d1.equals(d2))
	{
		ISS_CNTIME1 = ISSTIME;
	}
	else if(d1.after(d2))
	{
		ISS_CNTIME1 = "00:00:01AM";
	}
	
	String SUMINS 	= "0.00";
	String NETPREM	= "0.00";
	String CANCELREMARK2 = "";
	
	String SUBCLS	= "";
	SQL = "SELECT SUBCLS FROM TB_FWHSSCH WHERE UKEY2 = '" + UKEY + "' WITH UR";
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    if(DB_Template.getNextQuery())
    {
        SUBCLS      = common.setNullToString(DB_Template.getColumnString("SUBCLS"));
    }
    DB_Template.takeDown();
    if(SUBCLS.equals("")) SUBCLS = "M-GC";
    
	
	if(STATUS.equals("CANCELLED"))
	{
		SQL = "SELECT SUMINS, NETPREM FROM TB_FWHSSCH WHERE UKEY2 = '" + UKEY + "' WITH UR";
	    DB_Template.makeConnection();
	    DB_Template.executeQuery(SQL);
	    if(DB_Template.getNextQuery())
	    {
	        SUMINS      = common.setNullToString(DB_Template.getColumnString("SUMINS"));
	        NETPREM     = common.setNullToString(DB_Template.getColumnString("NETPREM"));
	    }
	    DB_Template.takeDown();
	    if (!SUMINS.equals(""))
			SUMINS		= "-"+common.twoDecimal(common.formatdouble(SUMINS)); 
		if (!NETPREM.equals("")){
			GSTPREM		= common.twoDecimal(common.formatdouble(NETPREM)); 
			NETPREM		= "-"+common.twoDecimal(common.formatdouble(NETPREM));
		}
		
		SQL = "SELECT CANCELREMARK2 FROM TB_TRANSACTION WHERE TYPE='CN' AND IDNO = '" + UKEY + "' WITH UR";
	    DB_Template.makeConnection();
	    DB_Template.executeQuery(SQL);
	    if(DB_Template.getNextQuery())
	    {
	        CANCELREMARK2      = common.setNullToString(DB_Template.getColumnString("CANCELREMARK2"));
	    }
	    DB_Template.takeDown();
	}else if(STATUS.equals("PRINTED") || (STATUS.equals("SUBMITTED")))
	{
		String ORI_SUMINS	= "";
		String ORI_NETPREM	= "";
		String temp_SUMINS	= "";
		String temp_NETPREM	= "";
		SQL = "SELECT SUMINS, NETPREM FROM TB_FWHSSCH WHERE UKEY2 = '" +PRINCIPLE+REPLACECN+ "' WITH UR";
	    DB_Template.makeConnection();
	    DB_Template.executeQuery(SQL);
	    if(DB_Template.getNextQuery())
	    {
	        ORI_SUMINS		= common.setNullToString(DB_Template.getColumnString("SUMINS"));
	        ORI_NETPREM		= common.setNullToString(DB_Template.getColumnString("NETPREM"));
	    }
	    DB_Template.takeDown();
	    
		SQL = "SELECT SUMINS, NETPREM FROM TB_FWHSSCH WHERE UKEY2 = '" + UKEY + "' WITH UR";
	    DB_Template.makeConnection();
	    DB_Template.executeQuery(SQL);
	    if(DB_Template.getNextQuery())
	    {
	        temp_SUMINS		= common.setNullToString(DB_Template.getColumnString("SUMINS"));
	        temp_NETPREM	= common.setNullToString(DB_Template.getColumnString("NETPREM"));
	    }
	    DB_Template.takeDown();
	    
	    if (ORI_SUMINS.equals("")){ORI_SUMINS		= "0.00"; }
	    if (ORI_NETPREM.equals("")){ORI_NETPREM		= "0.00"; }
	    if (temp_SUMINS.equals("")){temp_SUMINS		= "0.00"; }
	    if (temp_NETPREM.equals("")){temp_NETPREM	= "0.00"; }
	    
	    SUMINS	= String.valueOf(common.formatdouble(common.fnCutComma(ORI_SUMINS)) - common.formatdouble(common.fnCutComma(temp_SUMINS)));
	    NETPREM	= String.valueOf(common.formatdouble(common.fnCutComma(ORI_NETPREM)) - common.formatdouble(common.fnCutComma(temp_NETPREM)));
	    
	    if (!SUMINS.equals("") && !SUMINS.startsWith("0.0"))
			SUMINS		= "-"+common.twoDecimal(common.formatdouble(SUMINS)); 
		if (!NETPREM.equals("") && !NETPREM.startsWith("0.0")){
			GSTPREM		= common.twoDecimal(common.formatdouble(NETPREM)); 
			NETPREM		= "-"+common.twoDecimal(common.formatdouble(NETPREM));
		}
		
		SUMINS		= common.twoDecimal(common.formatdouble(common.fnCutComma(SUMINS))); 
		NETPREM		= common.twoDecimal(common.formatdouble(common.fnCutComma(NETPREM)));
	}
	
	if(CANCELREMARK2.equals(""))
	{
		if(CNTYPE.equals("ECS_WORKER_DET"))
			CANCELREMARK2 = "Amendment of worker details (Name of Worker, Sex, Occupation Sector, Date of Birth, Passport No, Country of Origin, Insured Status).";
		else if(CNTYPE.equals("ECS_POC"))
			CANCELREMARK2 = "Amendment of period of insurance.";
	}
	String seqno			= "";
	String emp_name			= "";
	String occpsec			= "";
	String dob				= "";
	String gender			= "";
	String passport			= "";
	String nationality		= "";
	String work_exp			= "";
	String ins_status		= "";
	String term_ind			= "";
	
	String seqno1			= "";
	String emp_name1		= "";
	String occpsec1			= "";
	String dob1				= "";
	String gender1			= "";
	String passport1		= "";
	String nationality1		= "";
	String work_exp1		= "";
	String ins_status1		= "";
	String term_ind1		= "";
	
	int iCounter 			= 0;
	String item_no 			= "";
	Vector vItem 			= new Vector();
	
	if(!STATUS.equals("CANCELLED"))
	{
	    SQL = "SELECT * FROM TB_FWHSITEM WHERE UKEY LIKE '"+UKEY+"$%' ORDER BY CAST(SEQNO AS INTEGER) WITH UR";
	    DB_Template.makeConnection();
	    DB_Template.executeQuery(SQL);
	    while(DB_Template.getNextQuery())
	    {
	    	seqno				= common.setNullToString(DB_Template.getColumnString("SEQNO")).trim();
			emp_name			= common.setNullToString(DB_Template.getColumnString("EMP_NAME")).trim();
			occpsec				= common.setNullToString(DB_Template.getColumnString("OCCPSEC")).trim();
			dob					= common.setNullToString(DB_Template.getColumnString("DOB")).trim();
			gender				= common.setNullToString(DB_Template.getColumnString("GENDER")).trim();
			passport			= common.setNullToString(DB_Template.getColumnString("PASSPORT")).trim();
			nationality			= common.setNullToString(DB_Template.getColumnString("NATIONALITY")).trim();
			work_exp			= common.setNullToString(DB_Template.getColumnString("WORK_EXP")).trim();
			ins_status			= common.setNullToString(DB_Template.getColumnString("INS_STATUS")).trim();
			term_ind			= common.setNullToString(DB_Template.getColumnString("TERM_DATE")).trim();
			
			SQL = "SELECT * FROM TB_FWHSITEM WHERE UKEY = '"+PRINCIPLE+REPLACECN+"$1$"+seqno+"' WITH UR";

		    DB_Contact.makeConnection();
		    DB_Contact.executeQuery(SQL);
		    if(DB_Contact.getNextQuery())
		    {
				emp_name1			= common.setNullToString(DB_Contact.getColumnString("EMP_NAME")).trim();
				occpsec1			= common.setNullToString(DB_Contact.getColumnString("OCCPSEC")).trim();
				dob1				= common.setNullToString(DB_Contact.getColumnString("DOB")).trim();
				gender1				= common.setNullToString(DB_Contact.getColumnString("GENDER")).trim();
				passport1			= common.setNullToString(DB_Contact.getColumnString("PASSPORT")).trim();
				nationality1		= common.setNullToString(DB_Contact.getColumnString("NATIONALITY")).trim();
				work_exp1			= common.setNullToString(DB_Contact.getColumnString("WORK_EXP")).trim();
				ins_status1			= common.setNullToString(DB_Contact.getColumnString("INS_STATUS")).trim();
				term_ind1			= common.setNullToString(DB_Contact.getColumnString("TERM_DATE")).trim();
			}
			else
			{
				emp_name1 	= "";
				occpsec1	= "";
				dob1		= "";
				gender1 	= "";
				passport1	= "";
				nationality1= "";
				work_exp1	= "";
				ins_status1	= "";
				term_ind1	= "";
			}
			
			DB_Contact.takeDown();

			Vector vRow = new Vector();
			vRow.addElement(seqno);				
			vRow.addElement(emp_name);
			vRow.addElement(occpsec);
			vRow.addElement(dob);
			vRow.addElement(gender);
			vRow.addElement(passport);
			vRow.addElement(nationality);
			vRow.addElement(work_exp);
			vRow.addElement(ins_status);
			vRow.addElement(term_ind);
			vItem.addElement(vRow);
		}
		DB_Template.takeDown();
	}
%>
<%
	String specialAgent = "";
	
	SQL = "SELECT FWIG_SIGN FROM TB_AGENT_AM WHERE INSCODE='08' AND ACCODE='"+ACCODE+"' WITH UR";
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
        specialAgent         = common.setNullToString(DB_Template.getColumnString("FWIG_SIGN"));
    }
	DB_Template.takeDown();
	
	//GST
	String GST_AMT			= "";
	String GST_PCT			= "";
	String GST_RT			= "";
	String GST_TAX_NO 		= "";
	String GST_IND			= "";
	String TITLE_GST 		= "";
	String CNSTATUS			= "";
	String GST_TRIGGER		= "";
	String GST_NO			= "";
	String strISSDATE		= timestampFormat3.format(timestampFormat2.parse(ISSDATE));
    String POLTYPE2	 		= common.setNullToString(request.getParameter("POLTYPE2"));
	String DEBIT_CREDIT		= "";
	SQL = "SELECT * FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='GST' AND CODE='GST_DATE' AND VALUE1<='"+strISSDATE+"' WITH UR";
    DB_Contact.makeConnection();
    DB_Contact.executeQuery(SQL);
	if(DB_Contact.getNextQuery())
	{
		GST_TRIGGER = "Y";
	}
	DB_Contact.takeDown();	
	
	if(NETPREM.equals("")||NETPREM.equals("0.00")||NETPREM.equals("-0.00")){
		GST_TRIGGER = "";
	}
	
	SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + PRINCIPLE + PREVPOL + "' WITH UR"; 

    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    if(DB_Template.getNextQuery())
    {
    	GST_IND	= "Y";
    }
	DB_Template.takeDown();	
	SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + PRINCIPLE+REPLACECN + "' WITH UR"; 
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
    	GST_PCT			= common.setNullToString(DB_Template.getColumnString("GST_PCT"));
    	GST_AMT			= common.setNullToString(DB_Template.getColumnString("GST_AMT"));
    	GST_RT			= common.setNullToString(DB_Template.getColumnString("GST_RT"));
    	GST_TAX_NO		= common.setNullToString(DB_Template.getColumnString("GST_TAX_NO"));
    }
	DB_Template.takeDown();	
	if (!GST_PCT.equals(""))
		GST_PCT		= common.fnFormatNumber(GST_PCT,0);
	else
		GST_PCT		= "0";
		
	if (!GST_AMT.equals(""))
		GST_AMT   	= common.twoDecimal(common.formatfloat(GST_AMT));	
	else
		GST_AMT		= "0.00";
		
	SQL = "SELECT CNSTATUS FROM TB_TRANSACTION WHERE IDNO = '" + UKEY + "' WITH UR"; 
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
    	CNSTATUS			= common.setNullToString(DB_Template.getColumnString("CNSTATUS"));
    }
	DB_Template.takeDown();	
	if(!GST_TAX_NO.equals("")){
		if((CNSTATUS.equals("CANCELLED")||CNSTATUS.equals("CANCELLED/REPLACED"))&&POLTYPE2.equals("Y")&&GST_TRIGGER.equals("Y")){
			TITLE_GST 		= "CREDIT NOTE";
			DEBIT_CREDIT 	= "Y";
			SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" +PRINCIPLE+REPLACECN+ "' WITH UR"; 
		    DB_Template.makeConnection();
		    DB_Template.executeQuery(SQL);
		    while(DB_Template.getNextQuery())
		    {
		    	GST_TAX_NO		= common.setNullToString(DB_Template.getColumnString("GST_TAX_NO_END"));
		    }
			DB_Template.takeDown();	
		}else if(GST_IND.equals("Y")){
			DEBIT_CREDIT 	= "Y";
			TITLE_GST = "DEBIT NOTE";
		}else if(ENDORSE_NO.equals("")){
			TITLE_GST = "TAX INVOICE";
		}
	}
	String sGST_TAX_NO = "";
	if(!NETPREM.equals("0.00")){
		sGST_TAX_NO = GST_TAX_NO;
	}
	
	//=====================
    //privacy clause setting
    String privacyEN = common.setNullToString(request.getParameter("privacyEN"));
    String privacyBM = common.setNullToString(request.getParameter("privacyBM"));
%>
<html>
<head>
<title>FWHS POLICY SCHEDULE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
</head>
<body bgcolor="#FFFFFF" text="#000000">

<jsp:include page="/template/pop_incl_h1.jsp">
        <jsp:param name="category"          	value="<%=CATEGORYMSG%>" />
        <jsp:param name="category1"     	value="<%=CATEGORYMSG1%>" />
        <jsp:param name="ref_mainpage"		value="<%=REF_MAINPAGE%>" />
        <jsp:param name="ref_mainpage1"     	value="<%=REF_MAINPAGE1%>" />
        <jsp:param name="printoption"     	value="<%=printOption%>" />
        <jsp:param name="TITLE_GST"     	value="<%=TITLE_GST%>" />
        <jsp:param name="GST_TRIGGER"     	value="<%=GST_TRIGGER%>" />
        <jsp:param name="GST_TAX_NO"     	value="<%=sGST_TAX_NO%>" />
</jsp:include>

<table width="100%" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td bordercolor="#000000" rowspan="4" width="40%" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Name and Address of Insured / </font>
    <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><i>Nama dan Alamat Pihak Diinsuranskan</i><br>
      <b><%=common.stringToHTMLString(NAME.toUpperCase())%></b><br>
      <%if(!ADDRESS_1.equals("")) {%>
      <b><%=common.stringToHTMLString(ADDRESS_1.toUpperCase())%></b><br>
      <%}
      	if(!ADDRESS_2.equals("")) {
      %>
      <b><%=common.stringToHTMLString(ADDRESS_2.toUpperCase())%></b><br>
      <%}
      	if(!ADDRESS_3.equals("")) {
      %>      
      <b><%=common.stringToHTMLString(ADDRESS_3.toUpperCase())%></b><br>
      <%}
      	if(!ADDRESS_4.equals("")) {
      %>      
      <b><%=common.stringToHTMLString(ADDRESS_4.toUpperCase())%></b><br>
      <%}
      %>
      <b><%=common.stringToHTMLString(POSTCODE.toUpperCase())%></b>
      </font></td>
    
    <td bordercolor="#000000" width="30%" valign="middle"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Class Code / <i>Kod Class</i><br><b><%=common.stringToHTMLString(SUBCLS)%></b></font></td>
    <td bordercolor="#000000" width="30%" valign="middle"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Class Description / <i>Deskripsi Kelas</i><br><b>GROUP MEDICAL (GUARANTEED ADMISSION - YEARLY)</b></font></td>
  </tr>
  <% if (specialAgent.equals("Y")) { %>
  <tr>
    <td bordercolor="#000000" valign="middle" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code / <i>Kod Ejen</i><br><b><%=common.stringToHTMLString(ACCODE)%></b></font></td>
  </tr>
  <% }else{ %>
  <tr>
    <td bordercolor="#000000" valign="middle"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code / <i>Kod Ejen</i><br><b><%=common.stringToHTMLString(ACCODE)%></b></font></td>
    <td bordercolor="#000000" valign="middle"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Name / <i>Nama Ejen</i><br><b><%=common.stringToHTMLString(AGENCY_NAME)%></b></font></td>
  </tr>
  <% } %>
  <tr>
    <td bordercolor="#000000" valign="middle"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">e-Policy No / <i>e-Polisi No</i><br><b><%=common.stringToHTMLString(ORI_CNCODE)%></b></font></td>
    <td bordercolor="#000000" valign="middle"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Endorsement No / <i>No Endorsemen</i><br><b><%=common.stringToHTMLString(CNCODE)%></b></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Effective Date / <i>Tarikh Mula</i><br><b><%=ISS_CNTIME1%> <%=common.stringToHTMLString(EFFDATE)%></b></font></td>
    <td bordercolor="#000000" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Period of Insurance / <i>Tempoh Insurans</i><br>From <b><%=common.stringToHTMLString(EFFDATE)%> </b> To <b><%=common.stringToHTMLString(EXPDATE)%></b></font></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td bordercolor="#000000" width="25%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Revised Sum Insured<br><i>Jumlah Semakan Insuran</i><br>RM<br><br><b><%=SUMINS%></b></font></td>
		<td bordercolor="#000000" width="25%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Future Annual Premium<br><i>Premium Pada Tahunan Hadapan</i><br>RM<br><br><b>0.00</b></font></td>
		<%if(!GST_TAX_NO.equals("")&&GST_TRIGGER.equals("Y")&&DEBIT_CREDIT.equals("Y")&&NETPREM.equals("0.00")){%>
		<td bordercolor="#000000" width="15%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
		Additional Premium
		<br><br>
		GST <%=GST_PCT%>%
		<br><br>
		Total (Incl. GST)
		</font></td>
		<td bordercolor="#FFFFFF" width="10%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
		RM 0.00 
		<br><br>
		RM <%=GST_AMT%> 
		<br><br>
		RM <%=GSTPREM%> 
		</font></td>
		<%}else{%>
		<td bordercolor="#000000" width="25%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Additional Premium<br><i>Premium Tambahan</i><br>RM<br><br><b>0.00</b></font></td>
		<%}%>
		<td bordercolor="#000000" width="25%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Refund Premium<br><i>Premium Bayar Balik</i><br>RM<br><br><b><%=NETPREM%></b></font></td>
	</tr>
</table>

<table width="100%" border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td bordercolor="#FFFFFF" width="100%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">The following changes are made to the Policy as from the effective date and subject always to all the Terms, Exceptions and Conditions of the Policy unless expressly varied: -</font></td>
	</tr>
	<tr>
    <td valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(CANCELREMARK2)%></b></font>
    </td>
    </tr>
    <% if(vItem!=null && vItem.size()==0){%>
	<tr>
		<td height="10"><br><br><br><br><br><br></td>
	</tr>
	<%}%>
</table>
<%if(vItem.size()>0){%>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
<tr>
    <td bordercolor="#FFFFFF" width="8%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">ID Card No.<br><i>No. Kad ID</i></font></td>
    <td bordercolor="#FFFFFF" width="22%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Name Of Worker / Sex<br><i>Nama Pekerja / Jantina</i></font></td>
    <td bordercolor="#FFFFFF" width="18%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Occp.Sector<br>Code/ <i>Kod Sektor Pekerjaan</i></font></td>
    <td bordercolor="#FFFFFF" width="10%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Date Of Birth<br><i>Tarikh Lahir</i></font></td>
    <td bordercolor="#FFFFFF" width="10%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Passport No.<br><i>No. Passport</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Country Of Origin<br><i>Negara Asal</i></font></td>
    <td bordercolor="#FFFFFF" width="10%" align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Insured Status<br><i></i></font></td>
    <td bordercolor="#FFFFFF" width="10%" align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Terminate Ind.<br><i></i></font></td>
  </tr>
<% if(vItem!=null){
	String id_no = "";
	int k=1;
	DecimalFormat df1 	= new DecimalFormat("0000");
	for(int i=0; i<vItem.size(); i++){
		id_no = df1.format(k);
		Vector vItemNo			= (Vector) vItem.elementAt(i);
		String sItemNo			= (String) vItemNo.elementAt(0);
		String sEmp_Name		= (String) vItemNo.elementAt(1);
		String sOccpsec			= (String) vItemNo.elementAt(2);
		String sDob				= (String) vItemNo.elementAt(3);
		String sGender			= (String) vItemNo.elementAt(4);
		String sPassport		= (String) vItemNo.elementAt(5);
		String sNationality		= (String) vItemNo.elementAt(6);
		String sWork_Exp		= (String) vItemNo.elementAt(7);
		String sIns_Status		= (String) vItemNo.elementAt(8);
		String sTerm_Ind		= (String) vItemNo.elementAt(9);

		if(!sTerm_Ind.equals("")) 
			sTerm_Ind = "Y";
		else
			sTerm_Ind = "-";
			
        if(!sDob.equals(""))
            sDob = timestampFormat2.format(timestampFormat3.parse(sDob));		

		SQL	= "SELECT DESCP FROM TB_FWIGPREM WHERE NATIONALITY = '"+sNationality+"' AND INSCODE = '"+PRINCIPLE+"' WITH UR";
		String sCountry	= "";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		if(DB_Template.getNextQuery())
			sCountry	= common.setNullToString(DB_Template.getColumnString("DESCP"));
		DB_Template.takeDown();
		
		SQL = "SELECT DESCP FROM TB_OCCUPSECTOR WHERE CODE = '"+sOccpsec+"' AND INSCODE = '"+PRINCIPLE+"' WITH UR";
		String sOccupDesc	= "";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		if(DB_Template.getNextQuery())
			sOccupDesc	= common.setNullToString(DB_Template.getColumnString("DESCP"));
		DB_Template.takeDown();
		k++;
%>
  <tr>
    <td bordercolor="#FFFFFF" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=id_no%></b></font></td>
    <td bordercolor="#FFFFFF" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sEmp_Name)%> (<%=common.stringToHTMLString(sGender)%>)</b></font></td>
    <td bordercolor="#FFFFFF" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sOccupDesc)%></b></font></td>
    <td bordercolor="#FFFFFF" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sDob)%></b></font></td>
    <td bordercolor="#FFFFFF" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sPassport)%></b></font></td>
    <td bordercolor="#FFFFFF" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sCountry)%></b></font></td>
    <td bordercolor="#FFFFFF" align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sIns_Status)%></b></font></td>
    <td bordercolor="#FFFFFF" align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sTerm_Ind)%></b></font></td>
  </tr>
<%
	}
   }
%>
</table>
<%}%>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
		<td width="40%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
		<td width="35%" valign="bottom" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">For                                                   <br><b>Liberty General Insurance Berhad<%if(!GST_TRIGGER.equals("")){%><%=GST_NO%><%}%></b></font></td>
	</tr>
	<tr>
		<td valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br><br><br><br><br><br><br><br><br><%if(!PREVPOL.equals("")){%>Original policy Tax Invoice:<%}%><br>Date of Issue / Time</font></td>
		<td valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br><br><br><br><br><br><br><br><br><%if(!PREVPOL.equals("")){%><%=PREVPOL%><%}%><br><b><%=common.stringToHTMLString(ISSDATE)%> / <%=common.stringToHTMLString(ISSTIME)%></b></font></td>
		<td valign="bottom" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><img src="../common/jpg/getjpg.jsp?fn=/Liberty_Auto_Signature.png" width="140" height="30" valign="bottom" align="right"><br>_____________________________<br>Authorised Signature / <br><i>Tandatangan Yang Diberi Kuasa</i></font></td>
	</tr>
</table>
<PAGEBREAK_INC></PAGEBREAK_INC>
<% if (!GST_TAX_NO.equals("") ){ %>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/pop_incl_tax_invoice.jsp">
<jsp:param name="UKEY"         	    value="<%=PRINCIPLE+CNCODE%>" />
</jsp:include> 
<%if (INTERMEDIARY_IND.equals("Y")) {%>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/pop_incl_tax_invoice_intermediary.jsp">
<jsp:param name="UKEY"         	    value="<%=PRINCIPLE+CNCODE%>" />
</jsp:include> 
<%} %>
<%} %>
<%-- <%if (privacyEN.equals("Y") && !CNTYPE.equals("RN")) {%>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/privacynoticeEN.jsp">
</jsp:include> 
<%} %>
<%if (privacyBM.equals("Y") && !CNTYPE.equals("RN")) {%>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/privacyclauseBM.jsp">
</jsp:include> 
<%} %> --%> 
</body>
</html>