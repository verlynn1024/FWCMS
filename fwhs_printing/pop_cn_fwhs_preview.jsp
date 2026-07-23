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
	String OCCUPATION_DESC			= "";
	String OCCUPATION_CODE			= "";
	String ISSDATE					= "";	
	String EFFDATE					= "";
	String EXPDATE					= "";	
	String CLASS    				= "";
	String MAINCLS					= common.setNullToString(request.getParameter("CLASS"));
	if(MAINCLS.equals(""))
		MAINCLS = "FWHS";
		
	String TRADE					= "";
	String MASTERPOL				= "";
	String MASTERIND				= "";
	String PROPOSAL_DATE			= "";
	String CNTYPE				 	= "";
	String NEW_IC_NO				= "";
	String OLD_IC_NO				= "";
	String BUSINESS_NO				= "";
	String NATURE_BUSINESS			= "";
	String REPLACECN				= "";
    // TB_FWCSCN

	// TB_FWCSSCH
    String GPREM	 				= "";
    String STAXPCT					= "";
    String STAXAMT					= "";
    String SFEEAMT					= "";
    String SFW_FEEAMT				= "";
    String STAMPDUTY				= "";
    String TOTPREM	     			= "";
    String ORCAMT					= "";
    String LEVYAMT					= "";
    String REBATEPCT				= "";
    String REBATEAMT				= "";
    String FWCMSREFNO				= "";
    String CLAUSE					= "";
    
    // STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
	String STAMP_FEES				= "";
	// TB_FWCSSCH

	// TB_FWCSSUB
	String UKEY1 					= "";
	String SEQNO 					= "";
	String EMP_NAME 				= "";
	String OCCPSEC			     	= "";
	String DOB						= "";
	String GENDER					= "";
	String PASSPORT					= "";
	String NATIONALITY				= "";
	String WORK_EXP					= "";
	String EMP_PLACE				= "";
	
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
    String STATUS					= "";
    // TB_USER
    Date today						= new Date();
	Date SST_EFFDATE;
	Date CLAUSE_EFFDATE;
    //TB_AGENT_AM
    String INTERMEDIARY_IND			= "";
    //TB_AGENT_AM
    
	String WMFWIS		= common.setNullToString((String) session.getAttribute("SES_WMFWIS"));
	String CATEGORYMSG 				= "";
	String CATEGORYMSG1				= "";
	String REF_MAINPAGE				= "";
	String REF_MAINPAGE1			= "";
	int iLINECNT					= 55;
	String SQL						= "";
	
	String CFMKT_IND 				= "";
    String CONTACT_TYPE				= "";
	
    SimpleDateFormat timestampFormat 	= new SimpleDateFormat("yyyyMMddHHmmss");
    SimpleDateFormat timestampFormat2 	= new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat timestampFormat3 	= new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat timestampFormat4 	= new SimpleDateFormat("hh:mm:ssa");
    SimpleDateFormat timestampFormat5 	= new SimpleDateFormat("dd-MM-yyyy / hh:mm:ssa");
    SimpleDateFormat checkdigitformat 	= new SimpleDateFormat("MMdd");
    DecimalFormat df = new DecimalFormat("00");
    //added by Gopi to determine pdf print / preview
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
        SQL = "SELECT * FROM TB_"+MAINCLS+"CN WHERE UKEY = '" + CNCODE + "' WITH UR";
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
			OCCUPATION_DESC		= common.setNullToString(DB_Template.getColumnString("OCCUPATION_DESC"));
			OCCUPATION_CODE		= common.setNullToString(DB_Template.getColumnString("OCCUPATION_CODE"));
			ISSDATE				= common.setNullToString(DB_Template.getColumnString("ISSDATE"));
			EFFDATE				= common.setNullToString(DB_Template.getColumnString("EFFDATE"));
			EXPDATE				= common.setNullToString(DB_Template.getColumnString("EXPDATE"));
			CLASS				= common.setNullToString(DB_Template.getColumnString("CLASS"));
			ISSTIME				= common.setNullToString(DB_Template.getColumnString("CNTIME"));
			TRADE				= common.setNullToString(DB_Template.getColumnString("TRADE"));
			MASTERPOL			= common.setNullToString(DB_Template.getColumnString("MASTERPOL"));
			MASTERIND			= common.setNullToString(DB_Template.getColumnString("MASTERIND"));
			PROPOSAL_DATE		= common.setNullToString(DB_Template.getColumnString("PROPOSAL_DATE"));
			CNTYPE				= common.setNullToString(DB_Template.getColumnString("CNTYPE"));
			BUSINESS_NO			= common.setNullToString(DB_Template.getColumnString("BUSINESS_NO"));
			NEW_IC_NO			= common.setNullToString(DB_Template.getColumnString("NEW_IC_NO"));
			OLD_IC_NO			= common.setNullToString(DB_Template.getColumnString("OLD_IC_NO"));
			NATURE_BUSINESS		= common.setNullToString(DB_Template.getColumnString("NATURE_BUSINESS"));
			CONTACT_TYPE    	= common.setNullToString(DB_Template.getColumnString("CONTACT_TYPE"));
			REPLACECN			= common.setNullToString(DB_Template.getColumnString("REPLACECN"));
			STATUS				= common.setNullToString(DB_Template.getColumnString("STATUS"));
        }
		DB_Template.takeDown();
		
		if (NEW_IC_NO.equals(""))
		{
			NEW_IC_NO = OLD_IC_NO;	
		}
		
		if (NEW_IC_NO.equals(""))
		{
			NEW_IC_NO = BUSINESS_NO;	
		}
		
		SQL = "SELECT * FROM TB_AGENT_AM WHERE ACCODE = '"+ACCODE+"'WITH UR";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		while(DB_Template.getNextQuery())
		{
			INTERMEDIARY_IND =common.setNullToString(DB_Template.getColumnString("INTERMEDIARY_IND"));
			
		}
		DB_Template.takeDown();
				
		
		SQL	= "SELECT DESCP FROM TB_NMOCCUPATION WHERE CODE = '"+NATURE_BUSINESS+"' AND INSCODE = '"+PRINCIPLE+"' AND MAINCLS = 'IG' WITH UR";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		if(DB_Template.getNextQuery())
			OCCUPATION_CODE	= common.setNullToString(DB_Template.getColumnString("DESCP"));
		DB_Template.takeDown();			
		
		if ( OCCUPATION_DESC.equals("") || OCCUPATION_DESC.equals("-"))
		{
			OCCUPATION_DESC = OCCUPATION_CODE;
		}

		// STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
        SQL = "SELECT * FROM TB_"+MAINCLS+"SCH WHERE UKEY2 = '" + UKEY + "' WITH UR";
        DB_Template.makeConnection();
        DB_Template.executeQuery(SQL);
        while(DB_Template.getNextQuery())
        {	
        	GPREM				= common.setNullToString(DB_Template.getColumnString("GPREM"));
        	STAXPCT				= common.setNullToString(DB_Template.getColumnString("STAXPCT"));
        	STAXAMT				= common.setNullToString(DB_Template.getColumnString("STAXAMT"));
        	SFEEAMT				= common.setNullToString(DB_Template.getColumnString("SERVICE_FEE"));
        	SFW_FEEAMT			= common.setNullToString(DB_Template.getColumnString("FWCMS_FEE"));
            STAMPDUTY      		= common.setNullToString(DB_Template.getColumnString("STAMPDUTY"));
            TOTPREM      		= common.setNullToString(DB_Template.getColumnString("NETPREM"));
            ORCAMT				= common.setNullToString(DB_Template.getColumnString("ORCAMT"));
            LEVYAMT				= common.setNullToString(DB_Template.getColumnString("LEVYAMT"));
            CFMKT_IND			= common.setNullToString(DB_Template.getColumnString("CFMKT_IND"));
            REBATEPCT			= common.setNullToString(DB_Template.getColumnString("REBATEPCT"));
        	REBATEAMT			= common.setNullToString(DB_Template.getColumnString("REBATEAMT"));
        	FWCMSREFNO			= common.setNullToString(DB_Template.getColumnString("FWCMSREFNO"));
        	CLAUSE				= common.setNullToString(DB_Template.getColumnString("POL_CLAUSE"));
        	STAMP_FEES			= common.setNullToString(DB_Template.getColumnString("STAMP_FEES"));
        }

		DB_Template.takeDown();
	    if(common.getKey(ACCODE,"-").length() < 6)
	    {
	    	if((ACCODE.substring(ACCODE.length()-3,ACCODE.length())).equalsIgnoreCase("-NM"))
	    	{
	    		ACCODEID	= ACCODE.substring(0,ACCODE.length()-3);
	    	}else{
	    		ACCODEID	= ACCODE;    	
	    	}
	    }
	    else
			ACCODEID 	= common.getKey(ACCODE,"-")+"-00";
		
		//for clauses
		String clause 			= "";
		Vector vClause_Warr		= new Vector();
		com.rexit.easc.StringTokenizer st1	= new com.rexit.easc.StringTokenizer(CLAUSE,"^","",true);
		while(st1.hasMoreTokens())
		{				
			Vector vRow		= new Vector();
			clause			= st1.nextToken();
			vRow.addElement(clause);
			vClause_Warr.addElement(vRow);
		}
		
		// STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0]
		boolean showStampFees = false;
		if(STAMP_FEES.equals("10.00")){
			showStampFees = true;
		}
		
		String DESCP = "";
		String NARRATION = "";
		if(vClause_Warr!=null)
		{
			for(int i=0; i<vClause_Warr.size(); i++)
			{
				Vector vItemNo			= (Vector) vClause_Warr.elementAt(i);
				String sClause_Warr		= (String) vItemNo.elementAt(0);
		        SQL = "SELECT * FROM TB_NMCLAUSE WHERE CODE = '"+sClause_Warr+"' AND INSCODE='"+PRINCIPLE+"' AND MAINCLS = 'WM' WITH UR";
		        DB_Template.makeConnection();
		        DB_Template.executeQuery(SQL);
		        if(DB_Template.getNextQuery())
		        {
		        	Vector vRow		= new Vector();
		        	
		        	DESCP = common.setNullToString(DB_Template.getColumnString("DESCP"));
		        	NARRATION 	= common.setNullToString(DB_Template.getColumnString("NARRATION"));
		        	
		        	if(!DESCP.equals(""))
		        	{
		        		vItemNo.addElement(DESCP);
		        	}
		        	else
		        	{
		        		vItemNo.addElement("");
		        	}		
		        	
		        	if(!NARRATION.equals(""))
		        	{
		        		vItemNo.addElement(NARRATION);
		        	}
		        	else
		        	{
		        		vItemNo.addElement("");
		        	}
				}
				else
		    	{		    	
		    		vItemNo.addElement("");
		    		vItemNo.addElement("");
		    	}
				
				DB_Template.takeDown();
			}
		}

		//for Narration
		String CWCODE = "";
		String CWDESCP = "";
		Vector vNARRATION = new Vector();
		if(vClause_Warr!=null)
		{
			for(int i=0; i<vClause_Warr.size(); i++)
			{
				Vector vItemNo			= (Vector) vClause_Warr.elementAt(i);
				String sClause_Warr		= (String) vItemNo.elementAt(0);
				Vector vRow				= new Vector();
			        SQL = "SELECT DESCP,NARRATION FROM TB_NMCLAUSE WHERE CODE = '"+sClause_Warr+"' AND INSCODE='"+PRINCIPLE+"' AND MAINCLS = 'BG' WITH UR";
				DB_Template.makeConnection();
				DB_Template.executeQuery(SQL);
				if(DB_Template.getNextQuery())
			        {	
			    	vRow.addElement(sClause_Warr);
			        	
			        	try { CWDESCP 	= common.setNullToString(DB_Template.getColumnString("DESCP"));} catch (Exception e) { CWDESCP = ""; };
			        	vRow.addElement(CWDESCP);
				        	
			        	try { NARRATION 	= common.setNullToString(DB_Template.getColumnString("NARRATION"));} catch (Exception e) { NARRATION = ""; };
			        	
			        	NARRATION	= common.searchReplace(NARRATION,"\n\n","^nbsp^nbsp");
			        	NARRATION	= common.searchReplace(NARRATION,"\n"," ");
			        	NARRATION	= common.searchReplace(NARRATION,"^nbsp^nbsp","\n\n");
			        	NARRATION	= common.searchReplace(NARRATION,"`","\n");
			        	int pos;
						while((pos = NARRATION.indexOf("  ")) > -1)
						{
						  	NARRATION = NARRATION.substring(0,pos)+NARRATION.substring(pos+1);
						}
			        	vRow.addElement(NARRATION.trim());
				}/* 			
				else		//202206 - Blocking Clause without Narration Description
			       	{
			      		vRow.addElement(sClause_Warr);
			       		vRow.addElement("");
			       		vRow.addElement("");
			       	} */
			       	if(!vRow.isEmpty()){
			       		vNARRATION.addElement(vRow);
			       	}
			       	/* if(PRINCIPLE.equals("08")){
				       	if(i==vClause_Warr.size()-1){
				       		Vector vTemp= new Vector();
				       		vTemp.addElement("GST");
				    		vTemp.addElement("GOODS & SERVICES TAX (GST)");
				   			vTemp.addElement("Goods and Services Tax (GST) will be imposed instead of Service Tax on the applicable portion of the premium due and payable upon GST implementation and where GST is applicable.");
				   			vNARRATION.addElement(vTemp);
						}
					} */
			       	DB_Template.takeDown();				
			}
		}
		//end for Narration
		
		SQL = "SELECT USERID FROM TB_ACNO_AM WHERE ACCODE = '" + ACCODEID + "' FETCH FIRST ROW ONLY WITH UR";
		//System.err.println("SQL [TB_ACNO] :: "+SQL);
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		while(DB_Template.getNextQuery())
		{
			ID = common.setNullToString(DB_Template.getColumnString("USERID"));					
		}
		DB_Template.takeDown();
		
		if(!ID.equals(""))						
			ACUSERID = common.getKey(ID,"-");				
		else
			ACUSERID = USERID;
		
		SQL = "SELECT * FROM TB_USER_AM WHERE USERID = '" + ACUSERID + "' WITH UR";
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
		if (!GPREM.equals(""))
			GPREM   	= common.twoDecimal(common.formatfloat(GPREM));
		
		if (!STAXPCT.equals(""))
			STAXPCT		= common.fnFormatNumber(STAXPCT,0);
		
		if (!STAXAMT.equals(""))
	    	STAXAMT 	= common.twoDecimal(common.formatfloat(STAXAMT));
	    	
	    if (!ORCAMT.equals(""))
	    	ORCAMT 	= common.twoDecimal(common.formatfloat(ORCAMT));
	    
	    if (!SFEEAMT.equals(""))
	    	//SFEEAMT		= common.twoDecimal(common.formatdouble(SFEEAMT)+common.formatdouble(SFW_FEEAMT)+common.formatdouble(LEVYAMT)); //remove sst for tpca
	    	SFEEAMT		= common.twoDecimal(common.formatdouble(SFEEAMT)+common.formatdouble(SFW_FEEAMT));
	    if (LEVYAMT.equals(""))
	    	LEVYAMT  	= "0.00";
	    	
	    if (!STAMPDUTY.equals(""))
	    	STAMPDUTY  	= common.twoDecimal(common.formatfloat(STAMPDUTY));
		if (!LEVYAMT.equals(""))
	    	LEVYAMT  	= common.twoDecimal(common.formatfloat(LEVYAMT));

	    if (!TOTPREM.equals(""))
			TOTPREM		= common.twoDecimal(common.formatfloat(TOTPREM));

        if(!ISSDATE.equals(""))
            ISSDATE = timestampFormat2.format(timestampFormat3.parse(ISSDATE));

        if(!EFFDATE.equals(""))
            EFFDATE = timestampFormat2.format(timestampFormat3.parse(EFFDATE));

        if(!EXPDATE.equals(""))
            EXPDATE = timestampFormat2.format(timestampFormat3.parse(EXPDATE));
        
        if(!PROPOSAL_DATE.equals(""))
            PROPOSAL_DATE = timestampFormat2.format(timestampFormat3.parse(PROPOSAL_DATE));
        
        if (!REBATEPCT.equals(""))
	    	REBATEPCT 	= common.twoDecimal(common.formatfloat(REBATEPCT));
	    
	    if (!REBATEAMT.equals(""))
	    	REBATEAMT	= common.twoDecimal(common.formatfloat(REBATEAMT));
