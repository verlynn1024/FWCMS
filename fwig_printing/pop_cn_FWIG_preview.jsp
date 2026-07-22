<%@ page language="java" import="java.util.*,java.util.Date,java.text.SimpleDateFormat" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB_Template" scope="page" class="com.rexit.easc.DB_Template" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="EnglishDecimalFormat" scope="page" class="com.rexit.easc.EnglishDecimalFormat" />
<%
	//20060601 - kcong - To add the justify for the letter printing
	//         -         and print full address.
	//20060606 - kcong - Change the font size to 2.5 instead of 3.
	//20060607 - kcong - Adjust the wording according to user new requirement.
	//20060612 - kcong - Change the wording guarantee to Guarantee to according to user requirement.
	//20060719 - kcong - To incorporate authorised signature.
	//20060721 - kcong - To solve problem in TB_BRANCH selection by PRINCIPLE.
	String CNCODE					= "";
	String POLNO					= "";

	// TB_FWIGCN
	String UKEY						= "";
	String ISSDATE					= "";
	String EFFDATE					= "";
	String EXPDATE					= "";
	String NAME						= "";
	String ADDRESS_1				= "";
	String ADDRESS_2				= "";
	String ADDRESS_3				= "";
	String ADDRESS_4				= "";
	String STATE					= "";
	String PRINCIPLE				= "";
	String ACCODE					= "";
	String POSTCODE					= "";
	String USERID					= "";
	// TB_FWIGCN
	
	// TB_FWIGSCH
	String SUMINS					= "";
	String BCHRG					= "";
	double dBCHRG					= 0;
	String FWCMSREFNO				= "";
	
	// STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
	String STAMP_FEES = "";
	// TB_FWIGSCH

	// TB_FWIGMAST
	String IMMI_NAME				= "";
	//String IMMI_ADDRESS_1			= "";
	//String IMMI_ADDRESS_2			= "";
	//String IMMI_ADDRESS_3			= "";
	//String IMMI_ADDRESS_4			= "";
	String IMMI_ADDRESS				= "";
	String IMMI_POSTCODE			= "";
	String EMP_NAME					= "";
	String EMP_PASSPORT				= "";
	String EMP_NATIONALITY			= "";
	String EMP_GENDER				= "";
	String EMP_AMOUNT				= "";
	String SUM_NATIONALITY			= "";
	String SUM_NOOFWORKER			= "";
	String SUM_AMOUNT				= "";
	String SUM_TOT_AMOUNT			= "";
	String TOT_AMOUNT				= "";
	// TB_FWIGMAST
	
	// TB_MAINPRINCIPLE
	String PRINCIPLE_NAME			= "";
	// TB_MAINPRINCIPLE

	// TB_BRANCH
	String BR_NAME					= "";
	String BR_ADD1					= "";
	String BR_ADD2					= "";
	String BR_ADD3					= "";
	String BR_ADD4					= "";
	String BR_POSTCODE				= "";
	// TB_BRANCH
	
	// TB_NATIONALITY
	String NATIONALITY_DESCP 		= "";
	// TB_NATIONALITY
	
	//TB_AGENT_AM
    String INTERMEDIARY_IND			= "";
    //TB_AGENT_AM
	
	String CFMKT_IND 				= "";
    String CONTACT_TYPE				= "";
    String CNTYPE					= "";
    String dbISSDATE				= "";
	

    SimpleDateFormat timestampFormat 	= new SimpleDateFormat("yyyyMMddHHmmss");
    SimpleDateFormat timestampFormat2 	= new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat timestampFormat3 	= new SimpleDateFormat("yyyyMMdd");
    
    String TYPE = common.setNullToString(request.getParameter("TYPE"));

    String AMTDESC 		= ""; 
    
    String TABLE 		= common.setNullToString((String)session.getAttribute("SES_TABLE"));
    String TABLE_MST 	= common.setNullToString((String)session.getAttribute("SES_TABLE_MST"));
    String TABLE_SCH 	= common.setNullToString((String)session.getAttribute("SES_TABLE_SCH"));

    if (TYPE.equals("GRAB"))
    {
        CNCODE 		= common.setNullToString(request.getParameter("CNCODE"));
        AMTDESC 	= common.setNullToString(request.getParameter("AMTDESC"));
        TABLE 		= common.setNullToString(request.getParameter("TABLE"));
        TABLE_MST 	= common.setNullToString(request.getParameter("TABLE_MST"));
        TABLE_SCH 	= common.setNullToString(request.getParameter("TABLE_SCH"));
    }
    else
    {
        CNCODE = common.setNullToString((String)session.getAttribute("SESCNCODE"));
        AMTDESC = common.setNullToString(request.getParameter("AMTDESC"));
    }

	String printOption = common.setNullToString(request.getParameter("option")); 
	String AgtStatus	= common.setNullToString(request.getParameter("AgtStatus"));
	AgtStatus			= "A"; //Temporary set to 'A' until summary screen for agent implementation.
	
