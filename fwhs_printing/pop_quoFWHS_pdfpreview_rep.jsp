<%@ page language="java" import="com.rexit.easc.postSubmission,java.io.*,java.net.*,java.util.*,java.util.Date,java.text.SimpleDateFormat,com.lowagie.text.*,com.lowagie.text.pdf.*,com.rexit.easc.EInvoiceAPI.GetDocument"  contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="RP_html2pdf" scope="page" class="com.rexit.easc.RP_html2pdf" />
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB_Template" scope="page" class="com.rexit.easc.DB_Template" />
<jsp:useBean id="DB_Appointment" scope="page" class="com.rexit.easc.DB_Appointment" />
<jsp:useBean id="DB_FWHS" scope="page" class="com.rexit.easc.DB_FWHS" />
<jsp:useBean id="inputXML" scope="page" class="com.rexit.easc.inputXML" />
<jsp:useBean id="postMQXML" scope="page" class="com.rexit.easc.postMQXML" />
<jsp:useBean id="DB_Myprofile" scope="page" class="com.rexit.easc.DB_Myprofile" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="BestinetXML" scope="page" class="com.rexit.easc.BestinetXML" />
<jsp:useBean id="mailsender" scope="page" class="com.rexit.easc.mailsender" />
<jsp:useBean id="DB_FWPOL" scope="page" class="com.rexit.easc.DB_FWPOL" />
<jsp:useBean id="DB_Contact2" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="Period" scope="page" class="com.rexit.easc.speriod" />
<jsp:useBean id="DB_Workmen" scope="page" class="com.rexit.easc.DB_Workmen" />
<jsp:useBean id="DB_Contact1" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="eInvoice" scope="page" class="com.rexit.easc.EInvoiceAPI" />
<jsp:useBean id="SignInvoiceUtil" scope="page" class="com.rexit.easc.SignInvoiceDocument" />