%>

<%
		CATEGORYMSG		= "HOSPITALIZATION AND SURGICAL SCHEME FOR FOREIGN WORKER";
		CATEGORYMSG1	= "SKIM KEMASUKAN HOSPITAL DAN PEMBEDAHAN PEKERJA ASING";
		REF_MAINPAGE	= "MI-UW F054(E)";
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
	
	String WITHOUTLOGO   = common.setNullToString(request.getParameter("WITHOUTLOGO"));
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
	
	//SST/*
	String SST_EFFDATE_1 		= "";
	SQL	= "SELECT EFFDATE FROM TB_SST WHERE INSCODE = '08' AND MAINCLS = 'FWHS' AND SST_PCT != '0.00' ORDER BY EFFDATE ASC FETCH FIRST ROW ONLY WITH UR";
	DB_Template.makeConnection();
	DB_Template.executeQuery(SQL);
	if(DB_Template.getNextQuery()) 
	{
		SST_EFFDATE_1 = common.setNullToString(DB_Template.getColumnString("EFFDATE"));		
	}
	SST_EFFDATE 		 = timestampFormat3.parse(SST_EFFDATE_1);
	if(!ISSDATE.equals("")){
		today				 = timestampFormat2.parse(ISSDATE);
	}
	DB_Template.takeDown();
	//GST
	String GST_AMT			= "0.00";
	String GST_OTHAMT		= "0.00";
	String SST_OTHAMT		= "0.00";
	String SST_OTHPCT		= "0";
	String GST_FWCMSAMT		= "0.00";
	String GST_PCT			= "0.00";
	String GST_RT			= "";
	String GST_TAX_NO 		= "";
	String GST_TRIGGER		= "";
	String TITLE_GST		= "";
	String GST_IND			= "";
	String PREV_TAX_NO		= "";
	String POLTYPE2	 		= common.setNullToString(request.getParameter("POLTYPE2"));

	SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + PRINCIPLE + CNCODE + "' WITH UR"; 
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
    	GST_PCT			= common.setNullToString(DB_Template.getColumnString("GST_PCT"));
    	GST_AMT			= common.setNullToString(DB_Template.getColumnString("GST_AMT"));
    	GST_OTHAMT		= common.setNullToString(DB_Template.getColumnString("GST_OTHAMT"));
    	GST_FWCMSAMT	= common.setNullToString(DB_Template.getColumnString("GST_FWCMSAMT"));
    	GST_RT			= common.setNullToString(DB_Template.getColumnString("GST_RT"));
    	GST_TAX_NO		= common.setNullToString(DB_Template.getColumnString("GST_TAX_NO"));
    	
    	if(!GST_RT.equals(""))
    		GST_TRIGGER = "Y";
    }
	DB_Template.takeDown();
	
 	SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + PRINCIPLE + PREVPOL + "' WITH UR";
	DB_Contact.makeConnection();
	DB_Contact.executeQuery(SQL);
	if(DB_Contact.getNextQuery())
	{
		PREV_TAX_NO = common.setNullToString(DB_Contact.getColumnString("GST_TAX_NO"));
		GST_IND	= "Y";
	}
	DB_Contact.takeDown();
			
	if (!GST_OTHAMT.equals(""))
		GST_OTHAMT   	= common.twoDecimal(common.formatfloat(GST_OTHAMT));	
		
	if (!GST_FWCMSAMT.equals(""))
		GST_FWCMSAMT   	= common.twoDecimal(common.formatfloat(GST_FWCMSAMT));	
		
	if (GST_FWCMSAMT.equals(""))
		GST_FWCMSAMT   	= "0.00";
	
	if (!GST_OTHAMT.equals(""))
		GST_OTHAMT   	= common.twoDecimal(common.formatfloat(GST_OTHAMT)+common.formatfloat(GST_FWCMSAMT));

	if(GST_IND.equals("Y"))
		TITLE_GST = "DEBIT NOTE";
	else if(!GST_TAX_NO.equals(""))
		TITLE_GST = "TAX INVOICE";
		
	if (!GST_PCT.equals(""))
		GST_PCT		= common.fnFormatNumber(GST_PCT,0);
			
	if (!GST_AMT.equals(""))
		GST_AMT   	= common.twoDecimal(common.formatfloat(GST_AMT));					
	
	if (PREVPOL.equals(""))
	{
		if (!REPLACECN.equals(""))
		{
			PREVPOL = REPLACECN;
		}
	}
	if(today.after(SST_EFFDATE) || today.compareTo(SST_EFFDATE) == 0){
		GST_TRIGGER = "N";
	}
	
	//CLAUSE PRINTING CONTROL DATE
	String CLAUSE_EFFDATE1	= "";
	String CLAUSE_PRINT		= "N";
	SQL = "SELECT VALUE1 FROM TB_CONTROL WHERE INSCODE = '08' AND TYPE = 'CLAUSE_DATE' AND CODE = 'FWIGFWHS' WITH UR";
	DB_Template.makeConnection();
	DB_Template.executeQuery(SQL);
	if(DB_Template.getNextQuery()) 
	{
		CLAUSE_EFFDATE1 = common.setNullToString(DB_Template.getColumnString("VALUE1"));	//20220701	
	}
	CLAUSE_EFFDATE 		 = timestampFormat3.parse(CLAUSE_EFFDATE1);
	DB_Template.takeDown();
	if(today.after(CLAUSE_EFFDATE) || today.compareTo(CLAUSE_EFFDATE) == 0){
		CLAUSE_PRINT = "Y";
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
        <jsp:param name="category"          value="<%=CATEGORYMSG%>" />
        <jsp:param name="category1"     	value="<%=CATEGORYMSG1%>" />
        <jsp:param name="ref_mainpage"		value="<%=REF_MAINPAGE%>" />
        <jsp:param name="ref_mainpage1"     value="<%=REF_MAINPAGE1%>" />
        <jsp:param name="printoption"     	value="<%=printOption%>" />
        <jsp:param name="WITHOUTLOGO"     	value="<%=WITHOUTLOGO%>" />
        <jsp:param name="GST_TAX_NO"     	value="<%=GST_TAX_NO%>" />
        <jsp:param name="TITLE_GST"     	value="<%=TITLE_GST%>" />
        <jsp:param name="GST_TRIGGER"     	value="<%=GST_TRIGGER%>" />             
</jsp:include>

<table width="100%" border="1" cellspacing="0" cellpadding="3">
<%if(PREVPOL.equals("")){%>
  <tr>
    <td bordercolor="#000000" rowspan="2" colspan="2" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Name and Address of Insured / </font>
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
      <b><%=common.stringToHTMLString(ADDRESS_4.toUpperCase())%></b>
      <%}
      %></font></td>
    
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">e-Policy No.<br><i>No. e- Polisi</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(CNCODE)%></b></font></td>
  </tr>
  <% if (specialAgent.equals("Y")) { %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code<br><i>Kod Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%></b></font></td>
  </tr>
  <% }else{ %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code & Name<br><i>Kod & Nama Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%> <%=common.stringToHTMLString(AGENCY_NAME)%></b></font></td>
  </tr>
  <% } %> 	
<%}else{%>
<tr>
    <td bordercolor="#000000" rowspan="3" colspan="2" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Name and Address of Insured / </font>
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
      <b><%=common.stringToHTMLString(ADDRESS_4.toUpperCase())%></b>
      <%}
      %></font></td>
    
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Previous Policy No.<br><i>No. Polisi Terdahulu</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(PREVPOL==""?"-" : PREVPOL)%></b></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">e-Policy No.<br><i>No. e- Polisi</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(CNCODE)%></b></font></td>
  </tr>
  <% if (specialAgent.equals("Y")) { %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code<br><i>Kod Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%></b></font></td>
  </tr>
  <% }else{ %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code & Name<br><i>Kod & Nama Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%> <%=common.stringToHTMLString(AGENCY_NAME)%></b></font></td>
  </tr>
  <% } %> 	