%>

<%
    String SQL = "SELECT * FROM "+TABLE+" WHERE UKEY ='" + CNCODE + "' WITH UR";
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
    	UKEY			= common.setNullToString(DB_Template.getColumnString("UKEY"));
    	PRINCIPLE		= common.setNullToString(DB_Template.getColumnString("PRINCIPLE"));
    	CNCODE			= common.setNullToString(DB_Template.getColumnString("CNCODE"));
    	POLNO			= common.setNullToString(DB_Template.getColumnString("POLNO"));
    	NAME			= common.setNullToString(DB_Template.getColumnString("NAME"));
    	ADDRESS_1		= common.setNullToString(DB_Template.getColumnString("ADDRESS_1"));
    	ADDRESS_2		= common.setNullToString(DB_Template.getColumnString("ADDRESS_2"));
    	ADDRESS_3		= common.setNullToString(DB_Template.getColumnString("ADDRESS_3"));
    	ADDRESS_4		= common.setNullToString(DB_Template.getColumnString("ADDRESS_4"));
		ISSDATE			= common.setNullToString(DB_Template.getColumnString("ISSDATE"));
		EFFDATE			= common.setNullToString(DB_Template.getColumnString("EFFDATE"));
		EXPDATE			= common.setNullToString(DB_Template.getColumnString("EXPDATE"));
		ACCODE			= common.setNullToString(DB_Template.getColumnString("ACCODE"));
		POSTCODE		= common.setNullToString(DB_Template.getColumnString("POSTCODE"));
		USERID			= common.setNullToString(DB_Template.getColumnString("USERID"));
		STATE			= common.setNullToString(DB_Template.getColumnString("STATE"));
		CONTACT_TYPE    = common.setNullToString(DB_Template.getColumnString("CONTACT_TYPE"));
		CNTYPE    		= common.setNullToString(DB_Template.getColumnString("CNTYPE"));
		dbISSDATE		= common.setNullToString(DB_Template.getColumnString("ISSDATE"));
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
	
	SQL = "SELECT DESCP FROM TB_STATE WHERE INSCODE ='" + PRINCIPLE + "' AND CODE='"+STATE+"' WITH UR";

    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    if(DB_Template.getNextQuery())
    {
    	STATE	= common.setNullToString(DB_Template.getColumnString("DESCP"));
    	STATE	= STATE.toUpperCase();
	}
	DB_Template.takeDown();
	
	// STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
	if(TABLE_SCH.equals("TB_FWIGSCH")){
		SQL = "SELECT * FROM "+TABLE_SCH+" WHERE UKEY2 ='" + UKEY + "' WITH UR";
	
	    DB_Template.makeConnection();
	    DB_Template.executeQuery(SQL);
	    while(DB_Template.getNextQuery())
	    {
	    	SUMINS			= common.setNullToString(DB_Template.getColumnString("SUMINS"));
	    	BCHRG			= common.setNullToString(DB_Template.getColumnString("BCHRGAMT"));
	    	dBCHRG			= common.formatdouble(common.fnCutComma(BCHRG));
	    	CFMKT_IND		= common.setNullToString(DB_Template.getColumnString("CFMKT_IND"));
			STAMP_FEES		= common.setNullToString(DB_Template.getColumnString("STAMP_FEES"));
		}
		DB_Template.takeDown();
	}else{
		SQL = "SELECT * FROM "+TABLE_SCH+" WHERE UKEY2 ='" + UKEY + "' WITH UR";
	
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		while(DB_Template.getNextQuery())
		{
			SUMINS			= common.setNullToString(DB_Template.getColumnString("SUMINS"));
			BCHRG			= common.setNullToString(DB_Template.getColumnString("BCHRGAMT"));
			dBCHRG			= common.formatdouble(common.fnCutComma(BCHRG));
			CFMKT_IND		= common.setNullToString(DB_Template.getColumnString("CFMKT_IND"));
		}
		DB_Template.takeDown();
	}	
	String emp_name 		= "";
	String emp_passport 	= "";
	String emp_nationality	= "";
	String emp_gender		= "";
	String emp_amount		= "";
	String sum_nationality	= "";
	String sum_noofworker 	= "";
	String sum_amount		= "";
	String sum_tot_amount	= "";
	int iNoofEmp	= 0;
	Vector vItem			= new Vector();
	Vector vItem1			= new Vector();

    SQL = "SELECT * FROM "+TABLE_MST+" WHERE UKEY2 ='" + UKEY + "' WITH UR";
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
		IMMI_NAME		= common.setNullToString(DB_Template.getColumnString("IMMI_NAME"));
		IMMI_ADDRESS	= common.setNullToString(DB_Template.getColumnString("IMMI_ADDRESS"));
		IMMI_POSTCODE	= common.setNullToString(DB_Template.getColumnString("IMMI_POSTCODE"));
		EMP_NAME		= common.setNullToString(DB_Template.getColumnString("EMP_NAME"));
		EMP_PASSPORT	= common.setNullToString(DB_Template.getColumnString("EMP_PASSPORT"));
		EMP_NATIONALITY	= common.setNullToString(DB_Template.getColumnString("EMP_NATIONALITY"));
		EMP_GENDER		= common.setNullToString(DB_Template.getColumnString("EMP_GENDER"));
		EMP_AMOUNT		= common.setNullToString(DB_Template.getColumnString("EMP_AMOUNT"));
		SUM_NATIONALITY	= common.setNullToString(DB_Template.getColumnString("SUM_NATIONALITY"));
		SUM_NOOFWORKER	= common.setNullToString(DB_Template.getColumnString("SUM_NOOFWORKER"));
		SUM_AMOUNT		= common.setNullToString(DB_Template.getColumnString("SUM_AMOUNT"));
		SUM_TOT_AMOUNT	= common.setNullToString(DB_Template.getColumnString("SUM_TOT_AMOUNT"));
		TOT_AMOUNT		= common.setNullToString(DB_Template.getColumnString("TOT_AMOUNT"));
		
		com.rexit.easc.StringTokenizer st1	= new com.rexit.easc.StringTokenizer(EMP_NAME,"^","",true);
		com.rexit.easc.StringTokenizer st2	= new com.rexit.easc.StringTokenizer(EMP_PASSPORT,"^","",true);
		com.rexit.easc.StringTokenizer st3	= new com.rexit.easc.StringTokenizer(EMP_NATIONALITY,"^","",true);
		com.rexit.easc.StringTokenizer st4	= new com.rexit.easc.StringTokenizer(EMP_AMOUNT,"^","",true);
		com.rexit.easc.StringTokenizer st9	= new com.rexit.easc.StringTokenizer(EMP_GENDER,"^","",true);
		
		if(!EMP_NAME.equals(""))
		{
			while(st1.hasMoreTokens()){
				Vector vRow		= new Vector();
				emp_name		= st1.nextToken();
				iNoofEmp	+= 1;
				vRow.addElement(emp_name);
	
				if(st2.hasMoreTokens()){
					emp_passport 	= st2.nextToken();
					vRow.addElement(emp_passport);
				}
	
				if(st3.hasMoreTokens()){
					emp_nationality = st3.nextToken();
					vRow.addElement(emp_nationality);
				}
				
				if(st4.hasMoreTokens()){
					emp_amount 		= st4.nextToken();
					vRow.addElement(emp_amount);
				}
				
				if(st9.hasMoreTokens()){
					emp_gender		= st9.nextToken();
					vRow.addElement(emp_gender);
				}
				vItem.addElement(vRow);
			}
			
			com.rexit.easc.StringTokenizer st5	= new com.rexit.easc.StringTokenizer(SUM_NATIONALITY,"^","",true);
			com.rexit.easc.StringTokenizer st6	= new com.rexit.easc.StringTokenizer(SUM_NOOFWORKER,"^","",true);
			com.rexit.easc.StringTokenizer st7	= new com.rexit.easc.StringTokenizer(SUM_AMOUNT,"^","",true);
			com.rexit.easc.StringTokenizer st8	= new com.rexit.easc.StringTokenizer(SUM_TOT_AMOUNT,"^","",true);
	
			while(st5.hasMoreTokens()){
				Vector vRow		= new Vector();
				sum_nationality		= st5.nextToken();
				vRow.addElement(sum_nationality);
	
				if(st6.hasMoreTokens()){
					sum_noofworker 	= st6.nextToken();
					vRow.addElement(sum_noofworker);
				}
	
				if(st7.hasMoreTokens()){
					sum_amount		 = st7.nextToken();
					vRow.addElement(sum_amount);
				}
				
				if(st8.hasMoreTokens()){
					sum_tot_amount	 = st8.nextToken();
					vRow.addElement(sum_tot_amount);
				}
				
				vItem1.addElement(vRow);
			}
		}
		else
		{
			if(SUM_NOOFWORKER.equals("")) SUM_NOOFWORKER = "0";
			iNoofEmp = Integer.parseInt(SUM_NOOFWORKER);
		}
	}
	DB_Template.takeDown();

    SQL = "SELECT * FROM TB_MAINPRINCIPLE WHERE CODE = '" + PRINCIPLE + "' WITH UR";
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
        PRINCIPLE_NAME      	= common.setNullToString(DB_Template.getColumnString("NAME"));
    }   
	DB_Template.takeDown();
	
    SQL = "SELECT * FROM TB_BRANCH,TB_AGENT_AM WHERE TB_BRANCH.INSCODE='"+PRINCIPLE+"' AND TB_AGENT_AM.INSCODE='"+PRINCIPLE+"' AND TB_AGENT_AM.ACCODE='" + ACCODE + "' AND TB_BRANCH.BR_ID = TB_AGENT_AM.BR_ID FETCH FIRST 1 ROW ONLY WITH UR";
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    if(DB_Template.getNextQuery())
    {
    	BR_NAME				    = common.setNullToString(DB_Template.getColumnString("BR_NAME"));
        BR_ADD1				    = common.setNullToString(DB_Template.getColumnString("BR_ADD1"));
        BR_ADD2				    = common.setNullToString(DB_Template.getColumnString("BR_ADD2"));
        BR_ADD3				    = common.setNullToString(DB_Template.getColumnString("BR_ADD3"));
        BR_ADD4					= common.setNullToString(DB_Template.getColumnString("BR_ADD4"));
        BR_POSTCODE				= common.setNullToString(DB_Template.getColumnString("BR_POSTCODE"));
    }
	DB_Template.takeDown();

	if(vItem!=null){
		for(int i=0; i<vItem.size(); i++){
			Vector vItemNo			= (Vector) vItem.elementAt(i);
			String sNationality		= (String) vItemNo.elementAt(2);

	        SQL = "SELECT DESCP FROM TB_FWIGPREM WHERE NATIONALITY = '"+sNationality+"' AND INSCODE = '"+PRINCIPLE+"' FETCH FIRST ROWS ONLY WITH UR";
	        DB_Template.makeConnection();
	        DB_Template.executeQuery(SQL);
	        if(DB_Template.getNextQuery())
	        {
	        	NATIONALITY_DESCP = common.setNullToString(DB_Template.getColumnString("DESCP"));
	        	vItemNo.addElement(NATIONALITY_DESCP);
			}
			DB_Template.takeDown();
			
		}
	}
	
	
	if(vItem1!=null){
		for(int i=0; i<vItem1.size(); i++){
			Vector vItemNo			= (Vector) vItem1.elementAt(i);
			String sNationality		= (String) vItemNo.elementAt(0);

	        SQL = "SELECT DESCP FROM TB_FWIGPREM WHERE NATIONALITY = '"+sNationality+"' AND INSCODE = '"+PRINCIPLE+"' FETCH FIRST ROWS ONLY WITH UR";
	        DB_Template.makeConnection();
	        DB_Template.executeQuery(SQL);
	        if(DB_Template.getNextQuery())
	        {
	        	NATIONALITY_DESCP = common.setNullToString(DB_Template.getColumnString("DESCP"));
	        	vItemNo.addElement(NATIONALITY_DESCP);
			}
			DB_Template.takeDown();
			
		}
	}
