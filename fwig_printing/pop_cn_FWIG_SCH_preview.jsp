<%@ page language="java" import="java.util.*,java.util.Date,java.text.SimpleDateFormat,java.text.DecimalFormat" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB_Template" scope="page" class="com.rexit.easc.DB_Template" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />

<%
//20060602 - kcong - Bug fix on Agent Name / address printing
//                 - Bug fix on Proposal Date printing (follow Non-Motor Free Text)
//20060607 - kcong - To adjust the wording to follow user new requirement.
//20060615 - kcong - To trim the space in Clause / Warranty wording.
//                 - To select clause narration with maincls = 'BG' instead of 'IG'.
//20060623 - Hamidah- To replace ~ with new line for Narration
//20060613 - HGONG	- Change replace(~,/n) to replace(`,/n)
	Date today				= new Date();
	Date SST_EFFDATE;
	Date CLAUSE_EFFDATE;
	String CNCODE			= "";
    String ISSUEDBY			= "";
	String STAXPCT			= "";
	String PRINCIPLE		= "";	
	String ISSTIME			= "";
	String CHECKDIGIT		= "";
	String ALLDIGIT			= "";

    // TB_FWIGCN
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
	String ISSDATE					= "";	
	String EFFDATE					= "";
	String EXPDATE					= "";
	String CLASS					= "";
	String TRADE					= "";
	String MEMO						= "";
	String OCCUPATION_CODE			= "";
	String PROPOSAL_DATE			= "";
	String NEW_IC_NO				= "";
	String OLD_IC_NO				= "";
	String BUSINESS_NO				= "";
	String MASTERPOL				= "";
	String MASTERIND				= "";
    // TB_FWIGCN

	// TB_FWIGSCH
	String GPREM	 				= "";
	String STAXAMT					= "";
	//String SFEEAMT					= "";
	String STAMPDUTY				= "";
	String TOTPREM	     			= "";
	String NETPREM	     			= "";
	String REBATEPCT				= "";
	String REBATEAMT				= "";
	String FWCMSREFNO				= "";
	
	// STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
	String STAMP_FEES				= "";
	
	// TB_FWIGSCH

	// TB_FWIGMAST
	String EMP_NAME			= "";
	String EMP_GENDER		= "";
	String EMP_OCCUPATION	= "";
	String EMP_PASSPORT		= "";
	String EMP_NATIONALITY	= "";
	// TB_FWIGMAST

	// TB_FWIGCLAUSE
	String CLAUSE					= "";
	// TB_FWIGCLAUSE

	// TB_FWIGWARR
	String WARRANTY					= "";	
	// TB_FWIGWARR

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
	int iLINECNT					= 55;
	
	String ISS_CNTIME1				= "";
	
	String CFMKT_IND 				= "";
    String CONTACT_TYPE				= "";
    String CNTYPE					= "";
	
	SimpleDateFormat timestampFormat 	= new SimpleDateFormat("yyyyMMddHHmmss");
	SimpleDateFormat timestampFormat2 	= new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat timestampFormat3 	= new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat timestampFormat4 	= new SimpleDateFormat("hh:mm:ssa");
	SimpleDateFormat timestampFormat5 	= new SimpleDateFormat("dd-MM-yyyy / hh:mm:ssa");
	SimpleDateFormat checkdigitformat 	= new SimpleDateFormat("MMdd");
	DecimalFormat df = new DecimalFormat("00");
	//added by Gopi to determine pdf print / preview
	String printOption = common.setNullToString(request.getParameter("option"));
	
	// STFee_FT_A1_CheckAccode -- Check account code of current user [StampFees_Flowchart_v1.0]
	// Could be more efficient in 2 ways 
	// 1. 	Using "LOCATE" in DB2SQL, saving time since it will only have query results if the agent code exist within VALUE1
	// 2. 	Using Set and split the existing queried Account code into an Array and put the array into a HashMap, 
	// 		then check the Set if it contains the Account Code
	
	String dbHowdenAccode			= "";
	String headerFooterChange 		= "";
	
	
	DB_Contact.makeConnection();
	String howdenSQL	= "SELECT VALUE1 FROM TB_CONTROL WHERE INSCODE = '"+PRINCIPLE+"' AND TYPE='STAMP_FEES' AND CODE='HOWDEN_AGENT' WITH UR";
	DB_Contact.executeQuery(howdenSQL);
	while(DB_Contact.getNextQuery())
	{
		dbHowdenAccode	= common.setNullToString(DB_Contact.getColumnString("VALUE1"));
	}
	DB_Contact.takeDown();
	
	StringTokenizer tokenizedAccode	= new StringTokenizer(dbHowdenAccode, "^");
	
	while(tokenizedAccode.hasMoreTokens()){
		if(ACCODE.equals(tokenizedAccode.nextToken())){
			headerFooterChange				= "Y"; 
			
		}
	}
	
	session.setAttribute("headerFooterChange", headerFooterChange);
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
	    
	    //CNCODE = "08FWTEST-1045";
	    //CNCODE = "08FWTEST-1093";