<%}%>
  <tr>
  	<td bordercolor="#000000" width="60%" colspan="2" ><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Postcode / <i>Poskod </i> <br><b><%=common.stringToHTMLString(POSTCODE)%></b></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Gross Premium<br><i>Premium Kasar</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(GPREM)%></b></font></td>
  </tr>

  <%if(!REBATEAMT.startsWith("0.00")){%>
  <tr>
  	<td <%if(!GST_RT.equals("") && !REBATEAMT.startsWith("0.00") && !GST_TRIGGER.equals("N")){%>rowspan="3" <%}else if(!GST_RT.equals("")){%>rowspan="2" <%}else if(!REBATEAMT.startsWith("0.00")){%>rowspan="2" <%}%>bordercolor="#000000" width="27%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business or Occupation<br><i>Perniagaan atau Pekerjaan </i> <br><b><%=common.stringToHTMLString(OCCUPATION_DESC=="" ? OCCUPATION_CODE : OCCUPATION_DESC)%></b></font></td> 
    <td <%if(!GST_RT.equals("") && !REBATEAMT.startsWith("0.00") && !GST_TRIGGER.equals("N")){%>rowspan="3" <%}else if(!GST_RT.equals("")){%>rowspan="2" <%}else if(!REBATEAMT.startsWith("0.00")){%>rowspan="2" <%}%>bordercolor="#000000" width="33%" ><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business Reg. No./ New/Old NRIC No. <br><i> No Pendaftaran Syarikat/ No KP Baru/Lama</i> <br><b><%=common.stringToHTMLString(NEW_IC_NO)%></b></font></td>
    <%if(!REBATEAMT.startsWith("0.00")){%>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(REBATEPCT)%>% Rebate<br><i><%=common.stringToHTMLString2(REBATEPCT)%>% Rebat</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(REBATEAMT)%></b></font></td>
    <%}%>
  </tr>
  <tr>
  	<td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(STAXPCT)%>% Service Tax<br><i><%=common.stringToHTMLString2(STAXPCT)%>% Cukai Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAXAMT)%></b></font></td>
  </tr>
  <%}else{%>
	<tr>
  	<td <%if(!GST_RT.equals("")){%>rowspan="2"<%}%>bordercolor="#000000" width="27%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business or Occupation<br><i>Perniagaan atau Pekerjaan </i> <br><b><%=common.stringToHTMLString(OCCUPATION_DESC=="" ? OCCUPATION_CODE : OCCUPATION_DESC)%></b></font></td> 
    <td <%if(!GST_RT.equals("")){%>rowspan="2"<%}%>bordercolor="#000000" width="33%" ><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business Reg. No./ New/Old NRIC No. <br><i> No Pendaftaran Syarikat/ No KP Baru/Lama</i> <br><b><%=common.stringToHTMLString(NEW_IC_NO)%></b></font></td>
    <td bordercolor="#000000" width="20%" <%if(GST_TRIGGER.equals("N")){%>rowspan="2" <%} %> valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(STAXPCT)%>% Service Tax<br><i><%=common.stringToHTMLString2(STAXPCT)%>% Cukai Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" <%if(GST_TRIGGER.equals("N")){%>rowspan="2" <%} %> valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAXAMT)%></b></font></td>
  </tr>
  <%}%>