%>

<%
	// words coding start
	Vector vItemSumins = new Vector();
	String sumins	= "";
	String sdollar 	= "";
	String scents	= "";
	int	   idollar	= 0;
	int    icents	= 0;	
	com.rexit.easc.StringTokenizer st1	= new com.rexit.easc.StringTokenizer(SUMINS,".","",true);
	String AMOUNT_DESCRIPTION = "";
	
	while(st1.hasMoreTokens()){
		Vector vRow		= new Vector();
		sumins			= st1.nextToken();
		vRow.addElement(sumins);
		vItemSumins.addElement(vRow);
	}

	if(vItemSumins!=null){
			Vector vItemNo1			= (Vector) vItemSumins.elementAt(0);
			String dollar			= (String) vItemNo1.elementAt(0);
			Vector vItemNo2			= (Vector) vItemSumins.elementAt(1);
			String cents			= (String) vItemNo2.elementAt(0);			
			
			idollar	= Integer.parseInt(dollar);
			icents	= Integer.parseInt(cents);
			sdollar = EnglishDecimalFormat.convert(idollar).toUpperCase();
			scents 	= EnglishDecimalFormat.convert(icents).toUpperCase();
	}
			// words coding ended
	if(scents.equals("ZERO")){
		AMOUNT_DESCRIPTION = sdollar;
	}else{
		AMOUNT_DESCRIPTION = sdollar+" & "+scents+" CENTS";
	}

	if(!ISSDATE.equals("")){
		ISSDATE = timestampFormat2.format(timestampFormat3.parse(ISSDATE));
	}

	if(!EFFDATE.equals("")){
		EFFDATE = timestampFormat2.format(timestampFormat3.parse(EFFDATE));
	}

	if(!EXPDATE.equals("")){
		EXPDATE = timestampFormat2.format(timestampFormat3.parse(EXPDATE));
	}
	
	//generate print information
	String sCounter = "";
	String sSAVETIME = timestampFormat.format(new Date());
	if (TYPE.equals("GRAB"))
	{
	    DB_Contact.makeConnection();
	    sCounter = DB_Contact.getNextCounterNo(UKEY,"IG",sSAVETIME,"","EP");
	    DB_Contact.takeDown();
	}
