<%@ page language="java" import="com.rexit.easc.postSubmission,java.util.*,java.sql.*,java.util.*,java.util.Date,java.text.SimpleDateFormat" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="inputXML" scope="page" class="com.rexit.easc.inputXML" />
<jsp:useBean id="postMQXML" scope="page" class="com.rexit.easc.postMQXML" />
<jsp:useBean id="Period" scope="page" class="com.rexit.easc.speriod" />
<jsp:useBean id="EASCManager" scope="page" class="com.rexit.easc.EASCManager" />


<%   
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
	response.setHeader("Pragma","no-cache");		//HTTP 1.0
	response.setDateHeader ("Expires", 0);
	
    String SESUSERID = common.setNullToString((String)session.getAttribute("SESUSERID"));

    if ((SESUSERID.equals("")) || (SESUSERID == null)) {
        response.sendRedirect("../login/logout.jsp"); 
        return;
    } 
    String PRINCIPLE    = common.setNullToString((String) session.getAttribute("SES_PRINCIPLE"));
    if(PRINCIPLE.equals(""))
    	PRINCIPLE		= common.setNullToString(common.filterAttack((String) request.getParameter("PRINCIPLE")));
    PRINCIPLE			= common.getKey(PRINCIPLE," ");
	int intSeqNo = 0;
	int intSubSeqNo = 0;
	session.setAttribute("SES_CLS","IG");

	SimpleDateFormat timestampFormat = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat timestampFormat2 = new SimpleDateFormat("dd-MM-yyyy");
    
    String today			= timestampFormat.format(new Date());
    
	Hashtable htItem 		= new Hashtable();
	String SQL   			= "";
 	String CLS 				= "";
	String TITLE			= "Update Cover Note";
	String PAGE			    = "../fwig/pop_cnFWIG_add_1.jsp";
    String UKEY 			= "";
	String CNCODE 			= common.setNullToString((String) session.getAttribute("SES_CNCODE"));
	String POLNO 			= "";
	String USERID 			= "";
	//String PRINCIPLE 		= "";
	String ACCODE 			= "";
	String BRUSER_ID 		= "";
	String BR_ID 			= "";
	String PREVPOL 			= "";
	String RI_METHOD 		= "";
	String CNTYPE 			= common.setNullToString((String) session.getAttribute("SES_CNTYPE"));
	String ISSDATE 			= common.setNullToString((String) session.getAttribute("SES_ISSDATE"));
	String EFFDATE 			= common.setNullToString((String) session.getAttribute("SES_EFFDATE"));
	String EXPDATE 			= common.setNullToString((String) session.getAttribute("SES_EXPDATE"));
	String NOOFMONTH 		= "";
	String CNTIME 			= "";
	String REGION 			= "";
	String NEW_IC_NO 		= "";
	String OLD_IC_NO 		= "";
	String NAME 			= "";
	String DOB 				= "";
	String ADDRESS_1 		= "";
	String ADDRESS_2 		= "";
	String ADDRESS_3 		= "";
	String ADDRESS_4 		= "";
	String AGE 				= "";
	String MARITAL_STATUS 	= "";
	String SALUTATION 		= "";
	String NATIONALITY 		= "";
	String RACE 			= "";
	String STATE 			= "";
	String POSTCODE 		= "";
	String OCCUPATION_CODE 	= "";
	String OCCUPATION_DESC 	= "";
	String GENDER 			= "";
	String TEL_NO_HOME 		= "";
	String TEL_NO_OFFICE 	= "";
	String MOBILE_NO 		= "";
	String EMAIL 			= "";
	String FAX_NO_HOME 		= "";
	String FAX_NO_OFFICE 	= "";
	String BUSINESS_NO 		= "";
	String TRADE 			= "";
	String CONTACT_TYPE 	= "";
	String ME_INCHARGE 		= "";
	String STATUS 			= "";
	String REC_DATE 		= "";
	String REC_NO 			= "";
	String REC_STATUS 		= "";
	String REC_BALANCE 		= "";
	String REPLACECN 		= "";
	String CANCELDATE 		= "";
	String SUBMISSIONNO 	= "";
	String CONTACTID 		= "";
	String DELETED 			= "";
	String REFERIND 		= "";
	String ACCOM_REMARK 	= "";
	String PROPOSAL_IND 	= "";
	String PROPOSAL_DATE 	= "";
	String UWYR_YR 			= "";
	String UWYR_MTH 		= "";
	String PRN_IND 			= "";
	String ORCCODE 			= "";
	String CLASS 			= "";
	
	String TIN	 			= "";
	String SST	 			= "";
	String MSIC_CODE	 	= "";
	
	String UKEY2 			= "";
	String IMMI_CODE 		= "";
	String IMMI_NAME 		= "";
	String IMMI_ADDRESS_1 	= "";
	String IMMI_ADDRESS_2 	= "";
	String IMMI_ADDRESS_3 	= "";
	String IMMI_ADDRESS_4 	= "";
	String IMMI_POSTCODE 	= "";
	String IMMI_TEL 		= "";
	String IMMI_FAX 		= "";
	String OFR_NAME 		= "";
	String OFR_DESG 		= "";
	String OFR_AUTHLIMIT 	= "";
	String GUARANTOR 		= "";
	String GUAR_REGNO 		= "";
	String GUAR_SECURITY 	= "";
	String GUAR_STAMPDATE 	= "";
	String COLLSTAMPDATE 	= "";
	String COLLTYPE 		= "";
	String COLLAMT 			= "";
	String COLLPCT 			= "";
	String EMP_NAME 		= "";
	String EMP_PASSPORT 	= "";
	String EMP_NATIONALITY 	= "";
	String EMP_RATE 		= "";
	String EMP_PREM 		= "";
	String EMP_IND 			= "";
	String EMP_AMOUNT 		= "";
	String EMP_OCCUPATION 	= "";
	String EMP_GENDER		= "";
	String EMP_TERM_DATE	= "";
	String SUM_NATIONALITY 	= "";
	String SUM_NOOFWORKER 	= "";
	String SUM_AMOUNT 		= "";
	String SUM_TOT_AMOUNT 	= "";
	String SUM_TOT_PREM 	= "";
	String SUM_TOT_APREM 	= "";
	String TOT_AMOUNT 		= "";
	String TOT_PREM 		= "";
	String TOT_APREM 		= "";
	
	
	String BILL_CURR 		= "";
	String POL_CURR 		= "";
	String XRATE 			= "";
	String BILL_SUMINS 		= "";
	String SUMINS 			= "";
	String APREM 			= "";
	String GPREM 			= "";
	String REBATEAMT 		= "";
	String REBATEPCT 		= "";
	String STAXAMT 			= "";
	String STAXPCT 			= "";
	String STAMPDUTY 		= "";
	String NETPREM 			= "";
	String COMMAMT 			= "";
	String COMMPCT 			= "";
	String LEVYAMT 			= "";
	String LEVYPCT 			= "";
	String TOTPREM 			= "";
	String ORG_APREM 		= "";
	String BCHRGAMT 		= "";
	String BCHRGPCT 		= "";
	
	String NEW_CNCODE="";
	Vector vEMPLOYEE = new Vector();
	Vector vITEM = new Vector();
	Vector vSUBITEM = new Vector();
	
	UKEY = common.setNullToString(common.filterAttack(request.getParameter("CNCODE")));
	String FWCS_CONV_IND = common.setNullToString(common.filterAttack(request.getParameter("FWCS_CONV_IND")));
	String FWIG_CONV_IND = common.setNullToString(common.filterAttack(request.getParameter("FWIG_CONV_IND")));
	String FWHS_CONV_IND = common.setNullToString(common.filterAttack(request.getParameter("FWHS_CONV_IND")));

	try
	{
		Enumeration enumKEY = session.getAttributeNames();
		while(enumKEY.hasMoreElements())
		{
			String sessionKEY = (String)enumKEY.nextElement();
			if(
				!(sessionKEY.equals("SESLASTTO") || sessionKEY.equals("SESSTAFFID") ||
				sessionKEY.equals("SESBRUSERID") || sessionKEY.equals("SESINSCODE_LOGIN") ||
				sessionKEY.equals("SESSMS") || sessionKEY.equals("SESBRANCHEXIST") ||
				sessionKEY.equals("SESLASTFROM") || sessionKEY.equals("SESLASTCLIENT") ||
				sessionKEY.equals("SESUSERID") || sessionKEY.equals("SESUSER_NAME") ||
				sessionKEY.equals("SESJPJSMS") || sessionKEY.equals("SESLAST_LOGOUT") ||
				sessionKEY.equals("SESLAST_LOGIN_IP") || sessionKEY.equals("SESSEARCH") ||
				sessionKEY.equals("SESLAST_LOGIN") || sessionKEY.equals("SES_CON_INSTANCE_NO") ||
				sessionKEY.equals("SESBRCODE_LOGIN") ||	sessionKEY.equals("SES_FAX_NO_OFFICE") ||
				sessionKEY.equals("SES_RACE") || sessionKEY.equals("SES_STATE") ||
				sessionKEY.equals("SES_CONTACT_ID") || sessionKEY.equals("SES_NAME") ||
				sessionKEY.equals("SES_SALUTATION") || sessionKEY.equals("SES_TRADE") ||
				sessionKEY.equals("SES_POSTCODE") || sessionKEY.equals("SES_OLD_IC_NO") ||
				sessionKEY.equals("SES_MOBILE_NO") || sessionKEY.equals("SES_NEW_IC_NO") ||
				sessionKEY.equals("SES_EMAIL") || sessionKEY.equals("SES_NATIONALITY") ||
				sessionKEY.equals("SES_CONTACT_TYPE") || sessionKEY.equals("SES_AGE") ||
				sessionKEY.equals("SES_TEL_NO_OFFICE") || sessionKEY.equals("SES_TITLE") ||
				sessionKEY.equals("SESBRUSERID") || sessionKEY.equals("SES_FAX_NO_HOME") ||
				sessionKEY.equals("SES_DOB") || sessionKEY.equals("SES_BUSINESS_NO") ||
				sessionKEY.equals("SES_ADDRESS_4") || sessionKEY.equals("SES_OLD_OWNER_CONTACTID") ||
				sessionKEY.equals("SES_GENDER") || sessionKEY.equals("SES_ADDRESS_3") ||
				sessionKEY.equals("SES_ADDRESS_2") || sessionKEY.equals("SES_ADDRESS_1") ||
				sessionKEY.equals("SES_MARITAL_STATUS") || sessionKEY.equals("SES_INSCODE") ||
				sessionKEY.equals("SES_PRINCIPLE") || sessionKEY.equals("SES_ACCODE") ||
				sessionKEY.equals("SES_CNCODE") || sessionKEY.equals("SES_CNTYPE") ||
				sessionKEY.equals("SES_QUO_CNCODE") || sessionKEY.equals("SES_HP_AUTONUM") ||
				sessionKEY.equals("SES_CLS") || sessionKEY.equals("SES_OCCUPATION_DESC") ||
				sessionKEY.equals("SES_OCCUPATION_CODE") || sessionKEY.equals("SES_TEL_NO_HOME") ||
				sessionKEY.equals("SES_ME_INCHARGE") || sessionKEY.equals("SESISNM") || 
				sessionKEY.equals("SES_USER_TYPE") || sessionKEY.equals("SESINSCODE") ||
				sessionKEY.equals("SESPASSWORD") || sessionKEY.equals("SESACCODE") || sessionKEY.equals("SESPRINCIPLE"))
			)
			{
				session.setAttribute(sessionKEY, null);
				session.removeAttribute(sessionKEY);
			}
		}
	}
	catch(Exception exp)
	{
		exp.printStackTrace();			
	}

	if (UKEY.trim().length()>0) {        
        SQL = "SELECT * FROM TB_FWHSCN WHERE UKEY = '"+ UKEY+"' WITH UR";
        DB.makeConnection();
        DB.executeQuery(SQL);       
        if(DB.getNextQuery())   {           
	        
        	UKEY 			= common.setNullToString(DB.getColumnString("UKEY"));
			CNCODE 			= common.setNullToString(DB.getColumnString("CNCODE"));
			ACCODE 			= common.setNullToString(DB.getColumnString("ACCODE"));
			BR_ID 			= common.setNullToString(DB.getColumnString("BR_ID"));
			CNTYPE 			= common.setNullToString(DB.getColumnString("CNTYPE"));
			ISSDATE 		= common.setNullToString(DB.getColumnString("ISSDATE"));
			EFFDATE 		= common.setNullToString(DB.getColumnString("EFFDATE"));
			EXPDATE 		= common.setNullToString(DB.getColumnString("EXPDATE"));

			NEW_IC_NO 		= common.setNullToString(DB.getColumnString("NEW_IC_NO"));
			OLD_IC_NO 		= common.setNullToString(DB.getColumnString("OLD_IC_NO"));
			NAME 			= common.setNullToString(DB.getColumnString("NAME"));
			DOB 			= common.setNullToString(DB.getColumnString("DOB"));
			ADDRESS_1 		= common.setNullToString(DB.getColumnString("ADDRESS_1"));
			ADDRESS_2 		= common.setNullToString(DB.getColumnString("ADDRESS_2"));
			ADDRESS_3 		= common.setNullToString(DB.getColumnString("ADDRESS_3"));
			ADDRESS_4 		= common.setNullToString(DB.getColumnString("ADDRESS_4"));
			AGE 			= common.setNullToString(DB.getColumnString("AGE"));
			MARITAL_STATUS 	= common.setNullToString(DB.getColumnString("MARITAL_STATUS"));
			SALUTATION 		= common.setNullToString(DB.getColumnString("SALUTATION"));
			NATIONALITY 	= common.setNullToString(DB.getColumnString("NATIONALITY"));
			RACE 			= common.setNullToString(DB.getColumnString("RACE"));
			STATE 			= common.setNullToString(DB.getColumnString("STATE"));
			POSTCODE 		= common.setNullToString(DB.getColumnString("POSTCODE"));
			OCCUPATION_DESC = common.setNullToString(DB.getColumnString("OCCUPATION_DESC"));
			GENDER 			= common.setNullToString(DB.getColumnString("GENDER"));
			TEL_NO_HOME 	= common.setNullToString(DB.getColumnString("TEL_NO_HOME"));
			TEL_NO_OFFICE 	= common.setNullToString(DB.getColumnString("TEL_NO_OFFICE"));
			MOBILE_NO 		= common.setNullToString(DB.getColumnString("MOBILE_NO"));
			EMAIL 			= common.setNullToString(DB.getColumnString("EMAIL"));
			FAX_NO_HOME 	= common.setNullToString(DB.getColumnString("FAX_NO_HOME"));
			FAX_NO_OFFICE 	= common.setNullToString(DB.getColumnString("FAX_NO_OFFICE"));
			BUSINESS_NO 	= common.setNullToString(DB.getColumnString("BUSINESS_NO"));
			CONTACT_TYPE 	= common.setNullToString(DB.getColumnString("CONTACT_TYPE"));
			CONTACTID 		= common.setNullToString(DB.getColumnString("CONTACTID"));
			ORCCODE 		= common.setNullToString(DB.getColumnString("ORCCODE"));
			String NATURE_BUSINESS = common.setNullToString(DB.getColumnString("NATURE_BUSINESS"));
			
			if(CONTACT_TYPE.equals("B"))
				TRADE = NATURE_BUSINESS;
			else
				OCCUPATION_CODE = NATURE_BUSINESS;
			
            SQL = "SELECT RIMTD_POL FROM TB_PARAM_GEN WHERE INSCODE = '"+PRINCIPLE+"'";
            DB.executeQuery(SQL);
            if(DB.getNextQuery())
            	RI_METHOD	= DB.getColumnString("RIMTD_POL");
            	
            if (!ISSDATE.equals("")) ISSDATE = timestampFormat2.format(timestampFormat.parse(ISSDATE));      
            if (!EFFDATE.equals("")) EFFDATE = timestampFormat2.format(timestampFormat.parse(EFFDATE));
            if (!EXPDATE.equals("")) EXPDATE = timestampFormat2.format(timestampFormat.parse(EXPDATE));
            if (!DOB.equals(""))     DOB     = timestampFormat2.format(timestampFormat.parse(DOB));           
			if (!PROPOSAL_DATE.equals("")) PROPOSAL_DATE = timestampFormat2.format(timestampFormat.parse(PROPOSAL_DATE));

			session.setAttribute("SES_CNCODE", "NEW");
			session.setAttribute("SES_POLNO", POLNO);
			session.setAttribute("SES_PRINCIPLE", PRINCIPLE);
			session.setAttribute("SES_ACCODE", ACCODE);
			session.setAttribute("SESACCODE", ACCODE);
			session.setAttribute("SES_RI_METHOD", RI_METHOD);
			session.setAttribute("SES_CNTYPE", CNTYPE);
			session.setAttribute("SES_ISSDATE", ISSDATE);
			session.setAttribute("SES_EFFDATE", EFFDATE);
			session.setAttribute("SES_NOOFMONTH", NOOFMONTH);
			session.setAttribute("SES_NEW_IC_NO", NEW_IC_NO);
			session.setAttribute("SES_OLD_IC_NO", OLD_IC_NO);
			session.setAttribute("SES_NAME", NAME);
			session.setAttribute("SES_DOB", DOB);
			session.setAttribute("SES_ADDRESS_1", ADDRESS_1);
			session.setAttribute("SES_ADDRESS_2", ADDRESS_2);
			session.setAttribute("SES_ADDRESS_3", ADDRESS_3);
			session.setAttribute("SES_ADDRESS_4", ADDRESS_4);
			session.setAttribute("SES_AGE", AGE);
			session.setAttribute("SES_MARITAL_STATUS", MARITAL_STATUS);
			session.setAttribute("SES_SALUTATION", SALUTATION);
			session.setAttribute("SES_NATIONALITY", NATIONALITY);
			session.setAttribute("SES_RACE", RACE);
			session.setAttribute("SES_STATE", STATE);
			session.setAttribute("SES_POSTCODE", POSTCODE);
			session.setAttribute("SES_OCCUPATION_CODE", OCCUPATION_CODE);
			session.setAttribute("SES_OCCUPATION_DESC", OCCUPATION_DESC);
			session.setAttribute("SES_GENDER", GENDER);
			session.setAttribute("SES_TEL_NO_HOME", TEL_NO_HOME);
			session.setAttribute("SES_TEL_NO_OFFICE", TEL_NO_OFFICE);
			session.setAttribute("SES_MOBILE_NO", MOBILE_NO);
			session.setAttribute("SES_EMAIL", EMAIL);
			session.setAttribute("SES_FAX_NO_HOME", FAX_NO_HOME);
			session.setAttribute("SES_FAX_NO_OFFICE", FAX_NO_OFFICE);
			session.setAttribute("SES_BUSINESS_NO", BUSINESS_NO);
			session.setAttribute("SES_TRADE", TRADE);
			session.setAttribute("SES_CONTACT_TYPE", CONTACT_TYPE);
			session.setAttribute("SPE_CONTACT_TYPE", CONTACT_TYPE);
			session.setAttribute("SES_ME_INCHARGE", ME_INCHARGE);
			session.setAttribute("SES_CONTACT_ID", CONTACTID);
			session.setAttribute("SES_ORCCODE", ORCCODE);
			session.setAttribute("SES_EFF_FOCUS", "Y");
			
			session.setAttribute("SES_FWCS_CONV_IND", FWCS_CONV_IND);
			session.setAttribute("SES_FWHS_CONV_IND", FWHS_CONV_IND);
			session.setAttribute("SES_FWIG_CONV_IND", FWIG_CONV_IND);
        }       
        DB.takeDown();
        
        DB.makeConnection();
		SQL	= "SELECT * FROM TB_FWHSSCH WHERE UKEY2 = '"+ UKEY+"' WITH UR";
		DB.executeQuery(SQL);
		if(DB.getNextQuery())
		{
			TIN 		= common.setNullToString(DB.getColumnString("TIN"));
			SST 		= common.setNullToString(DB.getColumnString("SST_REGNO"));
			
			session.setAttribute("SES_TIN", TIN);
			session.setAttribute("SES_SST", SST);
		}
		DB.takeDown();
        
        
        String sBR_ID	= "";
        DB.makeConnection();
		SQL	= "SELECT BR_ID FROM TB_AGENT_AM WHERE ACCODE = '"+ACCODE+"' AND INSCODE = '"+PRINCIPLE+"' FETCH FIRST ROW ONLY WITH UR";
		DB.executeQuery(SQL);
		if(DB.getNextQuery())
		{
			sBR_ID	= common.setNullToString(DB.getColumnString("BR_ID"));
		}
		DB.takeDown();

        SQL	= "SELECT * FROM TB_FWHSITEM WHERE UKEY LIKE '"+ UKEY +"$%' ORDER BY CAST(SEQNO AS INTEGER) WITH UR" ;
                
       	DB.makeConnection();
        DB.executeQuery(SQL);

        Vector field1 = new Vector();
        Vector field2 = new Vector();
        Vector field3 = new Vector();
        Vector field4 = new Vector();
        Vector field5 = new Vector();
        Vector field6 = new Vector();
        Vector field7 = new Vector();
        Vector field8 = new Vector();
        
        while(DB.getNextQuery()) {           
			EMP_NAME 		= common.setNullToString(DB.getColumnString("EMP_NAME"));
			EMP_PASSPORT 	= common.setNullToString(DB.getColumnString("PASSPORT"));
			EMP_NATIONALITY = common.setNullToString(DB.getColumnString("NATIONALITY"));
			EMP_OCCUPATION 	= common.setNullToString(DB.getColumnString("OCCPSEC"));
			EMP_GENDER      = common.setNullToString(DB.getColumnString("GENDER"));
			EMP_TERM_DATE   = common.setNullToString(DB.getColumnString("TERM_DATE"));
		
			com.rexit.easc.StringTokenizer EMP 		= new com.rexit.easc.StringTokenizer(EMP_NAME,"^","",true);
			com.rexit.easc.StringTokenizer PASS 	= new com.rexit.easc.StringTokenizer(EMP_PASSPORT,"^","",true);
			com.rexit.easc.StringTokenizer NAT  	= new com.rexit.easc.StringTokenizer(EMP_NATIONALITY,"^","",true);
			com.rexit.easc.StringTokenizer OCC 		= new com.rexit.easc.StringTokenizer(EMP_OCCUPATION,"^","",true);
			com.rexit.easc.StringTokenizer GEN   	= new com.rexit.easc.StringTokenizer(EMP_GENDER,"^","",true);
			com.rexit.easc.StringTokenizer TERMDATE = new com.rexit.easc.StringTokenizer(EMP_TERM_DATE,"^","",true);
			
			while (EMP.hasMoreTokens()) {
				field1.addElement(EMP.nextToken());
					
				if(PASS.hasMoreTokens())
					field2.addElement(PASS.nextToken());
				else
					field2.addElement("");
					
				if(NAT.hasMoreTokens())
				{
					String sNATIONALITY	= NAT.nextToken();
					String FWIG_UKEY	= sNATIONALITY+ACCODE+sBR_ID;
			        SQL = "SELECT AMOUNT,RATE FROM TB_FWIGPREM WHERE UKEY ='" +FWIG_UKEY + "' FETCH FIRST ROW ONLY WITH UR";
					
					String AMOUNT	= "";
					String RATE		= "";
					EASCManager.makeConnection();
			        EASCManager.executeQuery(SQL);
			        if (EASCManager.getNextQuery())
			        {
			            AMOUNT  = common.setNullToString(EASCManager.getColumnString("AMOUNT")); 
			            RATE  	= common.setNullToString(EASCManager.getColumnString("RATE"));                   
			        }
			        
			        if(AMOUNT.length() == 0)
			        {
			        	FWIG_UKEY		= sNATIONALITY+ACCODE;
			        	String UKEY1	= sNATIONALITY+sBR_ID;
			        	
			        	SQL	= "SELECT AMOUNT,RATE FROM TB_FWIGPREM WHERE UKEY = '"+ FWIG_UKEY + "' OR UKEY = '"+ UKEY1 + "' FETCH FIRST ROW ONLY WITH UR";
			        	EASCManager.executeQuery(SQL);
			        	if(EASCManager.getNextQuery())
			        	{
			        		AMOUNT  = common.setNullToString(EASCManager.getColumnString("AMOUNT"));  
			        		RATE  	= common.setNullToString(EASCManager.getColumnString("RATE"));    
			        	}
			        	
			        	if(AMOUNT.length() == 0)
			        	{
			        		FWIG_UKEY	= sNATIONALITY;
				        	SQL = "SELECT AMOUNT,RATE FROM TB_FWIGPREM WHERE UKEY ='" + FWIG_UKEY + "' FETCH FIRST ROW ONLY WITH UR";
					        EASCManager.executeQuery(SQL);
					
					        if (EASCManager.getNextQuery())
					        {
					            AMOUNT  = common.setNullToString(EASCManager.getColumnString("AMOUNT"));
					            RATE  	= common.setNullToString(EASCManager.getColumnString("RATE")); 	                      
					        }
					    }
			        }
			        EASCManager.takeDown();
			        com.rexit.easc.StringTokenizer st1   = new com.rexit.easc.StringTokenizer(AMOUNT,"^","",true);
			        if(st1.hasMoreTokens())
			        {
			        	AMOUNT = st1.nextToken();
			        }
			        st1   = new com.rexit.easc.StringTokenizer(RATE,"^","",true);
			        if(st1.hasMoreTokens())
			        {
			        	RATE = st1.nextToken();
			        }
			        
			        if(AMOUNT.equals(""))
			        	field6.addElement("0.00");
			        else
			        	field6.addElement(common.fnFormatComma(AMOUNT));
			        	
			        if(RATE.equals(""))
			        	field7.addElement("0.000000");
			        else
			        	field7.addElement(common.fnFormatNumber(RATE,6));
			        
					EASCManager.makeConnection();
			        try
			        {   
				        String DESCP 	= EASCManager.retrieveDescp(sNATIONALITY, "NATIONALITY", "DESCP", "TB_FWIGPREM","INSCODE",PRINCIPLE);	        
				        sNATIONALITY	= sNATIONALITY + " " + DESCP;
				    }
				    catch (Exception exp)
				    {
				    	exp.printStackTrace();
				    }
				    finally
				    {
				    	EASCManager.takeDown();
				    }
					field3.addElement(sNATIONALITY);
				}
				else
					field3.addElement("");
					
				if(OCC.hasMoreTokens())
				{
					String sOCCPSECTOR	= OCC.nextToken();
					field4.addElement(sOCCPSECTOR);
				}
				else
					field4.addElement("");
				
				if(GEN.hasMoreTokens())
				{
					String sGENDER		= GEN.nextToken();
					EASCManager.makeConnection();
			        try
			        {   
				        String DESCP 	= EASCManager.retrieveDescp(sGENDER, "CODE", "DESCP", "TB_GENDER","INSCODE",PRINCIPLE);	        
				        sGENDER			= sGENDER + " " + DESCP;
				    }
				    catch (Exception exp)
				    {
				    	exp.printStackTrace();
				    }
				    finally
				    {
				    	EASCManager.takeDown();
				    }
					field5.addElement(sGENDER);
  				}
				else
				   field5.addElement("");
				
				if(TERMDATE.hasMoreTokens())
				{
					String sTERM_DATE		= TERMDATE.nextToken();
					
					field8.addElement(sTERM_DATE);
  				}
				else
				   field8.addElement("");
			}
		}
		DB.takeDown();
		
		int y = 0;
		for (int z=0; z<field1.size();z++) {
			EMP_TERM_DATE = (String) field8.elementAt(z);
			
			if(EMP_TERM_DATE.equals(""))
			{
				y++;
				vITEM = new Vector();
				vITEM.addElement(Integer.toString(y)); //0
		        vITEM.addElement(Integer.toString(y)); //1
		        vITEM.addElement(field1.elementAt(z));  //2
		        vITEM.addElement(field3.elementAt(z));  //3
		        vITEM.addElement(field5.elementAt(z));	//4
				vITEM.addElement(field2.elementAt(z));  //5
				vITEM.addElement(field4.elementAt(z));  //6
				vITEM.addElement(field6.elementAt(z)); //7
				vITEM.addElement(field7.elementAt(z)); //8
				vITEM.addElement("0.00"); //9
				vITEM.addElement(""); //9
				 
				vEMPLOYEE.addElement(vITEM);
			}
		}
		session.setAttribute("table_vTable_EMPLOYEE",vEMPLOYEE);
		DB.takeDown();
	}
	
	boolean bSpecialAgt = false;
    DB.makeConnection();
    SQL = "SELECT VALUE2 FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='FWIG' AND CODE='STOP_AUTO' AND VALUE1 = '"+ACCODE+"' WITH UR";
    DB.executeQuery(SQL);
    if(DB.getNextQuery())
    {
        String VALUE2   = common.setNullToString(DB.getColumnString("VALUE2"));
        if(!VALUE2.equals(""))
		{
            if(Integer.parseInt(today)>=Integer.parseInt(VALUE2))
            {
            	bSpecialAgt = true;
            }
    	}
    }
    DB.takeDown();
	
	NOOFMONTH = "18"; //default 18 month
	vEMPLOYEE		= session.getAttribute("table_vTable_EMPLOYEE") == null ? new Vector(): (Vector) session.getAttribute("table_vTable_EMPLOYEE");		
		
	double dPREMIUM			= 0;
	double dIG_AMOUNT		= 0;
	double dRATE			= 0;
	int iNOOFMONTH			= Integer.parseInt(NOOFMONTH);
	double dTOT_PREM		= 0;
	if (vEMPLOYEE != null) 
	{ 
		for (int i = 0; i < vEMPLOYEE.size(); i++)
		{
			Vector vTemp		= (Vector) vEMPLOYEE.elementAt(i);
			String sIG_AMOUNT	= (String) vTemp.elementAt(7); //IG Amount
			String sRATE		= (String) vTemp.elementAt(8); //Rate
			dIG_AMOUNT			= common.formatdouble(common.fnCutComma(sIG_AMOUNT));
			dRATE				= common.formatdouble(common.fnCutComma(sRATE));
			
			if(bSpecialAgt)
			{
				iNOOFMONTH	= 12; //for FWIGREF
				dRATE = 1;
			}
			
			double dPREM_TEMP = ((dIG_AMOUNT * dRATE * iNOOFMONTH / 12)) / 100;
			vTemp.setElementAt(common.fnGetValue(dPREM_TEMP),9); //Total Premium
		}
		session.setAttribute("table_vTable_EMPLOYEE",vEMPLOYEE);

		int iSeqNo	= vEMPLOYEE.size();
		double dTOT_PREMIUM	= 0;
		double dTOT_AMOUNT	= 0;
		Hashtable hashtable	= new Hashtable();
		for(int i = 0; i < iSeqNo; i++) 
		{ 
			Vector vRow	= (Vector) vEMPLOYEE.elementAt(i); 
	
			String sEMP_NAT		= common.setNullToString((String) vRow.elementAt(3)); 
			double dAMOUNT		= common.formatdouble(common.fnCutComma((String) vRow.elementAt(7))); 
			dPREMIUM			= common.formatdouble(common.fnCutComma((String) vRow.elementAt(9)));
			String sHASHKEY		= sEMP_NAT + "^" + dAMOUNT;
			dTOT_AMOUNT			+= dAMOUNT;
			dTOT_PREMIUM		+= dPREMIUM;
			
			if(hashtable.get(sHASHKEY) != null) 
			{ 
				Vector vTemp	= (Vector) hashtable.get(sHASHKEY);
				int iTemp		= Integer.parseInt((String) vTemp.elementAt(0)) + 1;
				double dTemp	= common.formatdouble(common.fnCutComma((String) vTemp.elementAt(2))) + dAMOUNT; 
				double dTot_Prem= common.formatdouble(common.fnCutComma((String) vTemp.elementAt(3))) + dPREMIUM;
				
				vTemp.setElementAt(String.valueOf(iTemp),0); // NO of Worker
				vTemp.setElementAt(common.fnFormatComma(common.fnGetValue2(dAMOUNT)),1); //IG Amount Per Worker
				vTemp.setElementAt(common.fnFormatComma(common.fnGetValue2(dTemp)),2); //Total IG Amount
				vTemp.setElementAt(common.fnFormatComma(common.fnGetValue2(dTot_Prem)),3); //Total Premium
				vTemp.setElementAt("0.00",4);
			} 
			else 
			{ 	
				Vector vTemp	= new Vector(); 
				vTemp.addElement("1"); // NO of Worker
				vTemp.addElement(common.fnFormatComma(common.fnGetValue2(dAMOUNT))); //IG Amount Per Worker
				vTemp.addElement(common.fnFormatComma(common.fnGetValue2(dAMOUNT))); //Total IG Amount
				vTemp.addElement(common.fnFormatComma(common.fnGetValue2(dPREMIUM))); //Total Premium
				vTemp.addElement("0.00");
	
				hashtable.put(sHASHKEY, vTemp);
			}
		}
		
		Vector vTable_Summ	= new Vector();
		Enumeration	enum2	= hashtable.keys(); 
		int i	= 1;
		while(enum2.hasMoreElements()) 
		{ 
			String sHASHKEY	= (String) enum2.nextElement(); 
			String sSUMM_NAT	= sHASHKEY.substring(0, sHASHKEY.indexOf("^")); 
	
			Vector vTemp	= (Vector) hashtable.get(sHASHKEY); 
			
			String sNOOFWORKER	= (String) vTemp.elementAt(0); // NO of Worker
			String sAMOUNT		= (String) vTemp.elementAt(1); //IG Amount Per Worker
			String sIG_AMOUNT	= (String) vTemp.elementAt(2); //Total IG Amount
			String sPREMIUM		= (String) vTemp.elementAt(3); //Total Premium 
			String sAPREMIUM	= (String) vTemp.elementAt(4); //Total Annual Premium 
			
			Vector vRow	= new Vector(); 
			vRow.addElement(String.valueOf(i)); 
			vRow.addElement(String.valueOf(i)); 
			vRow.addElement(sSUMM_NAT); 
			vRow.addElement(sNOOFWORKER); 
			vRow.addElement(common.fnFormatComma(sAMOUNT)); 
			vRow.addElement(common.fnFormatComma(sIG_AMOUNT)); 
			vRow.addElement(common.fnFormatComma(sPREMIUM)); 
			vRow.addElement(common.fnFormatComma(sAPREMIUM));
	
			vTable_Summ.addElement(vRow);
			i++; 
		} 
		session.setAttribute("SES_TOT_FWIG_PREMIUM",common.fnFormatComma(common.fnGetValue(dTOT_PREMIUM)));
		session.setAttribute("SES_TOT_FWIG_IG_AMOUNT",common.fnFormatComma(common.fnGetValue(dTOT_AMOUNT)));
	
		session.setAttribute("table_vTable_EMPLOYEE_SUMM",vTable_Summ);
	}
		
	DB.makeConnection();
	SQL = "SELECT BG_FWIG FROM TB_PARAM_NM WHERE INSCODE = '"+PRINCIPLE+"'";
	
	DB.executeQuery(SQL);
	while(DB.getNextQuery())
	{
		String FWIG_CLS			= common.setNullToString(DB.getColumnString("BG_FWIG"));
		com.rexit.easc.StringTokenizer FWIG 	= new com.rexit.easc.StringTokenizer(FWIG_CLS,"^","",true);
		if(FWIG.hasMoreTokens())
			session.setAttribute("SES_CLASS",FWIG.nextToken());
	}
	DB.takeDown();
	
	Vector vOFR_CODE1 = new Vector();
	SQL="SELECT FWIG_AUTH_PERSON FROM TB_PARAM_NM WHERE INSCODE='"+PRINCIPLE+"' WITH UR";
	DB.makeConnection();
	DB.executeQuery(SQL);
	String sFWIG_AUTH_PERSON="";
	while(DB.getNextQuery())
	{
	    sFWIG_AUTH_PERSON = common.setNullToString(DB.getColumnString("FWIG_AUTH_PERSON"));
	}
	DB.takeDown();
	
	if (Integer.parseInt(today) < 20221228)
		sFWIG_AUTH_PERSON = "10038479^10032673";
	
	int seqno=1;
	com.rexit.easc.StringTokenizer sAUTH_PERSON = new com.rexit.easc.StringTokenizer(sFWIG_AUTH_PERSON,"^","",true);
	while (sAUTH_PERSON.hasMoreTokens())
	{
        String auth_person="";
	  	try { auth_person 			= sAUTH_PERSON.nextToken();	 		} catch (Exception exp) { }
	    SQL = "SELECT DESCP,DESIGNATION,AUTH_LIMIT FROM TB_OFFICER WHERE CODE='"+auth_person+"' AND INSCODE='"+PRINCIPLE+"' WITH UR";
	    
	    DB.makeConnection();
     	DB.executeQuery(SQL);
	    while(DB.getNextQuery())
	    {
	        String sDESCP         = common.setNullToString(DB.getColumnString("DESCP"));
	        String sDESIGNATION   = common.setNullToString(DB.getColumnString("DESIGNATION")); 
	        String sAUTH_LIMIT    = common.setNullToString(DB.getColumnString("AUTH_LIMIT"));
	        String sAUTH_LIMIT_DESCP ="";
	    
	        SQL  = "SELECT DESCP FROM tb_auth_limit WHERE CODE='"+sAUTH_LIMIT+"'";
	        DB.executeQuery(SQL);
	        while(DB.getNextQuery())
	        {
	            sAUTH_LIMIT_DESCP = common.setNullToString(DB.getColumnString("DESCP"));
	        }    	        
	        Vector vTemp   =  new Vector();
	        vTemp.addElement(Integer.toString(seqno));//seqno
	        vTemp.addElement(Integer.toString(seqno));//seqno
	        vTemp.addElement(auth_person+" - "+sDESCP);
	        vTemp.addElement(sDESIGNATION);
	        vTemp.addElement(sAUTH_LIMIT+" - "+sAUTH_LIMIT_DESCP); 	        
	        vOFR_CODE1.add(vTemp);
	        seqno++;
	    }
	    DB.takeDown();
    }
    session.setAttribute("SES_CLS","IG");
	session.setAttribute("SES_CONVERT","Y");
    session.setAttribute("SES_TRANSKEY","INIT");
    session.setAttribute("table_vTable_OFFICER",vOFR_CODE1);
    
    
    if(bSpecialAgt) PAGE = "../fwig/pop_cnFWIGREF_add_1.jsp";
	response.sendRedirect(PAGE);
	
%>