%>

<%
        String SQL = "SELECT * FROM TB_FWIGCN WHERE UKEY = '" + CNCODE + "' WITH UR";
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
			PROPOSAL_DATE		= common.setNullToString(DB_Template.getColumnString("PROPOSAL_DATE"));
			BUSINESS_NO			= common.setNullToString(DB_Template.getColumnString("BUSINESS_NO"));
	        NEW_IC_NO			= common.setNullToString(DB_Template.getColumnString("NEW_IC_NO"));
			OLD_IC_NO			= common.setNullToString(DB_Template.getColumnString("OLD_IC_NO"));
			CONTACT_TYPE    	= common.setNullToString(DB_Template.getColumnString("CONTACT_TYPE"));
			CNTYPE    			= common.setNullToString(DB_Template.getColumnString("CNTYPE"));
			MASTERPOL			= common.setNullToString(DB_Template.getColumnString("MASTERPOL"));
			MASTERIND			= common.setNullToString(DB_Template.getColumnString("MASTERIND"));
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
		
		if (NEW_IC_NO.equals(""))
		{
			NEW_IC_NO = OLD_IC_NO;	
		}
		
		if(!TRADE.equals(""))
		{
			String TRADE_DESCP	= "";
			SQL	= "SELECT DESCP FROM TB_NMOCCUPATION WHERE CODE = '"+TRADE+"' AND INSCODE = '"+PRINCIPLE+"' AND MAINCLS = 'IG' WITH UR";
			DB_Template.makeConnection();
			DB_Template.executeQuery(SQL);
			if(DB_Template.getNextQuery())
				TRADE_DESCP	= common.setNullToString(DB_Template.getColumnString("DESCP"));
			DB_Template.takeDown();
			if(TRADE_DESCP.equals(""))
				OCCUPATION_DESC	= TRADE;
			else
				OCCUPATION_DESC	= TRADE_DESCP;
		}
		else		
		if(!OCCUPATION_CODE.equals(""))
		{			
			SQL	= "SELECT DESCP FROM TB_NMOCCUPATION WHERE CODE = '"+OCCUPATION_CODE+"' AND INSCODE = '"+PRINCIPLE+"' AND MAINCLS = 'IG' WITH UR";
			DB_Template.makeConnection();
			DB_Template.executeQuery(SQL);
			if(DB_Template.getNextQuery())
				OCCUPATION_CODE	= common.setNullToString(DB_Template.getColumnString("DESCP"));
			DB_Template.takeDown();		
			
			if ( OCCUPATION_DESC.equals("") || OCCUPATION_DESC.equals("-"))
			{
				OCCUPATION_DESC = OCCUPATION_CODE;
			}		
		}	

        SQL = "SELECT * FROM TB_FWIGSCH WHERE UKEY2 = '" + UKEY + "' WITH UR";
        DB_Template.makeConnection();
        DB_Template.executeQuery(SQL);
		while(DB_Template.getNextQuery())
		{	
			GPREM				= common.setNullToString(DB_Template.getColumnString("GPREM"));
			STAXAMT				= common.setNullToString(DB_Template.getColumnString("STAXAMT"));
			STAXPCT				= common.setNullToString(DB_Template.getColumnString("STAXPCT"));
			//SFEEAMT			= common.setNullToString(DB_Template.getColumnString("SERVICE_FEE"));
			STAMPDUTY			= common.setNullToString(DB_Template.getColumnString("STAMPDUTY"));
			TOTPREM				= common.setNullToString(DB_Template.getColumnString("TOTPREM"));
			NETPREM		 		= common.setNullToString(DB_Template.getColumnString("NETPREM"));
			CFMKT_IND			= common.setNullToString(DB_Template.getColumnString("CFMKT_IND"));
			REBATEPCT			= common.setNullToString(DB_Template.getColumnString("REBATEPCT"));
			REBATEAMT			= common.setNullToString(DB_Template.getColumnString("REBATEAMT"));
			FWCMSREFNO			= common.setNullToString(DB_Template.getColumnString("FWCMSREFNO"));

			// STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
			STAMP_FEES			= common.setNullToString(DB_Template.getColumnString("STAMP_FEES"));
		}

		DB_Template.takeDown();
		
		// STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0]
		boolean showStampFees = false;
		if(STAMP_FEES.equals("10.00")){
			showStampFees = true;
		}
		
		if(STAXPCT.equals("")){
			STAXPCT = "0.00";
		}
		STAXPCT 				= common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(STAXPCT)));
		String emp_name			= "";
		String emp_gender		= "";
		String emp_occupation	= "";
		String emp_passport		= "";
		String emp_nationality	= "";

		int iCounter 			= 0;
		String item_no 			= "";
		Vector vItem 			= new Vector();
		
        SQL = "SELECT * FROM TB_FWIGMAST WHERE UKEY2 LIKE '"+UKEY+"' ORDER BY UKEY2 WITH UR";
        DB_Template.makeConnection();
        DB_Template.executeQuery(SQL); 
        DecimalFormat df1 	= new DecimalFormat("000");
        while(DB_Template.getNextQuery())
        {
			EMP_NAME			= common.setNullToString(DB_Template.getColumnString("EMP_NAME"));
			EMP_GENDER			= common.setNullToString(DB_Template.getColumnString("EMP_GENDER"));
			EMP_OCCUPATION		= common.setNullToString(DB_Template.getColumnString("EMP_OCCUPATION"));
			EMP_PASSPORT		= common.setNullToString(DB_Template.getColumnString("EMP_PASSPORT"));
			EMP_NATIONALITY		= common.setNullToString(DB_Template.getColumnString("EMP_NATIONALITY"));

			com.rexit.easc.StringTokenizer st1	= new com.rexit.easc.StringTokenizer(EMP_NAME,"^","",true);
			com.rexit.easc.StringTokenizer st2	= new com.rexit.easc.StringTokenizer(EMP_GENDER,"^","",true);
			com.rexit.easc.StringTokenizer st3	= new com.rexit.easc.StringTokenizer(EMP_OCCUPATION,"^","",true);
			com.rexit.easc.StringTokenizer st4	= new com.rexit.easc.StringTokenizer(EMP_PASSPORT,"^","",true);
			com.rexit.easc.StringTokenizer st5	= new com.rexit.easc.StringTokenizer(EMP_NATIONALITY,"^","",true);

			int emp_item	= 1; 
			while(st1.hasMoreTokens()) 
			{
				Vector vRow		= new Vector(); 
				vRow.addElement(df1.format(emp_item));
				
				if(st2.hasMoreTokens()) 
				{
					emp_name	= st1.nextToken();
					vRow.addElement(emp_name);
				}else{
					vRow.addElement("");
				} 
				
				if(st2.hasMoreTokens()){
					emp_gender	= st2.nextToken();
					vRow.addElement(emp_gender);
				}else{
					vRow.addElement("");
				}
				
				if(st3.hasMoreTokens()){
					emp_occupation	= st3.nextToken(); 
					vRow.addElement(emp_occupation);
				}else{
					vRow.addElement("");
				} 
				
				vRow.addElement(""); 
				
				if(st4.hasMoreTokens()){
					emp_passport	= st4.nextToken();
					vRow.addElement(emp_passport);
				}else{
					vRow.addElement("");
				} 

				if(st5.hasMoreTokens()){
					emp_nationality	= st5.nextToken();
					vRow.addElement(emp_nationality);
				}else{
					vRow.addElement("");
				} 
				
				vRow.addElement(""); 

				vItem.addElement(vRow); 
				
				emp_item++; 
			}			
        }
		DB_Template.takeDown();

		String clause 			= "";
		String warranty			= "";
		Vector vClause_Warr		= new Vector();
		SQL = "SELECT * FROM TB_FWIGPERIL WHERE UKEY2 = '"+UKEY+"' WITH UR";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		while(DB_Template.getNextQuery())
		{
			CLAUSE				= common.setNullToString(DB_Template.getColumnString("CODE"));
		
			com.rexit.easc.StringTokenizer st1	= new com.rexit.easc.StringTokenizer(CLAUSE,"^","",true);
		
			while(st1.hasMoreTokens())
			{				
				Vector vRow		= new Vector();
				clause			= st1.nextToken();
				vRow.addElement(clause);
				vClause_Warr.addElement(vRow);
			}
		}
		DB_Template.takeDown();
		
		SQL = "SELECT * FROM TB_FWIGWARR WHERE UKEY2 = '"+UKEY+"' WITH UR";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		while(DB_Template.getNextQuery())
		{
			WARRANTY			= common.setNullToString(DB_Template.getColumnString("CODE"));
		
			com.rexit.easc.StringTokenizer st1	= new com.rexit.easc.StringTokenizer(WARRANTY,"^","",true);
		
			while(st1.hasMoreTokens())
			{
				Vector vRow		= new Vector();
				warranty		= st1.nextToken();
				vRow.addElement(warranty);
				vClause_Warr.addElement(vRow);
			}
		}
		DB_Template.takeDown();
		
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
				}
				/* else        //202206 - Blocking Clause without Narration Description
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

       	// SQL = "SELECT * FROM TB_USER WHERE USERID = '" + USERID + "' WITH UR";
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
		
		SQL = "SELECT USERID FROM TB_ACNO_AM WHERE ACCODE = '" + ACCODEID + "' FETCH FIRST ROW ONLY WITH UR";
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
		
	    if (!STAXAMT.equals(""))
	    	STAXAMT 	= common.twoDecimal(common.formatfloat(STAXAMT));
	    
	    if (!STAXPCT.equals(""))
			STAXPCT		= common.fnFormatNumber(STAXPCT,0);
			
	    if (!STAMPDUTY.equals(""))
	    	STAMPDUTY  	= common.twoDecimal(common.formatfloat(STAMPDUTY));

	    if (!TOTPREM.equals(""))
			TOTPREM		= common.twoDecimal(common.formatfloat(TOTPREM));

		if (!NETPREM.equals(""))
			NETPREM		= common.twoDecimal(common.formatfloat(NETPREM));

        if(!ISSDATE.equals(""))
            ISSDATE = timestampFormat2.format(timestampFormat3.parse(ISSDATE));

        if(!EFFDATE.equals(""))
            EFFDATE = timestampFormat2.format(timestampFormat3.parse(EFFDATE));

        if(!EXPDATE.equals(""))
            EXPDATE = timestampFormat2.format(timestampFormat3.parse(EXPDATE));
            
        if(!PROPOSAL_DATE.equals(""))
        	PROPOSAL_DATE	= timestampFormat2.format(timestampFormat3.parse(PROPOSAL_DATE));
        
        if (!REBATEPCT.equals(""))
	    	REBATEPCT 	= common.twoDecimal(common.formatfloat(REBATEPCT));
	    
	    if (!REBATEAMT.equals(""))
	    	REBATEAMT	= common.twoDecimal(common.formatfloat(REBATEAMT));
        
%>

<%
		CATEGORYMSG		= "FOREIGN WORKERS INSURANCE GUARANTEE SCHEDULE";
		CATEGORYMSG1	= "JADUAL GERENTI INSURANS PEKERJA ASING";
		REF_MAINPAGE	= "UW-NM-F149(E)";
		REF_MAINPAGE1	= "REV : A";
%>

<%
		ALLDIGIT	= CNCODE.substring(CNCODE.length()-2,CNCODE.length())+"*"+checkdigitformat.format(timestampFormat2.parseObject(ISSDATE))+"*"+CLASS;	
		CHECKDIGIT	= common.jumbleAlternate(ALLDIGIT);
		
		//ADDED BY GOPI FOR PRINTING CHANGES
		session.setAttribute("CATEGORYMSG",CATEGORYMSG);
		session.setAttribute("CATEGORYMSG1",CATEGORYMSG1);
		
		//generate print information
		String sCounter = "";
		String sSAVETIME = timestampFormat.format(new Date());
		if (TYPE.equals("GRAB"))
		{
		    DB_Contact.makeConnection();
		    sCounter = DB_Contact.getNextCounterNo(UKEY,"IG",sSAVETIME,CHECKDIGIT,"EP");
		    DB_Contact.takeDown();
		}
		
		 if(!MEMO.equals(""))
	    {
	    	MEMO	= common.searchReplace(MEMO,"\n\n","^nbsp^nbsp");
        	MEMO	= common.searchReplace(MEMO,"\n"," ");
        	MEMO	= common.searchReplace(MEMO,"^nbsp^nbsp","\n\n");
	    }
	    
	    session.setAttribute("SES_PRINCIPLE",PRINCIPLE);
%>

<%
	//rajesh 20080325
	java.util.Date d1= timestampFormat2.parse(EFFDATE);
	java.util.Date d2= timestampFormat2.parse(ISSDATE);

	if(d1.equals(d2))
	{
		ISS_CNTIME1 = ISSTIME;
	}
	else if(d1.after(d2) || d1.before(d2))
	{
		ISS_CNTIME1 = "00:00:01AM";
	}
%>
<%
	//rajesh 20080402
	boolean bIssdate = false;
	
	java.util.Date b1= timestampFormat2.parse(ISSDATE);
	java.util.Date b2= timestampFormat2.parse("01-04-2008");

	if(b1.equals(b2) || b1.after(b2))
	{
		bIssdate = true;
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
	
	
	//GST
	String GST_AMT			= "";
	String GST_PCT			= "";
	String GST_RT			= "";
	String GST_TAX_NO 		= "";
	String GST_TRIGGER		= "";
	String TITLE_GST		= "";
	String POLTYPE2	 		= common.setNullToString(request.getParameter("POLTYPE2"));
		
	SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + PRINCIPLE + CNCODE + "' WITH UR"; 
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
    	GST_PCT			= common.setNullToString(DB_Template.getColumnString("GST_PCT"));
    	GST_AMT			= common.setNullToString(DB_Template.getColumnString("GST_AMT"));
    	GST_RT			= common.setNullToString(DB_Template.getColumnString("GST_RT"));
    	GST_TAX_NO		= common.setNullToString(DB_Template.getColumnString("GST_TAX_NO"));
    	if(!GST_RT.equals(""))
    		GST_TRIGGER = "Y";
    }
	DB_Template.takeDown();
	
	if (!GST_TAX_NO.equals(""))
		TITLE_GST		= "TAX INVOICE";

	if (!GST_PCT.equals(""))
		GST_PCT		= common.fnFormatNumber(GST_PCT,0);
			
	if (!GST_AMT.equals(""))
		GST_AMT   	= common.twoDecimal(common.formatfloat(GST_AMT));		
	
//SST/*
	String SST_EFFDATE_1 		= "";
	SQL	= "SELECT EFFDATE FROM TB_SST WHERE INSCODE = '08' AND MAINCLS = 'FWIG' AND SST_PCT != '0.00' ORDER BY EFFDATE ASC FETCH FIRST ROW ONLY WITH UR";
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
	if(today.after(SST_EFFDATE) || today.compareTo(SST_EFFDATE) == 0){
		GST_TRIGGER = "N";
		if(GST_RT.equals("")){
			GST_RT		= "SST";
		}
	}
	else{
	if(GST_RT.equals("")){
			GST_RT		= "SR";
		}
	}
	
	//CLAUSE PRINTING CONTROL DATE
	String CLAUSE_EFFDATE1	= "";
	String CLAUSE_PRINT		= "N";
	SQL = "SELECT VALUE1 FROM TB_CONTROL WHERE INSCODE = '08' AND TYPE = 'CLAUSE_DATE' AND CODE = 'FWIGFWHS' WITH UR";
	DB_Template.makeConnection();
	DB_Template.executeQuery(SQL);
	if(DB_Template.getNextQuery()) 
	{
		CLAUSE_EFFDATE1 = common.setNullToString(DB_Template.getColumnString("VALUE1")); //20220701
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

	int grossPremium_rowSpan = 1; // Gross Premium row

	if(!REBATEAMT.startsWith("0.00")) {
		grossPremium_rowSpan++;
	}
	
	if(!GST_RT.equals("")) {
		grossPremium_rowSpan++;
	}
	
	if(showStampFees) {
		grossPremium_rowSpan++;
	}
	
	/* Total Payable */
	grossPremium_rowSpan++;
	
	/* Total Payable (OTC) */
	if(bIssdate) {
	    grossPremium_rowSpan++;
	}
	
		