%>
<%
	String ADDRESS = ADDRESS_1.trim();
	if(!ADDRESS_2.equals(""))
	{
		if(ADDRESS_2.endsWith(".")) ADDRESS_2 = ADDRESS_2.substring(0,ADDRESS_2.length()-1)+",";
		ADDRESS += " "+ADDRESS_2.trim();
	}
	if(!ADDRESS_3.equals(""))
	{
		if(ADDRESS_3.endsWith(".")) ADDRESS_3 = ADDRESS_3.substring(0,ADDRESS_3.length()-1)+",";
		ADDRESS += " "+ADDRESS_3.trim();
	}
	if(!ADDRESS_4.equals(""))
	{
		if(ADDRESS_4.endsWith(".")) ADDRESS_4 = ADDRESS_4.substring(0,ADDRESS_4.length()-1)+",";
		ADDRESS += " "+ADDRESS_4.trim();
	}
	if(!POSTCODE.equals(""))
	{
		ADDRESS += " "+POSTCODE.trim();
	}
	
	if(!STATE.equals(""))
	{
		ADDRESS += " "+STATE.trim();
	}
	if(!TABLE.equals("TB_FWIGREF"))
	{
		CNCODE = common.getKey(CNCODE,"-");
	}
	else
	{
		com.rexit.easc.StringTokenizer stCNCODE = new com.rexit.easc.StringTokenizer(CNCODE, "-","",true);
		int cnt = stCNCODE.countTokens();

		if(cnt<=4)
		{

		}
		else
		{
			int pos = CNCODE.lastIndexOf("-");
			CNCODE 	= CNCODE.substring(0,pos);
		}
	}
	
	
    SQL = "SELECT FWCMSREFNO FROM "+TABLE_SCH+" WHERE UKEY2 = '"+PRINCIPLE+CNCODE+"' WITH UR";
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    if(DB_Template.getNextQuery())
    {
    	FWCMSREFNO = common.setNullToString(DB_Template.getColumnString("FWCMSREFNO"));
	}
	DB_Template.takeDown();