<%if(!GST_RT.equals("") && !GST_TRIGGER.equals("N")){%>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(GST_PCT)%>% GST<br><i><%=common.stringToHTMLString(GST_PCT)%>% Cukai Barangan dan Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(GST_AMT)%></b></font></td>
  </tr>
<%}%>
	<!-- STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0] -->
  <tr>
    <td bordercolor="#000000" <%if(!GST_RT.equals("") && !GST_TRIGGER.equals("N")){%>rowspan="5" <%}else{%>rowspan="5"<%}if(showStampFees){%>rowspan="6" <%}%>colspan="2" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Period of Insurance / </font>
    <font face="Verdana, Arial, Helvetica, sans-serif" size="2" border="0"><i>Tempoh Insurans</i><br>
		(a)&nbsp;From <b><%=ISS_CNTIME1%>&nbsp;<%=common.stringToHTMLString(EFFDATE)+" "%></b> to <b><%=common.stringToHTMLString(EXPDATE)%></b> (both dates inclusive)<br>
	<i>&nbsp;&nbsp;&nbsp;Dari&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sehingga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(termasuk kedua-dua tarikh)</i><br>
		(b)&nbsp;Any subsequent period for which the Insured shall pay and the Company shall <br>
		&nbsp;&nbsp;&nbsp;agree to accept a renewal premium<br>
		<i>&nbsp;&nbsp;&nbsp;Pada setiap tempoh yang berikutnya di mana Pihak Diinsuranskan sepatutnya <br>
		&nbsp;&nbsp;&nbsp;membuat bayaran dan Syarikat kemudiannya bersetuju menerima premium <br>
		&nbsp;&nbsp;&nbsp;pembaharuan</i>
	</font></td>
	<td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">TPCA Fee / Service Fee<br><i>Yuran TPCA / Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(SFEEAMT)%></b></font></td>
  </tr>