%>

<html>
<head>
<title>FOREIGN WORKERS INSURANCE GUARANTEE SCHEDULE</title>
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
        <jsp:param name="StampDutyPaid"     value="N" />
        <jsp:param name="WITHOUTLOGO"     	value="<%=WITHOUTLOGO%>" />
        <jsp:param name="GST_TAX_NO"     	value="<%=GST_TAX_NO%>" />
        <jsp:param name="TITLE_GST"     	value="<%=TITLE_GST%>" />
        <jsp:param name="GST_TRIGGER"     	value="<%=GST_TRIGGER%>" />            
</jsp:include>

<table width="100%" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td bordercolor="#000000" rowspan="2" colspan="2" valign="top"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Name and Address of Insured  / </font>
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
    
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">e-Policy No.<br><i>No. e- Polisi</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(CNCODE)%></b></font></td>
  </tr>
  <% if (specialAgent.equals("Y")) { %>
  <tr>
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code<br><i>Kod Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%></b></font></td>
  </tr>  
  <% }else{ %>
  <tr>
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Agent Code & Name<br><i>Kod & Nama Ejen</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(ACCODE)%> <%=common.stringToHTMLString(AGENCY_NAME)%></b></font></td>
  </tr>  
  <% } %> 	
  <tr>
    <td rowspan="<%=grossPremium_rowSpan%>" bordercolor="#000000" width="60%" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Postcode / <i>Poskod </i>: <br><b><%=common.stringToHTMLString(POSTCODE)%></b></font></td>
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Gross Premium<br><i>Premium Kasar</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(GPREM)%></b></font></td>  
  </tr>
  <%if(!REBATEAMT.startsWith("0.00")){%>
  <tr>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(REBATEPCT)%>% Rebate<br><i><%=common.stringToHTMLString2(REBATEPCT)%>% Rebat</i></font></td>
    <td bordercolor="#000000" width="20%" valign="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(REBATEAMT)%></b></font></td>
  </tr>
  <%}%>