%>
<%
	String GST_TAX_NO ="";
	SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + PRINCIPLE + CNCODE + "' WITH UR"; 
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
    	GST_TAX_NO		= common.setNullToString(DB_Template.getColumnString("GST_TAX_NO"));
    }
	DB_Template.takeDown();
	
	
	//=====================
    //privacy clause setting
    String privacyEN = common.setNullToString(request.getParameter("privacyEN"));
    String privacyBM = common.setNullToString(request.getParameter("privacyBM"));
 %>

<html>
<head>
<title>IG</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000">

<table width="900" border="0" cellspacing="0" cellpadding="3">          
  <tr>          
     <td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="3"><b>FOREIGN WORKER INSURANCE GUARANTEE</b></font></td>
  </tr>
  <tr>          
     <td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5">Date:&nbsp;<b><%= common.stringToHTMLString(ISSDATE) %></b></font></td>
  </tr>
  <tr>          
    <td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
  </tr>          
  <tr>          
  <% 
  	int count = 0;
  	String sTemp = IMMI_ADDRESS;
  	StringTokenizer stTemp1 = new StringTokenizer(sTemp,"\n");
	count =  stTemp1.countTokens();
	
  if(IMMI_ADDRESS.indexOf("\n") != -1)
  {
  	IMMI_NAME = IMMI_ADDRESS.substring(0,IMMI_ADDRESS.indexOf("\n"));
  	IMMI_ADDRESS = IMMI_ADDRESS.substring(IMMI_ADDRESS.indexOf("\n")+1);        
  }

  %>
    <td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b><%= common.stringToHTMLString(IMMI_NAME) %></b></font></td>
  </tr>
  <tr>          
    <td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><%=common.stringToHTMLString2(common.searchReplace(IMMI_ADDRESS,"\n","\\n"))%>

    </font></td>
  </tr>