<%if(!GST_RT.equals("") &&  !GST_TRIGGER.equals("N")){%>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(GST_PCT)%>% GST on TPCA Fee / Service Fee<br><i><%=common.stringToHTMLString2(GST_PCT)%>% Duti Setem / Yuran Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(GST_OTHAMT)%></b></font></td>  
  </tr>
<%}else{%>
 <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(STAXPCT)%>% Service Charge on TPCA Fee / Service Fee<br><i><%=common.stringToHTMLString2(STAXPCT)%>% Caj Perkhidmatan pada Yuran TPCA / Yuran Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(LEVYAMT)%></b></font></td>  
  </tr>
<%}%>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Stamp Duty<br><i>Duti Setem</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAMPDUTY)%></b></font></td>  
  </tr>
  <!-- STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0] -->
  <%if(showStampFees){ %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Stamp Fees<br><i>Caj Setem</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAMP_FEES)%></b></font></td>  
  </tr>
  <%} %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Total Payable<br><i>Jumlah Berbayar</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(TOTPREM)%></b></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Total Payable (OTC)<br><i>Jumlah Berbayar Di Kaunter</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%></b></font></td>
  </tr>
<%if(MASTERIND.equals("Y")){%>
<%}else{%>
  <tr>
    <td bordercolor="#000000" colspan="4" height="160" align="center" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">DESCRIPTION OF INSURED PERSON (S) / <i>DESKRIPSI PIHAK DIINSURANSKAN</i></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" colspan="4" height="160" align="left" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">On the following employee(s) of the Insured for which the Insured is responsible:<br><i>Ke atas pekerja-pekerja yang Diinsuranskan yang telah dipertanggungjawabkan ke atas Pihak Diinsuranskan:</i></font></td>
  </tr>
<%}%>
</table>
<%if(MASTERIND.equals("Y")){%>
<%}else{%>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td bordercolor="#FFFFFF" width="10%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">ID Card No.<br><i>No. Kad ID</i></font></td>
    <td bordercolor="#FFFFFF" width="22%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Name Of Worker / Sex<br><i>Nama Pekerja / Jantina</i></font></td>
    <td bordercolor="#FFFFFF" width="18%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Occp.Sector<br>Code/ <i>Kod Sektor Pekerjaan</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Date Of Birth<br><i>Tarikh Lahir</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Passport No.<br><i>No. Passport</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Country Of Origin<br><i>Negara Asal</i></font></td>
    <td bordercolor="#FFFFFF" width="14%" align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Premium (RM)<br><i>Premium (RM)</i></font></td>
  </tr>
</table>

<table width="100%" border="1" cellspacing="0" cellpadding="3">

<%
	String id_no = "";
	int k=0;
	DecimalFormat df1 	= new DecimalFormat("0000");
	
	SQL = "SELECT * FROM TB_FWHSITEM WHERE UKEY LIKE '"+UKEY+"$%' ORDER BY CAST(SEQNO AS INTEGER) WITH UR";
    DB_Contact.makeConnection();
    DB_Contact.executeQuery(SQL);
    while(DB_Contact.getNextQuery())
    {
    	UKEY1				= common.setNullToString(DB_Contact.getColumnString("UKEY"));
    	SEQNO				= common.setNullToString(DB_Contact.getColumnString("SEQNO"));
		EMP_NAME			= common.setNullToString(DB_Contact.getColumnString("EMP_NAME"));
		OCCPSEC				= common.setNullToString(DB_Contact.getColumnString("OCCPSEC"));
		DOB					= common.setNullToString(DB_Contact.getColumnString("DOB"));
		GENDER				= common.setNullToString(DB_Contact.getColumnString("GENDER"));
		PASSPORT			= common.setNullToString(DB_Contact.getColumnString("PASSPORT"));
		NATIONALITY			= common.setNullToString(DB_Contact.getColumnString("NATIONALITY"));
		WORK_EXP			= common.setNullToString(DB_Contact.getColumnString("PREMIUM"));
		EMP_PLACE			= common.setNullToString(DB_Contact.getColumnString("EMP_PLACE"));

		String sItemNo			= SEQNO;
		String sEmp_Name		= EMP_NAME;
		String sOccpsec			= OCCPSEC;
		String sDob				= DOB;
		String sGender			= GENDER;
		String sPassport		= PASSPORT;
		String sNationality		= NATIONALITY;
		String sWork_Exp		= WORK_EXP;
		String sEmp_Place		= EMP_PLACE;

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
		id_no = df1.format(k);
%>
  <tr>
    <td bordercolor="#FFFFFF" width="10%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=id_no%></b></font></td>
    <td bordercolor="#FFFFFF" width="22%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sEmp_Name)%> (<%=common.stringToHTMLString(sGender)%>)</b></font></td>
    <td bordercolor="#FFFFFF" width="18%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sOccupDesc)%></b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sDob)%></b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sPassport)%></b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sCountry)%></b></font></td>
    <td bordercolor="#FFFFFF" width="14%" align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(common.fnFormatComma(sWork_Exp))%></b></font></td>
  </tr>
<%
	}
   DB_Contact.takeDown();
%>
</table>
<%}%>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td bordercolor="#FFFFFF" width="100%" align="left" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Subject to the following Clauses / Warranties / Endorsements attached hereto: -<br><i>Tertakluk kepada Fasal / Waranti / Endorsemen berikut yang disertakan bersama ini:-</i></font></td>
	</tr>
	<tr>
		<td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Code / <i>Kod</i></font></td>
		<td bordercolor="#FFFFFF" width="88%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Description / <i>Deskripsi</i></font></td>
	</tr><br>
<%
if(CLAUSE_PRINT.equals("Y")) {
if(vClause_Warr!=null)
{
	for(int i=0; i<vClause_Warr.size(); i++)
	{
		Vector vItemNo			= (Vector) vClause_Warr.elementAt(i);
		if(vItemNo.elementAt(0).equals("GST") && GST_TRIGGER.equals("N")){
		}
		else{
		String sCode			= (String) vItemNo.elementAt(0);
		String sDescp			= (String) vItemNo.elementAt(1);
%>
  <tr>
		<td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sCode)%></b></font></td>
		<td bordercolor="#FFFFFF" width="88%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sDescp)%></b></font></td>
  </tr>
<%
		}
	}
}
}%>
<% if(PRINCIPLE.equals("08") && !GST_TRIGGER.equals("N")){ %>
	<tr>
		<td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>GST</b></font></td>
		<td bordercolor="#FFFFFF" width="88%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>GOODS & SERVICES TAX (GST)</b></font></td>
	</tr>
<%} %>
<br><br><br>
</table>
<jsp:include page="/template/pop_incl_f1.jsp">
    <jsp:param name="issuedby"		value="<%=ISSUEDBY%>" />
    <jsp:param name="prevpol"		value="<%=PREVPOL%>" />
    <jsp:param name="issdate"		value="<%=ISSDATE%>" />
    <jsp:param name="isstime"		value="<%=ISSTIME%>" />
    <jsp:param name="masterpol"		value="<%=MASTERPOL%>" />
    <jsp:param name="FWCMSREFNO"	value="<%=FWCMSREFNO%>" />
    <jsp:param name="propdate"		value="" />
    <jsp:param name="specialAgent"	value="" />
</jsp:include>
<%
String CNCODE1 = "";
if (TYPE.equals("GRAB"))
{
    CNCODE1 = common.setNullToString(request.getParameter("CNCODE1"));
}
else
{
    CNCODE1 = common.setNullToString((String)session.getAttribute("SESCNCODE1"));
}
	    
session.setAttribute("SESCNCODE1",CNCODE1);