<%if(!GST_RT.equals("") && !GST_TRIGGER.equals("N")){%>  
  <tr>
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString(GST_PCT)%>% GST<br><i><%=common.stringToHTMLString(GST_PCT)%>% Cukai Barangan dan Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(GST_AMT)%></b></font></td>  
  </tr>  
<%}else{%>  
  <tr>
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString(STAXPCT)%>% Service Tax<br><i><%=common.stringToHTMLString(STAXPCT)%>% Cukai Perkhidmatan</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAXAMT)%></b></font></td>  
  </tr>  
<%}%>  
  <tr>
	<td bordercolor="#000000" width="27%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">1Business or Occupation<br><i>Perniagaan atau Pekerjaan</i> : <br><b><%=common.stringToHTMLString(OCCUPATION_DESC=="" ? OCCUPATION_CODE : OCCUPATION_DESC)%></b></font></td>
	<td bordercolor="#000000" width="33%" ><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Business Reg. No./ New/Old NRIC No. <br><i> No Pendaftaran Syarikat/ No KP Baru/Lama</i> <br><b><%=common.stringToHTMLString(BUSINESS_NO=="" ? NEW_IC_NO : BUSINESS_NO)%></b></font></td>
	<td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Stamp Duty<br><i>Duti Setem</i></font></td>
	<td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAMPDUTY)%></b></font></td>  
  </tr>
	<!-- STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0] -->
	<% if(showStampFees){ %>
	<tr>
		<td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Stamp Fees<br><i>Caj Setem</i></font></td>
		<td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(STAMP_FEES)%></b></font></td>
	</tr>
	<% } %>
  <%if(bIssdate) {%>
  <tr>
  	<td bordercolor="#000000" rowspan="2" colspan="2" valign="top">
    <font face="Verdana, Arial, Helvetica, sans-serif" size="2">Period of Insurance / <i>Tempoh Insurans</i><br>
	(a)&nbsp;From <b><%=ISS_CNTIME1%>&nbsp;<%=common.stringToHTMLString(EFFDATE)+" "%></b> to <b><%=common.stringToHTMLString(EXPDATE)%></b> (both dates inclusive)<br>
	<i>&nbsp;&nbsp;&nbsp;Dari&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sehingga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(termasuk kedua-dua tarikh)</i><br>
	(b)&nbsp;Any subsequent period for which the Insured shall pay and the<br>&nbsp;&nbsp;&nbsp;Company shall agree to accept a renewal premium<br>
	<i>&nbsp;&nbsp;&nbsp;Pada  setiap tempoh yang berikutnya di mana Pihak Diinsuranskan<br>&nbsp;&nbsp;&nbsp;sepatutnya  membuat bayaran  dan Syarikat kemudiannya bersetuju menerima<br>&nbsp;&nbsp;&nbsp;premium pembaharuan</i>
	</font></td>
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Total Payable<br><i>Jumlah Berbayar</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(NETPREM)%></b></font></td>  
  </tr>
  <tr>
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Total Payable (OTC)<br><i>Jumlah Berbayar Di Kaunter</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%if((!NETPREM.equals("0.0000"))|(!NETPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(NETPREM))))%><%}else{%><%=common.stringToHTMLString(NETPREM)%><%}%></b></font></td>
  </tr>  
  <%}else{%>
  <tr>
  	<td bordercolor="#000000" colspan="2" valign="top">
    <font face="Verdana, Arial, Helvetica, sans-serif" size="2">Period of Insurance / <i>Tempoh Insurans</i><br>
	(a)&nbsp;From <b><%=ISS_CNTIME1%>&nbsp;<%=common.stringToHTMLString(EFFDATE)+" "%></b> to <b><%=common.stringToHTMLString(EXPDATE)%></b> (both dates inclusive)<br>
	<i>&nbsp;&nbsp;&nbsp;Dari&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sehingga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(termasuk kedua-dua tarikh)</i><br>
	(b)&nbsp;Any subsequent period for which the Insured shall pay and the<br>&nbsp;&nbsp;&nbsp;Company shall agree to accept a renewal premium<br>
	<i>&nbsp;&nbsp;&nbsp;Pada  setiap tempoh yang berikutnya di mana Pihak Diinsuranskan<br>&nbsp;&nbsp;&nbsp;sepatutnya  membuat bayaran  dan Syarikat kemudiannya bersetuju menerima<br>&nbsp;&nbsp;&nbsp;premium pembaharuan</i>
	</font></td>
    <td bordercolor="#000000" width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Total Payable<br><i>Jumlah Berbayar</i></font></td>
    <td bordercolor="#000000" width="20%" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>RM <%=common.stringToHTMLString(NETPREM)%></b></font></td>  
  </tr>
  <%}%>