<%	if(count<6)
  	{
		for(int space=0; space<6-count; space++)
	  	{%>
	  	<tr>    
	  	<td align="justify" width="900"><br></td>
	  	</tr>
<%	  	}
	}%>       
  <tr>          
    <td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><br>Dear Sir(s),<br><br></font></td>
  </tr>
          
  <tr>
  	<%if(dBCHRG != 0){%>
    <td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>BANK GUARANTEE NO: <%= common.stringToHTMLString(CNCODE) %> FOR RM<%=common.stringToHTMLString(common.twoDecimal(common.formatfloat(SUMINS)))%> EXPIRING <%=common.stringToHTMLString(EXPDATE)%></b><br><b>________________________________________________________________________________________________</b><br><br></font></td>
    <%}else{%>
    <td align="justify" width="900"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>INSURANCE GUARANTEE NO: <%= common.stringToHTMLString(CNCODE) %> FOR RM<%=common.stringToHTMLString(common.twoDecimal(common.formatfloat(SUMINS)))%> EXPIRING <%=common.stringToHTMLString(EXPDATE)%></b><br><b>________________________________________________________________________________________________</b><br><br></font></td>
    <%}%>
  </tr>
<tr>
    <td align="justify"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><p align="justify" >
    As requested by <b><%= common.stringToHTMLString(NAME) %> </b>of <b><%= common.stringToHTMLString(ADDRESS.toUpperCase())%>. </b>We, <b><%= common.stringToHTMLString(PRINCIPLE_NAME.toUpperCase()) %> </b> hereby guarantee and agree to pay on your written demand up to the maximum aggregate sum of <b>RM<%= common.stringToHTMLString(common.twoDecimal(common.formatfloat(SUMINS))) %></b>&nbsp;(Ringgit Malaysia: <b><%= common.stringToHTMLString(AMOUNT_DESCRIPTION)%> ONLY</b>), being the amount of security deposit required to be deposited with you for <b><%=String.valueOf(iNoofEmp)%> </b> foreign worker(s) (as per list attached) employed by the said <b><%= common.stringToHTMLString(NAME) %> </b> being surety for the repatriation expenses in the event that any one of them be repatriated in their course of stay in Malaysia as employees of <b><%= common.stringToHTMLString(NAME)%></b>.<br><br>
    This Guarantee is effective from <b> <%= common.stringToHTMLString(EFFDATE) %> </b> until <b><%= common.stringToHTMLString(EXPDATE) %> </b>within the limit of the aforesaid.<br><br>
    Notwithstanding the above, any claim arising hereunder must reach us in writing latest by <b><%= common.stringToHTMLString(EXPDATE) %> </b> and our liability to pay any claim under this Guarantee shall expire on the said date notwithstanding the fact that this Guarantee may not be returned to us for cancellation.
	</p></font></td>