if(!CNCODE1.equals(""))
{
	CNCODE1 = PRINCIPLE + CNCODE1;
%>
<%
        SQL = "SELECT * FROM TB_FWHSCN WHERE UKEY = '" + CNCODE1 + "' WITH UR";
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
			OCCUPATION_DESC		= common.setNullToString(DB_Template.getColumnString("OCCUPATION_DESC"));
			OCCUPATION_CODE		= common.setNullToString(DB_Template.getColumnString("OCCUPATION_CODE"));
			ISSDATE				= common.setNullToString(DB_Template.getColumnString("ISSDATE"));
			EFFDATE				= common.setNullToString(DB_Template.getColumnString("EFFDATE"));
			EXPDATE				= common.setNullToString(DB_Template.getColumnString("EXPDATE"));
			CLASS				= common.setNullToString(DB_Template.getColumnString("CLASS"));
			ISSTIME				= common.setNullToString(DB_Template.getColumnString("CNTIME"));
			TRADE				= common.setNullToString(DB_Template.getColumnString("TRADE"));
			MASTERPOL			= common.setNullToString(DB_Template.getColumnString("MASTERPOL"));
			PROPOSAL_DATE		= common.setNullToString(DB_Template.getColumnString("PROPOSAL_DATE"));
			CNTYPE				= common.setNullToString(DB_Template.getColumnString("CNTYPE"));
			BUSINESS_NO			= common.setNullToString(DB_Template.getColumnString("BUSINESS_NO"));
			NEW_IC_NO			= common.setNullToString(DB_Template.getColumnString("NEW_IC_NO"));
			OLD_IC_NO			= common.setNullToString(DB_Template.getColumnString("OLD_IC_NO"));
			NATURE_BUSINESS		= common.setNullToString(DB_Template.getColumnString("NATURE_BUSINESS"));
        }
		DB_Template.takeDown();
		
		if (NEW_IC_NO.equals(""))
		{
			NEW_IC_NO = OLD_IC_NO;	
		}
		
		if (NEW_IC_NO.equals(""))
		{
			NEW_IC_NO = BUSINESS_NO;	
		}
		
		SQL	= "SELECT DESCP FROM TB_NMOCCUPATION WHERE CODE = '"+NATURE_BUSINESS+"' AND INSCODE = '"+PRINCIPLE+"' AND MAINCLS = 'IG' WITH UR";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		if(DB_Template.getNextQuery())
			OCCUPATION_CODE	= common.setNullToString(DB_Template.getColumnString("DESCP"));
		DB_Template.takeDown();			
		
		if ( OCCUPATION_DESC.equals("") || OCCUPATION_DESC.equals("-"))
		{
			OCCUPATION_DESC = OCCUPATION_CODE;
		}

        SQL = "SELECT * FROM TB_FWHSSCH WHERE UKEY2 = '" + UKEY + "' WITH UR";
        DB_Template.makeConnection();
        DB_Template.executeQuery(SQL);
        while(DB_Template.getNextQuery())
        {	
        	GPREM				= common.setNullToString(DB_Template.getColumnString("GPREM"));
        	STAXPCT				= common.setNullToString(DB_Template.getColumnString("STAXPCT"));
        	STAXAMT				= common.setNullToString(DB_Template.getColumnString("STAXAMT"));
        	SFEEAMT				= common.setNullToString(DB_Template.getColumnString("SERVICE_FEE"));
        	SFW_FEEAMT			= common.setNullToString(DB_Template.getColumnString("FWCMS_FEE"));
            STAMPDUTY      		= common.setNullToString(DB_Template.getColumnString("STAMPDUTY"));
            TOTPREM      		= common.setNullToString(DB_Template.getColumnString("NETPREM"));
            ORCAMT				= common.setNullToString(DB_Template.getColumnString("ORCAMT"));
            LEVYAMT				= common.setNullToString(DB_Template.getColumnString("LEVYAMT"));
	        REBATEPCT			= common.setNullToString(DB_Template.getColumnString("REBATEPCT"));
        	REBATEAMT			= common.setNullToString(DB_Template.getColumnString("REBATEAMT"));
        	FWCMSREFNO			= common.setNullToString(DB_Template.getColumnString("FWCMSREFNO"));
        }
		DB_Template.takeDown();
%>

<%
		if (!GPREM.equals(""))
			GPREM   	= common.twoDecimal(common.formatfloat(GPREM));
		
		if (!STAXPCT.equals(""))
			STAXPCT		= common.fnFormatNumber(STAXPCT,0);
			
	    if (!ORCAMT.equals(""))
	    	ORCAMT 	= common.twoDecimal(common.formatfloat(ORCAMT));
	    
	    if (!SFEEAMT.equals(""))
	    	SFEEAMT		= common.twoDecimal(common.formatdouble(SFEEAMT)+common.formatdouble(SFW_FEEAMT)+common.formatdouble(LEVYAMT));
			
	    if (!STAMPDUTY.equals(""))
	    	STAMPDUTY  	= common.twoDecimal(common.formatfloat(STAMPDUTY));

	    if (!TOTPREM.equals(""))
			TOTPREM		= common.twoDecimal(common.formatfloat(TOTPREM));

        if(!ISSDATE.equals(""))
            ISSDATE = timestampFormat2.format(timestampFormat3.parse(ISSDATE));

        if(!EFFDATE.equals(""))
            EFFDATE = timestampFormat2.format(timestampFormat3.parse(EFFDATE));

        if(!EXPDATE.equals(""))
            EXPDATE = timestampFormat2.format(timestampFormat3.parse(EXPDATE));
        
        if(!PROPOSAL_DATE.equals(""))
            PROPOSAL_DATE = timestampFormat2.format(timestampFormat3.parse(PROPOSAL_DATE));
        
        if (!REBATEPCT.equals(""))
	    	REBATEPCT 	= common.twoDecimal(common.formatfloat(REBATEPCT));
	    
	    if (!REBATEAMT.equals(""))
	    	REBATEAMT	= common.twoDecimal(common.formatfloat(REBATEAMT));
            
%>

<%
		CATEGORYMSG		= "HOSPITALIZATION AND SURGICAL SCHEME FOR FOREIGN WORKER";
		CATEGORYMSG1	= "SKIM KEMASUKAN HOSPITAL DAN PEMBEDAHAN PEKERJA ASING";
		REF_MAINPAGE	= "MI-UW F059(E)";
		REF_MAINPAGE1	= "REV : A";

		ALLDIGIT	= CNCODE.substring(CNCODE.length()-2,CNCODE.length())+"*"+checkdigitformat.format(timestampFormat2.parseObject(ISSDATE))+"*"+CLASS;	
		CHECKDIGIT	= common.jumbleAlternate(ALLDIGIT);
		
		session.setAttribute("CATEGORYMSG",CATEGORYMSG);
		session.setAttribute("CATEGORYMSG1",CATEGORYMSG1);
		
		//generate print information
	    sCounter = "";
	    sSAVETIME = timestampFormat.format(new Date());
	    if (TYPE.equals("GRAB"))
	    {
	        DB_Contact.makeConnection();
	        sCounter = DB_Contact.getNextCounterNo(UKEY,"FWHS",sSAVETIME,CHECKDIGIT,"EP");
	        DB_Contact.takeDown();
	    }
	    
		ISS_CNTIME1		= "";
		d1= timestampFormat2.parse(EFFDATE);
		d2= timestampFormat2.parse(ISSDATE);
	
		if(d1.equals(d2))
		{
			ISS_CNTIME1 = ISSTIME;
		}
		else if(d1.after(d2))
		{
			ISS_CNTIME1 = "00:00:01AM";
		}