</table>
<%if(MASTERIND.equals("Y")){%>
<%}else{%>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td bordercolor="#000000" colspan="7" height="20" align="center" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">DESCRIPTION OF INSURED PERSON (S) / <i>DESKRIPSI PIHAK DIINSURANSKAN</i></font></td>
  </tr>
  <tr>
    <td bordercolor="#000000" colspan="7" height="60" align="left" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">On the following employee(s) of the Insured for which the Insured is responsible:<br><i>Ke atas pekerja-pekerja yang Diinsuranskan yang telah dipertanggungjawabkan ke atas Pihak Diinsuranskan:</i></font></td>
  </tr>
</table>
 
<table width="100%" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td bordercolor="#FFFFFF" width="9%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">ID Card No.<br><i>No. Kad ID</i></font></td>
    <td bordercolor="#FFFFFF" width="25%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Name Of Worker / Sex<br><i>Nama Pekerja / Jantina</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Occp. Sector <br>Code/<i>Kod Sektor Pekerjaan</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Date Of Birth<br><i>Tarikh Lahir</i></font></td>
    <td bordercolor="#FFFFFF" width="15%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Passport No.<br><i>No. Passport</i></font></td>
    <td bordercolor="#FFFFFF" width="15%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Country Of Origin<br><i>Negara Asal</i></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Work Permit Expiry Date<br><i>Tarikh Tamat Tempoh Permit</i></font></td>
  </tr>
</table>


<table width="100%" border="1" cellspacing="0" cellpadding="3">
<% if(vItem!=null){
	for(int i=0; i<vItem.size(); i++) 
	{ 
		Vector vItemNo			= (Vector) vItem.elementAt(i);
		String sItemNo			= (String) vItemNo.elementAt(0);
		String sEmp_Name		= (String) vItemNo.elementAt(1);
		String sGender			= (String) vItemNo.elementAt(2);
		String sOccpsec			= (String) vItemNo.elementAt(3);
		String sDob				= (String) vItemNo.elementAt(4);
		String sPassport		= (String) vItemNo.elementAt(5);
		String sNationality		= (String) vItemNo.elementAt(6); 
		
		if(!sDob.equals(""))
            sDob = timestampFormat2.format(timestampFormat3.parse(sDob));		

		SQL	= "SELECT DESCP FROM TB_FWIGPREM WHERE NATIONALITY = '"+sNationality+"' AND INSCODE = '"+PRINCIPLE+"' AND DECLINE <> 'Y' WITH UR";
		String sCountry	= "";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		if(DB_Template.getNextQuery())
			sCountry	= common.setNullToString(DB_Template.getColumnString("DESCP"));
		DB_Template.takeDown();
		
		SQL = "SELECT DESCP FROM TB_OCCUPSECTOR WHERE CODE = '"+sOccpsec+"' AND INSCODE = '"+PRINCIPLE+"' AND DECLINE <> 'Y' WITH UR";
		String sOccupDesc	= "";
		DB_Template.makeConnection();
		DB_Template.executeQuery(SQL);
		if(DB_Template.getNextQuery())
			sOccupDesc	= common.setNullToString(DB_Template.getColumnString("DESCP"));
		DB_Template.takeDown();
%>
  <tr>
    <td bordercolor="#FFFFFF" width="9%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sItemNo)%></b></font></td>
    <td bordercolor="#FFFFFF" width="25%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sEmp_Name)%>&nbsp;(<%=common.stringToHTMLString2(sGender)%>)</b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString2(sOccupDesc)%></b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sDob)%></b></font></td>
    <td bordercolor="#FFFFFF" width="15%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sPassport)%></b></font></td>
    <td bordercolor="#FFFFFF" width="15%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><%=common.stringToHTMLString(sCountry)%></b></font></td>
    <td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&nbsp;</font></td>
  </tr>
<%
	}
   }
%>
</table>
<%}%>