<tr><br>
</table>
<table width="900" border="0" cellpadding="3" cellspacing="0" bordercolor="#FFFFFF">
  <%if(AgtStatus.equals("")){%>
  <tr>
    <td width="900" colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5">Yours faithfully,<br>For <b><%= common.stringToHTMLString(PRINCIPLE_NAME.toUpperCase()) %></b></font></td>
  </tr>
  <tr>
    <td width="350" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5">_____________________________<br>Authorised Signature</font></td>
    <td width="200"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"></font></td>
    <td width="350" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5">_____________________________<br>Authorised Signature</font></td>
  </tr>
  <%}else{%>
  <tr>
    <td width="900" colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5">Yours faithfully,<br>For <b><%= common.stringToHTMLString(PRINCIPLE_NAME.toUpperCase()) %></b></font></td>
  </tr>
	  <% if (Integer.parseInt(dbISSDATE) > 20221227) {%>
	  <tr>
	    <td width="400" align="left" colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><u><img src="../common/jpg/getjpg.jsp?fn=/CEO_Signature.jpg" width="120" height="80" valign="bottom"></u></font></td>
	  </tr>
	  <%}else if (Integer.parseInt(dbISSDATE) > 20210820) {%>
	  <tr>
	    <td width="400" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><U><img src="../common/jpg/getjpg.jsp?fn=/CEO_Signature.jpg" width="180" height="100" valign="bottom"></U></font></td>
	    <td width="100"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"></font></td>
	    <td width="400" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><U><img src="../common/jpg/getjpg.jsp?fn=/CEO_Signature.jpg" width="180" height="100" valign="bottom"></U></font></td>
	  </tr>
	  <%}else{ %>
	  <tr>
	    <td width="400" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><U><img src="../common/jpg/getjpg.jsp?fn=/CEO_Signature.jpg" width="180" height="100" valign="bottom"></U></font></td>
	    <td width="100"><font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"></font></td>
	    <td width="400" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><U><img src="../common/jpg/getjpg.jsp?fn=/CEO_Signature.jpg" width="180" height="100" valign="bottom"></U></font></td>
	  </tr>
	  <%} %>
	  <%}%>
