<%@ page language="java" import="com.rexit.easc.postSubmission,java.util.*,java.sql.*,java.util.*,java.util.Date,java.text.SimpleDateFormat" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="DB_Workmen" scope="page" class="com.rexit.easc.DB_Workmen" />
<jsp:useBean id="Period" scope="page" class="com.rexit.easc.speriod" />
<jsp:useBean id="EASCManager" scope="page" class="com.rexit.easc.EASCManager" />


<%	
	String SESUSERID = common.setNullToString((String)session.getAttribute("SESUSERID"));

    if ((SESUSERID.equals("")) || (SESUSERID == null)) {
        response.sendRedirect("/easck/login/logout.jsp"); 
    } 
    String PRINCIPLE	= common.setNullToString((String) request.getParameter("PRINCIPLE"));
    if(PRINCIPLE.equals(""))
    	PRINCIPLE    	= common.setNullToString((String) session.getAttribute("SES_PRINCIPLE"));

    PRINCIPLE			= common.getKey(PRINCIPLE," ");

    String ACCODE		= common.setNullToString((String) request.getParameter("ACCODE"));
    if(ACCODE.equals(""))
    	ACCODE    		= common.setNullToString((String) session.getAttribute("SES_ACCODE"));

    ACCODE				= common.getKey(ACCODE," ");
    
    String SOURCE		= common.setNullToString((String) request.getParameter("SOURCE"));
    String DEF_SPEC		= "";
	String DEF_SPECDESC	= "";
        	
	int intSeqNo = 0;
	int intSubSeqNo = 0;
	SimpleDateFormat timestampFormat = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat timestampFormat2 = new SimpleDateFormat("dd-MM-yyyy");
	Hashtable htItem = new Hashtable();
	String SQL   			= "";
 	String CLS 				= "";
	String TITLE			= "New Cover Note";
	String PAGE			    = "/liberty/fwcs/pop_cnFWCS_add_1.jsp";
    String UKEY 			= "";
	String CNCODE 			= "";
	String POLNO 			= "";
	String USERID 			= "";
	String BRUSER_ID 		= "";
	String BR_ID 			= "";
	String REGION 			= "";
	String PREVPOL 			= "";
	String RI_METHOD 		= "";
	String CNTYPE 			= "";
	String ISSDATE 			= "";
	String EFFDATE 			= "";
	String EXPDATE 			= "";
	String NATURE_BUSINESS	= "";

	String CURRYR			= "";
	String CONTACTID		= "";
	String NEW_IC_NO		= "";
	String OLD_IC_NO		= "";
	String NAME				= "";
	String DOB				= "";
	String ADDRESS_1		= "";
	String ADDRESS_2		= "";
	String ADDRESS_3		= "";
	String ADDRESS_4		= "";
	String AGE				= "";
	String MARITAL_STATUS	= "";
	String POSTCODE			= "";
	String OCCUPATION_CODE	= "";
	String OCCUPATION_DESC	= "";
	String GENDER			= "";
	String TEL_NO_HOME		= "";
	String TEL_NO_OFFICE	= "";
	String MOBILE_NO		= "";
	String EMAIL			= "";
	String FAX_NO_HOME		= "";
	String FAX_NO_OFFICE	= "";
	String BUSINESS_NO		= "";
	String TRADE			= "";
	String CONTACT_TYPE		= "";
	String STATUS			= "";
	String SUBMISSIONNO		= "";
	String DELETED			= "";
	String SALUTATION		= "";
	String NATIONALITY		= "";
	String RACE				= "";
	String STATE			= "";
	String ORCCODE			= "";
	
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
				sessionKEY.equals("SESBRCODE_LOGIN") || sessionKEY.equals("SES_INSCODE") ||
				sessionKEY.equals("SES_PRINCIPLE") || sessionKEY.equals("SES_ACCODE") ||
				sessionKEY.equals("SES_QUO_CNCODE") || sessionKEY.equals("SES_HP_AUTONUM") ||
				sessionKEY.equals("SES_USER_TYPE") || sessionKEY.equals("SESPASSWORD") ||
				sessionKEY.equals("SESINSCODE") || sessionKEY.equals("SESPRINCIPLE"))
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
	
	UKEY = common.setNullToString(request.getParameter("CNCODE"));
	String FWCS_CONV_IND = common.setNullToString(request.getParameter("FWCS_CONV_IND"));
	String FWIG_CONV_IND = common.setNullToString(request.getParameter("FWIG_CONV_IND"));
	String FWHS_CONV_IND = common.setNullToString(request.getParameter("FWHS_CONV_IND"));

	if (UKEY.trim().length()>0) {
        
        SQL	= "SELECT * FROM TB_FWHSCN WHERE UKEY = '"+ UKEY+"' WITH UR"; 
		DB_Contact.makeConnection();
		DB_Contact.executeQuery(SQL);
		while(DB_Contact.getNextQuery())
		{           
			UKEY 			= common.setNullToString(DB_Contact.getColumnString("UKEY")).trim();
			CNCODE 			= common.setNullToString(DB_Contact.getColumnString("CNCODE")).trim();
			USERID 			= common.setNullToString(DB_Contact.getColumnString("USERID")).trim();
			PRINCIPLE 		= common.setNullToString(DB_Contact.getColumnString("PRINCIPLE")).trim();
			ACCODE 			= common.setNullToString(DB_Contact.getColumnString("ACCODE")).trim();
			CNTYPE			= common.setNullToString(DB_Contact.getColumnString("CNTYPE")).trim(); 
			ISSDATE			= common.setNullToString(DB_Contact.getColumnString("ISSDATE")).trim(); 
			EFFDATE			= common.setNullToString(DB_Contact.getColumnString("EFFDATE")).trim(); 
			EXPDATE			= common.setNullToString(DB_Contact.getColumnString("EXPDATE")).trim(); 
			REGION 			= common.setNullToString(DB_Contact.getColumnString("REGION")).trim();
			NEW_IC_NO 		= common.setNullToString(DB_Contact.getColumnString("NEW_IC_NO")).trim();
			OLD_IC_NO 		= common.setNullToString(DB_Contact.getColumnString("OLD_IC_NO")).trim();
			NAME 			= common.setNullToString(DB_Contact.getColumnString("NAME")).trim();
			DOB 			= common.setNullToString(DB_Contact.getColumnString("DOB")).trim();
			ADDRESS_1 		= common.setNullToString(DB_Contact.getColumnString("ADDRESS_1")).trim();
			ADDRESS_2 		= common.setNullToString(DB_Contact.getColumnString("ADDRESS_2")).trim();
			ADDRESS_3 		= common.setNullToString(DB_Contact.getColumnString("ADDRESS_3")).trim();
			ADDRESS_4 		= common.setNullToString(DB_Contact.getColumnString("ADDRESS_4")).trim();
			AGE 			= common.setNullToString(DB_Contact.getColumnString("AGE")).trim();
			MARITAL_STATUS 	= common.setNullToString(DB_Contact.getColumnString("MARITAL_STATUS")).trim();
			SALUTATION 		= common.setNullToString(DB_Contact.getColumnString("SALUTATION")).trim();
			NATIONALITY 	= common.setNullToString(DB_Contact.getColumnString("NATIONALITY")).trim();
			RACE 			= common.setNullToString(DB_Contact.getColumnString("RACE")).trim();
			STATE 			= common.setNullToString(DB_Contact.getColumnString("STATE")).trim();
			POSTCODE 		= common.setNullToString(DB_Contact.getColumnString("POSTCODE")).trim();
			OCCUPATION_CODE	= common.setNullToString(DB_Contact.getColumnString("OCCUPATION_CODE")).trim();
			OCCUPATION_DESC	= common.setNullToString(DB_Contact.getColumnString("OCCUPATION_DESC")).trim();
			GENDER 			= common.setNullToString(DB_Contact.getColumnString("GENDER")).trim();
			TEL_NO_HOME 	= common.setNullToString(DB_Contact.getColumnString("TEL_NO_HOME")).trim();
			TEL_NO_OFFICE 	= common.setNullToString(DB_Contact.getColumnString("TEL_NO_OFFICE")).trim();
			MOBILE_NO 		= common.setNullToString(DB_Contact.getColumnString("MOBILE_NO")).trim();
			EMAIL 			= common.setNullToString(DB_Contact.getColumnString("EMAIL")).trim();
			FAX_NO_HOME 	= common.setNullToString(DB_Contact.getColumnString("FAX_NO_HOME")).trim();
			FAX_NO_OFFICE 	= common.setNullToString(DB_Contact.getColumnString("FAX_NO_OFFICE")).trim();
			BUSINESS_NO 	= common.setNullToString(DB_Contact.getColumnString("BUSINESS_NO")).trim();
			TRADE 			= common.setNullToString(DB_Contact.getColumnString("TRADE")).trim();
			CONTACT_TYPE 	= common.setNullToString(DB_Contact.getColumnString("CONTACT_TYPE")).trim();
			CONTACTID		= common.setNullToString(DB_Contact.getColumnString("CONTACTID")).trim();
			DELETED			= common.setNullToString(DB_Contact.getColumnString("DELETED")).trim(); 
			ORCCODE			= common.setNullToString(DB_Contact.getColumnString("ORCCODE")).trim(); 
			
			NATURE_BUSINESS	= common.setNullToString(DB_Contact.getColumnString("NATURE_BUSINESS")).trim(); 
			
			String EMPLOYER_TYPE	= common.setNullToString(DB_Contact.getColumnString("EMPLOYER_TYPE")).trim();
			session.setAttribute("SES_EMPLOYER_TYPE",EMPLOYER_TYPE);
			
			if(CONTACT_TYPE.equals("B"))
				TRADE 			= NATURE_BUSINESS;
			else
				OCCUPATION_CODE	= NATURE_BUSINESS;
  			session.setAttribute("SES_ORI_EFFDATE", EFFDATE); 
			if (!ISSDATE.equals("")) ISSDATE	= timestampFormat2.format(timestampFormat.parse(ISSDATE));      
			if (!EFFDATE.equals("")) EFFDATE	= timestampFormat2.format(timestampFormat.parse(EFFDATE));
			if(!EFFDATE.equals(""))
            	EXPDATE = common.fnGenExpDate(EFFDATE);
			if (!DOB.equals(""))     DOB		= timestampFormat2.format(timestampFormat.parse(DOB));
			
			if(TEL_NO_HOME.length() > 15)
				TEL_NO_HOME = TEL_NO_HOME.substring(0,15);
			if(TEL_NO_OFFICE.length() > 15)
				TEL_NO_OFFICE = TEL_NO_OFFICE.substring(0,15);
			if(FAX_NO_HOME.length() > 15)
				FAX_NO_HOME = FAX_NO_HOME.substring(0,15);
			if(FAX_NO_OFFICE.length() > 15)
				FAX_NO_OFFICE = FAX_NO_OFFICE.substring(0,15);
			if(MOBILE_NO.length() > 15)
				MOBILE_NO = MOBILE_NO.substring(0,15);           

			session.setAttribute("SES_USERID", USERID);
			session.setAttribute("SES_PRINCIPLE", PRINCIPLE);
			session.setAttribute("SES_INSCODE", PRINCIPLE);
			session.setAttribute("SES_ACCODE", ACCODE);
			session.setAttribute("SES_ISSDATE", ISSDATE); 
			session.setAttribute("SES_EFFDATE", EFFDATE); 			
			session.setAttribute("SES_EXPDATE", EXPDATE);
			session.setAttribute("SES_REGION", REGION);
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
			session.setAttribute("SES_STATUS", STATUS);
			session.setAttribute("SES_CONTACT_ID", CONTACTID);
		
			session.setAttribute("SES_TITLE",TITLE);
			
			session.setAttribute("SES_FWHS_NO",CNCODE);
			session.setAttribute("SES_ORCCODE",ORCCODE);
			
			session.setAttribute("SES_NATURE_BUSINESS",NATURE_BUSINESS);
			
			session.setAttribute("SES_FWCS_CONV_IND", FWCS_CONV_IND);
			session.setAttribute("SES_FWHS_CONV_IND", FWHS_CONV_IND);
			session.setAttribute("SES_FWIG_CONV_IND", FWIG_CONV_IND);
		} 
		DB_Contact.takeDown();
		
		SQL = "Select DEF_SPEC from TB_DEFCLAUSE where code = '2-03' and MAINCLS = 'WM' AND INSCODE='"+PRINCIPLE+"' WITH UR";
		
	    EASCManager.makeConnection();
	    EASCManager.executeQuery(SQL);
	    if (EASCManager.getNextQuery())
	    {
	    	DEF_SPEC = common.setNullToString(EASCManager.getColumnString("DEF_SPEC"));    	
	    }
	    EASCManager.takeDown();
	    
	    SQL = "Select NARRATION from TB_SPECIFICATION where CODE = '"+DEF_SPEC+"' AND MAINCLS = 'WM'  AND INSCODE='"+PRINCIPLE+"' WITH UR";
		
	    EASCManager.makeConnection();
	    EASCManager.executeQuery(SQL);
	    if (EASCManager.getNextQuery())
	    {
	    	DEF_SPECDESC	= common.setNullToString(EASCManager.getColumnString("NARRATION"));
	    	DEF_SPECDESC	= common.searchReplace(DEF_SPECDESC,"\n","\r\n");
	    	DEF_SPECDESC	= common.fnRetainNewLine(DEF_SPECDESC);
	    }
	    EASCManager.takeDown();	
		
		session.setAttribute("SES_SOURCE",SOURCE);

		Vector vEMPLOYEE 		= new Vector();
		
		String TABLE_TYPE		= "EmployeeTable";
    
		Vector vRow			= new Vector();
		int i = 0;
		
		SQL = "SELECT WM_FWCSSI,WM_FWCSPREM,FWIG_SFEE FROM TB_PARAM_NM WHERE INSCODE='"+PRINCIPLE+"' FETCH FIRST ROW ONLY WITH UR";
		DB_Contact.makeConnection();
        DB_Contact.executeQuery(SQL);
        String sSUMINS = "";
        String sPREM   = "";
        String sSFee	= "";
        if(DB_Contact.getNextQuery()) {
	         sSUMINS =  common.fnFormatComma(common.setNullToString(DB_Contact.getColumnString("WM_FWCSSI")));
	         sPREM   =  common.fnFormatComma(common.setNullToString(DB_Contact.getColumnString("WM_FWCSPREM")));
	         sSFee	 =	common.fnFormatComma(common.setNullToString(DB_Contact.getColumnString("FWIG_SFEE")));
        }
        DB_Contact.takeDown();
		
		SQL	= "SELECT * FROM TB_FWHSITEM WHERE UKEY LIKE '" + UKEY + "$%' ORDER BY CAST(SEQNO AS INTEGER) WITH UR"; 
	
		DB_Contact.makeConnection();
		DB_Contact.executeQuery(SQL);
		while(DB_Contact.getNextQuery()) 
		{ 
			String sUKEY		= common.setNullToString(DB_Contact.getColumnString("UKEY")).trim(); 

			StringTokenizer stSEQNO			= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("SEQNO")).trim(), "^"); 
			StringTokenizer stEMP_NAME		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("EMP_NAME")).trim(), "^"); 
			StringTokenizer stOCCPSEC		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("OCCPSEC")).trim(), "^"); 
			StringTokenizer stCARD			= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("CARD")).trim(), "^");			
			StringTokenizer stDOB			= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("DOB")).trim(), "^"); 
			StringTokenizer stGENDER		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("GENDER")).trim(), "^"); 
			StringTokenizer stPASSPORT		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("PASSPORT")).trim(), "^"); 
			StringTokenizer stNATIONALITY	= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("NATIONALITY")).trim(), "^"); 
			
			com.rexit.easc.StringTokenizer stTERM_DATE		= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("TERM_DATE")).trim(), "^","",true); 
			com.rexit.easc.StringTokenizer stWORK_EXP		= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("WORK_EXP")).trim(), "^","",true);
			com.rexit.easc.StringTokenizer stINSURED_FOR	= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("INSURED_FOR")).trim(), "^","",true);
			com.rexit.easc.StringTokenizer stWORK_ID		= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("WORK_ID")).trim(), "^","",true);
	
			while(stSEQNO.hasMoreTokens()) 
			{ 
				String sSEQNO		= ""; 
				String sEMP_NAME	= ""; 
				String sOCCPSEC		= ""; 
				String sDOB			= ""; 
				String sGENDER		= ""; 
				String sPASSPORT	= ""; 
				String sNATIONALITY	= ""; 
				String sWORK_EXP	= ""; 
				String sCARD		= "Y";
				String sTERM_DATE	= "";
				String sINSURED_FOR	= "";
				String sWORK_ID		= "";
				
				try { sSEQNO		= stSEQNO.nextToken(); } catch (Exception exp) { sSEQNO	= ""; } 
				try { sEMP_NAME		= stEMP_NAME.nextToken(); } catch (Exception exp) { sEMP_NAME	= ""; } 
				try { sOCCPSEC		= stOCCPSEC.nextToken(); } catch (Exception exp) { sOCCPSEC	= ""; }  
				try { sDOB			= stDOB.nextToken(); } catch (Exception exp) { sDOB	= ""; } 
				try { sGENDER		= stGENDER.nextToken(); } catch (Exception exp) { sGENDER	= ""; } 
				try { sPASSPORT		= stPASSPORT.nextToken(); } catch (Exception exp) { sPASSPORT	= ""; } 
				try { sNATIONALITY	= stNATIONALITY.nextToken(); } catch (Exception exp) { sNATIONALITY	= ""; } 
				try { sWORK_EXP		= stWORK_EXP.nextToken(); } catch (Exception exp) { sWORK_EXP	= ""; } 
				try { sTERM_DATE	= stTERM_DATE.nextToken(); } catch (Exception exp) { sTERM_DATE	= ""; } 
				try { sINSURED_FOR	= stINSURED_FOR.nextToken(); } catch (Exception exp) { sINSURED_FOR	= ""; }
				try { sWORK_ID		= stWORK_ID.nextToken(); } catch (Exception exp) { sWORK_ID	= ""; }
				 
				
				try 
				{ 
					if (!sDOB.equals(""))	sDOB	= timestampFormat2.format(timestampFormat.parse(sDOB));
				}
				catch(Exception e) { } 
	
				try 
				{ 
					if (!sWORK_EXP.equals(""))	sWORK_EXP	= timestampFormat2.format(timestampFormat.parse(sWORK_EXP));
				}
				catch(Exception e) { }
				
				EASCManager.makeConnection();
				try
				{   
					String sNATDESCP 	= EASCManager.retrieveDescp(sNATIONALITY, "NATIONALITY", "DESCP", "TB_FWIGPREM","INSCODE", PRINCIPLE); 
					sNATIONALITY		= sNATIONALITY + " " + sNATDESCP;
					sNATIONALITY		= sNATIONALITY.trim();
				}
				catch (Exception exp)
				{
					exp.printStackTrace();
				}
				finally
				{
					EASCManager.takeDown();
				}
				
				if(sTERM_DATE.equals(""))
				{
					i++;
					vRow = new Vector();
					vRow.addElement(i+"");
			        vRow.addElement(i+"");
			        vRow.addElement("General Description");
			        vRow.addElement(sEMP_NAME);
					vRow.addElement(sOCCPSEC);
					vRow.addElement("Y");
					vRow.addElement(""); //6
					vRow.addElement(""); //7
					vRow.addElement(sDOB);  //8
					vRow.addElement(sGENDER);
					vRow.addElement(sPASSPORT);
					vRow.addElement(sNATIONALITY);
					vRow.addElement(sINSURED_FOR);
					vRow.addElement(sWORK_EXP);
					vRow.addElement(sSUMINS);   //13
					vRow.addElement(sPREM) ;  //14
					vRow.addElement(sSFee);  //15
					vRow.addElement(sPREM);  //16
					vRow.addElement("");
					vRow.addElement("");
					vRow.addElement("");
					vRow.addElement("");
					vRow.addElement("");				
					vRow.addElement("");
					vRow.addElement("");
					vRow.addElement("");
					vRow.addElement("");
					vRow.addElement(sWORK_ID);
					vEMPLOYEE.addElement(vRow);
				}
			}
			htItem.put("1", vEMPLOYEE); 
			stSEQNO			= null; 
			stEMP_NAME		= null; 
			stOCCPSEC		= null; 
			stCARD			= null; 
			stTERM_DATE		= null; 
			stDOB			= null; 
			stGENDER		= null; 
			stPASSPORT		= null; 
			stNATIONALITY	= null; 
			stWORK_EXP		= null; 
			
		}
		DB_Contact.takeDown();
		Vector vTable	= new Vector();

		vRow	= new Vector();
		vRow.addElement("1");
        vRow.addElement("1");
		vRow.addElement("General Description 1");
		vRow.addElement(DEF_SPEC);
	    vRow.addElement(DEF_SPECDESC);
		vRow.addElement("0.00");	
		vRow.addElement("0.00");
		vRow.addElement("0.00");
		vRow.addElement("0.00");
		vRow.addElement("N");
        vRow.addElement("N");
		vTable.addElement(vRow); 
 		session.setAttribute("table_vTable_Desc", vTable);
		session.setAttribute("keepRecord", vTable);
		session.setAttribute("RiskItem", htItem); 
	}	
	
	session.setAttribute("SES_CONVERT","Y");
	session.setAttribute("SES_CLS","WM");
	session.setAttribute("SES_WMCLASS","FWCS");
	session.setAttribute("SES_CLASS_CODE","2-03");
	session.setAttribute("SES_TRANSKEY","INIT");
	response.sendRedirect(PAGE);
	
%>