%>
<PAGEBREAK_PRO></PAGEBREAK_PRO>
<jsp:include page="/template/pop_incl_h1.jsp">
        <jsp:param name="category"          	value="<%=CATEGORYMSG%>" />
        <jsp:param name="category1"     	value="<%=CATEGORYMSG1%>" />
        <jsp:param name="ref_mainpage"		value="<%=REF_MAINPAGE%>" />
        <jsp:param name="ref_mainpage1"     	value="<%=REF_MAINPAGE1%>" />
        <jsp:param name="printoption"     	value="<%=printOption%>" />
        <jsp:param name="WITHOUTLOGO"     	value="<%=WITHOUTLOGO%>" />
</jsp:include>

<table width="100%" border="1" cellspacing="0" cellpadding="3">
<%if(PREVPOL.equals("")){%>
  <tr>
    <td bordercolor="#000000" rowspan="2" colspan="2" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Name and Address of Insured / </font>
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
      <b><%=common.stringToHTMLString(ADDRESS_4.toUpperCase())%></b>
      <%}
      %></font></td>
    
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">e-Policy No.<br><i>No. e- Polisi</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(CNCODE)%></b></font></td>
  </tr>
  <% if (specialAgent.equals("Y")) { %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code<br><i>Kod Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%></b></font></td>
  </tr>
  <% }else{ %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code & Name<br><i>Kod & Nama Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%> <%=common.stringToHTMLString(AGENCY_NAME)%></b></font></td>
  </tr>
  <% } %> 	
<%}else{%>
<tr>
    <td bordercolor="#000000" rowspan="3" colspan="2" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Name and Address of Insured / </font>
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
      <b><%=common.stringToHTMLString(ADDRESS_4.toUpperCase())%></b>
      <%}
      %></font></td>
    
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Previous Policy No.<br><i>No. Polisi Terdahulu</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(PREVPOL==""?"-" : PREVPOL)%></b></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">e-Policy No.<br><i>No. e- Polisi</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(CNCODE)%></b></font></td>
  </tr>
  <% if (specialAgent.equals("Y")) { %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code<br><i>Kod Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%></b></font></td>
  </tr>
  <% }else{ %>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code & Name<br><i>Kod & Nama Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%> <%=common.stringToHTMLString(AGENCY_NAME)%></b></font></td>
  </tr>
  <% } %> 	
<%}%>
  <tr>
  	<td bordercolor="#000000" width="60%" colspan="2" ><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Postcode / <i>Poskod </i> <br><b><%=common.stringToHTMLString(POSTCODE)%></b></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Gross Premium<br><i>Premium Kasar</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(GPREM)%></b></font></td>
  </tr>

  <%if(!REBATEAMT.startsWith("0.00")){%>
  <tr>
  	<td <%if(!GST_RT.equals("") && !REBATEAMT.startsWith("0.00")){%>rowspan="3" <%}else if(!GST_RT.equals("")){%>rowspan="2" <%}else if(!REBATEAMT.startsWith("0.00")){%>rowspan="2" <%}%>bordercolor="#000000" width="27%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business or Occupation<br><i>Perniagaan atau Pekerjaan </i> <br><b><%=common.stringToHTMLString(OCCUPATION_DESC=="" ? OCCUPATION_CODE : OCCUPATION_DESC)%></b></font></td> 
    <td <%if(!GST_RT.equals("") && !REBATEAMT.startsWith("0.00")){%>rowspan="3" <%}else if(!GST_RT.equals("")){%>rowspan="2" <%}else if(!REBATEAMT.startsWith("0.00")){%>rowspan="2" <%}%>bordercolor="#000000" width="33%" ><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business Reg. No./ New/Old NRIC No. <br><i> No Pendaftaran Syarikat/ No KP Baru/Lama</i> <br><b><%=common.stringToHTMLString(NEW_IC_NO)%></b></font></td>
    <%if(!REBATEAMT.startsWith("0.00")){%>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(REBATEPCT)%>% Rebate<br><i><%=common.stringToHTMLString2(REBATEPCT)%>% Rebat</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(REBATEAMT)%></b></font></td>
    <%}%>
  </tr>
  <tr>
  	<td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(STAXPCT)%>% Service Tax<br><i><%=common.stringToHTMLString2(STAXPCT)%>% Cukai Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAXAMT)%></b></font></td>
  </tr>
  <%}else{%>
  <tr>
  	<td bordercolor="#000000" width="27%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business or Occupation<br><i>Perniagaan atau Pekerjaan </i> <br><b><%=common.stringToHTMLString(OCCUPATION_DESC=="" ? OCCUPATION_CODE : OCCUPATION_DESC)%></b></font></td> 
    <td bordercolor="#000000" width="33%" ><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business Reg. No./ New/Old NRIC No. <br><i> No Pendaftaran Syarikat/ No KP Baru/Lama</i> <br><b><%=common.stringToHTMLString(NEW_IC_NO)%></b></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(STAXPCT)%>% Service Tax<br><i><%=common.stringToHTMLString2(STAXPCT)%>% Cukai Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAXAMT)%></b></font></td>
  </tr>
  <%}%>
	
	<!-- STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0] -->
  <tr>
    <td bordercolor="#000000" <%if(showStampFees){%> rowspan="5"<%}else{%>rowspan="4"<%}%>colspan="2" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Period of Insurance / </font>
    <font face="Verdana, Arial, Helvetica, sans-serif" size="2" border="0"><i>Tempoh Insurans</i><br>
		(a)&nbsp;From <b><%=ISS_CNTIME1%>&nbsp;<%=common.stringToHTMLString(EFFDATE)+" "%></b> to <b><%=common.stringToHTMLString(EXPDATE)%></b> (both dates inclusive)<br>
	<i>&nbsp;&nbsp;&nbsp;Dari&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sehingga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(termasuk kedua-dua tarikh)</i><br>
		(b)&nbsp;Any subsequent period for which the Insured shall pay and the Company shall <br>
		&nbsp;&nbsp;&nbsp;agree to accept a renewal premium<br>
		<i>&nbsp;&nbsp;&nbsp;Pada setiap tempoh yang berikutnya di mana Pihak Diinsuranskan sepatutnya <br>
		&nbsp;&nbsp;&nbsp;membuat bayaran dan Syarikat kemudiannya bersetuju menerima premium <br>
		&nbsp;&nbsp;&nbsp;pembaharuan</i>
	</font></td>
	<td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">TPCA Fee / Service Fee <br><i>Yuran TPCA / Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(SFEEAMT)%></b></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Stamp Duty<br><i>Duti Setem</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAMPDUTY)%></b></font></td>  
  </tr>
  
  <!-- STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0] -->
  <%if(showStampFees){%>
  <tr>
	<td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Stamp Fees<br><i>Caj Setem</i></font></td>
	<td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAMP_FEES)%></b></font></td>  
  </tr>
  <%}%>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Total Payable<br><i>Jumlah Berbayar</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(TOTPREM)%></b></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Total Payable (OTC)<br><i>Jumlah Berbayar Di Kaunter</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%></b></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" colspan="4" height="160" align="center" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">DESCRIPTION OF INSURED PERSON (S) / <i>DESKRIPSI PIHAK DIINSURANSKAN</i></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" colspan="4" height="160" align="left" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">On the following employee(s) of the Insured for which the Insured is responsible:<br><i>Ke atas pekerja-pekerja yang Diinsuranskan yang telah dipertanggungjawabkan ke atas Pihak Diinsuranskan:</i></font></td>
  </tr>