</table>
<%
if(vItem!=null){
if(vItem.size()>0){%>
<PAGEBREAK></PAGEBREAK>

<table width="900" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td align="center">        
      <font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b></b></font>
    </td>
  </tr>
  <tr>
    <td align="center">        
      <font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b>EMPLOYEES PARTICULARS LISTING</b></font>
    </td>
  </tr>
  <tr>
    <td align="center">        
      <font face="Verdana, Arial, Helvetica, sans-serif" size="2.5"><b></b></font>
    </td>
  </tr>
</table>

<table width="900" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td width="260" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">INSURED NAME</font></td>
    <td width="10" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">:</font></td>
    <td width="640" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(NAME) %></font></td>
  </tr>
  <tr>
    <td width="260" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">BUSINESS ADDRESS</font></td>
    <td width="10" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">:</font></td>
    <td width="640" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
    
    <%=common.stringToHTMLString(ADDRESS.toUpperCase()) %>
    </font></td>
  <tr>
    <td width="260" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">INSURANCE GUARANTEE NO</font></td>
    <td width="10" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">:</font></td>
    <td width="640" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(CNCODE) %></font></td>
  </tr>
  <tr>
    <td width="260" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">FWCMS REFERENCE NO</font></td>
    <td width="10" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">:</font></td>
    <td width="640" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(FWCMSREFNO) %></font></td>
  </tr>
  <tr>
    <td width="260" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
    <td width="10" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
    <td width="640" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
  </tr>

</table>

<table width="900" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td width="60" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">NO.</font></div>
    </td>
    <td width="460" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">NAME</font></div>
    </td>
    <%--
    <td width="60" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">SEX</font></div>
    </td>--%>
    <td width="190" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">PASSPORT NO.</font></div>
    </td>
    <td width="190" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">NATIONALITY</font></div>
    </td>
  </tr>
<%
   int k = 1;	
   if(vItem!=null){
	for(int i=0; i<vItem.size(); i++){
		Vector vItemNo			= (Vector) vItem.elementAt(i);
		String sEmp_Name		= (String) vItemNo.elementAt(0);
		String sEmp_Passport	= (String) vItemNo.elementAt(1);
		String sEmp_Nationality	= (String) vItemNo.elementAt(5);
		String sEmp_Gender		= (String) vItemNo.elementAt(4);
%>  
  <tr>
    <td width="60" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=k%></font></div>
    </td>
    <td width="460" bordercolor="#000000" align="left">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(sEmp_Name) %></font></div>
    </td>
    <%--
    <td width="60" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(sEmp_Gender) %></font></div>
    </td>--%>
    <td width="190" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(sEmp_Passport) %></font></div>
    </td>
    <td width="190" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(sEmp_Nationality) %></font></div>
    </td>
  </tr>
<%
   k++;
	}
   }
%>
</table>

<table width="900" border="0" cellspacing="0" cellpadding="3">
  <tr>
  	<td width="900" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
  </tr>
  <tr>
  	<td width="900" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Summary :</font></td>
  </tr>
</table>

<table width="900" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td width="225" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">NATIONALITY</font></div>
    </td>
    <td width="225" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">NO. OF WORKERS</font></div>
    </td>
    <td width="225" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">IG AMOUNT PER WORKER</font></div>
    </td>
    <td width="225" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">TOTAL IG AMOUNT</font></div>
    </td>
  </tr>
<%
   if(vItem!=null){
	for(int i=0; i<vItem1.size(); i++){
		Vector vItemNo				= (Vector) vItem1.elementAt(i);
		String sSum_Nationality		= (String) vItemNo.elementAt(0);
		String sSum_Noofworker		= (String) vItemNo.elementAt(1);
		String sSum_Amount			= (String) vItemNo.elementAt(2);
		String sSum_Tot_Amount		= (String) vItemNo.elementAt(3);
		String sNationality_Descp	= (String) vItemNo.elementAt(4);
%>
  <tr>
    <td width="225" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(sNationality_Descp) %></font></div>
    </td>
    <td width="225" bordercolor="#000000" align="center">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(sSum_Noofworker) %></font></div>
    </td>
    <td width="225" bordercolor="#000000" align="right">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(common.twoDecimal(common.formatfloat(sSum_Amount))) %></font></div>
    </td>
    <td width="225" bordercolor="#000000" align="right">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%= common.stringToHTMLString(common.twoDecimal(common.formatfloat(sSum_Tot_Amount))) %></font></div>
    </td>
  </tr>
<%
	}
   }
%>
  <tr>
    <td colspan="2" bordercolor="#000000" align="right">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">GRAND TOTAL</font></div>
    </td>
    <td colspan="2" bordercolor="#000000" align="right">
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%= common.stringToHTMLString(common.twoDecimal(common.formatfloat(TOT_AMOUNT))) %></b></font></div>
    </td>
  </tr>
</table>
<%}
}
%>
<%if(!TABLE.equals("TB_FWIGREF")){%>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/pop_incl_CFMKT.jsp">
<jsp:param name="CNTYPE"          	value="FWIG" />
<jsp:param name="CFMKT_IND"         value="<%=CFMKT_IND%>" />
<jsp:param name="CONTACT_TYPE"      value="<%=CONTACT_TYPE%>" />
<jsp:param name="CNCODE"         	value="<%=CNCODE%>" />
<jsp:param name="NAME"         		value="<%=NAME%>" />
<jsp:param name="GUARANTEE"         	    value="Y" />
</jsp:include>
<% if (!GST_TAX_NO.equals("") ){ %>
<PAGEBREAK></PAGEBREAK>
<jsp:include page="/template/pop_incl_tax_invoice.jsp">
<jsp:param name="UKEY"         	    value="<%=PRINCIPLE+CNCODE%>" />
<jsp:param name="GUARANTEE"         	    value="Y" />
</jsp:include> 

<%if (INTERMEDIARY_IND.equals("Y")) {%>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/pop_incl_tax_invoice_intermediary.jsp">
<jsp:param name="UKEY"         	    value="<%=PRINCIPLE+CNCODE%>" />
</jsp:include> 
<%}%>
<%}%>
<%}%>
<%-- <%if (privacyEN.equals("Y")  && !CNTYPE.equals("RN")) {%>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/privacynoticeEN.jsp">
</jsp:include> 
<%} %>
<%if (privacyBM.equals("Y")  && !CNTYPE.equals("RN")) {%>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/privacyclauseBM.jsp">
</jsp:include> 
<%} %> --%>
</body>
</html>