<table width="100%" border="1" cellspacing="0" cellpadding="3">
	<tr>
		<td bordercolor="#FFFFFF" width="100%" align="left" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Subject to the following Clauses / Warranties / Endorsements attached hereto: -<br><i>Tertakluk kepada Fasal / Waranti / Endorsemen berikut yang disertakan bersama ini: -</i></font></td>
	</tr>
	<tr>
		<td bordercolor="#FFFFFF" width="12%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Code / <i>Kod</i></font></td>
		<td bordercolor="#FFFFFF" width="88%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Description / <i>Deskripsi</i></font></td>
	</tr>
<%
if(CLAUSE_PRINT.equals("Y")){
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

<%
if(!MEMO.equals(""))
{
%>
<table width="100%" wrap="off" border="1" cellspacing="0" cellpadding="1">
	<tr>
		<td bordercolor="#000000" width="100%" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Memorandum / <i>Memorandum</i></font></td>
	</tr>
	<tr>
		<td bordercolor="#000000" width="100%" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=common.stringToHTMLString2(MEMO)%></font></td>
	</tr><br><br><br>
</table>
<%
}
%>

<!-- <PAGEBREAK></PAGEBREAK> -->
<jsp:include page="/template/pop_incl_f1.jsp">
    <jsp:param name="issuedby"		value="<%=ISSUEDBY%>" />
    <jsp:param name="prevpol"		value="<%=PREVPOL%>" />
    <jsp:param name="issdate"		value="<%=ISSDATE%>" />
    <jsp:param name="isstime"		value="<%=ISSTIME%>" />
    <jsp:param name="propdate"		value="<%=PROPOSAL_DATE%>" />
    <jsp:param name="specialAgent"	value="<%=specialAgent%>" />
    <jsp:param name="FWCMSREFNO"	value="<%=FWCMSREFNO%>" />
    <jsp:param name="masterpol"		value="<%=MASTERPOL%>" />
</jsp:include>
<PAGEBREAK></PAGEBREAK>
<jsp:include page="/template/pop_incl_f2.jsp">
	<jsp:param name="checkdigit"	value="<%=CHECKDIGIT%>" />
	<jsp:param name="check_ind"		value="Y" />
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
<jsp:param name="CNTYPE"          	value="FWIG" />
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
<%-- <%} %> --%>
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