</table>

<table width="100%" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td bordercolor="#FFFFFF" width="10%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">ID Card No.<br><i>No. Kad ID</i></font></td>
    <td bordercolor="#FFFFFF" width="22%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Name Of Worker / Sex<br><i>Nama Pekerja / Jantina</i></font></td>
    <td bordercolor="#FFFFFF" width="18%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Occp.Sector<br>Code/ <i>Kod Sektor Pekerjaan</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Date Of Birth<br><i>Tarikh Lahir</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Passport No.<br><i>No. Passport</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Country Of Origin<br><i>Negara Asal</i></font></td>
    <td bordercolor="#FFFFFF" width="14%" align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Premium (RM)<br><i>Premium (RM)</i></font></td>
  </tr>
</table>

<table width="100%" border="1" cellspacing="0" cellpadding="3">
<% 
	String id_no = "";
	int k=0;
	DecimalFormat df1 	= new DecimalFormat("0000");
	
	SQL = "SELECT * FROM TB_FWHSITEM WHERE UKEY LIKE '"+UKEY+"$%' ORDER BY CAST(SEQNO AS INTEGER) WITH UR";
    DB_Contact.makeConnection();
    DB_Contact.executeQuery(SQL);
    while(DB_Contact.getNextQuery())
    {
    	UKEY1				= common.setNullToString(DB_Contact.getColumnString("UKEY"));
    	SEQNO				= common.setNullToString(DB_Contact.getColumnString("SEQNO"));
		EMP_NAME			= common.setNullToString(DB_Contact.getColumnString("EMP_NAME"));
		OCCPSEC				= common.setNullToString(DB_Contact.getColumnString("OCCPSEC"));
		DOB					= common.setNullToString(DB_Contact.getColumnString("DOB"));
		GENDER				= common.setNullToString(DB_Contact.getColumnString("GENDER"));
		PASSPORT			= common.setNullToString(DB_Contact.getColumnString("PASSPORT"));
		NATIONALITY			= common.setNullToString(DB_Contact.getColumnString("NATIONALITY"));
		WORK_EXP			= common.setNullToString(DB_Contact.getColumnString("PREMIUM"));
		EMP_PLACE			= common.setNullToString(DB_Contact.getColumnString("EMP_PLACE"));

		String sItemNo			= SEQNO;
		String sEmp_Name		= EMP_NAME;
		String sOccpsec			= OCCPSEC;
		String sDob				= DOB;
		String sGender			= GENDER;
		String sPassport		= PASSPORT;
		String sNationality		= NATIONALITY;
		String sWork_Exp		= WORK_EXP;
		String sEmp_Place		= EMP_PLACE;
		
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
		id_no = df1.format(k);
%>
  <tr>
    <td bordercolor="#FFFFFF" width="10%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=id_no%></b></font></td>
    <td bordercolor="#FFFFFF" width="22%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sEmp_Name)%> (<%=common.stringToHTMLString(sGender)%>)</b></font></td>
    <td bordercolor="#FFFFFF" width="18%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sOccupDesc)%></b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sDob)%></b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sPassport)%></b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sCountry)%></b></font></td>
    <td bordercolor="#FFFFFF" width="14%" align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(common.fnFormatComma(sWork_Exp))%></b></font></td>
  </tr>
<%
	}
   DB_Contact.takeDown();
%>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td bordercolor="#FFFFFF" width="100%" align="left" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Subject to the following Clauses / Warranties / Endorsements attached hereto: -<br><i>Tertakluk kepada Fasal / Waranti / Endorsemen berikut yang disertakan bersama ini:-</i></font></td>
	</tr>
	<tr>
		<td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Code / <i>Kod</i></font></td>
		<td bordercolor="#FFFFFF" width="88%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Description / <i>Deskripsi</i></font></td>
	</tr><br>
<%
if(CLAUSE_PRINT.equals("Y")) {
if(vClause_Warr!=null)
{
	for(int i=0; i<vClause_Warr.size(); i++)
	{
		Vector vItemNo			= (Vector) vClause_Warr.elementAt(i);
		if(vItemNo.elementAt(0).equals("GST") && GST_TRIGGER.equals("N")){
		}
		else{
		String sCode			= (String) vItemNo.elementAt(0);
		String sDescp			= (String) vItemNo.elementAt(1);
%>
  <tr>
		<td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sCode)%></b></font></td>
		<td bordercolor="#FFFFFF" width="88%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sDescp)%></b></font></td>
  </tr>
<%
		}
	}
}
}%>
<% if(PRINCIPLE.equals("08") && !GST_TRIGGER.equals("N")){ %>
	<tr>
		<td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>GST</b></font></td>
		<td bordercolor="#FFFFFF" width="88%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>GOODS & SERVICES TAX (GST)</b></font></td>
	</tr>
<%} %>
<br><br><br>
</table>
<jsp:include page="/template/pop_incl_f1.jsp">
    <jsp:param name="issuedby"		value="<%=ISSUEDBY%>" />
    <jsp:param name="prevpol"		value="<%=PREVPOL%>" />
    <jsp:param name="issdate"		value="<%=ISSDATE%>" />
    <jsp:param name="isstime"		value="<%=ISSTIME%>" />
    <jsp:param name="masterpol"		value="<%=MASTERPOL%>" />
    <jsp:param name="FWCMSREFNO"	value="<%=FWCMSREFNO%>" />
    <jsp:param name="propdate"		value="" />
    <jsp:param name="specialAgent"	value="" />
</jsp:include>
<%
}
%>

<jsp:include page="/template/pop_incl_f2.jsp">
	<jsp:param name="checkdigit"	value="<%=CHECKDIGIT%>" />  
	<jsp:param name="check_ind"		value="H" />  
</jsp:include>

<% if(CLAUSE_PRINT.equals("Y")) {%>
<!-- <PAGEBREAK></PAGEBREAK> -->
<% 
session.setAttribute("SES_vNARRATION",vNARRATION); 
%>
<jsp:include page="/template/pop_incl_f3.jsp">    
</jsp:include>
<% } %>

<PAGEBREAK_INC></PAGEBREAK_INC>

<jsp:include page="/template/pop_incl_CFMKT.jsp">
<jsp:param name="CNTYPE"          	value="FWHS" />
<jsp:param name="CFMKT_IND"         value="<%=CFMKT_IND%>" />
<jsp:param name="CONTACT_TYPE"      value="<%=CONTACT_TYPE%>" />
<jsp:param name="CNCODE"         	value="<%=CNCODE%>" />
<jsp:param name="NAME"         		value="<%=NAME%>" />
</jsp:include> 

<% if (!GST_TAX_NO.equals("") ){ %>
<PAGEBREAK></PAGEBREAK>	
<jsp:include page="/template/pop_incl_tax_invoice.jsp">
<jsp:param name="UKEY"         	    value="<%=PRINCIPLE+CNCODE%>" />
</jsp:include> 
<%-- <%if (INTERMEDIARY_IND.equals("Y")) {%> --%>
<!-- <PAGEBREAK></PAGEBREAK>	 -->
<%-- <jsp:include page="/template/pop_incl_tax_invoice_intermediary.jsp"> --%>
<%-- <jsp:param name="UKEY"         	    value="<%=PRINCIPLE+CNCODE%>" /> --%>
<%-- </jsp:include>  --%>
<%-- <%	} %> --%> 
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