<html>
<head></head>
<body>
<%
    String SESUSERID 		= common.setNullToString((String)session.getAttribute("SESUSERID"));
	if ((SESUSERID.equals("")) || (SESUSERID == null))
    {
        response.sendRedirect("../login/logout.jsp"); 
        return;
    }
    
	SimpleDateFormat timestampFormat3 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
    SimpleDateFormat timestampFormat1 = new SimpleDateFormat("yyyyMMddHHmmss");//by Gopi for XML generation
    SimpleDateFormat timestampFormat2 = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat timestampFormat = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat timestampFormat4 = new SimpleDateFormat("hh:mm:ssa");
    String printtime    = timestampFormat3.format(new Date());    
    String DATE_CREATED = timestampFormat1.format(new Date()); //by Gopi for XML generation        
    String today	 	= timestampFormat2.format(new Date()); 
    String CNTIME       = timestampFormat4.format(new Date()); 
    
    String print_time   = timestampFormat3.format(new Date());
    //get list of files in ../template_image
    FileInputStream is = new FileInputStream("/easc/configk.prop");
    Properties prop = new Properties();
    prop.load(is);
    String server_root = prop.getProperty("server_root");
    String temp_path = prop.getProperty("temp_path");

	String POLTYPE2 		= common.setNullToString(request.getParameter("POLTYPE2"));
    String TABLECN	 		= common.setNullToString(request.getParameter("TABLECN")); 
    String TABLESCH	 		= common.setNullToString(request.getParameter("TABLESCH")); 
    String MAINCLS	 		= common.setNullToString(request.getParameter("MAINCLS")); 
    String PM_ENDORSE	 	= common.setNullToString(request.getParameter("PM_ENDORSE")); 
    String INS	 			= common.setNullToString(request.getParameter("INS")); 
    String QUICK_IND	 	= common.setNullToString(request.getParameter("QUICK_IND")); 
    String TABLE     		= common.filterAttack(request.getParameter("TABLE"));
	//SST
	Date today_1			= new Date();
	Date SST_EFFDATE;
	String SST_TRIGGER		= "";    
	String BUTTONIND    	= common.setNullToString(request.getParameter("BUTTONIND"));
    String BUTTONIND_TEMP   = common.setNullToString(request.getParameter("BUTTONIND_TEMP"));
    String LANGUAGE     	= common.setNullToString(request.getParameter("LANGUAGE"));
    String AMTDESC 			= common.setNullToString(request.getParameter("AMTDESC"));
    String CLASS     		= common.setNullToString((String) session.getAttribute("CLASS"));
    String RESP_CODE		= common.setNullToString(request.getParameter("RESP_CODE")); 
    String RESP_STATUS		= common.setNullToString(request.getParameter("RESP_STATUS"));
    String ERRORDESCP		= common.setNullToString(request.getParameter("ERRORDESCP")); 
    String CNCODE1			= common.setNullToString(request.getParameter("CNCODE1")); 
    String NOWORKER			= common.setNullToString(request.getParameter("NOWORKER")); 
    String FWCMSREF			= common.setNullToString(request.getParameter("FWCMSREF")); 
    String SUBMITIND		= common.setNullToString(request.getParameter("SUBMITIND"));      
	String UKEY	 			= common.setNullToString(request.getParameter("UKEY")); 
	String TYPE				= common.setNullToString(request.getParameter("TYPE"));
    String EMAIL_TO  		= common.setNullToString(request.getParameter("EMAIL_TO"));
    String CNCODE  			= common.setNullToString(request.getParameter("CNCODE"));
    String FILE_NAME		= common.setNullToString(request.getParameter("fileName"));
    String SESBRCODE_LOGIN  = common.setNullToString((String) session.getAttribute("SESBRCODE_LOGIN"));
    String BRUSERID			= common.setNullToString((String) session.getAttribute("SESBRUSERID")); 
    String genMCN			= common.setNullToString(request.getParameter("genMCN"));
    String privacyLang		= common.setNullToString(request.getParameter("privacyLang"));
    
    String CUT_OFF		= common.setNullToString(request.getParameter("CUT_OFF"));
    
    int iRowAffected 		= 0;
	String CNOTE			= "";
    int iRowsAffected 		= 0;
    String SRC_URL			= "pop_cn_fwhs_preview.jsp";
    String WITHOUTLOGO		=  "Y";
    String REPLACECN		= "";
    String PREVPOL			= "";
	String GST_TAX_NO	 	= "";
	String GST_TAX_NO_END	= "";
	String GSTTAX_TRIGGER	= "Y";
	String GST_RT		 	= "";
 	String GST_IND			= "";
 	String GST_TAX_NO2		= "";
	String TITLE_GST 		= "";
	String PREV_TAX_NO		= "";
	String GST_STATUS		= "";
	String GST_AMT		  	= "0.00";
	String GST_COMMAMT		= "0.00";
	String GST_TF_AMT		= "0.00";
	String GST_OTHAMT		= "0.00";
	String logo_height		= "140";
	String logo_height2		= "120";
	String FILE_PATH 		= temp_path+"/"+FILE_NAME;
    String EMAIL_FROM   	= prop.getProperty("easc_email");
	boolean error 			= false;
	String subID			= "";
    String EMAIL_CC			= "";
    String PRINCIPLE		= common.setNullToString((String)session.getAttribute("SESINSCODE"));
	String SQL				= "";
	String ACCODE			= ""; 
	String sName			= "-"; 
	String sAddress			= "-"; 
	String sTelephone		= "-"; 
	String sFax				= "-"; 
	String table			= "";
	String ENDORSE_NO		= "";
	String STATUS			= "";
	String SOURCE			= "F";
	String split_cancel_xml	= "";
	String FWCS_CONV_IND	= common.setNullToString(request.getParameter("FWCS_CONV_IND"));  
    String FWIG_CONV_IND	= common.setNullToString(request.getParameter("FWIG_CONV_IND")); 
    
    Vector vCNCODE			= new Vector();
    String ePLKS_MCN		= common.setNullToString(request.getParameter("ePLKS_MCN")); 
    
    String TIN =	common.setNullToString(request.getParameter("TIN"));
    String SST =	common.setNullToString(request.getParameter("SST")); 
    
    String STAMP_FEES = "0.00";
    
    if(ePLKS_MCN.equals("Y") || !FWCMSREF.equals("")){
		FILE_NAME = SESUSERID + "-FWHS-" + FWCMSREF + ".pdf";
	}

	if(BUTTONIND.equals("J") || BUTTONIND.equals("D") || BUTTONIND.equals("P") || BUTTONIND.equals("C"))
	{
		//FWCMS Confirm transaction
		if(RESP_STATUS.equals("F") && !ERRORDESCP.equals("") && !FWCMSREF.equals(""))
		{
		%>
			<script language="Javascript">
				alert("<%=ERRORDESCP%>");
			</script>
		<%  
			error = true;
		}    
		    
    	try {
	
			table 				= "TB_FWHSCN"; 
			String ORCCODE		= "";
			String POLNO		= "";
			String SQL2			= "";
			String SUBCODE		= "";
			String MASTERIND	= "";
			String NEW_IC_NO	= "";
			String OLD_IC_NO	= "";
			String CONTACT_TYPE	= "";
			String BUSINESS_NO	= "";
			String CNTYPE		= "";
			
			SQL	= "SELECT STATUS,CONTACT_TYPE,NEW_IC_NO,OLD_IC_NO,BUSINESS_NO,ACCODE FROM TB_FWHSCN WHERE UKEY = '"+ CNCODE+"' WITH UR"; 
			DB_Contact.makeConnection();
			DB_Contact.executeQuery(SQL);
			while(DB_Contact.getNextQuery())
			{
				STATUS 			= common.setNullToString(DB_Contact.getColumnString("STATUS"));
				CONTACT_TYPE	= common.setNullToString(DB_Contact.getColumnString("CONTACT_TYPE"));	
				NEW_IC_NO 		= common.setNullToString(DB_Contact.getColumnString("NEW_IC_NO"));	
				OLD_IC_NO		= common.setNullToString(DB_Contact.getColumnString("OLD_IC_NO"));
				BUSINESS_NO		= common.setNullToString(DB_Contact.getColumnString("BUSINESS_NO"));
				ACCODE			= common.setNullToString(DB_Contact.getColumnString("ACCODE"));
				
			}
			DB_Contact.takeDown();

			String POLEXIST	= "N";
		    SQL = "SELECT * FROM TB_FWHS_NEWPOL WHERE INSCODE = '"+PRINCIPLE+"' AND POLICYNO = '"+ CNCODE.substring(2)+"' WITH UR";
		    DB_FWPOL.makeConnection2();
		    DB_FWPOL.executeQuery(SQL);       
		    if(DB_FWPOL.getNextQuery())
		    {
		        POLEXIST		= "Y";
		    }
		    DB_FWPOL.takeDown();

			if(BUTTONIND.equals("J") && STATUS.equals("SAVED") && !error){
			
				boolean exception       = false;
				String ISSDATE			= "";
				String EFFDATE			= ""; 
				String EXPDATE			= "";
				String sGNL_BUSINESS	= "";					
				String sSUMINS      	= "0.00"; 
			    String sPREMIUM     	= "0.00"; 
			    String sEST_EARN    	= "0.00"; 
			    String sRATEAMT     	= "0.00"; 
			    String sBASICPREM   	= "0.00"; 
			    String sAPREM       	= "0.00"; 
			    String sDISWAGEPCT  	= "0.00"; 
			    String sDISWAGEAMT  	= "0.00"; 
			    String sGPREM       	= "0.00"; 
			    String sREBATEAMT   	= "0.00"; 
			    String sREBATEPCT   	= "0.00"; 
			    String sSTAXAMT     	= "0.00"; 
			    String sSTAXPCT     	= "0.00"; 
			    String sTCPA_STAXPCT   	= "0.00"; 
			    String sSERVICE_FEE 	= "0.00"; 
			    String sFWCMS_FEE		= "0.00"; 
			    String sLEVYAMT     	= "0.00"; 
			    String sSTAMPDUTY   	= "0.00"; 
			    String sNETTPREM    	= "0.00"; 
			    String sCOMMAMT     	= "0.00"; 
			    String sCOMMPCT     	= "0.00"; 
			    String sORCAMT      	= "0.00"; 
			    String sORCPCT      	= "0.00"; 
			    String sTOTPREM     	= "0.00"; 
			    String sORG_APREM   	= "0.00";
			    String sGST_OTHAMT  	= "0.00"; 
			    String sGST_FWCMSAMT	= "0.00"; 
			    String sGST_Amt			= "0.00";
			    String sGST_CommAmt		= "0.00";
			    String sSUBCLS      	= ""; 
			    String sCFMKT_IND   	= "";
			    String sFWCS_IND		= "";
			    String CFMKT_TIMESTAMP	= "";
			    String TRANSTYPE    	= "CN";
			    String CLIENTID    		= "";
			    String AUTO_SUBMIT_IND	= "";
				String sPOSTCODE		= "";
		        String sPOSTDESCP		= "";
	        	String EMPLOYER_TYPE 	= "";
				String NAME			    = "";
				String ADDRESS_1 		= "";
				String ADDRESS_2 		= "";
				String ADDRESS_3 		= "";
				String ADDRESS_4		= "";
				String STATECODE	    = "";
				String POSTCODE		    = "";
				String NATURE_BUSINESS  = "";
				String TEL_NO_HOME		= "";
				String TEL_NO_OFFICE 	= "";
				String MOBILE_NO 		= "";
				String EMAIL			= "";
				String INSUREDFOR		= "";
				String WORKPERMITNO		= "";
				
				String MASTERPOL 		= "";
				String USERID	 		= "";
				
				SQL	= "SELECT * FROM TB_FWHSCN WHERE UKEY = '"+ CNCODE+"' WITH UR"; 
				DB_Contact.makeConnection();
				DB_Contact.executeQuery(SQL);
				while(DB_Contact.getNextQuery())
				{
					ISSDATE			= common.setNullToString(DB_Contact.getColumnString("ISSDATE")).trim();
					EFFDATE			= common.setNullToString(DB_Contact.getColumnString("EFFDATE")).trim(); 
					EXPDATE			= common.setNullToString(DB_Contact.getColumnString("EXPDATE")).trim();
					sGNL_BUSINESS	= common.setNullToString(DB_Contact.getColumnString("NATURE_BUSINESS")).trim();
					PRINCIPLE		= common.setNullToString(DB_Contact.getColumnString("PRINCIPLE"));
					CNTYPE			= common.setNullToString(DB_Contact.getColumnString("CNTYPE"));
					ACCODE			= common.setNullToString(DB_Contact.getColumnString("ACCODE"));
					CLASS			= common.setNullToString(DB_Contact.getColumnString("CLASS"));
					CONTACT_TYPE	= common.setNullToString(DB_Contact.getColumnString("CONTACT_TYPE"));
					EMPLOYER_TYPE	= common.setNullToString(DB_Contact.getColumnString("EMPLOYER_TYPE"));
					NAME			= common.setNullToString(DB_Contact.getColumnString("NAME"));
					ADDRESS_1		= common.setNullToString(DB_Contact.getColumnString("ADDRESS_1"));
					ADDRESS_2		= common.setNullToString(DB_Contact.getColumnString("ADDRESS_2"));
					ADDRESS_3		= common.setNullToString(DB_Contact.getColumnString("ADDRESS_3"));
					ADDRESS_4		= common.setNullToString(DB_Contact.getColumnString("ADDRESS_4"));
					STATECODE		= common.setNullToString(DB_Contact.getColumnString("STATE"));
					POSTCODE		= common.setNullToString(DB_Contact.getColumnString("POSTCODE"));
					NATURE_BUSINESS	= common.setNullToString(DB_Contact.getColumnString("NATURE_BUSINESS"));
					TEL_NO_HOME		= common.setNullToString(DB_Contact.getColumnString("TEL_NO_HOME"));
					TEL_NO_OFFICE		= common.setNullToString(DB_Contact.getColumnString("TEL_NO_OFFICE"));
					MOBILE_NO		= common.setNullToString(DB_Contact.getColumnString("MOBILE_NO"));
					EMAIL		= common.setNullToString(DB_Contact.getColumnString("EMAIL"));
					USERID			= common.setNullToString(DB_Contact.getColumnString("USERID")).trim();
					
					MASTERPOL		= common.setNullToString(DB_Contact.getColumnString("MASTERPOL")).trim();
			
		            int iPostSpace = POSTCODE.indexOf(" ");
	
		            if (iPostSpace > 0)
					{
					    sPOSTDESCP	= POSTCODE.substring(iPostSpace+1,POSTCODE.length());
					    sPOSTCODE	= POSTCODE.substring(0,iPostSpace);
					}
					
					if (!EFFDATE.equals("")) EFFDATE	= timestampFormat.format(timestampFormat2.parse(EFFDATE));
					if (!EXPDATE.equals("")) EXPDATE	= timestampFormat.format(timestampFormat2.parse(EXPDATE));
				}
				
					SQL = "SELECT VALUE1 FROM TB_CONTROL WHERE INSCODE='08' AND TYPE='PRIVACY_NOTICE' AND CODE='PRIVACY_NOTICE' WITH UR";
					DB_Contact.executeQuery(SQL);
					if(DB_Contact.getNextQuery())
					{
						SimpleDateFormat temp_timestampFormat = new SimpleDateFormat("yyyyMMdd");
						String temp_value   = common.setNullToString(DB_Contact.getColumnString("VALUE1"));
						if(!temp_value.equals(""))
						{
							if((Integer.parseInt(ISSDATE)<Integer.parseInt(temp_value)) || (Integer.parseInt(ISSDATE) == Integer.parseInt(temp_value)))
							{
								CUT_OFF = "OLD";
							}else {
								CUT_OFF = "NEW";
							}
						}
					}
					DB_Contact.takeDown();
				
				String SST_EFFDATE_1 		= "";
				SQL	= "SELECT EFFDATE FROM TB_SST WHERE INSCODE = '08' AND MAINCLS = 'FWHS' AND SST_PCT != '0.00' ORDER BY EFFDATE ASC FETCH FIRST ROW ONLY WITH UR";
				DB_Contact.makeConnection();
				DB_Contact.executeQuery(SQL);
				if(DB_Contact.getNextQuery()) 
				{
					SST_EFFDATE_1 = common.setNullToString(DB_Contact.getColumnString("EFFDATE"));		
				}
				DB_Contact.takeDown();
					
				SST_EFFDATE 		 = timestampFormat2.parse(SST_EFFDATE_1);

				Date TCPA_SST_EFFDATE;
				String TCPA_SST_EFFDATE_1 		= "";
				SQL	= "SELECT EFFDATE FROM TB_SST WHERE INSCODE = '08' AND MAINCLS = 'FWHS_TCPA' AND SST_PCT != '0.00' ORDER BY EFFDATE ASC FETCH FIRST ROW ONLY WITH UR";
				DB_Contact.makeConnection();
				DB_Contact.executeQuery(SQL);
				if(DB_Contact.getNextQuery()) 
				{
					TCPA_SST_EFFDATE_1 = common.setNullToString(DB_Contact.getColumnString("EFFDATE"));		
				}
				DB_Contact.takeDown();
				
				TCPA_SST_EFFDATE 		 = timestampFormat2.parse(TCPA_SST_EFFDATE_1);

				if(!ISSDATE.equals("")){
					today_1				 = timestampFormat2.parse(ISSDATE);
				}
						
				if(today_1.after(TCPA_SST_EFFDATE) || today_1.compareTo(TCPA_SST_EFFDATE) == 0){
					SST_TRIGGER = "N";
					sSTAXPCT    = "6.00";
				}			

				if(today_1.after(SST_EFFDATE) || today_1.compareTo(SST_EFFDATE) == 0){
					SST_TRIGGER = "N";
					sTCPA_STAXPCT    = "6.00";
				}			
								
				String STATECD = "";
			    if(!STATECODE.equals(""))
			    {
			 	   DB_Contact.makeConnection();
			 	   SQL = "SELECT CODE FROM TB_STATE WHERE INSCODE='"+PRINCIPLE+"' AND UCASE(DESCP) ='"+STATECODE+"' WITH UR";
			 	   DB_Contact.executeQuery(SQL);
		           if(DB_Contact.getNextQuery())
		           {
		               STATECD       = common.setNullToString(DB_Contact.getColumnString("CODE")); 
		           }else{
		        	   STATECD		= "OTH";
		           }
		           DB_Contact.takeDown();
			    }
    					
				String GST_DATE			= "";
				String GST_TRIGGER		= "";
				String GST_PCT			= "";
				String GST_COMMPCT		= "";
				String COUNTRY			= "";
				String GST_STATUS_IND 	= "";
				String GST_NO	 		= "";
				String TOWN				= "";
			    String tempSUMINS  		= "";		
				String tempGPREM		= "";   
				String tempSERVICE_FEE	= "";
				String tempSTAXAMT		= "";
				String tempLEVYAMT		= "";
				String tempREBATEAMT	= "";
				
				SQL	=	"SELECT VALUE1 FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='GST' AND CODE='GST_DATE' WITH UR";
			    DB_Contact.makeConnection(); 
				DB_Contact.executeQuery(SQL);
				if(DB_Contact.getNextQuery())
				{
					GST_DATE   = common.setNullToString(DB_Contact.getColumnString("VALUE1"));
				}
				DB_Contact.takeDown();
				
				if(!GST_DATE.equals(""))
				{
					if(Integer.parseInt(ISSDATE)>=Integer.parseInt(GST_DATE))
					{
						GST_TRIGGER = "Y";
					}
				}
			    
			    if(GST_TRIGGER.equals("Y"))
				{
				    SQL	= "SELECT * FROM TB_GST WHERE INSCODE='"+PRINCIPLE+"' AND MAINCLS='FWHS' AND EFFDATE<='"+ISSDATE+"' AND EXPDATE>='"+ISSDATE+"' ORDER BY EXPDATE FETCH FIRST 1 ROW ONLY WITH UR";
					DB_Contact.makeConnection();
					DB_Contact.executeQuery(SQL);
					if(DB_Contact.getNextQuery()) 
					{
						GST_PCT	 	= common.setNullToString(DB_Contact.getColumnString("GST_PCT"));
						GST_COMMPCT	= common.setNullToString(DB_Contact.getColumnString("GST_PCT"));
				    }
				    DB_Contact.takeDown();
				    
				    SQL	= "SELECT * FROM TB_GST_CN WHERE PRINCIPLE='"+PRINCIPLE+"' AND MAINCLS='FWHS' AND UKEY='"+CNCODE+"' FETCH FIRST 1 ROW ONLY WITH UR";
					DB_Contact.makeConnection();
					DB_Contact.executeQuery(SQL);
					if(DB_Contact.getNextQuery()) 
					{
						COUNTRY	 		= common.setNullToString(DB_Contact.getColumnString("COUNTRY"));
						GST_STATUS_IND	= common.setNullToString(DB_Contact.getColumnString("GST_STATUS"));
						GST_NO	 		= common.setNullToString(DB_Contact.getColumnString("GST_NO"));
						TOWN	 		= common.setNullToString(DB_Contact.getColumnString("TOWN"));
				    }
				    DB_Contact.takeDown();					    
				    
				    if(COUNTRY.trim().equals(""))
				    {
				    	COUNTRY = "MYS";	    	
				    }
				    
				    if(COUNTRY.equals("MYS") && !SST_TRIGGER.equals("N")){
						GST_RT		= "SR";
				    }else if(SST_TRIGGER.equals("N")){
						GST_RT		= "SST";
				    }else{
				    	GST_PCT 	= "0.00";
				    	GST_COMMPCT = "0.00";
						GST_RT		= "ZR";	    	
				    }
				    
				    String GST_AGENT_STATUS = "";
				    SQL	=	"SELECT GST_STATUS FROM TB_AGENT_AM WHERE INSCODE='"+PRINCIPLE+"' AND ACCODE='"+ACCODE+"' WITH UR";
				    DB_Contact.makeConnection(); 
					DB_Contact.executeQuery(SQL);
					if(DB_Contact.getNextQuery())
					{
						GST_AGENT_STATUS   = common.setNullToString(DB_Contact.getColumnString("GST_STATUS"));
					}
				    DB_Contact.takeDown();
				    
				    if(!GST_AGENT_STATUS.equals("Y"))
				    {
				    	GST_COMMPCT = "0.00";
				    }
				}	
				
				SQL = "SELECT * FROM TB_FWHSSCH WHERE UKEY2='"+CNCODE+"' WITH UR";
				DB_Template.makeConnection();
		        DB_Template.executeQuery(SQL);
		        if(DB_Template.getNextQuery())
		        {
		            sREBATEPCT		= common.setNullToString(DB_Template.getColumnString("REBATEPCT"));
		            sSTAMPDUTY		= common.setNullToString(DB_Template.getColumnString("STAMPDUTY"));
		            sCOMMPCT		= common.setNullToString(DB_Template.getColumnString("COMMPCT"));
		            sSUBCLS			= common.setNullToString(DB_Template.getColumnString("SUBCLS"));
		            sCFMKT_IND		= common.setNullToString(DB_Template.getColumnString("CFMKT_IND"));
		            sFWCS_IND		= common.setNullToString(DB_Template.getColumnString("GUARANTEE_NO"));
		            tempSUMINS  	= common.setNullToString(DB_Template.getColumnString("SUMINS"));
		            tempGPREM		= common.setNullToString(DB_Template.getColumnString("GPREM"));
		            tempSERVICE_FEE	= common.setNullToString(DB_Template.getColumnString("SERVICE_FEE"));
		            tempSTAXAMT		= common.setNullToString(DB_Template.getColumnString("STAXAMT"));
		            tempLEVYAMT		= common.setNullToString(DB_Template.getColumnString("LEVYAMT"));
		            tempREBATEAMT   = common.setNullToString(DB_Template.getColumnString("REBATEAMT"));	
		            sSTAXPCT	   	= common.setNullToString(DB_Template.getColumnString("STAXPCT"));	
		            sTCPA_STAXPCT   = common.setNullToString(DB_Template.getColumnString("LEVYPCT"));	
		        }
		        DB_Template.takeDown();
				
				String sRate = common.setNullToString(request.getParameter("SRATE")); 
		        if(sRate.equals("")) sRate = "1";
		        
		        double dSRATE 		= 1;
		        if(!EFFDATE.equals("") && !EXPDATE.equals("")){
					Period.makeConnection();
					dSRATE 			=  Period.fnGetPRate2(EFFDATE,EXPDATE);
					Period.takeDown();
				}
				
				String sGNL_SEQNO		= "1"; 
				String sGNL_DESC		= "Within Malaysia"; 
				String sGNL_SUMINS		= "0.00"; 
				String sGNL_PREMIUM		= "0.00"; 
				String sGNL_SERVICE_FEE	= "0.00";
				String sGNL_FWCMS_FEE	= "0.00";
		
				Vector vTable	= new Vector();
				
				Vector vRow	= new Vector(); 
				vRow.addElement(sGNL_SEQNO);
		        vRow.addElement(sGNL_SEQNO);
				vRow.addElement(sGNL_DESC);
				vRow.addElement(sGNL_BUSINESS);			
				vRow.addElement("0");			
				vRow.addElement(sGNL_SUMINS);	
				vRow.addElement(sGNL_PREMIUM);
				vRow.addElement(sGNL_SERVICE_FEE);
				vRow.addElement(sGNL_FWCMS_FEE);
				vRow.addElement("0.00");
				vTable.addElement(vRow); 
				
				Vector vRow2	= new Vector(); 
				
				String tempDATE = "";
				if(!EFFDATE.equals(""))
					tempDATE = timestampFormat2.format(timestampFormat.parse(EFFDATE));
				
				String HS_FEE 		= "0.00";
				String FW_FEE 		= "0.00";
				String HS_SUMINS	= "0.00";
				String HS_APREM		= "0.00";
				String HS_PREM		= "0.00";

				DB_Contact.makeConnection();
				SQL = "SELECT VALUE1,VALUE2,VALUE3 FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='FWHS' AND CODE='DEFAULT' WITH UR";
				DB_Contact.executeQuery(SQL);
				if(DB_Contact.getNextQuery()) {
					HS_SUMINS	= common.fnFormatComma(common.setNullToString(DB_Contact.getColumnString("VALUE3")));
					HS_PREM   	= common.fnCutComma(common.setNullToString(DB_Contact.getColumnString("VALUE1")));
					HS_FEE		= common.fnCutComma(common.setNullToString(DB_Contact.getColumnString("VALUE2")));
				}    
				DB_Contact.takeDown();

				DB_Contact.makeConnection();		
				SQL2 = "SELECT VALUE2 FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='FWHS' AND CODE='DEFAULT_SI' AND VALUE1<='"+tempDATE+"' ORDER BY VALUE1 DESC FETCH FIRST 1 ROW ONLY WITH UR";
				DB_Contact.executeQuery(SQL2);
				if(DB_Contact.getNextQuery()) {
					HS_SUMINS  = common.fnFormatComma(common.setNullToString(DB_Contact.getColumnString("VALUE2")));
				}    
				DB_Contact.takeDown();

				String SQL3 = "SELECT VALUE2,VALUE3 FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='FWHS' AND CODE='DEFAULT_FEE' AND VALUE1<='"+tempDATE+"' ORDER BY VALUE1 DESC FETCH FIRST 1 ROW ONLY WITH UR";
				DB_Contact.makeConnection();
				DB_Contact.executeQuery(SQL3);
				if(DB_Contact.getNextQuery()) {
					HS_FEE  	= common.fnFormatComma(common.setNullToString(DB_Contact.getColumnString("VALUE2")));
					FW_FEE  	= common.fnFormatComma(common.setNullToString(DB_Contact.getColumnString("VALUE3")));
			    }
				DB_Contact.takeDown();
				
				SQL = "SELECT CLIENTID FROM TB_TRANSACTION WHERE IDNO='"+CNCODE+"' WITH UR";
		        DB_Contact.makeConnection();
				DB_Contact.executeQuery(SQL);
		        while(DB_Contact.getNextQuery())
		        {
		        	CLIENTID	= common.setNullToString(DB_Contact.getColumnString("CLIENTID"));
		        }
		        DB_Contact.takeDown();
		        
		        SQL = "SELECT AUTO_SUBMIT_IND FROM TB_AGENT_AM WHERE INSCODE='"+PRINCIPLE+"' AND ACCODE = '"+ACCODE+"' WITH UR";
		        DB_Contact.makeConnection();
		        DB_Contact.executeQuery(SQL);			
		        if(DB_Contact.getNextQuery())
		        {
		            AUTO_SUBMIT_IND   = common.setNullToString(DB_Contact.getColumnString("AUTO_SUBMIT_IND"));
			    }
			    DB_Contact.takeDown();
				
				HS_APREM		= HS_PREM;
			    double dPREM	= Double.parseDouble(HS_PREM);
			    dPREM			= dPREM * dSRATE;
			    
			    double dFEE		= Double.parseDouble(HS_FEE);
			    dFEE			= dFEE * dSRATE;
			    
			    double dFW_FEE	= Double.parseDouble(FW_FEE);
			    dFW_FEE			= dFW_FEE * dSRATE;
			    
			    HS_PREM			= common.fnFormatComma(common.fnGetValue2(dPREM));
			    HS_FEE			= common.fnFormatComma(common.fnGetValue2(dFEE));
			    FW_FEE			= common.fnFormatComma(common.fnGetValue2(dFW_FEE));
	
				Vector vRiskItem	= new Vector();
    			Vector vFWHSSUB		= new Vector();
				
				//TB_FWHSITEM
				SQL	= "SELECT * FROM TB_FWHSITEM WHERE UKEY LIKE '" + CNCODE + "$%' AND TERM_DATE='' ORDER BY CAST(SEQNO AS INTEGER) WITH UR"; 
				DB_Contact.makeConnection();
				DB_Contact.executeQuery(SQL);
				while(DB_Contact.getNextQuery()) 
				{
					String sUKEY					= common.setNullToString(DB_Contact.getColumnString("UKEY")).trim();						
					String sINS_STATUS				= common.setNullToString(DB_Contact.getColumnString("INS_STATUS")).trim(); 
					
					StringTokenizer stSEQNO			= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("SEQNO")).trim(), "^"); 
					StringTokenizer stEMP_NAME		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("EMP_NAME")).trim(), "^"); 
					StringTokenizer stOCCPSEC		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("OCCPSEC")).trim(), "^"); 
					
					StringTokenizer stGENDER		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("GENDER")).trim(), "^"); 
					StringTokenizer stPASSPORT		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("PASSPORT")).trim(), "^"); 
					StringTokenizer stNATIONALITY	= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("NATIONALITY")).trim(), "^"); 
					
					com.rexit.easc.StringTokenizer stCARD			= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("CARD")).trim(), "^","",true); 
					com.rexit.easc.StringTokenizer stEMP_PLACE		= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("EMP_PLACE")).trim(), "^","",true);  
					com.rexit.easc.StringTokenizer stTERM_DATE		= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("TERM_DATE")).trim(), "^","",true);
					com.rexit.easc.StringTokenizer stDOB			= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("DOB")).trim(), "^","",true); 
					com.rexit.easc.StringTokenizer stWORK_EXP		= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("WORK_EXP")).trim(), "^","",true); 
					
					StringTokenizer stSUMINS		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("SUMINS")).trim(), "^"); 
					StringTokenizer stPREMIUM		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("PREMIUM")).trim(), "^");  
					StringTokenizer stSERVICE_FEE	= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("SERVICE_FEE")).trim(), "^"); 
					StringTokenizer stFWCMS_FEE		= new StringTokenizer(common.setNullToString(DB_Contact.getColumnString("FWCMS_FEE")).trim(), "^"); 
					com.rexit.easc.StringTokenizer stINSURED_FOR	= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("INSURED_FOR")).trim(), "^","",true); 
					com.rexit.easc.StringTokenizer stWORK_ID		= new com.rexit.easc.StringTokenizer(common.setNullToString(DB_Contact.getColumnString("WORK_ID")).trim(), "^","",true); 
					
					int k = 1;
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
						String sCARD		= "";
						String sINSURED_FOR	= "";
						String sWORK_ID		= "";
						String sTERM_IND	= "";
						String sTERM_DATE	= "";
						String sTERM_REASON	= "";
						
						try { sSEQNO		= stSEQNO.nextToken(); } catch (Exception exp) { sSEQNO	= ""; } 
						try { sEMP_NAME		= stEMP_NAME.nextToken(); } catch (Exception exp) { sEMP_NAME	= ""; } 
						try { sOCCPSEC		= stOCCPSEC.nextToken(); } catch (Exception exp) { sOCCPSEC	= ""; }  
						try { sDOB			= stDOB.nextToken(); } catch (Exception exp) { sDOB	= ""; } 
						try { sGENDER		= stGENDER.nextToken(); } catch (Exception exp) { sGENDER	= ""; } 
						try { sPASSPORT		= stPASSPORT.nextToken(); } catch (Exception exp) { sPASSPORT	= ""; } 
						try { sNATIONALITY	= stNATIONALITY.nextToken(); } catch (Exception exp) { sNATIONALITY	= ""; } 
						try { sWORK_EXP		= stWORK_EXP.nextToken(); } catch (Exception exp) { sWORK_EXP	= ""; } 
						try { sSUMINS		= common.fnFormatComma(stSUMINS.nextToken()); } catch (Exception exp) { sSUMINS	= "0.00"; } 
						try { sPREMIUM		= common.fnFormatComma(stPREMIUM.nextToken()); } catch (Exception exp) { sPREMIUM	= "0.00"; } 
						try { sSERVICE_FEE	= common.fnFormatComma(stSERVICE_FEE.nextToken()); } catch (Exception exp) { sSERVICE_FEE	= "0.00"; } 
						try { sFWCMS_FEE	= common.fnFormatComma(stFWCMS_FEE.nextToken()); } catch (Exception exp) { sFWCMS_FEE	= "0.00"; }
						try { sCARD			= stCARD.nextToken(); } catch (Exception exp) { sCARD	= ""; }
						try { sINSURED_FOR	= stINSURED_FOR.nextToken(); } catch (Exception exp) { sINSURED_FOR	= ""; } 
						try { sWORK_ID		= stWORK_ID.nextToken(); } catch (Exception exp) { sWORK_ID	= ""; } 
						try { sTERM_DATE	= stTERM_DATE.nextToken(); } catch (Exception exp) { sTERM_DATE	= ""; }
						try { sTERM_REASON	= stEMP_PLACE.nextToken(); } catch (Exception exp) { sTERM_REASON	= ""; }
						try 
						{ 
							if (!sDOB.equals(""))	sDOB	= timestampFormat.format(timestampFormat2.parse(sDOB));
						}
						catch(Exception e) { } 
		
						try 
						{ 
							if (!sWORK_EXP.equals(""))	sWORK_EXP	= timestampFormat.format(timestampFormat2.parse(sWORK_EXP));
						}
						catch(Exception e) { }				
						
						SQL = "SELECT DESCP FROM TB_FWIGPREM WHERE INSCODE = '"+PRINCIPLE+"' AND NATIONALITY = '"+ sNATIONALITY +"' FETCH FIRST 1 ROW ONLY WITH UR";
						DB_Contact2.makeConnection();
						DB_Contact2.executeQuery(SQL);
						if(DB_Contact2.getNextQuery())
						{
							sNATIONALITY = sNATIONALITY + " "+common.setNullToString((String) DB_Contact2.getColumnString("DESCP"));
						}
						DB_Contact2.takeDown();
						
						if(!sTERM_DATE.equals(""))
							sTERM_IND = "Y";
						
						if(!sSERVICE_FEE.equals(HS_FEE)){
							sSERVICE_FEE = HS_FEE;
							sFWCMS_FEE	 = FW_FEE;
						}
						
						vRow	= new Vector(); 
						vRow.addElement(sSEQNO);
				        vRow.addElement(sSEQNO);
				        vRow.addElement(sEMP_NAME);
						vRow.addElement(sOCCPSEC);
						vRow.addElement(sDOB);
						vRow.addElement(sGENDER);
						vRow.addElement(sPASSPORT);
						vRow.addElement(sNATIONALITY);
						vRow.addElement(sWORK_EXP);
						vRow.addElement(sSUMINS);
						vRow.addElement(HS_PREM);
						vRow.addElement(sSERVICE_FEE);
						vRow.addElement(sFWCMS_FEE);
						vRow.addElement(common.fnFormatComma(HS_APREM));
						vRow.addElement("");
						vRow.addElement("0.00");
						vRow.addElement("0.00");
						vRow.addElement("0.00");
						vRow.addElement(sINS_STATUS);
						vRow.addElement(sINSURED_FOR);
						vRow.addElement(sWORK_ID);
						vRow.addElement(sTERM_IND);
						vRow.addElement(sTERM_DATE);
						vRow.addElement(sTERM_REASON);
						vRow.addElement("");
						vRiskItem.addElement(vRow); 	
					}
				}
				DB_Contact.takeDown();
				
				Hashtable hSortedWorker		= new Hashtable();
				Vector vWORK_EXPIRY			= new Vector();

				if(!FWCMSREF.equals("")){
					String sPREM	= "0.00";
					String sFEE		= "0.00";
					SQL 		= "SELECT VALUE1,VALUE2 FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='FWHS' AND CODE='DEFAULT' WITH UR";
					DB_Contact.makeConnection();
					DB_Contact.executeQuery(SQL);
					if(DB_Contact.getNextQuery()) {
				   		sPREM   	= common.fnCutComma(common.setNullToString(DB_Contact.getColumnString("VALUE1")));
				   		sFEE		= common.fnCutComma(common.setNullToString(DB_Contact.getColumnString("VALUE2")));
				    }
				    DB_Contact.takeDown();
					
					//expiry sort
					for(int y = 0; y < vRiskItem.size(); y++) 
		           	{ 
		           		Vector vOriWorker_Temp		= (Vector) vRiskItem.elementAt(y);
		           		String sWORK_EXP			= ((String) vOriWorker_Temp.elementAt(8)).equals("") ? timestampFormat.format(timestampFormat2.parse(EXPDATE)) : (String) vOriWorker_Temp.elementAt(8);
		           		String sNATIONALITY			= (String) vOriWorker_Temp.elementAt(7);
		           		
		           		
		           		
		           		String sWORK_EXP_perc			= sWORK_EXP;
		           		String sWORK_EFF_perc			= "";		
		           		sWORK_EFF_perc					= common.fnGenNextEffDate(sWORK_EXP_perc);
		           		
						if ( Integer.parseInt(today) > Integer.parseInt(timestampFormat2.format(timestampFormat.parse(sWORK_EFF_perc))) ){
							sWORK_EFF_perc = timestampFormat.format(new Date()); 
						}
						
		           		sWORK_EXP_perc					= common.fnGenExpDate(sWORK_EFF_perc); ;
		           		
		           		// --- NEW: Create the Composite Key ---
				        // We'll combine expiry date and nationality with an underscore separator
				        String compositeKey = sWORK_EXP_perc + "_" + sNATIONALITY;
				        
				        // --- Grouping Logic (Single Level) ---
				        // Get or create the Vector of workers for this specific composite key
				        Vector<Vector> vWorkersForCombination = (Vector<Vector>) hSortedWorker.get(compositeKey);
				        if (vWorkersForCombination == null) {
				          	vWorkersForCombination = new Vector();
				            hSortedWorker.put(compositeKey, vWorkersForCombination);
				        }
		           		
		           		Vector vSortedWorkerList	= hSortedWorker.get(compositeKey) == null ? new Vector(): (Vector) hSortedWorker.get(compositeKey);
		           		 			
		           		Period.makeConnection();
						dSRATE	 						=  Period.fnGetPRate2(sWORK_EFF_perc,sWORK_EXP_perc);
						Period.takeDown();
						
						dPREM		= common.formatdouble(sPREM);
						dPREM				= dPREM * dSRATE;
						dFEE			= common.formatdouble(sFEE);
						dFEE				= dFEE * dSRATE;
						
						String sPREM_exp	= common.fnFormatComma(common.fnGetValue2(dPREM));
						String sFEE_exp		= common.fnFormatComma(common.fnGetValue2(dFEE));
						
						Vector vUpdatedWorker_temp	= (Vector) vOriWorker_Temp;
		           		vUpdatedWorker_temp.setElementAt(sPREM_exp, 10);
		           		vUpdatedWorker_temp.setElementAt(sFEE_exp, 11);

		           		if(vSortedWorkerList.size()>0){
		           			vSortedWorkerList.addElement(vUpdatedWorker_temp);
		           			hSortedWorker.put(compositeKey, vSortedWorkerList);
		           		}else if(vSortedWorkerList == null || vSortedWorkerList.size() == 0){
		           			Vector vWORK_EXPIRY_Temp	= new Vector();
		           			vWORK_EXPIRY_Temp.addElement(compositeKey);
		           			vWORK_EXPIRY_Temp.addElement(""); 		// 1 	SUMINS
		           			vWORK_EXPIRY_Temp.addElement("");		// 2 	APREM
		           			vWORK_EXPIRY_Temp.addElement("");		// 3 	GPREM
		           			vWORK_EXPIRY_Temp.addElement("");		// 4 	REBATEAMT
		           			vWORK_EXPIRY_Temp.addElement("");		// 5 	REBATEPCT
		           			vWORK_EXPIRY_Temp.addElement("");		// 6 	STAXAMT
		           			vWORK_EXPIRY_Temp.addElement("");		// 7 	STAXPCT
		           			vWORK_EXPIRY_Temp.addElement("");		// 8 	SERVICE_FEE
		           			vWORK_EXPIRY_Temp.addElement("");		// 9 	FWCMS_FEE
		           			vWORK_EXPIRY_Temp.addElement("");		// 10 	STAMPDUTY
		           			vWORK_EXPIRY_Temp.addElement("");		// 11 	NETTPREM
		           			vWORK_EXPIRY_Temp.addElement("");		// 12 	COMMAMT
		           			vWORK_EXPIRY_Temp.addElement("");		// 13 	COMMPCT
		           			vWORK_EXPIRY_Temp.addElement("");		// 14 	ORCAMT
		           			vWORK_EXPIRY_Temp.addElement("");		// 15 	ORCPCT
		           			vWORK_EXPIRY_Temp.addElement("");		// 16 	TOTPREM
		           			vWORK_EXPIRY_Temp.addElement("");		// 17 	ORG_APREM
		           			vWORK_EXPIRY_Temp.addElement("");		// 18 	LEVYAMT
		           			vWORK_EXPIRY_Temp.addElement("");		// 19 	LEVYPCT
		           			vWORK_EXPIRY_Temp.addElement("");		// 20 	GUARANTEE_CHARGE
		           			vWORK_EXPIRY_Temp.addElement("");		// 21 	TOTEMP
		           			vWORK_EXPIRY_Temp.addElement("");		// 22 	GSTAMT
		           			vWORK_EXPIRY_Temp.addElement("");		// 23 	GSTPCT
		           			vWORK_EXPIRY_Temp.addElement("");		// 24 	GST_COMMAMT
		           			vWORK_EXPIRY_Temp.addElement("");		// 25 	GST_COMMPCT
		           			vWORK_EXPIRY_Temp.addElement("");		// 26 	GST_OTHAMT
		           			vWORK_EXPIRY_Temp.addElement(sWORK_EFF_perc);// 27 	EFFDATE
	
		           			vWORK_EXPIRY.addElement(vWORK_EXPIRY_Temp);
		           			vSortedWorkerList.addElement(vUpdatedWorker_temp);
		           			hSortedWorker.put(compositeKey, vSortedWorkerList);
		           		}
					}
					
					if(hSortedWorker.size()>1){
						ePLKS_MCN 		= "Y";
					}
				}
				if(!FWCMSREF.equals("") && ePLKS_MCN.equals("Y")){
					
					
					if(vRiskItem != null) 
    				{
    					double dSUMINS      = common.formatdouble(common.fnCutComma(HS_SUMINS)); 
				        double dBASICPREM   = common.formatdouble(common.fnCutComma(sBASICPREM)); 
				        double dAPREM       = common.formatdouble(common.fnCutComma(HS_APREM)); 
				        double dDISWAGEPCT  = common.formatdouble(common.fnCutComma(sDISWAGEPCT)); 
				        double dDISWAGEAMT  = common.formatdouble(common.fnCutComma(sDISWAGEAMT)); 
				        double dGPREM       = common.formatdouble(common.fnCutComma(HS_PREM));
				        double dGPREM2      = common.formatdouble(common.fnCutComma(HS_PREM)); 
				        double dREBATEAMT   = common.formatdouble(common.fnCutComma(sREBATEAMT)); 
				        double dREBATEPCT   = common.formatdouble(common.fnCutComma(sREBATEPCT)); 
				        double dSTAXAMT     = common.formatdouble(common.fnCutComma(sSTAXAMT)); 
				        double dSTAXPCT     = common.formatdouble(common.fnCutComma(sSTAXPCT)); 
				        double dLEVYAMT     = 0.0; 
				        
				        double dSERVICE_FEE = common.formatdouble(common.fnCutComma(HS_FEE)); 
				        double dFWCMS_FEE	= common.formatdouble(common.fnCutComma(FW_FEE)); 
				
				        double dSTAMPDUTY   = common.formatdouble(common.fnCutComma(sSTAMPDUTY)); 
				        double dNETTPREM    = common.formatdouble(common.fnCutComma(sNETTPREM));  
				        double dCOMMAMT     = common.formatdouble(common.fnCutComma(sCOMMAMT)); 
				        double dCOMMPCT     = common.formatdouble(common.fnCutComma(sCOMMPCT));
				        double dORCAMT      = common.formatdouble(common.fnCutComma(sORCAMT)); 
				        double dORCPCT      = common.formatdouble(common.fnCutComma(sORCPCT)); 
				        double dTOTPREM     = common.formatdouble(common.fnCutComma(sTOTPREM)); 
				        double dORG_APREM   = common.formatdouble(common.fnCutComma(sORG_APREM));
				        
				        double dGST_PCT     = common.formatdouble(GST_PCT); 
				        double dGST_COMMPCT = common.formatdouble(GST_COMMPCT);
				        double dGST_OTHAMT	 = 0.0;
				        double dGST_FWCMSAMT = 0.0;
			            
			            double dLEVYPCT			= 0;
			            double dGUARANTEE_CHRG	= 0;
			            double dGST_AMT			= 0;
						double dGST_COMMAMT		= 0;
						double dTCPA_STAXPCT    = common.formatdouble(common.fnCutComma(sTCPA_STAXPCT)); 
			            
			            dORG_APREM 		= dAPREM;  // ANNUAL
				        double drebate 	= dGPREM * dREBATEPCT / 100.00;
				        sREBATEAMT  	= common.fnGetValue2(drebate);  
				    	drebate			= Double.parseDouble(sREBATEAMT);
				      	
				    	double dstax	= (dGPREM - drebate) * dSTAXPCT / 100.00;
						sORCAMT     	= common.fnGetValue2(dstax);
						dstax			= Double.parseDouble(sORCAMT);
				    	
						dGST_AMT		= (dGPREM-drebate)*(dGST_PCT/100);
				        sGST_Amt 		= common.fnGetValue2(dGST_AMT);    
				    	dGST_AMT		= Double.parseDouble(sGST_Amt);
				      	
				    	double dstax_TPCA	= (dSERVICE_FEE) * dTCPA_STAXPCT / 100.00;
				    	sLEVYAMT    		= common.fnGetValue2(dstax_TPCA);
				    	dstax_TPCA			= Double.parseDouble(sLEVYAMT);
				        	
				    	double dGST_TPCA	= (dSERVICE_FEE) * dGST_PCT / 100.00;
				    	sGST_OTHAMT   		= common.fnGetValue2(dGST_TPCA); 
				    	dGST_TPCA			= Double.parseDouble(sGST_OTHAMT);
				    	
				    	double dGST_FWCMS	= (dFWCMS_FEE) * dGST_PCT / 100.00;
				    	sGST_FWCMSAMT  		= common.fnGetValue2(dGST_FWCMS); 
				    	dGST_FWCMS			= Double.parseDouble(sGST_FWCMSAMT);
				    		
				    	double dcomm	= (dGPREM - drebate) * dCOMMPCT / 100.00;
						sCOMMAMT     	= common.fnGetValue2(dcomm);
						dcomm			= Double.parseDouble(sCOMMAMT);
				        
						dGST_COMMAMT	= (dGST_COMMPCT*dcomm)/100;
						sGST_CommAmt   	= common.fnGetValue2(dGST_COMMAMT);
						dGST_COMMAMT	= Double.parseDouble(sGST_CommAmt);
				        
				        dREBATEAMT 	= drebate;
				    	dORCAMT		= dstax;
				    	dLEVYAMT	= dstax_TPCA;
				    	dGST_OTHAMT	= dGST_TPCA;
				    	dGST_FWCMSAMT = dGST_FWCMS;
				    	dCOMMAMT	= dcomm;
				        	       	
						dSTAXAMT    = dORCAMT + dLEVYAMT;
				        sSTAXAMT    = common.fnGetValue2(dSTAXAMT);
				        dSTAXAMT	= Double.parseDouble(sSTAXAMT);
				        
				        dNETTPREM   = dGPREM - dREBATEAMT + dSTAXAMT + dSTAMPDUTY + dSERVICE_FEE + dFWCMS_FEE + dGST_AMT + dGST_OTHAMT + dGST_FWCMSAMT; 
				            
				        dTOTPREM    = dNETTPREM - dCOMMAMT - dGST_COMMAMT;
				        
				        sBASICPREM  = common.fnFormatComma(common.fnGetValue2(dBASICPREM)); 
				        sAPREM      = common.fnFormatComma(common.fnGetValue2(dAPREM)); 
				        sDISWAGEPCT = common.formatNumber(dDISWAGEPCT,"##0.00"); 
				        sDISWAGEAMT = common.fnFormatComma(common.fnGetValue2(dDISWAGEAMT)); 
				        sGPREM      = common.fnFormatComma(common.fnGetValue2(dGPREM)); 
				        sSERVICE_FEE= common.fnFormatComma(common.fnGetValue2(dSERVICE_FEE)); 
				        sFWCMS_FEE	= common.fnFormatComma(common.fnGetValue2(dFWCMS_FEE)); 
				        
				        sREBATEPCT  = common.formatNumber(dREBATEPCT,"##0.00");
				        sREBATEAMT  = common.formatNumber(dREBATEAMT,"##0.00");
				        sSTAXPCT    = common.formatNumber(dSTAXPCT,"##0.00"); 
				        sSTAXAMT    = common.formatNumber(dSTAXAMT,"##0.00"); 
				        sSTAMPDUTY  = common.fnFormatComma(common.fnGetValue2(dSTAMPDUTY)); 
				        sNETTPREM   = common.fnFormatComma(common.fnGetValue2(dNETTPREM)); 
				        
				        sCOMMPCT    = common.formatNumber(dCOMMPCT,"##0.00"); 
				        
				        sORCPCT     = common.formatNumber(dORCPCT,"##0.00"); 
				        sORCAMT     = common.formatNumber(dORCAMT,"##0.00"); 
				        sLEVYAMT    = common.formatNumber(dLEVYAMT,"##0.00");
				        sCOMMAMT    = common.formatNumber(dCOMMAMT,"##0.00"); 
				        sTOTPREM    = common.fnFormatComma(common.fnGetValue2(dTOTPREM)); 
				        sORG_APREM  = common.fnFormatComma(common.fnGetValue2(dORG_APREM));
				
						sGST_Amt	= common.fnFormatComma(common.fnGetValue2(dGST_AMT));
						sGST_CommAmt= common.fnFormatComma(common.fnGetValue2(dGST_COMMAMT));
				        sGST_OTHAMT = common.formatNumber(dGST_OTHAMT,"##0.00");
				        sGST_FWCMSAMT = common.formatNumber(dGST_FWCMSAMT,"##0.00");
						
    					try
				    	{
					        DB_Template.makeConnection();
					        DB_Myprofile.makeConnection();
					        DB_Contact.makeConnection();
					        DB_FWHS.makeConnection();
					        DB_FWPOL.makeConnection2();
					        DB_Workmen.makeConnection();
					        
				            String temp_UKEY	= CNCODE;
				            String ORI_CNCODE	= temp_UKEY.substring(2);
				            String temp_CNCODE	= ORI_CNCODE;
				            
				            //cancel existing policy first
				             
				            iRowAffected = DB_FWHS.update_cancel(temp_UKEY, "C", REPLACECN, "SPLIT POLICY", DATE_CREATED, "TB_FWHSCN", "FWHS","");
						    if(iRowAffected == 0) 
						    {
						       throw new NullPointerException("update_cancel");
						    }
						    
						    iRowAffected	= DB_FWHS.update_cancelTrans(temp_UKEY, "C", "SPLIT POLICY");          
						    if(iRowAffected == 0) 
						    {
						       throw new NullPointerException("update_cancelTrans");
						    }
						    
						    iRowAffected 	= DB_Contact.updateTaxInvoice2(temp_CNCODE,PRINCIPLE, "CANCELLED");
							if (iRowAffected == 0)
							{
								throw new NullPointerException("updateTaxInvoice2");
							}
				
						    iRowAffected = DB_FWPOL.update_status_newpol(temp_CNCODE,PRINCIPLE, "CANCELLED","TB_FWHS_NEWPOL");
				            if(iRowAffected == 0) 
				            {
			                    throw new NullPointerException("update_status_newpol"); 
			                }
			                
			               	//generate XML to post to backend, then delete
			                
			                inputXML.makeConnection();
				       		split_cancel_xml = inputXML.genFWHSCNXML(PRINCIPLE,temp_CNCODE,"1");
				            inputXML.takeDown();
				            
							
	    					iRowAffected = DB_FWHS.delete_record("TB_FWHSITEM","UKEY LIKE '"+temp_UKEY+"$%'"); 
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete FWHSITEM");
				            }
							iRowAffected = DB_Workmen.delete_record("TB_FWSEARCH","UKEY2 = '" + temp_UKEY + "'");
							if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete TB_FWSEARCH");
				            }
				            iRowAffected = DB_FWHS.delete_record("TB_FWHSSCH","UKEY2 = '"+temp_UKEY+"'");
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete FWHSSCH");
				            } 
				            
				            iRowAffected = DB_FWHS.delete_record("TB_TRANSACTION","CLASS = '" + CLASS + "' AND IDNO = '" + temp_UKEY + "'");
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete TRANSACTION");
				            }
				            
				           	iRowAffected = DB_FWPOL.delete_record("TB_FWHS_NEWPOL","POLICYNO = '" + temp_CNCODE + "'");
				            if(iRowAffected == 0) {
				               throw new NullPointerException("update: Delete TB_FWHS_NEWPOL");
				            }
				            
				            iRowAffected = DB_FWPOL.delete_record("TB_FWHS_NEWPOL_WORKER","POLICYNO = '" + temp_CNCODE + "'");
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete TB_FWHS_NEWPOL_WORKER");
				            }
							

							if(ePLKS_MCN.equals("Y")){
								String sTERM_IND		= "";
								String sGOT_TERM_IND	= common.setNullToString((String) session.getAttribute("SES_GOT_TERM_IND"));

								// Calculation Param
								double dSST_SRATE 		= 1;
								double dTOTEMP_Temp		= 0.0;  
								//sREBATEPCT				= request.getParameter("REBATEPCT") == null ? "0.00": common.setNullToString(request.getParameter("REBATEPCT")); 
								//dREBATEPCT				= common.formatdouble(common.fnCutComma(sREBATEPCT)); // Rebate is choosen by agent 
								//sSTAXPCT				= request.getParameter("STAXPCT") == null ? "0.00": common.setNullToString(request.getParameter("STAXPCT")); 
								//dSTAXPCT				= common.formatdouble(common.fnCutComma(sSTAXPCT)); 
								
								String GST_TRIGGER_Temp				= "";
								String GST_AGENT_STATUS_Temp		= "";
								String GST_RT_Temp					= "";
								String GST_DATE_Temp				= "";
								String GST_PCT_Temp					= "";
								String GST_COMMPCT_Temp				= "";
				   				String STAMPDUTY_Temp				= "";
				   				
				   				DB_Contact1.makeConnection();
								SQL	= "SELECT STAMP FROM TB_PARAM_GEN WHERE INSCODE = '"+PRINCIPLE+"' WITH UR";
								DB_Contact1.executeQuery(SQL);
								while(DB_Contact1.getNextQuery())
								{
									STAMPDUTY_Temp	= common.setNullToString(DB_Contact1.getColumnString("STAMP"));
								}
								DB_Contact1.takeDown();
				
								
								STAMPDUTY_Temp	= "0.00";
				   				
				   				
				   				SQL	=	"SELECT VALUE1 FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='GST' AND CODE='GST_DATE' WITH UR";
							    DB_Contact1.makeConnection(); 
								DB_Contact1.executeQuery(SQL);
								if(DB_Contact1.getNextQuery())
								{
									GST_DATE_Temp   = common.setNullToString(DB_Contact1.getColumnString("VALUE1"));
								}
								DB_Contact1.takeDown();
								
								if(!GST_DATE_Temp.equals(""))
								{
									if(Integer.parseInt(ISSDATE)>=Integer.parseInt(GST_DATE_Temp))
									{
										GST_TRIGGER_Temp = "Y";
									}
								}
							    
							    if(GST_TRIGGER_Temp.equals("Y"))
								{
								    SQL	= "SELECT * FROM TB_GST WHERE INSCODE='"+PRINCIPLE+"' AND MAINCLS='FWHS' AND EFFDATE<='"+ISSDATE+"' AND EXPDATE>='"+ISSDATE+"' ORDER BY EXPDATE FETCH FIRST 1 ROW ONLY WITH UR";
									DB_Contact1.makeConnection();
									DB_Contact1.executeQuery(SQL);
									if(DB_Contact1.getNextQuery()) 
									{
										GST_PCT_Temp	 	= common.setNullToString(DB_Contact1.getColumnString("GST_PCT"));
										
								    }
								    DB_Contact1.takeDown();
							
								   	if(GST_COMMPCT_Temp.equals("")){
								   		GST_COMMPCT_Temp = "0.00";
								   	}
								   
								   	if(COUNTRY.trim().equals(""))
								   	{
								   		COUNTRY = "MYS";	    	
								   	}
								}
								
								//SST
								String SST_TRIGGER_Temp	= "N";
								String dbSTAXPCT_Temp 	= "";
								String STAXPCT_Temp		= "";
								String STAXPCT_TPCA_Temp= "";
								
								DB_Contact1.makeConnection();
							 	SQL = "SELECT * FROM TB_SST WHERE INSCODE='"+PRINCIPLE+"' AND MAINCLS='FWHS' AND EFFDATE<='"+ISSDATE+"' AND EXPDATE>='"+ISSDATE+"' WITH UR";
								DB_Contact1.executeQuery(SQL);
								if(DB_Contact1.getNextQuery())
								{
							 		dbSTAXPCT_Temp		= DB_Contact1.getColumnString("SST_PCT");
						
						 			STAXPCT_Temp = dbSTAXPCT_Temp;	
						 			SST_TRIGGER_Temp = "Y";
						 			GST_TRIGGER_Temp = "N";
							 	}
							 	DB_Contact1.takeDown(); 
							 	
							 	if(SST_TRIGGER_Temp.equals("Y")){
							 		DB_Contact1.makeConnection();
								 	SQL = "SELECT * FROM TB_SST WHERE INSCODE='"+PRINCIPLE+"' AND MAINCLS='FWHS_TCPA' AND EFFDATE<='"+ISSDATE+"' AND EXPDATE>='"+ISSDATE+"' WITH UR";
									DB_Contact1.executeQuery(SQL);
									if(DB_Contact1.getNextQuery())
									{
								 		STAXPCT_TPCA_Temp		= DB_Contact1.getColumnString("SST_PCT");
								 	}
								 	DB_Contact1.takeDown(); 
							 	}
				   		 				
				   				String SST_EFFDATE_temp = "";
								SQL	=	"SELECT EFFDATE FROM TB_SST WHERE INSCODE='"+PRINCIPLE+"' AND MAINCLS='FWHS' WITH UR";
							    DB_Contact1.makeConnection(); 
								DB_Contact1.executeQuery(SQL);
								if(DB_Contact1.getNextQuery())
								{
									SST_EFFDATE_temp   = common.setNullToString(DB_Contact1.getColumnString("EFFDATE"));
								}
								DB_Contact1.takeDown();
					
								if(!SST_EFFDATE_temp.equals("") && !EFFDATE.equals(""))
								{
									String strEFFDATE 	= timestampFormat2.format(timestampFormat.parse(EFFDATE));
								
									if(Integer.parseInt(SST_EFFDATE_temp) > Integer.parseInt(strEFFDATE))
									{
										SST_EFFDATE_temp = timestampFormat2.format(timestampFormat.parse(SST_EFFDATE_temp));
										Period.makeConnection();
										dSST_SRATE = Period.fnGetPRate2(SST_EFFDATE_temp,EXPDATE);
										Period.takeDown();
										
										if(dSST_SRATE>1) dSST_SRATE = 1;
									}
								}
								// End Calculation Param
								
								SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '"+temp_UKEY+"' WITH UR";
								DB_Contact.executeQuery(SQL);
								if(DB_Contact.getNextQuery())
								{
									 GST_RT 		= common.setNullToString(DB_Contact.getColumnString("GST_RT"));
									 COUNTRY	 	= common.setNullToString(DB_Contact.getColumnString("COUNTRY"));
									/*  GST_TAX_NO 	= common.setNullToString(DB_Contact.getColumnString("GST_TAX_NO"));
									 GST_TAX_NO_END	= common.setNullToString(DB_Contact.getColumnString("GST_TAX_NO_END"));
									 GST_AMT		= common.setNullToString(DB_Contact.getColumnString("GST_AMT"));	
									 GST_COMMAMT	= common.setNullToString(DB_Contact.getColumnString("GST_COMMAMT"));
									 GST_OTHAMT		= common.setNullToString(DB_Contact.getColumnString("GST_OTHAMT"));	 */
								}      		
								
								for(int x = 0; x < vWORK_EXPIRY.size(); x++){
									Vector vWORK_EXPIRY_Temp	= (Vector) vWORK_EXPIRY.elementAt(x);
									String sWORK_EXP			= (String) vWORK_EXPIRY_Temp.elementAt(0);
	
									Vector vSortedWorkerList	= hSortedWorker.get(sWORK_EXP) == null ? new Vector(): (Vector) hSortedWorker.get(sWORK_EXP);

									if(vSortedWorkerList.size() == 0 || vSortedWorkerList == null)
									{
										throw new NullPointerException("08 FWHS Invalid Sorting List");
									}
									
									double dTOT_SUMINS		= 0.00;
									double dTOT_GPREMIUM	= 0.00;
									double dTOT_APREMIUM	= 0.00;
									double dTOT_SERV_FEE	= 0.00;
									double dTOT_FWCMS_FEE	= 0.00;
									String sTOT_SUMINS		= "";	
									String sTOT_GPREMIUM	= "";
									String sTOT_APREMIUM	= "";
									String sTOT_SERV_FEE	= "";
									String sTOT_FWCMS_FEE	= "";
									
									for(int y  =0; y < vSortedWorkerList.size(); y++){
										Vector vSortedWorkerList_Temp	= (Vector) vSortedWorkerList.elementAt(y);
										dTOTEMP_Temp +=1;
										String sEMP_SUMINS				= (String) vSortedWorkerList_Temp.elementAt(9);
										String sEMP_GPREMIUM			= (String) vSortedWorkerList_Temp.elementAt(10);
										String sEMP_APREMIUM			= (String) vSortedWorkerList_Temp.elementAt(13);
										String sEMP_SERV_FEE			= (String) vSortedWorkerList_Temp.elementAt(11);
										String sEMP_FWCMS_FEE			= (String) vSortedWorkerList_Temp.elementAt(12);	
										
										if(sGOT_TERM_IND.equals("Y")){
											sTERM_IND = (String) vSortedWorkerList_Temp.elementAt(24);
										}
										
										if(sTERM_IND.equals("")){
											dTOT_SUMINS  	  = dTOT_SUMINS + Double.parseDouble(common.fnCutComma(sEMP_SUMINS));
											dTOT_GPREMIUM 	  = dTOT_GPREMIUM + Double.parseDouble(common.fnCutComma(sEMP_GPREMIUM));
											dTOT_APREMIUM 	  = dTOT_APREMIUM + Double.parseDouble(common.fnCutComma(sEMP_APREMIUM));
											dTOT_SERV_FEE 	  = dTOT_SERV_FEE + Double.parseDouble(common.fnCutComma(sEMP_SERV_FEE));
											dTOT_FWCMS_FEE 	  = dTOT_FWCMS_FEE + Double.parseDouble(common.fnCutComma(sEMP_FWCMS_FEE));
										}
										
										sTOT_SUMINS		  				= Double.toString(dTOT_SUMINS);
										sTOT_GPREMIUM		  			= Double.toString(dTOT_GPREMIUM);
										sTOT_APREMIUM		  			= Double.toString(dTOT_APREMIUM);
										sTOT_SERV_FEE		  			= Double.toString(dTOT_SERV_FEE);
										sTOT_FWCMS_FEE		  			= Double.toString(dTOT_FWCMS_FEE);
									}
									
									double dGST_PCT_Temp 		= common.formatdouble(GST_PCT_Temp);
									double dSTAXPCT_TPCA_Temp 	= common.formatdouble(STAXPCT_TPCA_Temp);
									double dSTAXPCT_Temp		= common.formatdouble(STAXPCT_Temp);
									double dGST_COMMPCT_Temp	= common.formatdouble(GST_COMMPCT_Temp);
									double dSTAMPDUTY_Temp		= common.formatdouble(STAMPDUTY_Temp);
									
									double dREBATEAMT_Temp  = dTOT_GPREMIUM * dREBATEPCT / 100.00; 
									double dSTAXAMT_Temp    = (dTOT_GPREMIUM - dREBATEAMT_Temp) * dSTAXPCT_Temp / 100.00 * dSST_SRATE; 
									double dGSTAMT_Temp		= (dGPREM - dREBATEAMT)*(dGST_PCT_Temp/100.00);
									double dGST_OTHAMT_Temp	= (dTOT_SERV_FEE)*(dGST_PCT_Temp/100.00);
									double dSST_OTHAMT_Temp	= (dTOT_SERV_FEE)*(dSTAXPCT_TPCA_Temp/100.00) * dSST_SRATE;
									double dGST_FWCMS_Temp	= Double.parseDouble(common.fnGetValue2((dTOT_FWCMS_FEE) * dGST_PCT_Temp / 100.00));
									double dNETTPREM_Temp	= dTOT_GPREMIUM - dREBATEAMT_Temp + dSTAXAMT_Temp + dSTAMPDUTY_Temp + dTOT_SERV_FEE + dTOT_FWCMS_FEE + dGSTAMT_Temp + dGST_OTHAMT_Temp + dGST_FWCMS_Temp + dSST_OTHAMT_Temp; 
									double dCOMMAMT_Temp    = dTOT_GPREMIUM * dCOMMPCT / 100.00; 
						            dCOMMAMT_Temp			= Double.parseDouble(common.fnGetValue2(dCOMMAMT_Temp)); 
						            
						            double dGST_COMMAMT_TEMP= (dGST_COMMPCT_Temp*dCOMMAMT_Temp)/100;
									dGST_COMMAMT_TEMP		= Double.parseDouble(common.fnGetValue2(dGST_COMMAMT_TEMP)); 
						            
						            double dORCAMT_Temp		= (dGPREM - dCOMMAMT) * dORCPCT / 100.00; 
						            double dTOTPREM_Temp	= dNETTPREM_Temp - dCOMMAMT_Temp - dORCAMT_Temp - dGST_COMMAMT_TEMP; 
						            
						            dTOT_SUMINS					= common.formatdouble(common.fnCutComma(common.fnGetValue2(dTOT_SUMINS))); 
						            dTOT_APREMIUM				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dTOT_APREMIUM))); 
						            dTOT_GPREMIUM				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dTOT_GPREMIUM))); 
						            dREBATEAMT_Temp				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dREBATEAMT_Temp))); 
						            dREBATEPCT					= common.formatdouble(common.fnCutComma(common.fnGetValue2(dREBATEPCT))); 
						            dSTAXAMT_Temp				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dSTAXAMT_Temp))); 
						            dSTAXPCT_Temp				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dSTAXPCT_Temp))); 
						            dSST_OTHAMT_Temp			= common.formatdouble(common.fnCutComma(common.fnGetValue2(dSST_OTHAMT_Temp)));
						            dSTAXPCT_TPCA_Temp 			= common.formatdouble(common.fnCutComma(common.fnGetValue2(dSTAXPCT_TPCA_Temp)));
						            dTOT_SERV_FEE				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dTOT_SERV_FEE))); 
						            dSTAMPDUTY_Temp				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dSTAMPDUTY_Temp))); 
						            dNETTPREM_Temp				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dNETTPREM_Temp))); 
						            dCOMMAMT_Temp				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dCOMMAMT_Temp))); 
						            dCOMMPCT					= common.formatdouble(common.fnCutComma(common.fnGetValue2(dCOMMPCT))); 
						            dORCAMT_Temp				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dORCAMT_Temp))); 
						            dORCPCT						= common.formatdouble(common.fnCutComma(common.fnGetValue2(dORCPCT))); 
						            dTOTPREM_Temp				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dTOTPREM_Temp)));
						            dGSTAMT_Temp 				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dGSTAMT_Temp)));
						            dGST_PCT_Temp 				= common.formatdouble(common.fnCutComma(common.fnGetValue2(dGST_PCT_Temp)));
						            dGST_COMMAMT_TEMP 			= common.formatdouble(common.fnCutComma(common.fnGetValue2(dGST_COMMAMT_TEMP)));
						            dGST_COMMPCT_Temp 			= common.formatdouble(common.fnCutComma(common.fnGetValue2(dGST_COMMPCT_Temp)));
						            dGST_OTHAMT_Temp 			= common.formatdouble(common.fnCutComma(common.fnGetValue2(dGST_OTHAMT_Temp)));
						            
									vWORK_EXPIRY_Temp.setElementAt(dTOT_SUMINS, 1); 		// 1	SUMINS
				           			vWORK_EXPIRY_Temp.setElementAt(dTOT_APREMIUM, 2);		// 2 	APREM
				           			vWORK_EXPIRY_Temp.setElementAt(dTOT_GPREMIUM, 3);		// 3 	GPREM
				           			vWORK_EXPIRY_Temp.setElementAt(dREBATEAMT_Temp, 4);		// 4 	REBATEAMT
				           			vWORK_EXPIRY_Temp.setElementAt(dREBATEPCT, 5);			// 5 	REBATEPCT
				           			vWORK_EXPIRY_Temp.setElementAt(dSTAXAMT_Temp, 6);		// 6 	STAXAMT
				           			vWORK_EXPIRY_Temp.setElementAt(dSTAXPCT_Temp, 7);		// 7 	STAXPCT
				           			vWORK_EXPIRY_Temp.setElementAt(dTOT_SERV_FEE, 8);		// 8 	SERVICE_FEE
				           			vWORK_EXPIRY_Temp.setElementAt(dTOT_FWCMS_FEE, 9);		// 9 	FWCMS_FEE
				           			vWORK_EXPIRY_Temp.setElementAt(dSTAMPDUTY_Temp, 10);	// 10 	STAMPDUTY
				           			vWORK_EXPIRY_Temp.setElementAt(dNETTPREM_Temp, 11);		// 11 	NETTPREM
				           			vWORK_EXPIRY_Temp.setElementAt(dCOMMAMT_Temp, 12);		// 12 	COMMAMT
				           			vWORK_EXPIRY_Temp.setElementAt(dCOMMPCT, 13);			// 13 	COMMPCT
				           			vWORK_EXPIRY_Temp.setElementAt(dORCAMT_Temp, 14);		// 14 	ORCAMT
				           			vWORK_EXPIRY_Temp.setElementAt(dORCPCT, 15);			// 15 	ORCPCT
				           			vWORK_EXPIRY_Temp.setElementAt(dTOTPREM_Temp, 16);		// 16 	TOTPREM
				           			vWORK_EXPIRY_Temp.setElementAt(dTOT_APREMIUM, 17);		// 17 	ORG_APREM
				           			vWORK_EXPIRY_Temp.setElementAt(dSST_OTHAMT_Temp, 18);	// 18 	LEVYAMT
				           			vWORK_EXPIRY_Temp.setElementAt(dSTAXPCT_TPCA_Temp, 19);	// 19 	LEVYPCT
				           			vWORK_EXPIRY_Temp.setElementAt(dGUARANTEE_CHRG, 20);	// 20 	GUARANTEE_CHARGE
				           			vWORK_EXPIRY_Temp.setElementAt(dTOTEMP_Temp, 21);		// 21 	TOTEMP
				          			vWORK_EXPIRY_Temp.setElementAt(dGSTAMT_Temp, 22);		// 22 	GSTAMT
				           			vWORK_EXPIRY_Temp.setElementAt(dGST_PCT_Temp, 23);		// 23 	GSTPCT
				           			vWORK_EXPIRY_Temp.setElementAt(dGST_COMMAMT_TEMP, 24);	// 24 	GST_COMMAMT
				           			vWORK_EXPIRY_Temp.setElementAt(dGST_COMMPCT_Temp, 25);	// 25 	GST_COMMPCT
				           			vWORK_EXPIRY_Temp.setElementAt(dGST_OTHAMT_Temp, 26);	// 26 	GST_OTHAMT
								}
							}
							
				            String MASTER_UKEY		= "";
				            //GEN MASTER POLICY HERE

				            if(ePLKS_MCN.equals("Y") && MASTERPOL.equals("")){
								String SES_IG_NO	= common.setNullToString((String) session.getAttribute("SES_IG_NO"));
								//SES_FWCS_NO			= common.setNullToString((String) session.getAttribute("SES_FWCS_NO"));
								//MASTERIND			= common.setNullToString((String) session.getAttribute("SES_MASTERIND")); 
								//MASTERPOL			= common.setNullToString((String) session.getAttribute("SES_MASTERPOL"));
								EMPLOYER_TYPE   	= common.setNullToString((String) session.getAttribute("SES_EMPLOYER_TYPE"));
								//NATURE_BUSINESS		= common.setNullToString((String) session.getAttribute("SES_NATURE_BUSINESS"));
								ORCCODE 			= common.setNullToString((String) session.getAttribute("SES_ORCCODE"));
								
								String MASTER_CNCODE	= "";
								String MAST_STATUS		= "PRINTED";
								
						            
					            MASTER_CNCODE 	= DB_FWHS.getCoverNoteFloat2(PRINCIPLE,ACCODE,MAST_STATUS,"4","FWHS");
								
								if(MASTER_CNCODE.equals("")) {
									throw new NullPointerException("EMPTY_MASTER_CNCODE");
								}			
										
								MASTER_UKEY			= PRINCIPLE + MASTER_CNCODE;
					            String ME_INCHARGE 	= "";
					            //CANCELDATE			= "";
					            
					            
					            String MAST_EFFDATE = EFFDATE;
					            //String EFFDATE_temp	= timestampFormat.format(timestampFormat2.parse(MAST_EFFDATE));
					            
					            String MAST_EXPDATE = common.fnGenExpDate(MAST_EFFDATE);

					            MAST_EFFDATE = timestampFormat2.format(timestampFormat.parse(MAST_EFFDATE));
					            MAST_EXPDATE = timestampFormat2.format(timestampFormat.parse(MAST_EXPDATE));
								
								iRowAffected = DB_Contact.insert_gst_contact(CLIENTID,GST_NO,GST_STATUS,COUNTRY,TOWN);
							
					                   
					            iRowAffected = DB_FWHS.duplicate_FWHSCN2(ORI_CNCODE, MASTER_CNCODE, PRINCIPLE, CNTIME, ISSDATE, "", "", "", ISSDATE,"",MAST_STATUS,CNTYPE,"Y","",MAST_EFFDATE,MAST_EXPDATE);
					           
					            if(iRowAffected == 0) {
									throw new NullPointerException("Insert_FWHSCN_08_MAST");
								}
								
							    String SUBCLS = "";
							    DB_Contact1.makeConnection();
							    SQL = "SELECT VALUE2 FROM TB_CONTROL WHERE INSCODE = '"+PRINCIPLE+"' AND TYPE='FWHS' AND CODE='NEWCLS' AND VALUE1<='"+ISSDATE+"' WITH UR";
							
							    DB_Contact1.executeQuery(SQL);       
							    if(DB_Contact1.getNextQuery())
							    {
							        SUBCLS    = common.setNullToString(DB_Contact1.getColumnString("VALUE2"));
							    }   
							    DB_Contact1.takeDown();
							                      
					               
								String POL_CLAUSE	= DB_Contact.addClauseByCode(PRINCIPLE, CLASS, CLASS);
										
								iRowAffected    = DB_FWHS.Insert_FWHSSCH(MASTER_UKEY, 0.00, 0.00, 0.00, 0.00, 
						            dREBATEPCT, 0.00, dSTAXPCT, 0.00, 0.00, 10.00, 10.00, 0.00, 0.00, 0.00, 0.00, 
						            10.00, 0.00, 0.00, dLEVYPCT,"",dGUARANTEE_CHRG,0.00,SUBCLS,sCFMKT_IND,CFMKT_TIMESTAMP,"","","","",TIN,SST, STAMP_FEES);   
					             
								if(iRowAffected == 0) 
					            {
									throw new NullPointerException("Insert_FWHSSCH_MAST");
					            }
					             
					             
								iRowAffected = DB_FWHS.insert_transaction(CLASS, TRANSTYPE, USERID, DATE_CREATED, CLIENTID, "N", PRINCIPLE, ACCODE, ISSDATE, "", 10.00, MASTER_CNCODE, SESBRCODE_LOGIN, "", BRUSERID, "PRINTED");          
																												
					           	if(iRowAffected == 0) 
					           	{
									throw new NullPointerException("insert_transaction");
					           	}
					                       
					           	String USERTYPE	= common.setNullToString((String) session.getAttribute("SES_USER_TYPE"));
					           	iRowAffected = DB_Contact.insert_transactionlog(PRINCIPLE, MASTER_CNCODE, USERID, USERTYPE, CLASS, TRANSTYPE, "ADD");          
							
					           	if(iRowAffected == 0) 
					           	{
									throw new NullPointerException("insert_transactionlog");
					           	}
							//GST
								TOWN 	  		= common.setNullToString((String) session.getAttribute("SES_TOWN"));
								//COUNTRY 	  	= common.setNullToString((String) session.getAttribute("SES_COUNTRY"));
								GST_STATUS   	= common.setNullToString((String) session.getAttribute("SES_GST_STATUS"));
								GST_NO 	  		= common.setNullToString((String) session.getAttribute("SES_GST_NO"));
					           
								//GST_RT		= common.setNullToString(request.getParameter("GST_RT"));
								GST_PCT		= common.setNullToString(request.getParameter("GST_PCT"));
								GST_AMT		= common.setNullToString(request.getParameter("GST_AMT"));
								GST_OTHAMT	= common.setNullToString(request.getParameter("GST_OTHAMT"));
								String GST_FWCMSAMT	= common.setNullToString(request.getParameter("GST_FWCMSAMT"));
								GST_COMMPCT	= common.setNullToString(request.getParameter("GST_COMMPCT"));
								GST_COMMAMT	= common.setNullToString(request.getParameter("GST_COMMAMT"));		
								
					           	dGST_AMT     	= common.formatdouble(common.fnCutComma(GST_AMT)); 
								dGST_PCT     	= common.formatdouble(common.fnCutComma(GST_PCT)); 
						    	dGST_COMMAMT		= common.formatdouble(common.fnCutComma(GST_COMMAMT));
						    	dGST_COMMPCT	 	= common.formatdouble(common.fnCutComma(GST_COMMPCT)); 
					   			dGST_OTHAMT		= common.formatdouble(common.fnCutComma(GST_OTHAMT));
					   			dGST_FWCMSAMT	= common.formatdouble(common.fnCutComma(GST_FWCMSAMT));
							
								iRowAffected = DB_Contact.insert_GSTCH_HS_08(MASTER_CNCODE, PRINCIPLE, "FWHS", GST_STATUS, GST_NO, TOWN, COUNTRY, dGST_AMT, dGST_PCT, dGST_COMMAMT, dGST_COMMPCT, dGST_OTHAMT, dGST_FWCMSAMT, GST_RT, "-", 0.00);
								
					           	if(iRowAffected == 0){
								throw new NullPointerException("insert_GSTCH_08");
					           	}
								
								MASTERPOL	= MASTER_CNCODE;
								
						        
						        /* if(!MASTER_CNCODE.equals("")){
						        	SimpleDateFormat timestampFormat4 	= new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
						        	String print_time    				= timestampFormat4.format(new Date());
						        	try{
						        		DB_Template.makeConnection();
						        		DB_Template.setAutoCommitOff();
							        	String GST_TAX_NO    	= DB_Template.getRunno_fw("TAX_INVOICE_FW",PRINCIPLE,ACCODE);
						               	iRowAffected 			= DB_Template.updateTaxInvoice(MASTER_CNCODE,GST_TAX_NO,PRINCIPLE, print_time, "PRINTED");
										if (iRowAffected == 0)
										{
											throw new NullPointerException("taxinvoice");
										}
									}
									catch(Exception e)
									{
										e.printStackTrace();
										DB_Template.rollBack();
										exception	= true;
									}
									finally
									{
										DB_Template.setAutoCommitOn();
										DB_Template.conCommit();
										DB_Template.takeDown(); 
									}
						        
						        
						        } */
						        
							}

				            for(int i = 0; i < vWORK_EXPIRY.size(); i++){
								Vector vWORK_EXPIRY_Temp	= (Vector) vWORK_EXPIRY.elementAt(i);
								String WORK_EXP		= (String)vWORK_EXPIRY_Temp.elementAt(0);
								EXPDATE				= timestampFormat2.format(timestampFormat.parse(WORK_EXP));	
								dSUMINS				= (Double)vWORK_EXPIRY_Temp.elementAt(1);
								dAPREM				= (Double)vWORK_EXPIRY_Temp.elementAt(2);
								dGPREM				= (Double)vWORK_EXPIRY_Temp.elementAt(3);
								dREBATEAMT			= (Double)vWORK_EXPIRY_Temp.elementAt(4);
								dREBATEPCT			= (Double)vWORK_EXPIRY_Temp.elementAt(5);
								dSTAXAMT			= (Double)vWORK_EXPIRY_Temp.elementAt(6);
								dSTAXPCT			= (Double)vWORK_EXPIRY_Temp.elementAt(7);
								dSERVICE_FEE		= (Double)vWORK_EXPIRY_Temp.elementAt(8);
								dFWCMS_FEE			= (Double)vWORK_EXPIRY_Temp.elementAt(9);
								dSTAMPDUTY			= (Double)vWORK_EXPIRY_Temp.elementAt(10);
								dNETTPREM			= (Double)vWORK_EXPIRY_Temp.elementAt(11);
								dCOMMAMT			= (Double)vWORK_EXPIRY_Temp.elementAt(12);
								dCOMMPCT			= (Double)vWORK_EXPIRY_Temp.elementAt(13);
								dORCAMT				= (Double)vWORK_EXPIRY_Temp.elementAt(14);
								dORCPCT				= (Double)vWORK_EXPIRY_Temp.elementAt(15);
								dTOTPREM			= (Double)vWORK_EXPIRY_Temp.elementAt(16);
								dORG_APREM			= (Double)vWORK_EXPIRY_Temp.elementAt(17);
								dLEVYAMT			= (Double)vWORK_EXPIRY_Temp.elementAt(18);
								dLEVYPCT			= (Double)vWORK_EXPIRY_Temp.elementAt(19);
								dGUARANTEE_CHRG		= (Double)vWORK_EXPIRY_Temp.elementAt(20);
								double dTOTEMP		= (Double)vWORK_EXPIRY_Temp.elementAt(21);
								dGST_AMT			= (Double)vWORK_EXPIRY_Temp.elementAt(22);
								dGST_PCT			= (Double)vWORK_EXPIRY_Temp.elementAt(23);
								dGST_COMMAMT		= (Double)vWORK_EXPIRY_Temp.elementAt(24);
								dGST_COMMPCT		= (Double)vWORK_EXPIRY_Temp.elementAt(25);
								dGST_OTHAMT	= (Double)vWORK_EXPIRY_Temp.elementAt(26);
								EFFDATE				= (String)vWORK_EXPIRY_Temp.elementAt(27);
								EFFDATE				= timestampFormat2.format(timestampFormat.parse(EFFDATE));	

								temp_CNCODE 	= DB_FWHS.getCoverNoteFloat2(PRINCIPLE,ACCODE,"SAVE","4","FWHS");
				                temp_UKEY    	= PRINCIPLE + temp_CNCODE;
				                
	
				                if(temp_CNCODE.equals("")) {
									DB_Template.takeDown();
									DB_Myprofile.takeDown();
									DB_Contact.takeDown();
									DB_FWHS.takeDown();
									DB_FWPOL.takeDown();
					                response.sendRedirect("pop_cnFWHS_add_1.jsp?RESULT=F2");
					            }

					            iRowAffected = DB_FWHS.duplicate_FWHSCN2(ORI_CNCODE, temp_CNCODE, PRINCIPLE, CNTIME, ISSDATE, "", "", "", ISSDATE,"",STATUS,CNTYPE,"",MASTERPOL,EFFDATE,EXPDATE);
								if(iRowAffected == 0) 
							    {
							       throw new NullPointerException("duplicate_FWHSCN");
							    }
								 

							    iRowAffected = DB_FWHS.insert_transaction(CLASS, TRANSTYPE, SESUSERID, DATE_CREATED, CLIENTID, "N", PRINCIPLE, ACCODE, ISSDATE, "", dTOTPREM, temp_CNCODE, SESBRCODE_LOGIN, "", BRUSERID, STATUS);          
																								
					            if(iRowAffected == 0) 
					            {
					                throw new NullPointerException("insert_transaction");
					            }
					        	
								String POL_CLAUSE		= DB_Contact.addClauseByCode(PRINCIPLE, CLASS, CLASS); 
								
								Vector vSortedWorkerList	= hSortedWorker.get(WORK_EXP) == null ? new Vector(): (Vector) hSortedWorker.get(WORK_EXP);
								
								if(vSortedWorkerList.size() == 0 || vSortedWorkerList == null)
								{
									throw new NullPointerException("08 FWHS Invalid Sorting List");
								} 
					            
					            double dTOTEMP_Temp = 0.00;
					            dTOTEMP_Temp = (double) vSortedWorkerList.size();
					              
					            iRowAffected    = DB_FWHS.Insert_FWHSSCH(temp_UKEY, dSUMINS, dAPREM, dGPREM, dREBATEAMT, 
				                dREBATEPCT, dSTAXAMT, dSTAXPCT, dSERVICE_FEE, dFWCMS_FEE, dSTAMPDUTY, dNETTPREM, dCOMMAMT, dCOMMPCT, dSTAXAMT, dORCPCT, 
				                dTOTPREM, dORG_APREM, dLEVYAMT, dTCPA_STAXPCT,sFWCS_IND,dGUARANTEE_CHRG ,dTOTEMP_Temp,sSUBCLS,sCFMKT_IND,CFMKT_TIMESTAMP,FWCMSREF,"","",POL_CLAUSE,TIN,SST, STAMP_FEES);    
					            
								if (dSTAXPCT > 0 && dSTAXAMT == 0)
									iRowAffected = 0;
					                	 
								if (dTCPA_STAXPCT > 0 && dLEVYAMT == 0)
									iRowAffected = 0;           	 

								if(iRowAffected == 0){
									throw new NullPointerException("Insert_FWHSSCH");
								}
				                
				                //GST
								iRowAffected = DB_Contact.insert_GSTCH_HS_08(temp_CNCODE, PRINCIPLE, "FWHS", GST_STATUS_IND, GST_NO, TOWN, COUNTRY, dGST_AMT, dGST_PCT, dGST_COMMAMT, dGST_COMMPCT, dGST_OTHAMT, dGST_FWCMSAMT, GST_RT, "-", 0.00);
								if(iRowAffected == 0){
									throw new NullPointerException("insert_GSTCH_HS_08");
								}
								
								
								

								
								double d_tempSUMINS     	= 0.00; 
							    double d_tempGPREM     		= 0.00;  
							    double d_tempSERVICE_FEE    = 0.00; 
							    double d_tempSTAXAMT      	= 0.00; 
							    double d_tempLEVYAMT      	= 0.00; 
							    double d_tempREBATEAMT      = 0.00;  

								for(int j  =0; j < vSortedWorkerList.size(); j++){
									Vector vSortedWorkerList_Temp	= (Vector) vSortedWorkerList.elementAt(j);
									//dTOTEMP_Temp +=1;
									String sEMP_SUMINS				= (String) vSortedWorkerList_Temp.elementAt(9);
	    					
			    					Vector vTempVector	= new Vector();
			    					Vector vTradeSub	= (Vector) vRiskItem.elementAt(i); 
			    					String sUKEY	    = temp_UKEY+"$1";
			    					String sCNCODE	    = temp_CNCODE+"$1";
			    					
		                            String sSEQNO2		= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(0));
		                            String sEMP_NAME2	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(2));
		                            String sOCCPSEC2	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(3));
		                            String sCARD2		= "Y";
		                            String sDOB2_TEMP	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(4));
		                                        
		                            if(!sDOB2_TEMP.equals(""))  sDOB2_TEMP  = timestampFormat2.format(timestampFormat.parse(sDOB2_TEMP));   
		                
		                            String sDOB2		= sDOB2_TEMP;
		                            String sGENDER2		= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(5));
		                            String sPASSPORT2	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(6));
		                            String sNATIONALITY2= common.getKey(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(7))," ");
		                            
		                            String sWORK_TEMP	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(8));
		                            
		                            if(!sWORK_TEMP.equals(""))  sWORK_TEMP  = timestampFormat2.format(timestampFormat.parse(sWORK_TEMP));   
		                
		                            String sWORK_EXP2	= sWORK_TEMP;
		                
		                            String sSUMINS2		= common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(9)));
		                            String sPREMIUM2	= common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(10)));
		                            String sSERVICE_FEE2= common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(11)));
		                            String sFWCMS_FEE2	= common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(12)));
		                            double dAPREM2		= common.formatdouble(common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(13))));
		                            double dORG_GPREM2	= common.formatdouble(common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(10))));
		                            
		                            String sREBATEAMT2	= common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(15)));
		                            String sSTAXAMT2	= common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(16)));
		                            String sSTAXAMT_TPCA2= common.fnCutComma(common.setNullToString((String) vSortedWorkerList_Temp.elementAt(17)));
		                            String sINS_STATUS	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(18));
		                            String sINSURED_FOR	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(19));
		                            String sWORK_ID		= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(20));
		                            String sTERM_IND2	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(21));
		                            String sTERM_DATE2	= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(22));
		                            
		                            String sEMP_PLACE2		= common.setNullToString((String) vSortedWorkerList_Temp.elementAt(23));
		                            double dORG_APREM2 = dAPREM2;  // ANNUAL
		                            
		                            d_tempSUMINS     	+= common.formatdouble(common.fnCutComma(sSUMINS2)); 
								    d_tempGPREM     	+= common.formatdouble(common.fnCutComma(sPREMIUM2)); 
								    d_tempSERVICE_FEE   += common.formatdouble(common.fnCutComma(sSERVICE_FEE2)); 
								    d_tempSTAXAMT      	+= common.formatdouble(common.fnCutComma(tempSTAXAMT)); 
								    d_tempLEVYAMT      	+= common.formatdouble(common.fnCutComma(tempLEVYAMT)); 
								    d_tempREBATEAMT     += common.formatdouble(common.fnCutComma(tempREBATEAMT)); 
		                            
		                            if(sINSURED_FOR.equals(""))
			                        {
			                        	sINSURED_FOR 	= "C";
			                        	sWORK_EXP2		= "";
			                        }
			                        
			    					//String SUBKEY = sUKEY + "$1";
			    					
			    					String SUBKEY = sUKEY + "$"+Integer.toString(j+1); 
		                           	vTempVector.addElement(SUBKEY);
		                           	vTempVector.addElement(Integer.toString(j+1));
		                           	vTempVector.addElement(sEMP_NAME2);
		                           	vTempVector.addElement(sOCCPSEC2);
		                           	vTempVector.addElement(sCARD2);
		                           	vTempVector.addElement(sEMP_PLACE2);
		                           	vTempVector.addElement(sTERM_DATE2);
		                           	vTempVector.addElement(sDOB2);
		                           	vTempVector.addElement(sGENDER2);
		                           	vTempVector.addElement(sPASSPORT2);
		                           	vTempVector.addElement(sNATIONALITY2);
		                           	vTempVector.addElement(sWORK_EXP2);
		                           	vTempVector.addElement(sSUMINS2);
		                           	vTempVector.addElement(sPREMIUM2);
		                           	vTempVector.addElement(sSERVICE_FEE2);
		                           	vTempVector.addElement(sFWCMS_FEE2);
		                           	vTempVector.addElement(Double.toString(dAPREM2));                           	
		                           	vTempVector.addElement(Double.toString(dORG_APREM2));
		                           	vTempVector.addElement(Double.toString(dORG_GPREM2));
		                           	vTempVector.addElement(sREBATEAMT2);
		                           	vTempVector.addElement(sSTAXAMT2);
		                           	vTempVector.addElement(sSTAXAMT_TPCA2);
		                           	vTempVector.addElement(sINS_STATUS);
		                        	vTempVector.addElement(sINSURED_FOR);
		                        	vTempVector.addElement(sWORK_ID);
			                        vFWHSSUB.addElement(vTempVector);
			    					
			    					if(vFWHSSUB.size() > 0) {
					               			iRowAffected = DB_FWHS.Insert_FWHSITEM(vFWHSSUB);
				
					                    if(iRowAffected == 0) {
					                        throw new NullPointerException("Insert_FWHSITEM");
			                        	}                
			                    	}
			                    	
									
			                    	Vector vEmployeeVector1 = new Vector(); 
						            Vector vTempVector1	   = new Vector();		                           	
						           	vTempVector1.addElement("FWHS");
						           	vTempVector1.addElement(sUKEY);
						           	vTempVector1.addElement(sUKEY+"$"+(j+1));
						           	vTempVector1.addElement(sEMP_NAME2);
						           	vTempVector1.addElement(sPASSPORT2);
						           	vTempVector1.addElement(sNATIONALITY2);
						           	vEmployeeVector1.addElement(vTempVector1);
							        
						           	if(vEmployeeVector1.size() > 0) {
							       		iRowAffected = DB_Workmen.Insert_FWSEARCHinBatch(vEmployeeVector1);
							            if(iRowAffected == 0) {
							                throw new NullPointerException("Insert_FWSEARCH");
							            }      
							       	} 
					               	vFWHSSUB = new Vector(); 
					               	
			    					
			    					String sTPCAFEES   = String.valueOf(common.formatdouble(common.fnCutComma(sSERVICE_FEE2)) + common.formatdouble(common.fnCutComma(sFWCMS_FEE2)));
	
			    					Vector vFWHSSUB_1	 = new Vector();
			                        Vector vTempVector_1 = new Vector();
			                        vTempVector_1.addElement(PRINCIPLE);
									vTempVector_1.addElement(temp_CNCODE); 
			                       	vTempVector_1.addElement(temp_CNCODE+"$"+(j+1));
			                       	vTempVector_1.addElement(sNATIONALITY2);
			                       	vTempVector_1.addElement(sPASSPORT2);
			                       	vTempVector_1.addElement(sOCCPSEC2);
			                       	vTempVector_1.addElement(sEMP_NAME2);
			                       	vTempVector_1.addElement(sGENDER2);
			                       	vTempVector_1.addElement(sDOB2);
			                       	vTempVector_1.addElement(sSUMINS2);
			                       	vTempVector_1.addElement(sPREMIUM2);
			                       	vTempVector_1.addElement(sTPCAFEES);
			                       	vTempVector_1.addElement(sINS_STATUS);
			                       	vTempVector_1.addElement(sINSURED_FOR);
			                       	vTempVector_1.addElement(sWORK_ID);
			                       	vTempVector_1.addElement(sWORK_EXP2);
			                     	vFWHSSUB_1.addElement(vTempVector_1);
			                     	
				                    if(vFWHSSUB_1.size() > 0) {
					               		iRowAffected = DB_FWPOL.Insert_FWHSNEWPOLWORKER(vFWHSSUB_1);
				
					                    if(iRowAffected == 0) {
					                        throw new NullPointerException("Insert_FWHSNEWPOLWORKER");
			                        	}                
			                    	}
		                    	
		                    	}
		                    	
							    
							    
							    String EMPLOYRCD ="";
				
								if(CONTACT_TYPE.equals("I"))
									EMPLOYRCD	= NEW_IC_NO;
								else if(CONTACT_TYPE.equals("B"))
									EMPLOYRCD	= BUSINESS_NO;
								else if(CONTACT_TYPE.equals("O"))
									EMPLOYRCD	= OLD_IC_NO;
		    					
								iRowAffected = DB_FWPOL.Insert_FWHSNEWPOL(PRINCIPLE,"KUR","FWM",temp_CNCODE,temp_CNCODE,ISSDATE,EFFDATE,EXPDATE,CONTACT_TYPE,
				             				EMPLOYRCD,NAME,ADDRESS_1,ADDRESS_2,ADDRESS_3,ADDRESS_4,sPOSTDESCP,sPOSTCODE,STATECD,NATURE_BUSINESS,
				             				ACCODE,TEL_NO_OFFICE,TEL_NO_HOME,MOBILE_NO,EMAIL,d_tempSUMINS,dTOTEMP_Temp,d_tempGPREM,d_tempSERVICE_FEE,d_tempSTAXAMT,d_tempLEVYAMT,
				             				d_tempREBATEAMT, "","","",null,STATUS,today,SOURCE);

								if(iRowAffected == 0) {
									throw new NullPointerException("Insert_FWHSNEWPOL");
								}

							  
								vCNCODE.addElement(temp_CNCODE);
							}

							iRowAffected = DB_FWHS.delete_record("TB_FWHSCN","UKEY LIKE '"+CNCODE+"%'"); 
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete FWHSITEM");
				            }

						}catch (Exception ex)
					    {
					    	DB_Myprofile.rollBack();
					        DB_Template.rollBack();
					        DB_Contact.rollBack();
					        DB_FWHS.rollBack();
					        DB_FWPOL.rollBack();
					        DB_Workmen.rollBack();
					        error = true;
					        ex.printStackTrace();
					    }
					    finally
					    {
					        DB_Myprofile.conCommit();
					        DB_Myprofile.setAutoCommitOn();
					        DB_Myprofile.takeDown(); //close connection
					        DB_Template.conCommit();
					        DB_Template.setAutoCommitOn();
					        DB_Template.takeDown();
					        DB_Contact.conCommit();
					        DB_Contact.setAutoCommitOn();
					        DB_Contact.takeDown();
					        DB_FWHS.conCommit();
					        DB_FWHS.setAutoCommitOn();
					        DB_FWHS.takeDown();
					        DB_FWPOL.conCommit();
					        DB_FWPOL.setAutoCommitOn();
					        DB_FWPOL.takeDown();
					        DB_Workmen.conCommit();
					        DB_Workmen.setAutoCommitOn();
					        DB_Workmen.takeDown();
					    }
					}
				
				}else if(genMCN.equals("Y"))
				{
					
					if(vRiskItem != null) 
    				{
    					double dSUMINS      = common.formatdouble(common.fnCutComma(HS_SUMINS)); 
				        double dBASICPREM   = common.formatdouble(common.fnCutComma(sBASICPREM)); 
				        double dAPREM       = common.formatdouble(common.fnCutComma(HS_APREM)); 
				        double dDISWAGEPCT  = common.formatdouble(common.fnCutComma(sDISWAGEPCT)); 
				        double dDISWAGEAMT  = common.formatdouble(common.fnCutComma(sDISWAGEAMT)); 
				        double dGPREM       = common.formatdouble(common.fnCutComma(HS_PREM));
				        double dGPREM2      = common.formatdouble(common.fnCutComma(HS_PREM)); 
				        double dREBATEAMT   = common.formatdouble(common.fnCutComma(sREBATEAMT)); 
				        double dREBATEPCT   = common.formatdouble(common.fnCutComma(sREBATEPCT)); 
				        double dSTAXAMT     = common.formatdouble(common.fnCutComma(sSTAXAMT)); 
				        double dSTAXPCT     = common.formatdouble(common.fnCutComma(sSTAXPCT)); 
				        double dLEVYAMT     = 0.0; 
				        
				        double dSERVICE_FEE = common.formatdouble(common.fnCutComma(HS_FEE)); 
				        double dFWCMS_FEE	= common.formatdouble(common.fnCutComma(FW_FEE)); 
				
				        double dSTAMPDUTY   = common.formatdouble(common.fnCutComma(sSTAMPDUTY)); 
				        double dNETTPREM    = common.formatdouble(common.fnCutComma(sNETTPREM));  
				        double dCOMMAMT     = common.formatdouble(common.fnCutComma(sCOMMAMT)); 
				        double dCOMMPCT     = common.formatdouble(common.fnCutComma(sCOMMPCT));
				        double dORCAMT      = common.formatdouble(common.fnCutComma(sORCAMT)); 
				        double dORCPCT      = common.formatdouble(common.fnCutComma(sORCPCT)); 
				        double dTOTPREM     = common.formatdouble(common.fnCutComma(sTOTPREM)); 
				        double dORG_APREM   = common.formatdouble(common.fnCutComma(sORG_APREM));
				        
				        double dGST_PCT     = common.formatdouble(GST_PCT); 
				        double dGST_COMMPCT = common.formatdouble(GST_COMMPCT);
				        double dGST_OTHAMT	 = 0.0;
				        double dGST_FWCMSAMT = 0.0;
			            
			            double dLEVYPCT			= 0;
			            double dGUARANTEE_CHRG	= 0;
			            double dGST_AMT			= 0;
						double dGST_COMMAMT		= 0;
						double dTCPA_STAXPCT    = common.formatdouble(common.fnCutComma(sTCPA_STAXPCT)); 
			            
			            dORG_APREM 		= dAPREM;  // ANNUAL
				        double drebate 	= dGPREM * dREBATEPCT / 100.00;
				        sREBATEAMT  	= common.fnGetValue2(drebate);  
				    	drebate			= Double.parseDouble(sREBATEAMT);
				      	
				    	double dstax	= (dGPREM - drebate) * dSTAXPCT / 100.00;
						sORCAMT     	= common.fnGetValue2(dstax);
						dstax			= Double.parseDouble(sORCAMT);
				    	
						dGST_AMT		= (dGPREM-drebate)*(dGST_PCT/100);
				        sGST_Amt 		= common.fnGetValue2(dGST_AMT);    
				    	dGST_AMT		= Double.parseDouble(sGST_Amt);
				      	
				    	double dstax_TPCA	= (dSERVICE_FEE) * dTCPA_STAXPCT / 100.00;
				    	sLEVYAMT    		= common.fnGetValue2(dstax_TPCA);
				    	dstax_TPCA			= Double.parseDouble(sLEVYAMT);
				        	
				    	double dGST_TPCA	= (dSERVICE_FEE) * dGST_PCT / 100.00;
				    	sGST_OTHAMT   		= common.fnGetValue2(dGST_TPCA); 
				    	dGST_TPCA			= Double.parseDouble(sGST_OTHAMT);
				    	
				    	double dGST_FWCMS	= (dFWCMS_FEE) * dGST_PCT / 100.00;
				    	sGST_FWCMSAMT  		= common.fnGetValue2(dGST_FWCMS); 
				    	dGST_FWCMS			= Double.parseDouble(sGST_FWCMSAMT);
				    		
				    	double dcomm	= (dGPREM - drebate) * dCOMMPCT / 100.00;
						sCOMMAMT     	= common.fnGetValue2(dcomm);
						dcomm			= Double.parseDouble(sCOMMAMT);
				        
						dGST_COMMAMT	= (dGST_COMMPCT*dcomm)/100;
						sGST_CommAmt   	= common.fnGetValue2(dGST_COMMAMT);
						dGST_COMMAMT	= Double.parseDouble(sGST_CommAmt);
				        
				        dREBATEAMT 	= drebate;
				    	dORCAMT		= dstax;
				    	dLEVYAMT	= dstax_TPCA;
				    	dGST_OTHAMT	= dGST_TPCA;
				    	dGST_FWCMSAMT = dGST_FWCMS;
				    	dCOMMAMT	= dcomm;
				        	       	
						dSTAXAMT    = dORCAMT + dLEVYAMT;
				        sSTAXAMT    = common.fnGetValue2(dSTAXAMT);
				        dSTAXAMT	= Double.parseDouble(sSTAXAMT);
				        
				        dNETTPREM   = dGPREM - dREBATEAMT + dSTAXAMT + dSTAMPDUTY + dSERVICE_FEE + dFWCMS_FEE + dGST_AMT + dGST_OTHAMT + dGST_FWCMSAMT; 
				            
				        dTOTPREM    = dNETTPREM - dCOMMAMT - dGST_COMMAMT;
				        
				        sBASICPREM  = common.fnFormatComma(common.fnGetValue2(dBASICPREM)); 
				        sAPREM      = common.fnFormatComma(common.fnGetValue2(dAPREM)); 
				        sDISWAGEPCT = common.formatNumber(dDISWAGEPCT,"##0.00"); 
				        sDISWAGEAMT = common.fnFormatComma(common.fnGetValue2(dDISWAGEAMT)); 
				        sGPREM      = common.fnFormatComma(common.fnGetValue2(dGPREM)); 
				        sSERVICE_FEE= common.fnFormatComma(common.fnGetValue2(dSERVICE_FEE)); 
				        sFWCMS_FEE	= common.fnFormatComma(common.fnGetValue2(dFWCMS_FEE)); 
				        
				        sREBATEPCT  = common.formatNumber(dREBATEPCT,"##0.00");
				        sREBATEAMT  = common.formatNumber(dREBATEAMT,"##0.00");
				        sSTAXPCT    = common.formatNumber(dSTAXPCT,"##0.00"); 
				        sSTAXAMT    = common.formatNumber(dSTAXAMT,"##0.00"); 
				        sSTAMPDUTY  = common.fnFormatComma(common.fnGetValue2(dSTAMPDUTY)); 
				        sNETTPREM   = common.fnFormatComma(common.fnGetValue2(dNETTPREM)); 
				        
				        sCOMMPCT    = common.formatNumber(dCOMMPCT,"##0.00"); 
				        
				        sORCPCT     = common.formatNumber(dORCPCT,"##0.00"); 
				        sORCAMT     = common.formatNumber(dORCAMT,"##0.00"); 
				        sLEVYAMT    = common.formatNumber(dLEVYAMT,"##0.00");
				        sCOMMAMT    = common.formatNumber(dCOMMAMT,"##0.00"); 
				        sTOTPREM    = common.fnFormatComma(common.fnGetValue2(dTOTPREM)); 
				        sORG_APREM  = common.fnFormatComma(common.fnGetValue2(dORG_APREM));
				
						sGST_Amt	= common.fnFormatComma(common.fnGetValue2(dGST_AMT));
						sGST_CommAmt= common.fnFormatComma(common.fnGetValue2(dGST_COMMAMT));
				        sGST_OTHAMT = common.formatNumber(dGST_OTHAMT,"##0.00");
				        sGST_FWCMSAMT = common.formatNumber(dGST_FWCMSAMT,"##0.00");
						
    					try
				    	{
					        DB_Template.makeConnection();
					        DB_Myprofile.makeConnection();
					        DB_Contact.makeConnection();
					        DB_FWHS.makeConnection();
					        DB_FWPOL.makeConnection2();
					        DB_Workmen.makeConnection();
					        
				            String temp_UKEY	= CNCODE;
				            String ORI_CNCODE	= temp_UKEY.substring(2);
				            String temp_CNCODE	= ORI_CNCODE;
				                       
							
	    					iRowAffected = DB_FWHS.delete_record("TB_FWHSITEM","UKEY LIKE '"+temp_UKEY+"$%'"); 
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete FWHSITEM");
				            }
							iRowAffected = DB_Workmen.delete_record("TB_FWSEARCH","UKEY2 = '" + temp_UKEY + "'");
							if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete TB_FWSEARCH");
				            }
				            iRowAffected = DB_FWHS.delete_record("TB_FWHSSCH","UKEY2 = '"+temp_UKEY+"'");
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete FWHSSCH");
				            } 
				            
				            iRowAffected = DB_FWHS.delete_record("TB_TRANSACTION","CLASS = '" + CLASS + "' AND IDNO = '" + temp_UKEY + "'");
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete TRANSACTION");
				            }
				            
				           iRowAffected = DB_FWPOL.delete_record("TB_FWHS_NEWPOL","POLICYNO = '" + temp_CNCODE + "'");
				            if(iRowAffected == 0) {
				               throw new NullPointerException("update: Delete TB_FWHS_NEWPOL");
				            }
				            
				            iRowAffected = DB_FWPOL.delete_record("TB_FWHS_NEWPOL_WORKER","POLICYNO = '" + temp_CNCODE + "'");
				            if(iRowAffected == 0) {
				                throw new NullPointerException("update: Delete TB_FWHS_NEWPOL_WORKER");
				            }
				            
				            
				            for(int i = 0; i < vRiskItem.size(); i++) 
							{	
								if(i != 0)
								{
									temp_CNCODE 	= DB_FWHS.getCoverNoteFloat2(PRINCIPLE,ACCODE,"SAVE","4","FWHS");
					                temp_UKEY    	= PRINCIPLE + temp_CNCODE;
					                if(temp_CNCODE.equals("")) {
										DB_Template.takeDown();
										DB_Myprofile.takeDown();
										DB_Contact.takeDown();
										DB_FWHS.takeDown();
										DB_FWPOL.takeDown();
						                response.sendRedirect("pop_cnFWHS_add_1.jsp?RESULT=F2");
						            }
						            
						            
						            iRowAffected = DB_FWHS.duplicate_FWHSCN(ORI_CNCODE, temp_CNCODE, PRINCIPLE, CNTIME, ISSDATE, "", "", "", ISSDATE,"",STATUS,CNTYPE);
									if(iRowAffected == 0) 
								    {
								       throw new NullPointerException("duplicate_FWHSCN");
								    }
								}
							    
							    iRowAffected = DB_FWHS.insert_transaction(CLASS, TRANSTYPE, SESUSERID, DATE_CREATED, CLIENTID, "N", PRINCIPLE, ACCODE, ISSDATE, "", dTOTPREM, temp_CNCODE, SESBRCODE_LOGIN, "", BRUSERID, STATUS);          
																								
					            if(iRowAffected == 0) 
					            {
					                throw new NullPointerException("insert_transaction");
					            }
					        	
								String POL_CLAUSE		= DB_Contact.addClauseByCode(PRINCIPLE, CLASS, CLASS);  
					            
					            iRowAffected    = DB_FWHS.Insert_FWHSSCH(temp_UKEY, dSUMINS, dAPREM, dGPREM, dREBATEAMT, 
				                dREBATEPCT, dORCAMT, dSTAXPCT, dSERVICE_FEE, dFWCMS_FEE, dSTAMPDUTY, dNETTPREM, dCOMMAMT, dCOMMPCT, dORCAMT, dORCPCT, 
				                dTOTPREM, dORG_APREM, dLEVYAMT, dTCPA_STAXPCT,sFWCS_IND,dGUARANTEE_CHRG ,1,sSUBCLS,sCFMKT_IND,CFMKT_TIMESTAMP,FWCMSREF,"","",POL_CLAUSE,TIN,SST, STAMP_FEES);    

								if (dSTAXPCT > 0 && dORCAMT == 0)
									iRowAffected = 0;
					                	 
								if (dTCPA_STAXPCT > 0 && dLEVYAMT == 0)
									iRowAffected = 0;           	 

								if(iRowAffected == 0){
									throw new NullPointerException("Insert_FWHSSCH");
								}
				                
				                //GST
								iRowAffected = DB_Contact.insert_GSTCH_HS_08(temp_CNCODE, PRINCIPLE, "FWHS", GST_STATUS_IND, GST_NO, TOWN, COUNTRY, dGST_AMT, dGST_PCT, dGST_COMMAMT, dGST_COMMPCT, dGST_OTHAMT, dGST_FWCMSAMT, GST_RT, "-", 0.00);
								if(iRowAffected == 0){
									throw new NullPointerException("insert_GSTCH_HS_08");
								}
		    					
		    					Vector vTempVector	= new Vector();
		    					Vector vTradeSub	= (Vector) vRiskItem.elementAt(i); 
		    					String sUKEY	    = temp_UKEY+"$1";
		    					String sCNCODE	    = temp_CNCODE+"$1";
		    					
	                            String sSEQNO2		= common.setNullToString((String) vTradeSub.elementAt(0));
	                            String sEMP_NAME2	= common.setNullToString((String) vTradeSub.elementAt(2));
	                            String sOCCPSEC2	= common.setNullToString((String) vTradeSub.elementAt(3));
	                            String sCARD2		= "Y";
	                            String sDOB2_TEMP	= common.setNullToString((String) vTradeSub.elementAt(4));
	                                        
	                            if(!sDOB2_TEMP.equals(""))  sDOB2_TEMP  = timestampFormat2.format(timestampFormat.parse(sDOB2_TEMP));   
	                
	                            String sDOB2		= sDOB2_TEMP;
	                            String sGENDER2		= common.setNullToString((String) vTradeSub.elementAt(5));
	                            String sPASSPORT2	= common.setNullToString((String) vTradeSub.elementAt(6));
	                            String sNATIONALITY2= common.getKey(common.setNullToString((String) vTradeSub.elementAt(7))," ");
	                            
	                            String sWORK_TEMP	= common.setNullToString((String) vTradeSub.elementAt(8));
	                            
	                            if(!sWORK_TEMP.equals(""))  sWORK_TEMP  = timestampFormat.format(timestampFormat2.parse(sWORK_TEMP));   
	                
	                            String sWORK_EXP2	= sWORK_TEMP;
	                
	                            String sSUMINS2		= common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(9)));
	                            String sPREMIUM2	= common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(10)));
	                            String sSERVICE_FEE2= common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(11)));
	                            String sFWCMS_FEE2	= common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(12)));
	                            double dAPREM2		= common.formatdouble(common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(13))));
	                            double dORG_GPREM2	= common.formatdouble(common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(10))));
	                            
	                            String sREBATEAMT2	= common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(15)));
	                            String sSTAXAMT2	= common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(16)));
	                            String sSTAXAMT_TPCA2= common.fnCutComma(common.setNullToString((String) vTradeSub.elementAt(17)));
	                            String sINS_STATUS	= common.setNullToString((String) vTradeSub.elementAt(18));
	                            String sINSURED_FOR	= common.setNullToString((String) vTradeSub.elementAt(19));
	                            String sWORK_ID		= common.setNullToString((String) vTradeSub.elementAt(20));
	                            String sTERM_IND2	= common.setNullToString((String) vTradeSub.elementAt(21));
	                            String sTERM_DATE2	= common.setNullToString((String) vTradeSub.elementAt(22));
	                            
	                            String sEMP_PLACE2		= common.setNullToString((String) vTradeSub.elementAt(23));
	                            double dORG_APREM2 = dAPREM2;  // ANNUAL
	                            
	                            if(sINSURED_FOR.equals(""))
		                        {
		                        	sINSURED_FOR 	= "C";
		                        	sWORK_EXP2		= "";
		                        }
		                        
		    					String SUBKEY = sUKEY + "$1";
	                           	vTempVector.addElement(SUBKEY);
	                           	vTempVector.addElement("1");
	                           	vTempVector.addElement(sEMP_NAME2);
	                           	vTempVector.addElement(sOCCPSEC2);
	                           	vTempVector.addElement(sCARD2);
	                           	vTempVector.addElement(sEMP_PLACE2);
	                           	vTempVector.addElement(sTERM_DATE2);
	                           	vTempVector.addElement(sDOB2);
	                           	vTempVector.addElement(sGENDER2);
	                           	vTempVector.addElement(sPASSPORT2);
	                           	vTempVector.addElement(sNATIONALITY2);
	                           	vTempVector.addElement(sWORK_EXP2);
	                           	vTempVector.addElement(sSUMINS2);
	                           	vTempVector.addElement(sPREMIUM2);
	                           	vTempVector.addElement(sSERVICE_FEE2);
	                           	vTempVector.addElement(sFWCMS_FEE2);
	                           	vTempVector.addElement(Double.toString(dAPREM2));                           	
	                           	vTempVector.addElement(Double.toString(dORG_APREM2));
	                           	vTempVector.addElement(Double.toString(dORG_GPREM2));
	                           	vTempVector.addElement(sREBATEAMT2);
	                           	vTempVector.addElement(sSTAXAMT2);
	                           	vTempVector.addElement(sSTAXAMT_TPCA2);
	                           	vTempVector.addElement(sINS_STATUS);
	                        	vTempVector.addElement(sINSURED_FOR);
	                        	vTempVector.addElement(sWORK_ID);
		                        vFWHSSUB.addElement(vTempVector);
		    					
		    					if(vFWHSSUB.size() > 0) {
				               			iRowAffected = DB_FWHS.Insert_FWHSITEM(vFWHSSUB);
			
				                    if(iRowAffected == 0) {
				                        throw new NullPointerException("Insert_FWHSITEM");
		                        	}                
		                    	}
		                    	Vector vEmployeeVector1 = new Vector(); 
					            Vector vTempVector1	   = new Vector();		                           	
					           	vTempVector1.addElement("FWHS");
					           	vTempVector1.addElement(temp_UKEY);
					           	vTempVector1.addElement(sUKEY);
					           	vTempVector1.addElement(sEMP_NAME2);
					           	vTempVector1.addElement(sPASSPORT2);
					           	vTempVector1.addElement(sNATIONALITY2);
					           	vEmployeeVector1.addElement(vTempVector1);
					           	
					           	
					           	if(vEmployeeVector1.size() > 0) {
						       		iRowAffected = DB_Workmen.Insert_FWSEARCHinBatch(vEmployeeVector1);
						            if(iRowAffected == 0) {
						                throw new NullPointerException("Insert_FWSEARCH");
						            }      
						       	} 
				               	vFWHSSUB = new Vector(); 
				               	vCNCODE.addElement(temp_CNCODE);
		    					
		    					String sTPCAFEES   = String.valueOf(common.formatdouble(common.fnCutComma(sSERVICE_FEE2)) + common.formatdouble(common.fnCutComma(sFWCMS_FEE2)));

		    					Vector vFWHSSUB_1	 = new Vector();
		                        Vector vTempVector_1 = new Vector();
		                        vTempVector_1.addElement(PRINCIPLE);
								vTempVector_1.addElement(temp_CNCODE); 
		                       	vTempVector_1.addElement(sCNCODE);
		                       	vTempVector_1.addElement(sNATIONALITY2);
		                       	vTempVector_1.addElement(sPASSPORT2);
		                       	vTempVector_1.addElement(sOCCPSEC2);
		                       	vTempVector_1.addElement(sEMP_NAME2);
		                       	vTempVector_1.addElement(sGENDER2);
		                       	vTempVector_1.addElement(sDOB2);
		                       	vTempVector_1.addElement(sSUMINS2);
		                       	vTempVector_1.addElement(sPREMIUM2);
		                       	vTempVector_1.addElement(sTPCAFEES);
		                       	vTempVector_1.addElement(sINS_STATUS);
		                       	vTempVector_1.addElement(sINSURED_FOR);
		                       	vTempVector_1.addElement(sWORK_ID);
		                       	vTempVector_1.addElement(sWORK_EXP2);
		                     	vFWHSSUB_1.addElement(vTempVector_1);
			                    if(vFWHSSUB_1.size() > 0) {
				               		iRowAffected = DB_FWPOL.Insert_FWHSNEWPOLWORKER(vFWHSSUB_1);
			
				                    if(iRowAffected == 0) {
				                        throw new NullPointerException("Insert_FWHSNEWPOLWORKER");
		                        	}                
		                    	}
		                    	
							    double d_tempSUMINS     	= common.formatdouble(common.fnCutComma(sSUMINS2)); 
							    double d_tempGPREM     		= common.formatdouble(common.fnCutComma(sPREMIUM2)); 
							    double d_tempSERVICE_FEE    = common.formatdouble(common.fnCutComma(sTPCAFEES)); 
							    double d_tempSTAXAMT      	= common.formatdouble(common.fnCutComma(tempSTAXAMT)); 
							    double d_tempLEVYAMT      	= common.formatdouble(common.fnCutComma(tempLEVYAMT)); 
							    double d_tempREBATEAMT      = common.formatdouble(common.fnCutComma(tempREBATEAMT)); 
							    
							    String EMPLOYRCD ="";
				
								if(CONTACT_TYPE.equals("I"))
									EMPLOYRCD	= NEW_IC_NO;
								else if(CONTACT_TYPE.equals("B"))
									EMPLOYRCD	= BUSINESS_NO;
								else if(CONTACT_TYPE.equals("O"))
									EMPLOYRCD	= OLD_IC_NO;
		    					
		    					String sEFFDATE = timestampFormat2.format(timestampFormat.parse(EFFDATE));
		    					String sEXPDATE = timestampFormat2.format(timestampFormat.parse(EXPDATE));
		    					 iRowAffected = DB_FWPOL.Insert_FWHSNEWPOL(PRINCIPLE,"KUR","FWM",temp_CNCODE,temp_CNCODE,ISSDATE,sEFFDATE,sEXPDATE,CONTACT_TYPE,
					             				EMPLOYRCD,NAME,ADDRESS_1,ADDRESS_2,ADDRESS_3,ADDRESS_4,sPOSTDESCP,sPOSTCODE,STATECD,NATURE_BUSINESS,
					             				ACCODE,TEL_NO_OFFICE,TEL_NO_HOME,MOBILE_NO,EMAIL,d_tempSUMINS,1,d_tempGPREM,d_tempSERVICE_FEE,d_tempSTAXAMT,d_tempLEVYAMT,
					             				d_tempREBATEAMT, sINSURED_FOR,WORKPERMITNO,sWORK_EXP2,null,STATUS,today,SOURCE);

				             if(iRowAffected == 0) {
				                 throw new NullPointerException("Insert_FWHSNEWPOL");
				             }
		    					//iRowAffected = DB_FWPOL.duplicate_FWHSNEWPOL(temp_CNCODE, ORI_CNCODE, dSUMINS, 1, dGPREM, dSERVICE_FEE, dREBATEAMT, "SAVED");
								//if(iRowAffected == 0) 
							   // {
							    //   throw new NullPointerException("duplicate_FWHSNEWPOL");
							  //  } 
							}
						}catch (Exception ex)
					    {
					    	DB_Myprofile.rollBack();
					        DB_Template.rollBack();
					        DB_Contact.rollBack();
					        DB_FWHS.rollBack();
					        DB_FWPOL.rollBack();
					        DB_Workmen.rollBack();
					        error = true;
					        ex.printStackTrace();
					    }
					    finally
					    {
					        DB_Myprofile.conCommit();
					        DB_Myprofile.setAutoCommitOn();
					        DB_Myprofile.takeDown(); //close connection
					        DB_Template.conCommit();
					        DB_Template.setAutoCommitOn();
					        DB_Template.takeDown();
					        DB_Contact.conCommit();
					        DB_Contact.setAutoCommitOn();
					        DB_Contact.takeDown();
					        DB_FWHS.conCommit();
					        DB_FWHS.setAutoCommitOn();
					        DB_FWHS.takeDown();
					        DB_FWPOL.conCommit();
					        DB_FWPOL.setAutoCommitOn();
					        DB_FWPOL.takeDown();
					        DB_Workmen.conCommit();
					        DB_Workmen.setAutoCommitOn();
					        DB_Workmen.takeDown();
					    }
					}
				}else{
					//String ISSDATE = "";
					SQL	= "SELECT ISSDATE FROM TB_FWHSCN WHERE UKEY = '"+ CNCODE+"' WITH UR"; 
					DB_Contact.makeConnection();
					DB_Contact.executeQuery(SQL);
					while(DB_Contact.getNextQuery())
					{
						ISSDATE			= common.setNullToString(DB_Contact.getColumnString("ISSDATE")).trim();
					}
					DB_Contact.takeDown();
					//SST/*
					//String SST_EFFDATE_1 		= "";
					SQL	= "SELECT EFFDATE FROM TB_SST WHERE INSCODE = '08' AND MAINCLS = 'FWHS' AND SST_PCT != '0.00' ORDER BY EFFDATE ASC FETCH FIRST ROW ONLY WITH UR";
					DB_Contact.makeConnection();
					DB_Contact.executeQuery(SQL);
					if(DB_Contact.getNextQuery()) 
					{
						SST_EFFDATE_1 = common.setNullToString(DB_Contact.getColumnString("EFFDATE"));		
					}
					SST_EFFDATE 		 = timestampFormat2.parse(SST_EFFDATE_1);
					if(!ISSDATE.equals("")){
						today_1				 = timestampFormat2.parse(ISSDATE);
					}
					DB_Contact.takeDown();
		
					if(today_1.after(SST_EFFDATE) || today_1.compareTo(SST_EFFDATE) == 0){
						SST_TRIGGER = "N";
					}				
					vCNCODE.addElement(CNCODE.substring(2));
				}
			}
			//===========================================================================================
			if(genMCN.equals("Y") || ePLKS_MCN.equals("Y")){
				try
				{
		  			DB_FWHS.makeConnection();
					DB_FWHS.setAutoCommitOff();	
					
					String CN_STATUS = "SAVED";
					if(ePLKS_MCN.equals("Y")){ CN_STATUS = "PRINTED"; }
											
					for(int k = 1 ; k < vCNCODE.size(); k++){
						String temp_CNCODE	= (String) vCNCODE.elementAt(k); 

						if(common.getKey(ACCODE,"-").length() < 6)
		            	{
		            		if((ACCODE.substring(ACCODE.length()-3,ACCODE.length())).equalsIgnoreCase("-NM"))
		    				{
								iRowAffected = DB_FWHS.insert_record_AUDIT_TRAIL_NM(PRINCIPLE,ACCODE.substring(0,ACCODE.length()-3),CN_STATUS, "4", "FWHS", temp_CNCODE);
			  				}else{
								iRowAffected = DB_FWHS.insert_record_AUDIT_TRAIL_NM(PRINCIPLE,ACCODE,CN_STATUS, "4", "FWHS", temp_CNCODE);
			  				}
			  			}else{
							iRowAffected = DB_FWHS.insert_record_AUDIT_TRAIL_NM(PRINCIPLE,common.getKey(ACCODE,"-")+"-00",CN_STATUS, "4", "FWHS", temp_CNCODE);
						}
										
						if(iRowAffected == 0){
					  		throw new NullPointerException("insert_record_AUDIT_TRAIL_NM");
					  	
				 		}
			 		}
				}catch (Exception e){
			   		e.printStackTrace();
					DB_FWHS.rollBack();
				}finally
				{
					DB_FWHS.conCommit();
		    		DB_FWHS.setAutoCommitOn();
					DB_FWHS.takeDown();		
				}
			}//end

			if(!error)
			{
				try
			    {
			        DB_Template.makeConnection();
			        DB_FWPOL.makeConnection2();

			    	for(int k = 0 ; k < vCNCODE.size(); k++){
						String temp_CNCODE	= (String) vCNCODE.elementAt(k); 
				        
				        SQL2 = "SELECT ACCODE,CNCODE,PRINCIPLE,ORCCODE,POLNO,ENDORSE_NO,STATUS,PREVPOL,REPLACECN,MASTERIND,NEW_IC_NO,OLD_IC_NO,BUSINESS_NO,CONTACT_TYPE,CLASS FROM TB_FWHSCN WHERE UKEY = '"+PRINCIPLE+temp_CNCODE+"' WITH UR";
				        DB_Template.executeQuery(SQL2);
				        while(DB_Template.getNextQuery())
				        {
				            PRINCIPLE   = common.setNullToString(DB_Template.getColumnString("PRINCIPLE"));
				            CNOTE		= common.setNullToString(DB_Template.getColumnString("CNCODE"));
				            ACCODE		= common.setNullToString(DB_Template.getColumnString("ACCODE"));
				            ORCCODE 	= common.setNullToString(DB_Template.getColumnString("ORCCODE"));
				            POLNO 		= common.setNullToString(DB_Template.getColumnString("POLNO"));
				            ENDORSE_NO	= common.setNullToString(DB_Template.getColumnString("ENDORSE_NO"));
				            STATUS 		= common.setNullToString(DB_Template.getColumnString("STATUS"));
				            PREVPOL		= common.setNullToString(DB_Template.getColumnString("PREVPOL"));
				            REPLACECN	= common.setNullToString(DB_Template.getColumnString("REPLACECN"));
				            MASTERIND	= common.setNullToString(DB_Template.getColumnString("MASTERIND"));
				            NEW_IC_NO	= common.setNullToString(DB_Template.getColumnString("NEW_IC_NO"));
				            OLD_IC_NO	= common.setNullToString(DB_Template.getColumnString("OLD_IC_NO"));
				            BUSINESS_NO	= common.setNullToString(DB_Template.getColumnString("BUSINESS_NO"));
				            CONTACT_TYPE= common.setNullToString(DB_Template.getColumnString("CONTACT_TYPE"));	
				            CLASS		= common.setNullToString(DB_Template.getColumnString("CLASS"));	            
				            
				            if(ORCCODE.equals(""))
				            	SUBCODE = POLNO;
				            else if(!POLNO.equals(""))
				            	SUBCODE	= ORCCODE + "*" + POLNO;
				        }
				             
					    //---GST ENDORSEMENT--
				        SQL = "SELECT CNSTATUS FROM TB_TRANSACTION WHERE IDNO='"+PRINCIPLE+temp_CNCODE+"' WITH UR";
				        DB_Template.executeQuery(SQL);
				
				        while(DB_Template.getNextQuery())
				        {
				        	GST_STATUS	= common.setNullToString(DB_Template.getColumnString("CNSTATUS"));
				        }
				 		SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + PRINCIPLE + PREVPOL + "' WITH UR";
					    DB_Contact.makeConnection();
						DB_Contact.executeQuery(SQL);
						if(DB_Contact.getNextQuery())
						{
							PREV_TAX_NO = common.setNullToString(DB_Contact.getColumnString("GST_TAX_NO"));
						}
						if(!PREV_TAX_NO.equals("")){					
							GST_IND	= "Y";
						}
						
						String temp_ukey 	  = PRINCIPLE + temp_CNCODE;
						
						if(PM_ENDORSE.equals("Y"))
							temp_ukey = PRINCIPLE+REPLACECN;
						
						SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '"+temp_ukey+"' WITH UR";
						DB_Contact.executeQuery(SQL);
							    
						if(DB_Contact.getNextQuery())
						{
							 GST_RT 		= common.setNullToString(DB_Contact.getColumnString("GST_RT"));
							 GST_TAX_NO 	= common.setNullToString(DB_Contact.getColumnString("GST_TAX_NO"));
							 GST_TAX_NO_END	= common.setNullToString(DB_Contact.getColumnString("GST_TAX_NO_END"));
							 GST_AMT		= common.setNullToString(DB_Contact.getColumnString("GST_AMT"));	
							 GST_COMMAMT	= common.setNullToString(DB_Contact.getColumnString("GST_COMMAMT"));
							 GST_OTHAMT		= common.setNullToString(DB_Contact.getColumnString("GST_OTHAMT"));	
						}      		
					    DB_Contact.takeDown();  
					    
						if (!GST_AMT.equals(""))
							GST_AMT   	= common.twoDecimal(common.formatfloat(GST_AMT));	
						else
							GST_AMT		= "0.00";
					    
						if (!GST_COMMAMT.equals(""))
							GST_COMMAMT   	= common.twoDecimal(common.formatfloat(GST_COMMAMT));	
						else
							GST_COMMAMT		= "0.00";
					    
						if (!GST_OTHAMT.equals(""))
							GST_OTHAMT   	= common.twoDecimal(common.formatfloat(GST_OTHAMT));	
						else
							GST_OTHAMT		= "0.00";
		
						if(GST_RT.equals("") && SST_TRIGGER.equals("N")){
							GST_RT = "SST";
						}
						else{
							GST_RT = "SR";
						}
						
				        if (GST_STATUS.equals("SAVED") && GSTTAX_TRIGGER.equals("Y") && !error)  
				        {           
						if(!GST_RT.equals("")){
							if(GST_TAX_NO.equals("")){	
								if(!SST_TRIGGER.equals("N")){	                	
					        		if(GST_IND.equals("Y") && !CNTYPE.equals("RN") && !CNTYPE.equals("NW")){
					            		GST_TAX_NO    	= DB_Template.getRunno("DEBIT_NOTE",PRINCIPLE);   
					           	 	}else{
					                	GST_TAX_NO    	= DB_Template.getRunno("TAX_INVOICE",PRINCIPLE);     
					            	}
					            }
					            else{
 									if(GST_IND.equals("Y") && !CNTYPE.equals("RN") && !CNTYPE.equals("NW")){
					            		GST_TAX_NO    	= DB_Template.getRunno("SST_DEBIT_NOTE",PRINCIPLE);   
					           	 	}else{
					                	GST_TAX_NO    	= DB_Template.getRunno("SST_TAX_INVOICE",PRINCIPLE);     
					            	}					            
					            } 				
								iRowAffected 	= DB_Template.updateTaxInvoice(CNOTE, GST_TAX_NO, PRINCIPLE, printtime, "PRINTED",PREV_TAX_NO);      		
				        		if (iRowAffected == 0)
								{
									throw new NullPointerException("tax_invoice");
								}
								
							 
								if (iRowAffected > 0)
								{
									if(POLEXIST.equals("Y")){
										iRowAffected 	= DB_FWPOL.update_FWHSNEWPOL("PRINTED",CNOTE); 
						        		if (iRowAffected == 0)
										{
											throw new NullPointerException("1.update_FWHSNEWPOL");
										}
									}
								}
							}						
				        }   
				        
				        boolean found	     = true;
				        String ORI_CN    	 = "";
				        String ORI_GPREM 	 = ""; 
				        String ORI_TPCAFEES  = "";
				        String ORI_wGPREM 	 = ""; 
				        String ORI_wTPCAFEES = "";
				        double dORI_GPREM    = 0;
				        double dORI_TPCAFEES = 0;
				        
				        DB_Contact.makeConnection();
						SQL = "SELECT CNCODE FROM TB_FWHSCN WHERE REPLACECN ='"+CNOTE+"' WITH UR";
						DB_Contact.executeQuery(SQL);
						if(DB_Contact.getNextQuery())
						{
							 ORI_CN 		= common.setNullToString(DB_Contact.getColumnString("CNCODE"));
							 found 			= false;
						}      		
					    DB_Contact.takeDown(); 
					    
						SQL = "SELECT TTLGROSSPREMIUM,TTLTPCAFEES FROM TB_FWHS_NEWPOL WHERE POLICYUNIQID ='"+ORI_CN+"' WITH UR";
						DB_FWPOL.executeQuery(SQL);
						if(DB_FWPOL.getNextQuery())
						{
							 ORI_GPREM 	 		= "-" + common.setNullToString(DB_FWPOL.getColumnString("TTLGROSSPREMIUM"));
							 ORI_TPCAFEES 		= "-" + common.setNullToString(DB_FWPOL.getColumnString("TTLTPCAFEES"));
							 
							 dORI_GPREM			 = common.formatdouble(common.fnCutComma(ORI_GPREM));
							 dORI_TPCAFEES	 	 = common.formatdouble(common.fnCutComma(ORI_TPCAFEES));
						}      		 
					    
					    SQL = "SELECT GROSSPREMIUM,TPCAFEES FROM TB_FWHS_NEWPOL_WORKER WHERE POLICYNO ='"+ORI_CN+"' WITH UR";
						DB_FWPOL.executeQuery(SQL);
						if(DB_FWPOL.getNextQuery())
						{
							 ORI_wGPREM 	 	= "-" + common.setNullToString(DB_FWPOL.getColumnString("GROSSPREMIUM"));
							 ORI_wTPCAFEES 		= "-" + common.setNullToString(DB_FWPOL.getColumnString("TPCAFEES"));
						}      	
						
					    if(!found)
					    {
								iRowAffected 	= DB_Template.update_replaced_cnstatus(CNOTE,PRINCIPLE,"TB_FWHSCN","TB_TRANSACTION","TB_GST_CN");      				        	
				        		if (iRowAffected == 0)
								{
									throw new NullPointerException("update_replaced_cnstatus");
								}
								
								String CANCELDATE 	= timestampFormat1.format(new Date());
								CANCELDATE = timestampFormat2.format(timestampFormat1.parse(CANCELDATE));
						
								String END_NO	= "";

								if(ORI_CN.indexOf("-")>-1)
								{
									int pos = ORI_CN.indexOf("-") + 1;
									END_NO = ORI_CN.substring(pos);
									END_NO = Integer.toString(Integer.parseInt(END_NO)+1);
								}
								else
								{
									END_NO 	= "1";
								}
								END_NO	= common.getKey(ORI_CN,"-") + "-" +END_NO;
								
								iRowAffected 	= DB_FWPOL.update_FWHS_ENDTPOL(ORI_CN, END_NO, PRINCIPLE, "", CANCELDATE, CANCELDATE, ORI_CN, "", CANCELDATE,"","CANCELLED","",CANCELDATE,dORI_GPREM,dORI_TPCAFEES,ORI_wGPREM,ORI_wTPCAFEES);
					       		if (iRowAffected == 0)
								{
									throw new NullPointerException("3.update_FWHS_ENDTPOL");
								}
								
						        // ******* gen XML
						        String POST_URL                 = "";   
						        String CERT_NAME                = "";
						        String CERT_PASS                = "";
						        String XML_TYPE                 = "";
						        String INTEGRATION              = ""; 
						        String SENDSAVED                = "";
						        String VIAMQ                    = "";
						        String MQ_HOST                  = "";
						        String MQ_CHANNEL               = "";
						        String MQ_PORT                  = "";
						        String MQ_USER                  = "";
						        String MQ_QUEUE                 = "";
						        String MQ_QUEUEMGR              = "";
						        String MQ_SAVEDQ                = "";
						
						        DB_Contact.makeConnection();  
						        SQL = "SELECT * FROM TB_MAINPRINCIPLE, TB_MAINPRINCIPLE_2 WHERE TB_MAINPRINCIPLE.CODE = TB_MAINPRINCIPLE_2.CODE AND TB_MAINPRINCIPLE.CODE ='"+PRINCIPLE+"' WITH UR";
						
						        DB_Contact.executeQuery(SQL);
						        if(DB_Contact.getNextQuery())
						        {
						            POST_URL        = common.setNullToString(DB_Contact.getColumnString("POST_URL"));
						            CERT_NAME       = common.setNullToString(DB_Contact.getColumnString("CERT_NAME"));               
						            CERT_PASS       = common.setNullToString(DB_Contact.getColumnString("CERT_PASS"));               
						            XML_TYPE        = common.setNullToString(DB_Contact.getColumnString("XML_TYPE"));
						            INTEGRATION     = common.setNullToString(DB_Contact.getColumnString("INTEGRATION"));
						            SENDSAVED       = common.setNullToString(DB_Contact.getColumnString("SENDSAVED"));
						
						            VIAMQ       = common.setNullToString(DB_Contact.getColumnString("VIAMQ"));    
						            MQ_HOST     = common.setNullToString(DB_Contact.getColumnString("MQ_HOST"));    
						            MQ_CHANNEL  = common.setNullToString(DB_Contact.getColumnString("MQ_CHANNEL"));    
						            MQ_PORT     = common.setNullToString(DB_Contact.getColumnString("MQ_PORT"));    
						            MQ_USER     = common.setNullToString(DB_Contact.getColumnString("MQ_USER"));    
						            MQ_QUEUE    = common.setNullToString(DB_Contact.getColumnString("MQ_QUEUE"));    
						            MQ_QUEUEMGR = common.setNullToString(DB_Contact.getColumnString("MQ_QUEUEMGR"));    
						            MQ_SAVEDQ   = common.setNullToString(DB_Contact.getColumnString("MQ_SAVEDQ"));    
						        }   
						        DB_Contact.takeDown();
						
						        postSubmission psb = null;
						        String sXML = "";
						        if((!INTEGRATION.equals("N")) && (SENDSAVED.equals("Y")))
						        {
						            inputXML.makeConnection();
						       		sXML = inputXML.genFWHSCNXML(PRINCIPLE,ORI_CN,XML_TYPE);
						            inputXML.takeDown();

						
						            if (VIAMQ.equals("Y"))
						            {
						                	postMQXML.posting(MQ_HOST,MQ_CHANNEL,MQ_PORT,MQ_USER,MQ_SAVEDQ,MQ_QUEUEMGR,sXML,PRINCIPLE,DATE_CREATED+"SV");
						            }
						            else
						            {
						                psb = new postSubmission(POST_URL,sXML,CERT_NAME,CERT_PASS,PRINCIPLE,DATE_CREATED);
						                psb.start();
						            }
								 
						        }
						    } 
				    	}
				    }
				    
				    if(!GST_TAX_NO.equals("")&&!PM_ENDORSE.equals("Y")&&ENDORSE_NO.equals("")){
					    logo_height="160";
						logo_height2="120";
				    	if(GST_IND.equals("Y")){
				    		TITLE_GST = "DEBIT NOTE";
				    	}else{
				    		TITLE_GST = "TAX INVOICE";
				    	}
			        }else if(!GST_TAX_NO.equals("")&&PM_ENDORSE.equals("Y")){
					    logo_height="160";
						logo_height2="120";
						GST_TAX_NO = GST_TAX_NO_END;
						TITLE_GST = "CREDIT NOTE";
				    }
				    GST_TAX_NO2 = GST_TAX_NO;	
					if(!ENDORSE_NO.equals("")&&!(GST_STATUS.equals("CANCELLED")||GST_STATUS.equals("CANCELLED/REPLACED"))){
						GST_TAX_NO2 = "";
					}
				    //END ENDORSEMENT 
			    }
			    catch (Exception ex)
			    {
			        ex.printStackTrace();
			    }
			    finally
			    {
			        DB_Template.takeDown();
			        DB_FWPOL.takeDown();
			    }
			    
			}
				
				if(CONTACT_TYPE.equals("I"))
					BUSINESS_NO = NEW_IC_NO;
				else if(CONTACT_TYPE.equals("O"))
					BUSINESS_NO = OLD_IC_NO;

			 	if(CONTACT_TYPE.equals("I") && BUSINESS_NO.length()==12 && !FWCMSREF.equals(""))
			    {
			    	String IC_1 = BUSINESS_NO.substring(0,6);
			    	String IC_2 = BUSINESS_NO.substring(6,8);
			    	String IC_3 = BUSINESS_NO.substring(8,BUSINESS_NO.length());
			    	
			    	BUSINESS_NO = IC_1+"-"+IC_2+"-"+IC_3;
			    }
			
				String ResponseCode			= "";
				
				//FWCMS Success TRansaction
			    if(!FWCMSREF.equals("") && !BUTTONIND.equals("D") && !SUBMITIND.equals("N") && !error)
			    {
				    boolean fwcms_success 		= true;
			    	String ERROR_DESC 			= "";
			    	String INSTYPE				= "H";
			    	
				    DB_Contact.makeConnection();
				    SQL = "SELECT * FROM TB_FWCMS_TRANS WHERE REFNO='"+FWCMSREF+"' AND INSCODE='"+PRINCIPLE+"' AND TRANS_TYPE='S' AND RESP_CODE='S' WITH UR";
				    DB_Contact.executeQuery(SQL);
				    while(DB_Contact.getNextQuery())
				    {
				        fwcms_success = false;
				    }
				    DB_Contact.takeDown(); 
				    
					BestinetXML.makeConnection();
					if(fwcms_success)
						ResponseCode = BestinetXML.FWCMS_SuccessTransac(CNCODE,FWCMSREF,PRINCIPLE,CNCODE.substring(2),INSTYPE,"S",SESUSERID,ACCODE,BUSINESS_NO,NOWORKER);
				    BestinetXML.takeDown();
				    
					if(!ResponseCode.equals("") && !FWCMSREF.equals(""))
					{
					    DB_Contact.makeConnection();
					    SQL = "SELECT DESCP FROM TB_FWCMS_ERROR where CODE='"+ResponseCode+"' WITH UR";
					    DB_Contact.executeQuery(SQL);
					    while(DB_Contact.getNextQuery())
					    {
					        ERROR_DESC    = common.setNullToString(DB_Contact.getColumnString("DESCP"));
					    }
					    DB_Contact.takeDown(); 	
					
						%>
							<script language="Javascript">
								alert("<%=ERROR_DESC%>");
							</script>
						<%  
						RESP_STATUS = "F";
						error = true;
					}else{
						RESP_STATUS = "S";
					}
				}		
			
			    if(!ENDORSE_NO.equals(""))
	    			SRC_URL = "pop_cn_fwhs_end_preview.jsp";
			    
			    String AUTO_SUBMIT_IND = "";
			    SQL2 = "SELECT AUTO_SUBMIT_IND FROM TB_AGENT_AM WHERE INSCODE='"+PRINCIPLE+"' AND ACCODE = '"+ACCODE+"' WITH UR";
		        DB_Template.makeConnection();
		        DB_Template.executeQuery(SQL2);
				
		        if(DB_Template.getNextQuery())
		        {
		            AUTO_SUBMIT_IND   = common.setNullToString(DB_Template.getColumnString("AUTO_SUBMIT_IND"));
			    }
			    DB_Template.takeDown();
			    
			    String SUMINS	= "0.00";
			    String GPREM	= "0.00";
			    String STAXAMT	= "0.00";
			    String STAMPDUTY	= "0.00";
			    String NETPREM	= "0.00";
			    String COMMAMT	= "0.00";		    
			    String TOTPREM 	= "0.00";
			    
		        SQL2 = "SELECT SUMINS,GPREM,STAXAMT,STAMPDUTY,NETPREM,COMMAMT,TOTPREM FROM TB_FWHSSCH WHERE UKEY2='"+CNCODE+"' WITH UR";
				DB_Template.makeConnection();
		        DB_Template.executeQuery(SQL2);
		
		        if(DB_Template.getNextQuery())
		        {
		            SUMINS   	= common.setNullToString(DB_Template.getColumnString("SUMINS"));
		            GPREM   	= common.setNullToString(DB_Template.getColumnString("GPREM"));
		            STAXAMT   	= common.setNullToString(DB_Template.getColumnString("STAXAMT"));
		            STAMPDUTY 	= common.setNullToString(DB_Template.getColumnString("STAMPDUTY"));
		            NETPREM   	= common.setNullToString(DB_Template.getColumnString("NETPREM"));
		            COMMAMT   	= common.setNullToString(DB_Template.getColumnString("COMMAMT"));
		            TOTPREM   	= common.setNullToString(DB_Template.getColumnString("TOTPREM"));
		        }
		        DB_Template.takeDown();
		        
	            String fileURL = server_root+request.getContextPath();

				if(BUTTONIND.equals("J") && STATUS.equals("SAVED") && !error){
					try
				    {
				        DB_Template.makeConnection();
				        DB_Myprofile.makeConnection();
				        DB_Contact.makeConnection();
				        DB_FWPOL.makeConnection2();

				        for(int k = 0 ; k < vCNCODE.size(); k++){
							CNOTE	= (String) vCNCODE.elementAt(k); 
							if(AUTO_SUBMIT_IND.equals("Y"))
		            		{
		            			subID = DB_Myprofile.insert_fbatch_auto(SESUSERID,PRINCIPLE,ACCODE,DATE_CREATED,"FWHS","ESUB",TOTPREM);
		            			if (subID.equals(""))
						        {
						            throw new NullPointerException("insert_batch");
						        }
						        iRowAffected = DB_Myprofile.insert_transBatch("FWHS",subID,SESUSERID,DATE_CREATED,PRINCIPLE,ACCODE,BRUSERID);
						        if (iRowAffected == 0)
						        {
						            throw new NullPointerException("insert_transBatch");
						        } 
						        					
					       		String TOTAL_GSTAMT		= common.twoDecimal(Double.parseDouble(GST_OTHAMT) + Double.parseDouble(GST_AMT));
					        
						        iRowAffected = DB_Myprofile.insertFSubDetails(subID,CNOTE,SUMINS, GPREM, COMMAMT, STAXAMT, STAMPDUTY, TOTPREM, "N", "FWHS", TOTAL_GSTAMT,GST_COMMAMT);
						        if (iRowAffected == 0)
						        {
						            throw new NullPointerException("insertFSubDetails");
						        }
						        iRowAffected 	= DB_Myprofile.update_fwcscnStatus(PRINCIPLE+CNOTE,subID,PRINCIPLE,"TB_FWHSCN","SUBMITTED");
						        if (iRowAffected == 0)
						        {
						            throw new NullPointerException("updateStatus");
						        }else
								{
									if(POLEXIST.equals("Y")){
										iRowAffected 	= DB_FWPOL.update_FWHSNEWPOL("SUBMITTED",CNOTE); 
						        		if (iRowAffected == 0)
										{
											throw new NullPointerException("4.update_FWHSNEWPOL");
										} 
									}
									
								}
						        iRowAffected 	= DB_Contact.update_FWHSSCH_CFMKT_TIMESTAMP(PRINCIPLE+CNOTE,DATE_CREATED);
						        if (iRowAffected == 0)
						        {
						            throw new NullPointerException("AUTOSUBMIT_update_FWHSSCH_CFMKT_TIMESTAMP");
						        }
						        iRowAffected = DB_Myprofile.update_fwcstranStatus(PRINCIPLE+CNOTE,PRINCIPLE,"SUBMITTED",BRUSERID);
					            if (iRowAffected == 0)
					            {
					                throw new NullPointerException("update_fwcstranStatus");
					            }else
								{
									if(POLEXIST.equals("Y")){
										iRowAffected 	= DB_FWPOL.update_FWHSNEWPOL("SUBMITTED",CNOTE); 
						        		if (iRowAffected == 0)
										{
											throw new NullPointerException("5.update_FWHSNEWPOL");
										}
									}
									
								}
		            		}
		            		else
		            		{     
			            		iRowAffected 	= DB_Template.updateStatus(PRINCIPLE+CNOTE,"TB_FWHSCN","PRINTED");
			            		if (iRowAffected == 0)
						        {
						            throw new NullPointerException("updateStatus");
						        }
						        
								if (iRowAffected > 0)
								{
									if(POLEXIST.equals("Y")){
										iRowAffected 	= DB_FWPOL.update_FWHSNEWPOL("PRINTED",CNOTE); 
						        		if (iRowAffected == 0)
										{
											throw new NullPointerException("6.update_FWHSNEWPOL");
										}
									}
									
								}
								
						        iRowAffected 	= DB_Contact.update_FWHSSCH_CFMKT_TIMESTAMP(PRINCIPLE+CNOTE,DATE_CREATED);
						        if (iRowAffected == 0)
						        {
						            throw new NullPointerException("update_FWHSSCH_CFMKT_TIMESTAMP");
						        }
						        
						        String USERTYPE	= common.setNullToString((String) session.getAttribute("SES_USER_TYPE"));
								iRowAffected = DB_Contact.insert_transactionlog(PRINCIPLE, CNOTE, SESUSERID, USERTYPE, CLASS, TYPE, "PRINT");          
							
								if(iRowAffected == 0) 
								{
									throw new NullPointerException("insert_transactionlog");
								}
						 	}
						}
		            }
				    catch (Exception ex)
				    {
				    	DB_Myprofile.rollBack();
				        DB_Template.rollBack();
				        DB_Contact.rollBack();
				        DB_FWPOL.rollBack();
				        error = true;
				        ex.printStackTrace();
				    }
				    finally
				    {
				        DB_Myprofile.conCommit();
				        DB_Myprofile.setAutoCommitOn();
				        DB_Myprofile.takeDown(); //close connection
				        DB_Template.conCommit();
				        DB_Template.setAutoCommitOn();
				        DB_Template.takeDown();
				        DB_Contact.conCommit();
				        DB_Contact.setAutoCommitOn();
				        DB_Contact.takeDown();
				        DB_FWPOL.conCommit();
				        DB_FWPOL.setAutoCommitOn();
				        DB_FWPOL.takeDown();
				    }
	            }else if(BUTTONIND.equals("D")){
	            	RP_html2pdf.setWaterMark("DRAFT_OUTLINED.jpg","610","445");
	            }
	
	    		//send data back to principal (XML)
	    	if(!error)
	    	{
	    		String POST_URL                 = "";   
		        String CERT_NAME                = "";
		        String CERT_PASS                = "";
		        //String SUBMISSIONNO             = "";
		        String XML_TYPE                 = "";
		        String INTEGRATION              = ""; 
		        String SENDSAVED                = "";
		        String VIAMQ                    = "";
		        String MQ_HOST                  = "";
		        String MQ_CHANNEL               = "";
		        String MQ_PORT                  = "";
		        String MQ_USER                  = "";
		        String MQ_QUEUE                 = "";
		        String MQ_QUEUEMGR              = "";
		        String MQ_SAVEDQ                = "";
		        String MAINCLASS				= CLASS;
		
		        DB_Template.makeConnection();  
		        SQL = "SELECT * FROM TB_MAINPRINCIPLE, TB_MAINPRINCIPLE_2 WHERE TB_MAINPRINCIPLE.CODE = TB_MAINPRINCIPLE_2.CODE AND TB_MAINPRINCIPLE.CODE ='"+PRINCIPLE+"' WITH UR";
		
		        DB_Template.executeQuery(SQL);
		        while(DB_Template.getNextQuery())
		        {
		            POST_URL        = common.setNullToString(DB_Template.getColumnString("POST_URL"));
		            CERT_NAME       = common.setNullToString(DB_Template.getColumnString("CERT_NAME"));               
		            CERT_PASS       = common.setNullToString(DB_Template.getColumnString("CERT_PASS"));               
		            XML_TYPE        = common.setNullToString(DB_Template.getColumnString("XML_TYPE"));
		            INTEGRATION     = common.setNullToString(DB_Template.getColumnString("INTEGRATION"));
		            SENDSAVED       = common.setNullToString(DB_Template.getColumnString("SENDSAVED"));
		
		            VIAMQ       = common.setNullToString(DB_Template.getColumnString("VIAMQ"));    
		            MQ_HOST     = common.setNullToString(DB_Template.getColumnString("MQ_HOST"));    
		            MQ_CHANNEL  = common.setNullToString(DB_Template.getColumnString("MQ_CHANNEL"));    
		            MQ_PORT     = common.setNullToString(DB_Template.getColumnString("MQ_PORT"));    
		            MQ_USER     = common.setNullToString(DB_Template.getColumnString("MQ_USER"));    
		            MQ_QUEUE    = common.setNullToString(DB_Template.getColumnString("MQ_QUEUE"));    
		            MQ_QUEUEMGR = common.setNullToString(DB_Template.getColumnString("MQ_QUEUEMGR"));    
		            MQ_SAVEDQ   = common.setNullToString(DB_Template.getColumnString("MQ_SAVEDQ"));    
		        }   
		        DB_Template.takeDown();
		        
		        //Split cancellation
		        if(!split_cancel_xml.equals("")){
			        postSubmission psb1 = null;
	
		            if (VIAMQ.equals("Y"))
		            {
		                postMQXML.posting(MQ_HOST,MQ_CHANNEL,MQ_PORT,MQ_USER,MQ_SAVEDQ,MQ_QUEUEMGR,split_cancel_xml,PRINCIPLE,DATE_CREATED+"SV");
		  
		            }
		            else
		            {
		                psb1 = new postSubmission(POST_URL,split_cancel_xml,CERT_NAME,CERT_PASS,PRINCIPLE,DATE_CREATED);
		                psb1.start();
		            }
	            }
	            
            
	    		for(int k = 0 ; k < vCNCODE.size(); k++){
					CNOTE	= (String) vCNCODE.elementAt(k); 
			        
			
			        postSubmission psb = null;
			
			        String sXML = "";
			        String sXML1 = "";
			
			        if((!INTEGRATION.equals("N")) && (SENDSAVED.equals("Y")))
			        {
			            inputXML.makeConnection();
		
		        		sXML = inputXML.genFWHSCNXML(PRINCIPLE,CNOTE,XML_TYPE);
						
			            inputXML.takeDown();
			            
			
			           if (VIAMQ.equals("Y") && !sXML.equals(""))
			            {
			            	if(!subID.equals(""))
			                	postMQXML.posting(MQ_HOST,MQ_CHANNEL,MQ_PORT,MQ_USER,MQ_QUEUE,MQ_QUEUEMGR,sXML,PRINCIPLE,DATE_CREATED);
			               	
			               	postMQXML.posting(MQ_HOST,MQ_CHANNEL,MQ_PORT,MQ_USER,MQ_SAVEDQ,MQ_QUEUEMGR,sXML,PRINCIPLE,DATE_CREATED+"SV"); 
			            }
			            else if(!sXML.equals(""))
			            {
			                psb = new postSubmission(POST_URL,sXML,CERT_NAME,CERT_PASS,PRINCIPLE,DATE_CREATED);
			                psb.start();
			            }
			            
			            if (VIAMQ.equals("Y") && !sXML1.equals(""))
			            {
			            	 if(!subID.equals(""))
			                	postMQXML.posting(MQ_HOST,MQ_CHANNEL,MQ_PORT,MQ_USER,MQ_QUEUE,MQ_QUEUEMGR,sXML1,PRINCIPLE,DATE_CREATED); 
			                
			                postMQXML.posting(MQ_HOST,MQ_CHANNEL,MQ_PORT,MQ_USER,MQ_SAVEDQ,MQ_QUEUEMGR,sXML1,PRINCIPLE,DATE_CREATED+"SV");
			            }
			            else if(!sXML1.equals(""))
			            {
			                psb = new postSubmission(POST_URL,sXML,CERT_NAME,CERT_PASS,PRINCIPLE,DATE_CREATED);
			                psb.start();
			            }
			        }	        
			        
			        if(!subID.equals(""))
			        {
			        	inputXML.makeConnection();
		        		sXML = inputXML.genSubmissionXMLPayment(subID);
			            inputXML.takeDown();
			
			            if (VIAMQ.equals("Y"))
			            {
			                postMQXML.posting(MQ_HOST,MQ_CHANNEL,MQ_PORT,MQ_USER,MQ_QUEUE,MQ_QUEUEMGR,sXML,PRINCIPLE,DATE_CREATED);
			            }
			            else
			            {
			                psb = new postSubmission(POST_URL,sXML,CERT_NAME,CERT_PASS,PRINCIPLE,DATE_CREATED);
			                psb.start();
			            }
			        }
				}
			}

			if(error)
	    	{
	%>
	            <script>
	                location.href="/liberty/clientProfile/clientProfile.jsp?result=f&RELOAD=N";
	            </script>   
	<%    	
	    	}
	    	else
	    	{
	    		for(int k = 0 ; k < vCNCODE.size(); k++){
	    			String CNCODE_PDF	= (String) vCNCODE.elementAt(k); 
	    			CNCODE_PDF 			= PRINCIPLE+CNCODE_PDF;
	    	
	    		String data = URLEncoder.encode("CNCODE") + "=" + URLEncoder.encode(CNCODE_PDF);
		        data += "&" + URLEncoder.encode("CNCODE1") + "=" + URLEncoder.encode(CNCODE1);
		        data += "&" + URLEncoder.encode("TYPE") + "=" + URLEncoder.encode("GRAB");
		        data += "&" + URLEncoder.encode("SUBMITIND") + "=" + URLEncoder.encode(SUBMITIND);
		        data += "&" + URLEncoder.encode("BUTTONIND") + "=" + URLEncoder.encode(BUTTONIND);
		        data += "&" + URLEncoder.encode("privacy"+privacyLang) + "=" + URLEncoder.encode("Y");
			          
				try
			    {
	        
			        DB_Template.makeConnection();
			        SQL = "SELECT A.BR_NAME,A.BR_ADD1,A.BR_ADD2,A.BR_ADD3,A.BR_ADD4,A.BR_POSTCODE,A.BR_TEL1,A.BR_TEL2,A.BR_FAX1,A.BR_FAX2 FROM TB_BRANCH A,TB_ACNO_AM B WHERE A.INSCODE='"+PRINCIPLE+"' AND B.INSCODE='"+PRINCIPLE+"' AND B.ACCODE='"+ACCODE+"' AND A.BR_ID=B.BR_ID FETCH FIRST ROW ONLY WITH UR";
			        DB_Template.executeQuery(SQL);
			
			        while(DB_Template.getNextQuery())
			        { 
			        	String BR_NAME		= common.setNullToString(DB_Template.getColumnString("BR_NAME"));
			        	String BR_ADD1		= common.setNullToString(DB_Template.getColumnString("BR_ADD1"));
			        	String BR_ADD2		= common.setNullToString(DB_Template.getColumnString("BR_ADD2"));
			        	String BR_ADD3		= common.setNullToString(DB_Template.getColumnString("BR_ADD3"));
			        	String BR_ADD4		= common.setNullToString(DB_Template.getColumnString("BR_ADD4"));
			        	String BR_POSTCODE	= common.setNullToString(DB_Template.getColumnString("BR_POSTCODE"));
			        	String BR_TEL1		= common.setNullToString(DB_Template.getColumnString("BR_TEL1"));
			        	String BR_TEL2		= common.setNullToString(DB_Template.getColumnString("BR_TEL2"));
			        	String BR_FAX1		= common.setNullToString(DB_Template.getColumnString("BR_FAX1"));
			        	String BR_FAX2		= common.setNullToString(DB_Template.getColumnString("BR_FAX2"));
			
			        	if(BR_NAME.length() > 0) { 
				        	sName	= BR_NAME; 
			        	} 
			        	if(BR_ADD1.length() > 0) { 
				        	sAddress	= BR_ADD1; 
			        	} 
			        	if(BR_ADD2.length() > 0) { 
			        		sAddress	+= ", " + BR_ADD2; 
			        	} 
			        	if(BR_ADD3.length() > 0) { 
			        		sAddress	+= ", " + BR_ADD3; 
			        	} 
			        	if(BR_ADD4.length() > 0) { 
			        		sAddress	+= ", " + BR_ADD4; 
			        	} 
			        	if(BR_POSTCODE.length() > 0) { 
			        		sAddress	+= ", " + BR_POSTCODE; 
			        	} 
			        	if(BR_TEL1.length() > 0) { 
				        	sTelephone	= BR_TEL1; 
			        	} 
			        	if(BR_TEL2.length() > 0) { 
				        	sTelephone	+= ", " + BR_TEL2; 
			        	} 
			        	if(BR_FAX1.length() > 0) { 
				        	sFax	= BR_FAX1; 
			        	} 
			        	if(BR_FAX2.length() > 0) { 
				        	sFax	+= ", " + BR_FAX2; 
			        	} 
			        }
			    }
			    catch (Exception ex)
			    {
			        ex.printStackTrace();
			    }
			    finally
			    {
			        DB_Template.takeDown();
			    }
				
		        String CATEGORYMSG	= "";
				String CATEGORYMSG1 = ""; 
				String REF_MAINPAGE	= "";
				String REF_MAINPAGE1= "";
	
				fileURL += "/template/"+SRC_URL+"?BUTTONIND="+BUTTONIND+"&option=print&POLTYPE2="+POLTYPE2;
	
	            URL url = new URL(fileURL);
	            URLConnection conn = url.openConnection();
	            conn.setDoOutput(true);
	            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
	
	            wr.write(data);
	            wr.flush();
	
	            // Get the response
	            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line;
	            StringBuffer results = new StringBuffer();
	
	            String sheader ="";
				String HEADER1 = "";
				String HEADER2 = "";
				String HEADER3 = "";
				String HEADER4 = "";
					
				while ((line = rd.readLine()) != null) 
				{        
	                results.append(line);
	
				        try { sheader=line.substring(0,11); } catch(Exception e) {};
				                        
				        if(sheader.equals("<!--HEADER1"))
				        {
				          	try {HEADER1=line.substring(12,line.length()-3); } catch(Exception e) {};
				        }
				        else if(sheader.equals("<!--HEADER2"))
				        {
				          	try {HEADER2=line.substring(12,line.length()-3); } catch(Exception e) {}; 
				        }
				        else if(sheader.equals("<!--HEADER3"))
				        {
				          	try {HEADER3=line.substring(12,line.length()-3); } catch(Exception e) {};
				        }
				        else if(sheader.equals("<!--HEADER4"))
				        {
				          	try {HEADER4=line.substring(12,line.length()-3); } catch(Exception e) {};
				        }
				        else if(sheader.equals("<!--CATEGO1"))
				        {
				          	try {CATEGORYMSG=line.substring(12,line.length()-3); } catch(Exception e) {};                  	
				        }
				        else if(sheader.equals("<!--CATEGO2"))
				        {
				          	try {CATEGORYMSG1=line.substring(12,line.length()-3); } catch(Exception e) {};
				        }
				        else if(sheader.equals("<!--REFMAI1"))
				        {
				          	try {REF_MAINPAGE=line.substring(12,line.length()-3); } catch(Exception e) {};
				        }
				        else if(sheader.equals("<!--REFMAI2"))
				        {
				          	try {REF_MAINPAGE1=line.substring(12,line.length()-3); } catch(Exception e) {};
				        }
				}
	            wr.close();
	            rd.close(); 
	    		
	    		String HTML = results.toString();
	            //font change from html to px
	            HTML = DB_Template.searchReplace(HTML,"size=\"-1\"","size=4");
	            HTML = DB_Template.searchReplace(HTML,"size=\"1\"","size=6");
	            HTML = DB_Template.searchReplace(HTML,"size=\"1.5\"","size=7");
	            HTML = DB_Template.searchReplace(HTML,"size=\"2\"","size=8");
	            HTML = DB_Template.searchReplace(HTML,"size=\"2.25\"","size=9");
	            HTML = DB_Template.searchReplace(HTML,"size=\"2.5\"","size=10");
	            HTML = DB_Template.searchReplace(HTML,"size=\"3\"","size=12");
	            HTML = DB_Template.searchReplace(HTML,"size=\"4\"","size=16");
	            HTML = DB_Template.searchReplace(HTML,"size=\"5\"","size=20");
	            HTML = DB_Template.searchReplace(HTML,"size=\"6\"","size=24");
	            HTML = DB_Template.searchReplace(HTML,"size=\"7\"","size=28");
	
				String headerHTML	= ""; 
				String headerHTML2	= ""; 
				String headerHTML3	= ""; 
				
		            if(SRC_URL.equalsIgnoreCase("pop_cn_fwhs_preview.jsp") || SRC_URL.equalsIgnoreCase("pop_cn_fwhs_end_preview.jsp")) 
		            {             	
						String CLASS_DESCP="";
						SQL = "SELECT CLASS,PRINCIPLE FROM "+table+" WHERE UKEY = '"+CNCODE_PDF+"' WITH UR";
				        DB_Template.makeConnection();
				        DB_Template.executeQuery(SQL);
				        while(DB_Template.getNextQuery())
				        {
				            CLASS         = common.setNullToString(DB_Template.getColumnString("CLASS"));
				            PRINCIPLE     = common.setNullToString(DB_Template.getColumnString("PRINCIPLE"));
				        }
						DB_Template.takeDown();
						
						//get the class description
						SQL = "SELECT * FROM TB_CLS WHERE INSCODE = '"+PRINCIPLE+"' AND DECLINE <> 'Y' AND CODE = '"+CLASS+"' WITH UR";
						DB_Template.makeConnection();
				        DB_Template.executeQuery(SQL);
				        while(DB_Template.getNextQuery())
				        {
				            CLASS_DESCP         = common.setNullToString(DB_Template.getColumnString("DESCP"));
				        }
						DB_Template.takeDown();
						String PAGE1 = common.setNullToString((String)session.getAttribute("SES_PAGE1"));
						if(PRINCIPLE.equals("08") && PAGE1.equals("")){
						headerHTML ="<table cellspacing='0' cellpadding='0' border='0' width='100%'>";
						headerHTML +="<tr>";
						headerHTML+="<td width='86%' valign='top'></td>";
						headerHTML+="<td width='14%' valign='top'><img src='../common/jpg/getjpg.jsp?fn=/stamp-duty2.gif' leading='-4' width='70' height='12'><font face='Arial' size='6'><br>"+REF_MAINPAGE+"<br>"+REF_MAINPAGE1;					
						headerHTML+="</font></td>";
						
						headerHTML+="</tr>";
						headerHTML+="</table>";
						headerHTML+="<table cellspacing='1' cellpadding='0' width='100%' border='0' bordercolor='#000000'>";
						headerHTML+="<tr>";
						headerHTML+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><b>"+common.stringToHTMLString(CATEGORYMSG)+"</b></font></td>";
						headerHTML+="</tr>";
						headerHTML+="<tr>";
						headerHTML+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><i>"+common.stringToHTMLString(CATEGORYMSG1)+"</i></font></td></tr>";
						headerHTML+="<br><tr><td align='left' width='100%' valign='bottom'><font face='Arial' size='8'><br><br>"+HEADER1+"<i>"+HEADER2+"</i></font></td></tr>";
						headerHTML+="</table>";
					}
					
					if(PRINCIPLE.equals("08")){
						headerHTML2 ="<table valign='bottom' border='0' width='100%'>";
						headerHTML2 +="<tr>";
						headerHTML2+="<td width='78%' valign='top'></td>";
						headerHTML2+="<td width='14%' valign='top'></td>";
						headerHTML2+="<td width='8%' align='center'></td>";
						headerHTML2+="</tr>";
						headerHTML2+="</table>";
						headerHTML2+="<table cellspacing='1' cellpadding='0' width='100%' border='0' bordercolor='#000000'>";
						headerHTML2+="<tr>";
						headerHTML2+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><b>"+common.stringToHTMLString(CATEGORYMSG)+"</b></font></td>";
						headerHTML2+="</tr>";
						headerHTML2+="<tr>";
						headerHTML2+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><i>"+common.stringToHTMLString(CATEGORYMSG1)+"</i></font></td></tr>";					
						headerHTML2+="<br><tr><td align='left' width='100%' valign='bottom'><font face='Arial' size='8'><br><br>"+HEADER3+"<i>"+HEADER4+" "+CNOTE+"</i></font></td></tr>";
						headerHTML2+="</table>";
					}
					
	            } 
	            else 
	            {
	            	headerHTML3 ="<table valign='bottom' border='0' width='100%'>";
					headerHTML3 +="<tr>";
					headerHTML3+="<td width='78%' valign='top'></td>";
					headerHTML3+="<td width='14%' valign='top'></td>";
					headerHTML3+="<td width='8%' align='center'></td>";
					headerHTML3+="</tr>";
					headerHTML3+="</table>";
					
	            }
	            if(SRC_URL.equalsIgnoreCase("pop_cn_fwhs_end_preview.jsp"))
	            {
		            headerHTML ="<table cellspacing='0' cellpadding='0' border='0' width='100%'>";
					headerHTML +="<tr>";
					headerHTML+="<td width='86%' valign='top'></td>";
					headerHTML+="<td width='14%' valign='top'><font face='Arial' size='6'><br>"+REF_MAINPAGE+"<br>"+REF_MAINPAGE1;
					headerHTML+="</font></td>";
					headerHTML+="</tr>";
					headerHTML+="</table>";
					headerHTML+="<table cellspacing='1' cellpadding='0' width='100%' border='0' bordercolor='#000000'>";
					headerHTML+="<tr>";
					headerHTML+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><b>"+common.stringToHTMLString(CATEGORYMSG)+"</b></font></td>";
					headerHTML+="</tr>";
					headerHTML+="<tr>";
					headerHTML+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><i>"+common.stringToHTMLString(CATEGORYMSG1)+"</i></font></td></tr>";				
					headerHTML+="<br><tr><td align='left' width='100%' valign='bottom'><font face='Arial' size='8'><br><br>"+HEADER1+"<i>"+HEADER2+"</i></font></td></tr>";
					headerHTML+="</table>";
	            }
	
	            if (LANGUAGE.equalsIgnoreCase("chinese"))
	                RP_html2pdf.generateHtml(SESUSERID + "-FWHS-" + CNCODE_PDF + ".pdf",HTML,"chinese","PORTRAIT","","<p align='center'>Page %%Currentpagenumber%</p>");
	            else
	            { 
	            
					String footer1	= "<table width='100%'><tr><td width='100%'></td><tr></table>"+
									"<table width='100%'><tr valign='bottom'><td width='34%'></td><td width='34%' align='center'><font face='Arial, Helvetica, sans-serif' size='6'>Page %%Currentpagenumber%</font></td><td width='33%' align='right'><font face='Arial, Helvetica, sans-serif' size='6'></font></td><tr></table>";
					String footer2	= "<table width='100%'><tr><td width='100%'></td><tr></table>"+
										"<table width='100%'><tr valign='bottom'><td width='34%'></td><td width='34%' align='center'><font face='Arial, Helvetica, sans-serif' size='6'>Page %%Currentpagenumber%</font></td><td width='33%' align='right'><font face='Arial, Helvetica, sans-serif' size='6'></font></td><tr></table>";
		
					String footer3	= "<table width='100%'><tr><td width='100%'></td><tr></table>";
		
					if(!SUBCODE.equals(""))
					{
						footer1	= "<table width='100%'><tr><td width='100%' colspan='3'><font face='Arial, Helvetica, sans-serif' size='6'>"+SUBCODE+"</font></td></tr>"+
								  "<tr valign='bottom'><td width='34%'></td><td width='34%' align='center'><font face='Arial, Helvetica, sans-serif' size='6'>Page %%Currentpagenumber%</font></td><td width='33%' align='right'><font face='Arial, Helvetica, sans-serif' size='6'></font></td></tr></table>";
						footer2	= "<table width='100%'><tr><td width='100%' colspan='3'><font face='Arial, Helvetica, sans-serif' size='6'>"+SUBCODE+"</font></td></tr><tr><td width='100%'></td></tr></table>"+
								  "<table width='100%'><tr valign='bottom'><td width='34%'></td><td width='34%' align='center'><font face='Arial, Helvetica, sans-serif' size='6'>Page %%Currentpagenumber%</font></td><td width='33%' align='right'><font face='Arial, Helvetica, sans-serif' size='6'></font></td></tr></table>";
					
					}
					if(WITHOUTLOGO.equals("Y"))
					{
						if(!SUBCODE.equals(""))
						{
							footer1	= "<table width='100%'><tr><td width='100%'><font face='Arial, Helvetica, sans-serif' size='6'>"+SUBCODE+"</font></td><tr></table>";
							footer2	= footer1;
						
						}
						else
						{
							footer1 = "";
							footer2	= "";
							footer3	= "";
						}
					}
					String PAGE1 = common.setNullToString((String)session.getAttribute("SES_PAGE1"));
					if(WITHOUTLOGO.equals("Y") && PAGE1.equals(""))
					{	
						headerHTML ="<table valign='bottom' border='0' width='100%'>";
						headerHTML +="<tr>";
						headerHTML+="<td width='86%' valign='top'><img src='../common/jpg/getjpg.jsp?fn=/hp_spacer.gif' height='60' width='128' align='left'></td>";
						headerHTML+="<td width='14%' valign='top'><img src='../common/jpg/getjpg.jsp?fn=/stamp-duty2.gif' leading='-4' width='70' height='12'><font face='Arial' size='6'><br>"+REF_MAINPAGE+"<br>"+REF_MAINPAGE1;
						headerHTML+="</font></td>";
						
						headerHTML+="</tr>";
						headerHTML+="</table>";
						headerHTML+="<table cellspacing='1' cellpadding='0' width='100%' border='0' bordercolor='#000000'>";
						headerHTML+="<tr>";
						headerHTML+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML+="</tr>";
						headerHTML+="<tr>";
						headerHTML+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML+="</tr>";
		
						headerHTML+="<tr>";
						headerHTML+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML+="</tr>";
						headerHTML+="<tr>";
						headerHTML+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML+="</tr>";
						headerHTML+="<tr>";
						headerHTML+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML+="</tr>";
						headerHTML+="<tr>";
						headerHTML+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><b>"+common.stringToHTMLString(CATEGORYMSG)+"</b></font></td>";
						headerHTML+="</tr>";
						headerHTML+="<tr>";
						headerHTML+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><i>"+common.stringToHTMLString(CATEGORYMSG1)+"</i></font></td></tr>";
						headerHTML+="<br><tr><td align='left' width='100%' valign='bottom'><font face='Arial' size='8'><br><br>"+HEADER1+"<i>"+HEADER2+"</i></font></td></tr>";
						headerHTML+="</table>";
					}
					if(WITHOUTLOGO.equals("Y"))
					{
						headerHTML2 ="<table valign='bottom' border='0' width='100%'>";
						headerHTML2 +="<tr>";
						headerHTML2+="<td width='78%' valign='top'><img src='../common/jpg/getjpg.jsp?fn=/hp_spacer.gif' height='60' width='128' align='left'></td>";
						headerHTML2+="<td width='14%' valign='top'></td>";
						headerHTML2+="<td width='8%' align='center'></td>";
						headerHTML2+="</tr>";
						headerHTML2+="</table>";
						headerHTML2+="<table cellspacing='1' cellpadding='0' width='100%' border='0' bordercolor='#000000'>";
						headerHTML2+="<tr>";
						headerHTML2+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML2+="</tr>";
						headerHTML2+="<tr>";
						headerHTML2+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML2+="</tr>";
		
						headerHTML2+="<tr>";
						headerHTML2+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML2+="</tr>";
						headerHTML2+="<tr>";
						headerHTML2+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML2+="</tr>";
						headerHTML2+="<tr>";
						headerHTML2+="<td align='left' width='100%' valign='bottom'></td>";
						headerHTML2+="</tr>";
						headerHTML2+="<tr>";
						headerHTML2+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><b>"+common.stringToHTMLString(CATEGORYMSG)+"</b></font></td>";
						headerHTML2+="</tr>";
						headerHTML2+="<tr>";
						headerHTML2+="<td align='center' width='100%' valign='bottom'><font face='Arial' size='12'><i>"+common.stringToHTMLString(CATEGORYMSG1)+"</i></font></td></tr>";					
						headerHTML2+="<br><tr><td align='left' width='100%' valign='bottom'><font face='Arial' size='8'><br><br>"+HEADER3+"<i>"+HEADER4+" "+CNOTE+"</i></font></td></tr>";
						headerHTML2+="</table>";
					}
					
					if(SRC_URL.equals("pop_cn_fwhs_end_preview.jsp"))
					{
						if(WITHOUTLOGO.equals("Y"))
				    		RP_html2pdf.generateHtml_custom_footer2(SESUSERID + "-FWHS-" + CNCODE_PDF + ".pdf",HTML,"english","PORTRAIT",headerHTML,headerHTML2,footer2, footer1,logo_height,"90","90");
				    	else
				    		RP_html2pdf.generateHtml_custom_footer2(SESUSERID + "-FWHS-" + CNCODE_PDF + ".pdf",HTML,"english","PORTRAIT",headerHTML,headerHTML2,footer2, footer1,logo_height2,"65","30");
					}
					else
					{
						String testHTML = HTML;
						ArrayList alHTML = new ArrayList();
						int idxHTML 	=0;
						int idxHTML2 	=0;
						int idxHTML3 	=0;
		
						if(testHTML.length()>0){ 			
							idxHTML2 = testHTML.indexOf("<PAGEBREAK_PRO></PAGEBREAK_PRO>");
							idxHTML3 = testHTML.indexOf("<PAGEBREAK_INC></PAGEBREAK_INC>");
							if(idxHTML2 > 0)
							{					
							
								String testHTML2 = testHTML.substring(idxHTML+12, idxHTML2);
								alHTML.add("<html>" + testHTML2+"</html>");	
								
								idxHTML = testHTML.indexOf("</PAGEBREAK_PRO>");
								testHTML2 = testHTML.substring(idxHTML+16, idxHTML3);
								if(testHTML2.length()>0){ 
									alHTML.add(testHTML2);
								}
								
								idxHTML = testHTML.indexOf("</PAGEBREAK_INC>");
								testHTML2 = testHTML.substring(idxHTML+16, testHTML.length());
								if(testHTML2.length()>0){ 
									alHTML.add(testHTML2);
								}
							}
							else
							{
								if(idxHTML3 > 0)
								{
									String testHTML3 = testHTML.substring(idxHTML+12, idxHTML3);
									alHTML.add("<html>" + testHTML3+"</html>");	
									idxHTML = testHTML.indexOf("</PAGEBREAK_INC>");
									testHTML = testHTML.substring(idxHTML+16, testHTML.length());
									if(testHTML.length()>0){ 
										alHTML.add("");
										alHTML.add(testHTML);
									}
								}
								else
								{
									if(testHTML.length()>0){ 
										alHTML.add(testHTML);
									}
								}
							}
							
						}									
						// end break HTML
						
						
						// decide watermark for each page
						for(int len=0; len < alHTML.size(); len++){
							String curr = (String) alHTML.get(len);
		                    if(curr.equals(""))
		                    {
		                    }
		                    else
		                    {
								if(len==0){
									if(WITHOUTLOGO.equals("Y"))			
										RP_html2pdf.generateHtml_custom_footer2(SESUSERID + "-FWHS-" + CNCODE_PDF + "pg"+len+".pdf",curr,"english","PORTRAIT",headerHTML,headerHTML2,footer2, footer1,logo_height,"90","90");
									else
										RP_html2pdf.generateHtml_custom_footer2(SESUSERID + "-FWHS-" + CNCODE_PDF + "pg"+len+".pdf",curr,"english","PORTRAIT",headerHTML,headerHTML2,footer2, footer1,logo_height2,"65","30");
								}else if(len==2){
									if(WITHOUTLOGO.equals("Y"))			
										RP_html2pdf.generateHtml_custom_footer2(SESUSERID + "-FWHS-" + CNCODE_PDF + "pg"+len+".pdf",curr,"english","PORTRAIT","","",footer3, footer3,"10","90","90");
									else
										RP_html2pdf.generateHtml_custom_footer2(SESUSERID + "-FWHS-" + CNCODE_PDF + "pg"+len+".pdf",curr,"english","PORTRAIT","","",footer3, footer3,"10","65","30");
								}
								else
								{
									if(WITHOUTLOGO.equals("Y"))	
										RP_html2pdf.generateHtml_custom_footer2(SESUSERID + "-FWHS-" + CNCODE_PDF + "pg"+len+".pdf",curr,"english","PORTRAIT",headerHTML,headerHTML2,footer2, footer1,logo_height,"90","90");
									else
										RP_html2pdf.generateHtml_custom_footer2(SESUSERID + "-FWHS-" + CNCODE_PDF + "pg"+len+".pdf",curr,"english","PORTRAIT",headerHTML,headerHTML2,footer2, footer1,logo_height2,"65","30");
								}
							}
						}
						//end decide watermark			
						
						// code to combine all pdf into 1 file
					    FileInputStream istest = new FileInputStream("/easc/configk.prop");
					    Properties proptest = new Properties();
					    proptest.load(istest);
					    String TEMP_PATH = proptest.getProperty("temp_path");
		    			
						PdfReader readerPage = new PdfReader(TEMP_PATH + "/" + SESUSERID + "-FWHS-" + CNCODE_PDF + "pg0.pdf");    
						Rectangle pagesize = readerPage.getPageSize(1);    
							
					    Document document = new Document(pagesize);					    
					    
					    PdfWriter Pdfwriter = PdfWriter.getInstance(document, new FileOutputStream(TEMP_PATH + "/" + SESUSERID + "-FWHS-" + CNCODE_PDF + ".pdf"));
					    document.open();
						PdfContentByte cb = Pdfwriter.getDirectContent();	
					            	
						for(int comb=0 ; comb < alHTML.size(); comb++){
							String curr = (String) alHTML.get(comb);
							if(curr.equals(""))
							{
							}
							else
							{
								PdfReader readerInner = new PdfReader(TEMP_PATH + "/" + SESUSERID + "-FWHS-" + CNCODE_PDF + "pg"+comb+".pdf");
								int ttlpage = readerInner.getNumberOfPages();
								for(int innersub=1 ; innersub <= ttlpage ; innersub++ )
								{
									PdfImportedPage pageInner = Pdfwriter.getImportedPage(readerInner, innersub);
									cb.addTemplate(pageInner, .5f, 0);	
									
									document.newPage();
								}	
							}			
						}					
						
						document.close();		
						// end combine file
						
						// remove the temporary file and remain the combine file				
						for(int remove = 0 ; remove < alHTML.size(); remove ++){
							String curr = (String) alHTML.get(remove);
							if(curr.equals(""))
							{
							}
							else
							{
								File tempfile = new File(TEMP_PATH + "/" + SESUSERID + "-FWHS-" + CNCODE_PDF + "pg"+remove+".pdf");
								if (tempfile.exists()){
									tempfile.delete();
								}
							}
						}
		    		} 
		    	}
		    }
		    if(ePLKS_MCN.equals("Y") || !FWCMSREF.equals("")){
		    	
		    	System.out.println("ePLKS_MCN prod issue: " + ePLKS_MCN);
		    	System.out.println("FWCMSREF prod issue: " + FWCMSREF);
	    		String UKEY_PDF	= CNCODE; 
		    	if(vCNCODE.size()>0){
		    		UKEY_PDF	= (String) vCNCODE.elementAt(0);
		    	}
	    		UKEY_PDF 		= PRINCIPLE+UKEY_PDF;
		    	// code to combine all pdf into 1 file
			    FileInputStream istest = new FileInputStream("/easc/configk.prop");
			    Properties proptest = new Properties();
			    proptest.load(istest);
			    String TEMP_PATH = proptest.getProperty("temp_path");

				PdfReader readerPage = new PdfReader(TEMP_PATH + "/" + SESUSERID + "-FWHS-" + UKEY_PDF + ".pdf");    
				Rectangle pagesize = readerPage.getPageSize(1);    
					
			    Document document = new Document(pagesize);					    
			    
			    PdfWriter Pdfwriter = PdfWriter.getInstance(document, new FileOutputStream(TEMP_PATH + "/" + SESUSERID + "-FWHS-" + FWCMSREF + ".pdf"));
			    document.open();
				PdfContentByte cb = Pdfwriter.getDirectContent();	
			    
			    for(int k = 0 ; k < vCNCODE.size(); k++){	
			    	String UKEY_PDF_temp	= (String) vCNCODE.elementAt(k); 
			    	UKEY_PDF_temp = PRINCIPLE+UKEY_PDF_temp;				

					PdfReader readerInner = new PdfReader(TEMP_PATH + "/" + SESUSERID + "-FWHS-" + UKEY_PDF_temp + ".pdf");
					int ttlpage = readerInner.getNumberOfPages();
					for(int innersub=1 ; innersub <= ttlpage ; innersub++ )
					{
						PdfImportedPage pageInner = Pdfwriter.getImportedPage(readerInner, innersub);
						cb.addTemplate(pageInner, .5f, 0);	
						
						document.newPage();
					}	
				}
				document.close();		
				// end combine file
				
				for(int k = 0 ; k < vCNCODE.size(); k++){	
			    	String UKEY_PDF_temp	= (String) vCNCODE.elementAt(k); 	
			    	UKEY_PDF_temp 			= PRINCIPLE+UKEY_PDF_temp;								
					File tempfile = new File(TEMP_PATH + "/" + SESUSERID + "-FWHS-" + UKEY_PDF_temp + ".pdf");
					if (tempfile.exists()){
						tempfile.delete();
					}
				}

				
	    	}
		    	
	
		    	//FWCMS Update Details Transaction
		    	if(!FWCMSREF.equals("") && !BUTTONIND.equals("D") && !SUBMITIND.equals("N"))
		    	{
			    	boolean fwcms_details 		= true;
			    	String acknowledgementCode 	= "";
			    	String ERROR_DESCP 			= "";
			    	String INSTYPE				= "H";
			    	
				    DB_Contact.makeConnection();
				    SQL = "SELECT * FROM TB_FWCMS_TRANS WHERE REFNO='"+FWCMSREF+"' AND INSCODE='"+PRINCIPLE+"' AND TRANS_TYPE='D' AND RESP_CODE='S' WITH UR";
				    DB_Contact.executeQuery(SQL);
				    while(DB_Contact.getNextQuery())
				    {
				        fwcms_details = false;
				    }
				   	DB_Contact.takeDown();     	
 
			    	if(fwcms_details)
			    	{
			    		BestinetXML.makeConnection();
				    	acknowledgementCode = BestinetXML.FWCMS_detailsRequest(CNCODE,FWCMSREF,PRINCIPLE,CNCODE.substring(2),INSTYPE,"D",SESUSERID,ACCODE,RESP_STATUS,ResponseCode,BUSINESS_NO,"",ePLKS_MCN);
				    	BestinetXML.takeDown();
				    	  
					    if(!acknowledgementCode.equals(""))
						{
						    DB_Contact.makeConnection();
						    SQL = "SELECT DESCP FROM TB_FWCMS_ERROR where CODE='"+acknowledgementCode+"' WITH UR";
						    DB_Contact.executeQuery(SQL);
						    while(DB_Contact.getNextQuery())
						    {
						        ERROR_DESCP    = common.setNullToString(DB_Contact.getColumnString("DESCP"));
						    }
						    DB_Contact.takeDown(); 
						      			
						%>
							<script language="Javascript">
								alert("<%=ERROR_DESCP%>");
								window.close();
							</script>
						<%  
						}
					}
				}  	    	
	    	}       
	    } 
	    catch (Exception e) 
	    {
		    e.printStackTrace();
	    }
	}
    
	if(TYPE.equals("QUOEMAIL"))
	{  
	    prop.load(is);
        String border 	= "0";
	    String width1 	= "100%";
	    String face   	= "Verdana, Geneva, sans-serif";
	    String size1  	= "2";
	    String size2  	= "1";
		String TITLE	= "e-Cover: Insurance Documents";
		
		String BODY  = "<html><body>"+
	                 "<table width="+width1+" border="+border+">"+
	                 "<tr><td width="+width1+"><font face="+face+" size="+size1+">&#34;Greetings from e-Cover.<br/><br/></font></td></tr>"+             
	                 "<tr><td width="+width1+"><font face="+face+" size="+size1+">This is an automated notification on a document requested as attached.<br/><br/></font></td></tr>"+                           
	                 "<tr><td width="+width1+"><font face="+face+" size="+size1+">For more information, please visit <a href='www.e-cover.com.my'>www.e-cover.com.my</a>.<br/><br/></td></tr>"+             
	                 "<tr><td width="+width1+"><font face="+face+" size="+size2+">*** Please do not respond to this email. ***<br/><br/></td></tr>"+       
	                 "<tr><td width="+width1+"><font face="+face+" size="+size1+">Regards,</font></td></tr>"+                         
	                 "<tr><td width="+width1+"><font face="+face+" size="+size1+">e-Cover Department&#34;</font></td></tr>"+                   
	                 "</table>"+
	                 "</body></html>";
	                 
		try{
			mailsender.setFrom(EMAIL_FROM);
			mailsender.setAttachment(FILE_PATH);
            mailsender.sendIt(EMAIL_TO.trim(), TITLE, BODY);
           
		}catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		}
	}

	for(int k = 0 ; k < vCNCODE.size(); k++){
	
	String temp_CNCODE	= (String) vCNCODE.elementAt(k); 
	String sXML = "";
	String temp_CNCODE1 = "08" + temp_CNCODE;
	
	boolean UUID_found = false;		
	boolean longID_found = false;
	boolean UUID2_found = false;		
	boolean longID2_found = false;
	String NEW_GST_TAX_NO = "";
	String NEW_GST_TAX_NO_END = "";
	String myQuery = "SELECT GST_TAX_NO, GST_TAX_NO_END FROM TB_GST_CN WHERE UKEY='" + temp_CNCODE1 + "' WITH UR";
	DB_Template.makeConnection();
	DB_Template.executeQuery(myQuery);
		if(DB_Template.getNextQuery()){
			NEW_GST_TAX_NO = common.setNullToString(DB_Template.getColumnString("GST_TAX_NO"));
			NEW_GST_TAX_NO_END = common.setNullToString(DB_Template.getColumnString("GST_TAX_NO_END"));
		}
		
		if(!NEW_GST_TAX_NO.equals("")){
			myQuery = "SELECT UUID FROM TB_EINVOICE_SUBMIT_DOCLOG WHERE CODE_NUMBER='" + NEW_GST_TAX_NO + "' WITH UR";
			DB_Template.executeQuery(myQuery);
			if(DB_Template.getNextQuery()){
				UUID_found = true;
			}
			
			myQuery = "SELECT * FROM TB_EINVOICE_GET_DOCLOG WHERE CODE_NUMBER='" + NEW_GST_TAX_NO + "' WITH UR";
			DB_Template.executeQuery(myQuery);
			if(DB_Template.getNextQuery()){
				longID_found = true;
			}
		}
		
		// Credit Note
		if(!NEW_GST_TAX_NO_END.equals("")){
			myQuery = "SELECT UUID FROM TB_EINVOICE_SUBMIT_DOCLOG WHERE CODE_NUMBER='" + NEW_GST_TAX_NO_END + "' WITH UR";
			DB_Template.executeQuery(myQuery);
			if(DB_Template.getNextQuery()){
				UUID2_found = true;
			}
			
			myQuery = "SELECT * FROM TB_EINVOICE_GET_DOCLOG WHERE CODE_NUMBER='" + NEW_GST_TAX_NO_END + "' WITH UR";
			DB_Template.executeQuery(myQuery);
			if(DB_Template.getNextQuery()){
				longID2_found = true;
			}
		}
		
		DB_Template.takeDown();
		
		if((!UUID_found && !longID_found) || (!UUID2_found && !longID2_found)){
			//GENERATE API JSON THING
			Vector vGenerateHash = new Vector();
			
			SignInvoiceUtil.makeConnection();
			String GenerateHash = SignInvoiceUtil.generateDocument(temp_CNCODE1,"TB_FWHSCN","TB_FWHSSCH","TB_GST_CN"); 
			SignInvoiceUtil.takeDown();
			vGenerateHash.add(GenerateHash);
			
			
			Vector vSubmitDocument = new Vector();
	
			for(int i = 0; i < vGenerateHash.size(); i++){
			String format = "JSON";
			String generateHash = (String) vGenerateHash.get(i);
			String docHash = "";
			String invoiceCode = "";
			String document = "";
			
			String[] lines = generateHash.split("\n");
	
			for (String line : lines) {
			    line = line.trim();  // Remove leading/trailing whitespace
			    if (line.startsWith("invoiceCode")){
			    	invoiceCode = line.split(":", 2)[1].trim();
			    }else if (line.startsWith("base64")) {
			        document = line.split(":", 2)[1].trim();
			    } else if (line.startsWith("sha256")) {
			        docHash = line.split(":", 2)[1].trim();
			    }
			}
			
			String SubmitDocument = eInvoice.submitDocument("08", format, docHash, invoiceCode, document,"NW");
			vSubmitDocument.add(SubmitDocument);
			
			 try {
		        Thread.sleep(1000);
		    } catch (InterruptedException e) {
		        Thread.currentThread().interrupt();  // Restore interrupted status
		        e.printStackTrace();
		    }
		    
			}
			
			for(int i = 0; i < vSubmitDocument.size(); i++){
			
				String submitDocument = (String) vSubmitDocument.get(i);
				String UUID = "";
				String INVOICE_CODE = "";
				
				String[] lines = submitDocument.split("\n");
			
				for (String line : lines) {
				    line = line.trim();  // Remove leading/trailing whitespace
				    if (line.startsWith("invoiceCode")){
				    	INVOICE_CODE = line.split(":", 2)[1].trim();
				    }else if (line.startsWith("UUID")) {
				        UUID = line.split(":", 2)[1].trim();
				    }
				}
				
			if(!UUID.equals("")){
			
				GetDocument getDocument = new GetDocument(UUID);
				
				String GetDocument = eInvoice.getDocument("08", INVOICE_CODE, getDocument, "NW");
				
				
				try {
			        Thread.sleep(1000);
			    } catch (InterruptedException e) {
			        Thread.currentThread().interrupt();  // Restore interrupted status
			        e.printStackTrace();
			    }
				    
				    }
			
			} 
		}
	}
	if(!TYPE.equals("")){%>
		<script>
			<%if(!error){
			System.out.println("FILE_NAME !error: " + FILE_NAME);%>
			window.open("/liberty/common/jpg/getPdf2.jsp?fn=<%=FILE_NAME%>&CUT_OFF=<%=CUT_OFF%>");
			<%}%>
			<%if(BUTTONIND.equals("C")){%>
				parent.location.href="/liberty/padmin/app/pa_listPolicy_NM.jsp";
			<%}else if(BUTTONIND.equals("D")){%>
				parent.location.href="pop_quoFWHS_generate_preview.jsp?STATUS=<%=STATUS%>&CNCODE=<%=CNCODE%>&CLASS=FWHS&BUTTONIND=J&QUICK_IND=<%=QUICK_IND%>&FWCMSREF=<%=FWCMSREF%>&FWCS_CONV_IND=<%=FWCS_CONV_IND%>&FWIG_CONV_IND=<%=FWIG_CONV_IND%>";
			<%}else{%>
				parent.location.href="pop_quoFWHS_generate_preview.jsp?STATUS=<%=STATUS%>&CNCODE=<%=CNCODE%>&CLASS=FWHS&BUTTONIND=P&QUICK_IND=<%=QUICK_IND%>&FWCMSREF=<%=FWCMSREF%>&FWCS_CONV_IND=<%=FWCS_CONV_IND%>&FWIG_CONV_IND=<%=FWIG_CONV_IND%>&ePLKS_MCN=<%=ePLKS_MCN%>";
			<%}%>
		</Script>
	<%}%>
</body>
</html>