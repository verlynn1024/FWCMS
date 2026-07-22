<%@ page language="java" import="java.util.*,java.util.Date,java.text.SimpleDateFormat" contentType="text/html;charset=iso-8859-1"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB_Template" scope="page" class="com.rexit.easc.DB_Template" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="QRGenerator" scope="page" class="com.rexit.easc.QRGenerator" />
<%
	String UKEY 	    = common.setNullToString(request.getParameter("UKEY"));
	String GUARANTEE 	= common.setNullToString(request.getParameter("GUARANTEE"));
    String SQL                   = "";
	String GST_AMT			     = "";
	String GST_PCT			     = ""; 
	String GST_RT			     = "";
	String GST_TAX_NO 		     = ""; 
	String GST_TAX_NO_END        = "";
	String GST_TAX_NO_DEBIT      = "";
	String GST_TF_AMT            = "";
	String GST_OTHAMT            = "";
	String GST_FWCMSAMT          = "";
	String TITLE_GST_ENGLISH	 = "";
	String TITLE_GST_MALAY	     = "";
	String PRINCIPLE             = "";
	String DEBIT_NOTE_SERIES     = ""; 
	String CREDIT_NOTE_SERIES    = ""; 
	String GST_TAX_NO_END_SERIES = "";
	String GST_TAX_NO_SERIES     = "";
	String ISSDATE               = "";
    String EFFDATE               = "";
    String EXPDATE               = "";
    String CNCODE                = "";
    String NAME                  = "";
    String ADDRESS_1             = "";
    String ADDRESS_2             = "";
    String ADDRESS_3             = "";
    String ADDRESS_4             = "";
    String POSTCODE              = "";
    String USERID                = "";
    String ACCODE                = "";
    String AGENCY_NAME           = "";
    String GPREM                 = "";  
    String STAXAMT				 = "";
    String STAXPCT				 = "";
    String STAXAMT_TPCA			 = "";
    String REBATEAMT             = "";
    String STAMP                 = "";
    String TRANSFER_FEE          = "";
    String TOTPREM               = "";
    String SERVICE_FEE           = ""; //TB_FWCSSCH
    String FWCMS_FEE	         = "";
    String MAINCLS               = "";
    String NOTE_IND              = "";
    String MAINCLS_DESCP         = "";
    String PACODE                = "";
    String TABLE                 = "";
    String TABLE2                = "";
    String MAINCLS_1             = "";
    String FIELDNAME             = "";
    String INS_FIELD             = "";
    String UKEY_FIELD            = "";
    String STAMP_FIELD           = "";
    String EXTRA_FIELD           = "";
    String TOTALPREM_FIELD       = "";
    String PREVPOL               = "";
    String PREVPOLCNOTE          = "";
    String PREV_CNCODE           = "";
    String CNTYPE				 = "";
   	String TIMESTAMP			 = "";	
   	String REPLACECN			 = "";
   	Date today					 = new Date();
	Date SST_EFFDATE;
	String SST_TRIGGER			 = "";
	String GST_TRIGGER			 = "";
    String GST_EFFDATE			 = "";
    String GST_EXPDATE			 = "";
    	
    SimpleDateFormat timestampFormat2 = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat timestampFormat3 = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat timestampFormat4	= new SimpleDateFormat("yyyyMMddHHmmss");
	SimpleDateFormat timestampFormat5	= new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
	
   	String LONGID = "";
	String UUID = "";
	String LONGID2 = "";
	String UUID2 = "";
	String NEW_GST_TAX_NO = "";
	String NEW_GST_TAX_NO_END = "";
	String qrContent = "";
	String savedPath = "";
	String savedPath2 = "";
	String VALIDATE_TIME = "";
	String VALIDATE_TIME2 = "";
	
	// STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
	String STAMP_FEES				= "";
	
	String myQuery = "SELECT GST_TAX_NO, GST_TAX_NO_END FROM TB_GST_CN WHERE UKEY='" + UKEY + "' WITH UR";
	DB_Template.makeConnection();
	DB_Template.executeQuery(myQuery);
	if(DB_Template.getNextQuery()){
		NEW_GST_TAX_NO = common.setNullToString(DB_Template.getColumnString("GST_TAX_NO"));
		NEW_GST_TAX_NO_END = common.setNullToString(DB_Template.getColumnString("GST_TAX_NO_END"));
	}
		
	if(!NEW_GST_TAX_NO_END.equals("")){
		myQuery = "SELECT * FROM TB_EINVOICE_GET_DOCLOG WHERE CODE_NUMBER='" + NEW_GST_TAX_NO_END + "' WITH UR";
		DB_Template.executeQuery(myQuery);
		if(DB_Template.getNextQuery()){
			LONGID2 = common.setNullToString(DB_Template.getColumnString("LONG_ID"));
			UUID2 = common.setNullToString(DB_Template.getColumnString("UUID"));
				
		}
	}else if(!NEW_GST_TAX_NO.equals("")){
		myQuery = "SELECT * FROM TB_EINVOICE_GET_DOCLOG WHERE CODE_NUMBER='" + NEW_GST_TAX_NO + "' WITH UR";
		DB_Template.executeQuery(myQuery);
		if(DB_Template.getNextQuery()){
			LONGID = common.setNullToString(DB_Template.getColumnString("LONG_ID"));
			UUID = common.setNullToString(DB_Template.getColumnString("UUID"));
				
		}
	}
	DB_Template.takeDown();
 	
	if(!UUID.equals("") && !LONGID.equals("")){
		DB_Template.makeConnection();
		String QR_URL = "";
		myQuery = "SELECT QR_URL FROM TB_EINVOICE_INFO WITH UR";
		DB_Template.executeQuery(myQuery);
			while(DB_Template.getNextQuery())
			{
				QR_URL			= common.setNullToString(DB_Template.getColumnString("QR_URL"));
			}
		DB_Template.takeDown();
		
		qrContent = "https://"+QR_URL+"/"+UUID+"/share/"+LONGID;
		
		savedPath = QRGenerator.saveQRCodeToFile(qrContent, NEW_GST_TAX_NO);	
		
		DB_Template.makeConnection();
		myQuery = "SELECT TIMESTAMP FROM TB_EINVOICE_GET_DOCLOG WHERE UUID='" + UUID + "' WITH UR";
		DB_Template.executeQuery(myQuery);
			while(DB_Template.getNextQuery())
			{
				VALIDATE_TIME = common.setNullToString(DB_Template.getColumnString("TIMESTAMP"));
			}
			
			if(!VALIDATE_TIME.equals("")){
				Date date = timestampFormat4.parse(VALIDATE_TIME);
				VALIDATE_TIME = timestampFormat5.format(date);
			}
		DB_Template.takeDown();
	}else if(!UUID2.equals("") && !LONGID2.equals("")){
		DB_Template.makeConnection();
		String QR_URL = "";
		myQuery = "SELECT QR_URL FROM TB_EINVOICE_INFO WITH UR";
		DB_Template.executeQuery(myQuery);
			while(DB_Template.getNextQuery())
			{
				QR_URL			= common.setNullToString(DB_Template.getColumnString("QR_URL"));
			}
			DB_Template.takeDown();
		
		qrContent = "https://"+QR_URL+"/"+UUID2+"/share/"+LONGID2;
		
		savedPath2 = QRGenerator.saveQRCodeToFile(qrContent, NEW_GST_TAX_NO_END);	
		
		DB_Template.makeConnection();
		myQuery = "SELECT TIMESTAMP FROM TB_EINVOICE_GET_DOCLOG WHERE UUID='" + UUID2 + "' WITH UR";
		DB_Template.executeQuery(myQuery);
			while(DB_Template.getNextQuery())
			{
				VALIDATE_TIME2 = common.setNullToString(DB_Template.getColumnString("TIMESTAMP"));
			}
		
			if(!VALIDATE_TIME2.equals("")){
				Date date = timestampFormat4.parse(VALIDATE_TIME2);
				VALIDATE_TIME2 = timestampFormat5.format(date);
			}
		DB_Template.takeDown();
	}
    
    SQL = "SELECT PRINCIPLE, CLASS FROM TB_TRANSACTION WHERE IDNO = '" + UKEY + "' WITH UR"; 
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {   
        PRINCIPLE       = common.setNullToString(DB_Template.getColumnString("PRINCIPLE"));
    	MAINCLS         = common.setNullToString(DB_Template.getColumnString("CLASS")); 
    	
    }
	DB_Template.takeDown();
	
	SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + UKEY + "' AND PRINCIPLE = '" + PRINCIPLE + "' WITH UR"; 
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {   
    	GST_PCT			= common.setNullToString(DB_Template.getColumnString("GST_PCT"));
    	GST_AMT			= common.setNullToString(DB_Template.getColumnString("GST_AMT"));
    	GST_RT			= common.setNullToString(DB_Template.getColumnString("GST_RT"));
    	GST_TAX_NO		= common.setNullToString(DB_Template.getColumnString("GST_TAX_NO"));
    	GST_TAX_NO_END  = common.setNullToString(DB_Template.getColumnString("GST_TAX_NO_END")); 
    	GST_TF_AMT  	= common.setNullToString(DB_Template.getColumnString("GST_TF_AMT")); 
    	GST_OTHAMT      = common.setNullToString(DB_Template.getColumnString("GST_OTHAMT")); 
    	GST_FWCMSAMT    = common.setNullToString(DB_Template.getColumnString("GST_FWCMSAMT")); 
    	TIMESTAMP		= common.setNullToString(DB_Template.getColumnString("TIMESTAMP"));
    }
	DB_Template.takeDown();


	if (GST_RT.equals(""))
	{	  
	  if (!GST_PCT.equals("") && !GST_AMT.equals(""))
	  {
		  if (Double.parseDouble(GST_PCT)> 0 &&  Double.parseDouble(GST_AMT) > 0 )
		  {
		        GST_RT = "SR";
		  }    
	  }else {
	  
			GST_RT = "ZR";
		}
	} 
	if(GST_RT.equals("SST")){
		GST_RT = "";
	}
	
	String SST_FIELD = "";
	if (MAINCLS.equals("FWHS")) 
	{	   
	    MAINCLS         = "FWHS";
	    TABLE	        = "TB_FWHSCN"; 
	    TABLE2	        = "TB_FWHSSCH"; 
	    FIELDNAME       = "CNCODE";
	    INS_FIELD       = "PRINCIPLE";
	    UKEY_FIELD      = "UKEY2";	
	    STAMP_FIELD     = "STAMPDUTY";
	    EXTRA_FIELD     = "REBATEAMT,SERVICE_FEE,FWCMS_FEE, STAMP_FEES";	// STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
	    TOTALPREM_FIELD = "NETPREM";
	    SST_FIELD		= "FWHS";	    		
	}
	else if (MAINCLS.equals("IG")) 
	{	   
	    MAINCLS         = "IG";	
	    TABLE	        = "TB_FWIGCN"; 	
	    TABLE2	        = "TB_FWIGSCH";
	    FIELDNAME       = "CNCODE";
	    INS_FIELD       = "PRINCIPLE";
	    UKEY_FIELD      = "UKEY2";
	    STAMP_FIELD     = "STAMPDUTY";	
	    EXTRA_FIELD     = "REBATEAMT, STAMP_FEES"; // STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
	    TOTALPREM_FIELD = "NETPREM";
	    SST_FIELD		= "FWIG";							
	}
	else if (MAINCLS.equals("FWCS") || MAINCLS.equals("WM")) 
	{	   
	    MAINCLS         = "WM";	
	    MAINCLS_1       = "FWCS";	
	    TABLE	        = "TB_FWCSCN"; 	
	    TABLE2	        = "TB_FWCSSCH";
	    FIELDNAME       = "CNCODE";
	    INS_FIELD       = "PRINCIPLE";
	    UKEY_FIELD      = "UKEY2";	
	    STAMP_FIELD     = "STAMPDUTY";	
	    EXTRA_FIELD     = "REBATEAMT,SERVICE_FEE";
	    TOTALPREM_FIELD = "NETPREM";			 
	}

	SQL = "SELECT ISSDATE FROM "+TABLE+" WHERE UKEY ='" + UKEY + "' WITH UR";
	DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {   
         ISSDATE   = common.setNullToString(DB_Template.getColumnString("ISSDATE"));
    }
    DB_Template.takeDown();
    
    SQL = "SELECT STAXPCT FROM  "+TABLE2+" WHERE UKEY2 ='" + UKEY + "' WITH UR";
	DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {   
         STAXPCT   = common.setNullToString(DB_Template.getColumnString("STAXPCT"));
    }
    DB_Template.takeDown();
	//SST/*
	String SST_EFFDATE_1 		= "";
	SQL	= "SELECT EFFDATE FROM TB_SST WHERE INSCODE = '08' AND MAINCLS = '"+SST_FIELD+"' AND SST_PCT != '0.00' ORDER BY EFFDATE ASC FETCH FIRST ROW ONLY WITH UR";
	DB_Template.makeConnection();
	DB_Template.executeQuery(SQL);
	if(DB_Template.getNextQuery()) 
	{
		SST_EFFDATE_1 = common.setNullToString(DB_Template.getColumnString("EFFDATE"));		
	}
	SST_EFFDATE 		 = timestampFormat3.parse(SST_EFFDATE_1);
	if(!ISSDATE.equals("")){
		today				 = timestampFormat3.parse(ISSDATE);
	}
	DB_Template.takeDown();
	if((today.after(SST_EFFDATE) || today.compareTo(SST_EFFDATE) == 0) && Double.parseDouble(STAXPCT) > 0){
		SST_TRIGGER = "Y";
	}
	SQL	= "SELECT VALUE1,VALUE3 FROM TB_CONTROL WHERE INSCODE = '08' AND TYPE = 'GST' ORDER BY AUTONUM DESC FETCH FIRST ROW ONLY WITH UR";
	DB_Contact.makeConnection();
	DB_Contact.executeQuery(SQL);
	if(DB_Contact.getNextQuery()) 
	{
		GST_EFFDATE	  = common.setNullToString(DB_Contact.getColumnString("VALUE1"));	
		GST_EXPDATE	  = common.setNullToString(DB_Contact.getColumnString("VALUE3"));	
	}
	DB_Contact.takeDown();	
	if((Integer.parseInt(ISSDATE)< Integer.parseInt(GST_EXPDATE) && Integer.parseInt(ISSDATE)>= Integer.parseInt(GST_EFFDATE)) || SST_TRIGGER.equals("")){
		GST_TRIGGER = "Y";
	}
	SQL = "SELECT DESCP FROM TB_MAINCLS WHERE INSCODE = '" + PRINCIPLE + "' AND CODE = '" + MAINCLS + "' WITH UR"; 
	DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {   
        MAINCLS_DESCP   = common.setNullToString(DB_Template.getColumnString("DESCP"));  
        MAINCLS_DESCP   = MAINCLS_DESCP.toUpperCase(); 	
    }
	DB_Template.takeDown();
	
	if(SST_TRIGGER.equals("Y"))
	{
		SQL = "SELECT SERIES FROM TB_CNSERIES WHERE INSCODE = '" + PRINCIPLE + "' AND  CLS='SST_DEBIT_NOTE' WITH UR"; 
	}else{		
		SQL = "SELECT SERIES FROM TB_CNSERIES WHERE INSCODE = '" + PRINCIPLE + "' AND  CLS='DEBIT_NOTE' WITH UR"; 
	}
	DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {   
        DEBIT_NOTE_SERIES   = common.setNullToString(DB_Template.getColumnString("SERIES"));   	
    }
	DB_Template.takeDown();
	
	if(SST_TRIGGER.equals("Y"))
	{
		SQL = "SELECT SERIES FROM TB_CNSERIES WHERE INSCODE = '" + PRINCIPLE + "' AND  CLS='SST_CREDIT_NOTE' WITH UR"; 
	}else{	
		SQL = "SELECT SERIES FROM TB_CNSERIES WHERE INSCODE = '" + PRINCIPLE + "' AND  CLS='CREDIT_NOTE' WITH UR"; 
	}
	DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {   
        CREDIT_NOTE_SERIES   = common.setNullToString(DB_Template.getColumnString("SERIES"));   	
    }
	DB_Template.takeDown();
	if (!GST_TAX_NO.equals("") && GST_TAX_NO_END.equals(""))
	{
		if(GST_TRIGGER.equals("Y")){
	    	TITLE_GST_ENGLISH		= "Tax Invoice";
	    	TITLE_GST_MALAY  		= "Invois Cukai";
	    	NOTE_IND                = "T";
	    }
	    else if (SST_TRIGGER.equals("Y")){
				TITLE_GST_ENGLISH		= "Invoice";
	    		TITLE_GST_MALAY  		= "Invois";
	    		NOTE_IND                = "T";
		}
		else{
				TITLE_GST_ENGLISH		= "Invoice";
	    		TITLE_GST_MALAY  		= "Invois";
	    		NOTE_IND                = "T";
		}
	}
	if (!GST_TAX_NO_END.equals("")) 
	{
		GST_TAX_NO_END_SERIES = GST_TAX_NO_END.substring(0,3);
		if (GST_TAX_NO_END_SERIES.equals(CREDIT_NOTE_SERIES) && GST_TRIGGER.equals("Y"))
		{
		    TITLE_GST_ENGLISH		= "GST Credit Note";
		    TITLE_GST_MALAY  		= "Penyata Kredit GST";
		    NOTE_IND                = "C";
		}
		else if (GST_TAX_NO_END_SERIES.equals(CREDIT_NOTE_SERIES) && SST_TRIGGER.equals("Y")){

		    TITLE_GST_ENGLISH		= "Credit Note";
		    TITLE_GST_MALAY  		= "Penyata Kredit";
		    NOTE_IND                = "C";		
		}
		else if (GST_TAX_NO_END_SERIES.equals(CREDIT_NOTE_SERIES)){

		    TITLE_GST_ENGLISH		= "Credit Note";
		    TITLE_GST_MALAY  		= "Penyata Kredit";
		    NOTE_IND                = "C";		
		}
	}
	else if (!GST_TAX_NO.equals("")) 
	{
	    GST_TAX_NO_SERIES = GST_TAX_NO.substring(0,3);
			if (GST_TAX_NO_SERIES.equals(DEBIT_NOTE_SERIES) && GST_TRIGGER.equals("Y"))
		{
		    TITLE_GST_ENGLISH		= "GST Debit Note";
		    TITLE_GST_MALAY  		= "Penyata Debit GST";
		    NOTE_IND                = "D";
		    GST_TAX_NO_DEBIT        = GST_TAX_NO;
		    GST_TAX_NO              = "";
		}
		else if(GST_TAX_NO_SERIES.equals(DEBIT_NOTE_SERIES) && SST_TRIGGER.equals("Y")){
		    TITLE_GST_ENGLISH		= "Debit Note";
		    TITLE_GST_MALAY  		= "Penyata Debit";
		    NOTE_IND                = "D";
		    GST_TAX_NO_DEBIT        = GST_TAX_NO;
		    GST_TAX_NO              = "";		
		}
		else if(GST_TAX_NO_SERIES.equals(DEBIT_NOTE_SERIES)){

		    TITLE_GST_ENGLISH		= "Debit Note";
		    TITLE_GST_MALAY  		= "Penyata Debit";
		    NOTE_IND                = "D";
		    GST_TAX_NO_DEBIT        = GST_TAX_NO;
		    GST_TAX_NO              = "";	
		}
	}
				
	SQL = "SELECT ISSDATE,EFFDATE,EXPDATE, "+FIELDNAME+" AS CNCODE,NAME,ADDRESS_1,ADDRESS_2,ADDRESS_3,ADDRESS_4,POSTCODE,USERID,"+INS_FIELD+" AS PRINCIPLE,ACCODE,PREVPOL,CNTYPE,REPLACECN FROM "+TABLE+" WHERE UKEY ='" + UKEY + "' WITH UR";
	DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {   
         ISSDATE   = common.setNullToString(DB_Template.getColumnString("ISSDATE"));
         EFFDATE   = common.setNullToString(DB_Template.getColumnString("EFFDATE"));
         EXPDATE   = common.setNullToString(DB_Template.getColumnString("EXPDATE"));
         CNCODE    = common.setNullToString(DB_Template.getColumnString("CNCODE"));
         NAME      = common.setNullToString(DB_Template.getColumnString("NAME"));
         ADDRESS_1 = common.setNullToString(DB_Template.getColumnString("ADDRESS_1"));
         ADDRESS_2 = common.setNullToString(DB_Template.getColumnString("ADDRESS_2"));
         ADDRESS_3 = common.setNullToString(DB_Template.getColumnString("ADDRESS_3"));
         ADDRESS_4 = common.setNullToString(DB_Template.getColumnString("ADDRESS_4")); 
         POSTCODE  = common.setNullToString(DB_Template.getColumnString("POSTCODE"));
         USERID    = common.setNullToString(DB_Template.getColumnString("USERID"));
         PRINCIPLE = common.setNullToString(DB_Template.getColumnString("PRINCIPLE"));
         ACCODE    = common.setNullToString(DB_Template.getColumnString("ACCODE"));
         PREVPOL   = common.setNullToString(DB_Template.getColumnString("PREVPOL"));
         CNTYPE    = common.setNullToString(DB_Template.getColumnString("CNTYPE"));	         
         REPLACECN = common.setNullToString(DB_Template.getColumnString("REPLACECN"));
    }
    DB_Template.takeDown();
       
    if(!ISSDATE.equals(""))
    {
       ISSDATE = timestampFormat2.format(timestampFormat3.parse(ISSDATE));
    }
    
    if(EFFDATE.equals(""))
    {
       EFFDATE = "-";
    }
    else
    {
       EFFDATE = timestampFormat2.format(timestampFormat3.parse(EFFDATE));
    }
    
    if(EXPDATE.equals(""))
    {
       EXPDATE = "-";    
	}
	else
	{
        EXPDATE = timestampFormat2.format(timestampFormat3.parse(EXPDATE));    
    }
    
    if(!TIMESTAMP.equals(""))
    {
      	TIMESTAMP = TIMESTAMP.substring(0, 10);
    }
    
	// STFee_FT_A3_RetrieveStampFees --- Retrieve Stamp Fees [StampFees_Flowchart_v1.0]
	SQL = "SELECT STAXAMT,STAXPCT,LEVYAMT, GPREM, "+STAMP_FIELD+" AS STAMP, "+TOTALPREM_FIELD+" AS TOTPREM "; 

	if (!EXTRA_FIELD.equals(""))
	{
		SQL +=", "+EXTRA_FIELD+" ";
	}

	if( CNTYPE.equals("ECS_POC")) {
		CNTYPE = "Change of Period of Cover";
	}else if (CNTYPE.equals("ECS_WORKER_DET")){
		CNTYPE = "Change of Worker Details";
	}	

	SQL +=" FROM "+TABLE2+" WHERE "+UKEY_FIELD+" = '" + UKEY + "' WITH UR "; 
	DB_Template.makeConnection();
	DB_Template.executeQuery(SQL);
	while(DB_Template.getNextQuery())
	{
		GPREM         = common.setNullToString(DB_Template.getColumnString("GPREM"));
		STAMP         = common.setNullToString(DB_Template.getColumnString("STAMP"));
		TOTPREM       = common.setNullToString(DB_Template.getColumnString("TOTPREM")); 
		STAXAMT	   = common.setNullToString(DB_Template.getColumnString("STAXAMT"));
		STAXPCT	   = common.setNullToString(DB_Template.getColumnString("STAXPCT"));
		STAXAMT_TPCA  = common.setNullToString(DB_Template.getColumnString("LEVYAMT")); 

		if (MAINCLS.equals("MT") || MAINCLS.equals("WM") || MAINCLS.equals("IG") || MAINCLS.equals("FWHS") || MAINCLS.equals("FI") || MAINCLS.equals("PA") )
		{
			REBATEAMT     = common.setNullToString(DB_Template.getColumnString("REBATEAMT"));
		}

		if (MAINCLS.equals("MT"))
		{         
			TRANSFER_FEE  = common.setNullToString(DB_Template.getColumnString("TRANSFER_FEE"));
		}

		if (MAINCLS_1.equals("FWCS"))
		{   
			SERVICE_FEE   = common.setNullToString(DB_Template.getColumnString("SERVICE_FEE"));
		}
		else if (MAINCLS.equals("FWHS"))
		{   
			SERVICE_FEE   = common.setNullToString(DB_Template.getColumnString("SERVICE_FEE"));
			FWCMS_FEE     = common.setNullToString(DB_Template.getColumnString("FWCMS_FEE"));
		}

		if(MAINCLS.equals("FWHS") || MAINCLS.equals("IG")){
			STAMP_FEES		= common.setNullToString(DB_Template.getColumnString("STAMP_FEES"));
		}
    }
	// STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0]
	boolean showStampFees = false;
	if(STAMP_FEES.equals("10.00")){
		showStampFees = true;
	}

    if(STAXAMT.equals("")){
    	STAXAMT = "0.00";
    }
    if(STAXPCT.equals("")){
    	STAXAMT = "0.00";
    }
    DB_Template.takeDown();
    
    SQL = "SELECT * FROM TB_USER_AM WHERE USERID = '" + USERID + "' WITH UR ";
    DB_Template.makeConnection();
    DB_Template.executeQuery(SQL);
    while(DB_Template.getNextQuery())
    {
         AGENCY_NAME         = common.setNullToString(DB_Template.getColumnString("AGENCY_NAME"));  
    } 
    DB_Template.takeDown();
     
    if(TRANSFER_FEE.equals(""))
    {
       TRANSFER_FEE = "0.00";
    }
    
    if(GST_TF_AMT.equals(""))
    {
       GST_TF_AMT = "0.00";
    }
    
    if(SERVICE_FEE.equals(""))
    {
       SERVICE_FEE = "0.00";
    }
    
    if(FWCMS_FEE.equals(""))
    {
       FWCMS_FEE = "0.00";
    }
    
    if(GST_OTHAMT.equals(""))
    {
       GST_OTHAMT = "0.00";
    }
    
    if(GST_FWCMSAMT.equals(""))
    {
       GST_FWCMSAMT = "0.00";
    }
    
    if(GPREM.equals(""))
    {
       GPREM= "0.00";
    }
    
    if(STAMP.equals("")) 
    {
       STAMP= "0.00";
    }
    
    if(TOTPREM.equals(""))
    {
       TOTPREM= "0.00";
    }
    
    if(REBATEAMT.equals(""))
    {
       REBATEAMT= "0.00";
    }  
        
    SERVICE_FEE	= common.twoDecimal(common.formatdouble(SERVICE_FEE)+common.formatdouble(FWCMS_FEE));
	GST_OTHAMT	= common.twoDecimal(common.formatdouble(GST_OTHAMT)+common.formatdouble(GST_FWCMSAMT));
	
%> 
<%
	if(NOTE_IND.equals("C")){ 
		String temp_GPREM			= "0.00";		
  	    String temp_GST_AMT			= "0.00";
  	    String temp_STAXAMT			= "0.00";
  	    String temp_STAXAMT_TPCA	= "0.00";
  	    String temp_SERVICE_FEE		= "0.00";
  	    String temp_GST_OTHAMT		= "0.00";
  	    String temp_FWCMS_FEE		= "0.00";
  	    String temp_GST_FWCMSAMT	= "0.00";
  	    String temp_TOTPREM			= "0.00";
  	    String temp_STAMP			= "0.00";
  	    String temp_REBATEAMT		= "0.00";
  	    SQL = "SELECT * FROM " + TABLE2 + " WHERE UKEY2 = '" + PRINCIPLE + REPLACECN + "' WITH UR ";
	    DB_Template.makeConnection();
	    DB_Template.executeQuery(SQL);
	    while(DB_Template.getNextQuery())
	    {
	        temp_GPREM			= common.setNullToString(DB_Template.getColumnString("GPREM"));
	  	    temp_SERVICE_FEE	= common.setNullToString(DB_Template.getColumnString("SERVICE_FEE"));
	  	    temp_TOTPREM        = common.setNullToString(DB_Template.getColumnString("TOTPREM")); 
	  	    temp_STAXAMT        = common.setNullToString(DB_Template.getColumnString("STAXAMT")); 
 			if (TABLE2.equals("TB_FWHSSCH") || TABLE2.equals("TB_FWCSSCH"))
         	{	  	   
         		temp_STAXAMT_TPCA   = common.setNullToString(DB_Template.getColumnString("LEVYAMT"));
         		temp_REBATEAMT		= common.setNullToString(DB_Template.getColumnString("REBATEAMT"));
	  	    }   
	  	    if (MAINCLS.equals("FWHS"))
         	{
	  	    	temp_FWCMS_FEE		= common.setNullToString(DB_Template.getColumnString("FWCMS_FEE"));	  	    	
  	   		}
	    } 
	    DB_Template.takeDown();
	    
		SQL = "SELECT * FROM TB_GST_CN WHERE UKEY = '" + PRINCIPLE + REPLACECN + "' WITH UR ";
	    DB_Template.makeConnection();
	    DB_Template.executeQuery(SQL);
	    while(DB_Template.getNextQuery())
	    {
	  	    temp_GST_AMT		= common.setNullToString(DB_Template.getColumnString("GST_AMT"));
	  	    temp_GST_OTHAMT		= common.setNullToString(DB_Template.getColumnString("GST_OTHAMT"));
	  	    temp_GST_FWCMSAMT	= common.setNullToString(DB_Template.getColumnString("GST_FWCMSAMT"));
	    } 
	    DB_Template.takeDown();
	    
	   
	    temp_SERVICE_FEE	= common.twoDecimal(common.formatdouble(temp_SERVICE_FEE)+common.formatdouble(temp_FWCMS_FEE));
		temp_GST_OTHAMT		= common.twoDecimal(common.formatdouble(temp_GST_OTHAMT)+common.formatdouble(temp_GST_FWCMSAMT));
	    STAXAMT				= common.twoDecimal(common.formatdouble(temp_STAXAMT)-common.formatdouble(STAXAMT));
	    STAXAMT_TPCA		= common.twoDecimal(common.formatdouble(temp_STAXAMT_TPCA)-common.formatdouble(STAXAMT_TPCA));
	    GPREM				= common.twoDecimal(common.formatdouble(temp_GPREM)-common.formatdouble(GPREM));
  	    if(GPREM.equals("0.00")){
	    	temp_STAMP		= common.twoDecimal(common.formatdouble(STAMP));
	    }
	    REBATEAMT			= common.twoDecimal(common.formatdouble(temp_REBATEAMT)-common.formatdouble(REBATEAMT));
	    STAMP				= common.twoDecimal(common.formatdouble(temp_STAMP));
  	    GST_AMT				= common.twoDecimal(common.formatdouble(temp_GST_AMT)-common.formatdouble(GST_AMT));
  	    SERVICE_FEE			= common.twoDecimal(common.formatdouble(temp_SERVICE_FEE)-common.formatdouble(SERVICE_FEE));
  	    GST_OTHAMT			= common.twoDecimal(common.formatdouble(temp_GST_OTHAMT)-common.formatdouble(GST_OTHAMT));
  	    TOTPREM				= common.twoDecimal(common.formatdouble(GPREM)+common.formatdouble(GST_AMT)+common.formatdouble(SERVICE_FEE)+common.formatdouble(GST_OTHAMT)+common.formatdouble(STAXAMT)+common.formatdouble(STAXAMT_TPCA)+common.formatdouble(temp_STAMP)-common.formatdouble(REBATEAMT));
	}
	
%>

<html>
<body>
<%if(!NOTE_IND.equals("")){ %>
 	<%if(!GUARANTEE.equals("Y")){%>
	<table cellspacing="0" cellpadding="0" width="100%" border="0" bordercolor="#000000">
		<tr>
			<td colspan ="4" height="130" >
			&nbsp;
			</td>
		</tr>
	</table>
	<%}%>
<table cellspacing="0" cellpadding="0" width="100%" border="0" bordercolor="#000000"> 
	<tr>
		<td align="center" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="3" color="#000000"><b><%=common.stringToHTMLString(TITLE_GST_ENGLISH)%></b></font></td>
	</tr>
	<tr>
		<td align="center" valign="bottom"><font face="Verdana, Arial, Helvetica, sans-serif" size="3" color="#000000"><b><i><%=common.stringToHTMLString(TITLE_GST_MALAY)%></i></b></font></td>
	</tr>	
</table>
<br/>
<table width="100%" border="1" cellpadding="3" cellspacing="0" bordercolor="#000000" >


<%if(NOTE_IND.equals("T")){ %>
 
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  	  	<%if(GST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Tax Invoice No : <br> <i>No. Invois Cukai</i></font></td>
  		<%}else if(SST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Invoice No : <br> <i>No. Invois</i></font></td>
  		<%}%>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(GST_TAX_NO)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Date : <br> <i>Tarikh</i></font></td>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(ISSDATE)%></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
<%}%> 
 
<%if(NOTE_IND.equals("D")){ %>
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<%if(GST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">GST Debit Note No : <br><i>No. Penyata Debit GST</i></font></td>
  		<%}else if(SST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Debit Note No : <br><i>No. Penyata Debit</i></font></td>
  		<%} %>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(GST_TAX_NO_DEBIT)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Date : <br> <i>Tarikh</i></font></td>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(ISSDATE)%></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>	
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<%if(GST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Tax Invoice No (Reference) : <br> <i>No. Invois Cukai (Rujukan)</i></font></td>
  		<%}else if(SST_TRIGGER.equals("Y")){%>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Invoice No (Reference) : <br> <i>No. Invois (Rujukan)</i></font></td>
  		<%}%>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(GST_TAX_NO)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Tax Invoice Date : <br><i>Tarikh Invois Cukai</i></font></td>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(TIMESTAMP)%></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
<%}%> 

<%if(NOTE_IND.equals("C")){ %> 
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<%if(GST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">GST Credit Note No : <br><i>No. Penyata Credit GST</i></font></td>
  		<%}else if(SST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Credit Note No : <br><i>No. Penyata Credit</i></font></td>
  		<%} %>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(GST_TAX_NO_END)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Date : <br> <i>Tarikh</i></font></td>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(ISSDATE)%></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<%if(GST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Tax Invoice No (Reference) : <br> <i>No. Invois Cukai (Rujukan)</i></font></td>
  		<%}else if(SST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Invoice No (Reference) : <br> <i>No. Invois (Rujukan)</i></font></td>
  		<%}%>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(GST_TAX_NO)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  	    <%if(GST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Tax Invoice Date : <br><i>Tarikh Invois Cukai</i></font></td>
  		<%}else if(SST_TRIGGER.equals("Y")){ %>
  			<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Invoice Date : <br><i>Tarikh Invois</i></font></td>
  		<%} %>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(TIMESTAMP)%></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
<%}%>

    <tr>
  		<td width="100%"  colspan="7" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">_________________________________________________________________________________________________________________________</font></td>
	</tr>
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Name : <br> <i>Nama</i></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(NAME.toUpperCase())%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Insurer Address : <br> <i>Alamat</i></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%if(!ADDRESS_1.equals(""))%><%=common.stringToHTMLString(ADDRESS_1.toUpperCase())%><%if(!ADDRESS_2.equals("")){%><br><%=common.stringToHTMLString(ADDRESS_2.toUpperCase())%><%}%><%if(!ADDRESS_3.equals("")){%><br><%=common.stringToHTMLString(ADDRESS_3.toUpperCase())%><%}%><%if(!POSTCODE.equals("")){%><br><%=common.stringToHTMLString(POSTCODE.toUpperCase())%><%}%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
	<tr>
  		<td width="100%"  colspan="7" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">_________________________________________________________________________________________________________________________</font></td>
	</tr>
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Agent Name : <br> <i>Nama Agent</i></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(AGENCY_NAME)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Account No : <br> <i>No Akaun</i></font></td>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(ACCODE)%></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
	<tr>
  		<td width="100%"  colspan="7" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">_________________________________________________________________________________________________________________________</font></td>
	</tr>
	
 	<% if(NOTE_IND.equals("T")){ %> 
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Policy / Endorsement No : <br> <i>No. Polisi / Endorsemen</i></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(CNCODE)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
	<%}%> 
		
	<% if ( NOTE_IND.equals("C") || NOTE_IND.equals("D")) { %>   
		<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Policy / Endorsement No : <br> <i>No. Polisi / Endorsemen</i></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(CNCODE)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Reason : <br> <i>Sebab</i></font>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=CNTYPE%></font></td> 		
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
	<%} %>
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Class of Policy : <br> <i>Jenis Insurans</i></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=common.stringToHTMLString(MAINCLS_DESCP)%></font></td>
  	    <td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="25%" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="5%" valign="top"  bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
	<tr>
  		<td width="5%"  valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
  		<td width="20%" valign="top" bordercolor="#FFFFFF"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Period of Insurance : <br> <i>Tempoh Insurans</i></font></td>
  		<td colspan="5" valign="top" bordercolor="#FFFFFF" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">From &nbsp;&nbsp;&nbsp;&nbsp;<%=common.stringToHTMLString(EFFDATE)%> &nbsp;&nbsp;&nbsp;&nbsp;To &nbsp;&nbsp;&nbsp;&nbsp;<%=common.stringToHTMLString(EXPDATE)%></font></td>
	</tr>

<%if(NOTE_IND.equals("T")){ %> 

<%if (MAINCLS.equals("MT")){%>
 
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br>6<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Gross Premium / <i>Premium Kasar</i><br>
  		Rebate / <i>Rebat</i><br>
  		GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  		Stamp Duty / <i>Duti Setem</i><br>
  		Transfer fees / <i>Yuran Pemindahan</i><br>
  		GST on Tranfer Fees / <i>GST Yuran Pemindahan</i><br> </font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(GPREM)%><br>
  	    <%=common.fnFormatComma(REBATEAMT)%><br>
  	    <%=common.fnFormatComma(GST_AMT)%><br>
  	    <%=common.fnFormatComma(STAMP)%><br>
  	    <%=common.fnFormatComma(TRANSFER_FEE)%><br> 
  	    <%=common.fnFormatComma(GST_TF_AMT)%><br></font></td>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">6<br>7<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>

<%}else if (MAINCLS.equals("DPPA")|| MAINCLS.equals("MCPA") || MAINCLS.equals("MCPI") || MAINCLS.equals("AUTO") || MAINCLS.equals("FI") || MAINCLS.equals("PA") || MAINCLS.equals("IG")){%>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4"  valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2"  valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
		<%// STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0]
			if(showStampFees){%>
		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br></font></td>
		<td colspan="4"  valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
			<%if(SST_TRIGGER.equals("Y")){%>
				Gross Premium / <i>Premium Kasar</i><br>
				Rebate / <i>Rebat</i><br>
	  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
	  			Stamp Duty / <i>Duti Setem</i><br>
	  			Stamp Fees / <i>Caj Setem</i><br></font></td>
	  	    	<td colspan="2"  valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  	    	<%=common.fnFormatComma(GPREM)%><br>
	  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
	  	    	<%=common.fnFormatComma(STAXAMT)%><br>
	  	    	<%=common.fnFormatComma(STAMP)%><br>
	  	    	<%=common.fnFormatComma(STAMP_FEES)%><br></font></td>
	  	    	<%} else{%>
	  	    	Gross Premium / <i>Premium Kasar</i><br>
	  			Rebate / <i>Rebat</i><br>
	  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
	  			Stamp Duty / <i>Duti Setem</i><br>
	  			Stamp Fees / <i>Caj Setem</i><br></font></td>
	  	    	<td colspan="2"  valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  	    	<%=common.fnFormatComma(GPREM)%><br>
	  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
	  	    	<%=common.fnFormatComma(GST_AMT)%><br>
	  	    	<%=common.fnFormatComma(STAMP)%><br>
	  	    	<%=common.fnFormatComma(STAMP_FEES)%><br></font></td>
  	    	<%} %>
    	<%} else{ %>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br></font></td>
  		<td colspan="4"  valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  			<%if(SST_TRIGGER.equals("Y")){%>
	  			Gross Premium / <i>Premium Kasar</i><br>
	  			Rebate / <i>Rebat</i><br>
	  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
	  			Stamp Duty / <i>Duti Setem</i><br></font></td>
	  	    	<td colspan="2"  valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  	    	<%=common.fnFormatComma(GPREM)%><br>
	  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
	  	    	<%=common.fnFormatComma(STAXAMT)%><br>
	  	    	<%=common.fnFormatComma(STAMP)%><br></font></td>
	  	    	<%} else{%>
	  	    	Gross Premium / <i>Premium Kasar</i><br>
	  			Rebate / <i>Rebat</i><br>
	  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
	  			Stamp Duty / <i>Duti Setem</i><br></font></td>
	  	    	<td colspan="2"  valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  	    	<%=common.fnFormatComma(GPREM)%><br>
	  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
	  	    	<%=common.fnFormatComma(GST_AMT)%><br>
	  	    	<%=common.fnFormatComma(STAMP)%><br></font></td>
  	    	<%} %>
  		<%} %>
  		
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">5<br>6<br></font></td>
  		<td colspan="4"  valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>

<%}else if (MAINCLS.equals("WM")){%>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br>6<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		<%if(GST_TRIGGER.equals("Y")){%>
  			Gross Premium / <i>Premium Kasar</i><br>
  			Rebate / <i>Rebat</i><br>
  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			Service Fees / <i>Yuran Perkhidmatan</i><br>
  			GST on Service Fees / <i>GST Yuran Perkhidmatan</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
  	    	<%=common.fnFormatComma(GST_AMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	<%=common.fnFormatComma(GST_OTHAMT)%><br></font></td>
  	    <%} else if(SST_TRIGGER.equals("Y")){%>
  			Gross Premium / <i>Premium Kasar</i><br>
  			Rebate / <i>Rebat</i><br>
  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			Service Fees / <i>Yuran Perkhidmatan</i><br>
  			<%= common.getKey(STAXPCT,".") %>% Service Charge on Service Fees / <i><%= common.getKey(STAXPCT,".") %>% Caj Perkhidmatan pada Yuran Perkhidmatan</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
  	    	<%=common.fnFormatComma(STAXAMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
			<%=common.fnFormatComma(STAXAMT_TPCA)%><br></font></td>
  	    <%} %>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">7<br>8<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>
	
<%}else if (MAINCLS.equals("FWHS")){%>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
		<%// STFee_FT_A5_DisplayStampFees --- Display Stamp Fees for PDF [StampFees_Flowchart_v1.0]
		if(showStampFees){%>
		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br>6<br>7<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  		<%if(GST_TRIGGER.equals("Y")){%>
	  			Gross Premium / <i>Premium Kasar</i><br>
	  			Rebate / <i>Rebat</i><br>
	  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
	  			Stamp Duty / <i>Duti Setem</i><br>
	  			Stamp Fees / <i>Caj Setem</i><br>
	  			TPCA Fee/Service Fee / <i>Yuran TPCA/Perkhidmatan</i> <br>
	  			<%= common.getKey(GST_PCT,".") %>% GST on TPCA/Service Fee / <i><%= common.getKey(GST_PCT,".") %>% Duti Setem/Yuran Perkhidmatan</i><br> </font></td>
	  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  	    	<%=common.fnFormatComma(GPREM)%><br>
	  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
	  	    	<%=common.fnFormatComma(GST_AMT)%><br>
	  	    	<%=common.fnFormatComma(STAMP)%><br>
	  	    	<%=common.fnFormatComma(STAMP_FEES)%><br>
	  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
	  	    	<%=common.fnFormatComma(GST_OTHAMT)%><br></font></td>
	  	    <%} else if(SST_TRIGGER.equals("Y")){%>
				Gross Premium / <i>Premium Kasar</i><br>
	  			Rebate / <i>Rebat</i><br>
	  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
	  			Stamp Duty / <i>Duti Setem</i><br>
	  			Stamp Fees / <i>Caj Setem</i><br>
	  			TPCA Fee/Service Fee / <i>Yuran TPCA/Perkhidmatan</i> <br> 
	  			<%= common.getKey(STAXPCT,".") %>% Service Charge on TPCA/Service Fee / <i><%= common.getKey(STAXPCT,".") %>% Caj Perkhidmatan pada Yuran TPCA/Yuran Perkhidmatan </i><br> </font></td>
	  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  	    	<%=common.fnFormatComma(GPREM)%><br>
	  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
	  	    	<%=common.fnFormatComma(STAXAMT)%><br>
	  	    	<%=common.fnFormatComma(STAMP)%><br>
	  	    	<%=common.fnFormatComma(STAMP_FEES)%><br>
	  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
	  	    	<%=common.fnFormatComma(STAXAMT_TPCA)%><br></font></td>
	  	    <%}%>
		<%}else{%>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br>6<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  		<%if(GST_TRIGGER.equals("Y")){%>
	  			Gross Premium / <i>Premium Kasar</i><br>
	  			Rebate / <i>Rebat</i><br>
	  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
	  			Stamp Duty / <i>Duti Setem</i><br>
	  			TPCA Fee/Service Fee / <i>Yuran TPCA/Perkhidmatan</i> <br>
	  			<%= common.getKey(GST_PCT,".") %>% GST on TPCA/Service Fee / <i><%= common.getKey(GST_PCT,".") %>% Duti Setem/Yuran Perkhidmatan</i><br> </font></td>
	  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  	    	<%=common.fnFormatComma(GPREM)%><br>
	  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
	  	    	<%=common.fnFormatComma(GST_AMT)%><br>
	  	    	<%=common.fnFormatComma(STAMP)%><br>
	  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
	  	    	<%=common.fnFormatComma(GST_OTHAMT)%><br></font></td>
	  	    <%} else if(SST_TRIGGER.equals("Y")){%>
				Gross Premium / <i>Premium Kasar</i><br>
	  			Rebate / <i>Rebat</i><br>
	  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
	  			Stamp Duty / <i>Duti Setem</i><br>
	  			TPCA Fee/Service Fee / <i>Yuran TPCA/Perkhidmatan</i> <br> 
	  			<%= common.getKey(STAXPCT,".") %>% Service Charge on TPCA/Service Fee / <i><%= common.getKey(STAXPCT,".") %>% Caj Perkhidmatan pada Yuran TPCA/Yuran Perkhidmatan </i><br> </font></td>
	  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
	  	    	<%=common.fnFormatComma(GPREM)%><br>
	  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
	  	    	<%=common.fnFormatComma(STAXAMT)%><br>
	  	    	<%=common.fnFormatComma(STAMP)%><br>
	  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
	  	    	<%=common.fnFormatComma(STAXAMT_TPCA)%><br></font></td>
	  	    <%}%>
  	    <%}%>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">7<br>8<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
   </tr>

<%}%>

<%}else if(NOTE_IND.equals("C")){ %> 

<%if (MAINCLS.equals("MT")){ %>
 
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Refund Premium / <i>Premium Bayaran Balik</i><br>
  		GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  		Stamp Duty / <i>Duti Setem</i><br>
  		Transfer fees / <i>Yuran Pemindahan</i><br>
  		GST on Tranfer Fees / <i>GST Yuran Pemindahan</i><br> </font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    -<%=common.fnFormatComma(GPREM)%><br>
  	    -<%=common.fnFormatComma(GST_AMT)%><br>
  	    <%=common.fnFormatComma(STAMP)%><br>
  	    -<%=common.fnFormatComma(TRANSFER_FEE)%><br> 
  	    -<%=common.fnFormatComma(GST_TF_AMT)%><br></font></td>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">6<br>7<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    -<%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%>-<%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%>-<%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
    </tr>
   
<%}else if (MAINCLS.equals("DPPA")|| MAINCLS.equals("MCPA") || MAINCLS.equals("MCPI") || MAINCLS.equals("AUTO") || MAINCLS.equals("FI") || MAINCLS.equals("PA") || MAINCLS.equals("IG")){ %>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		<%if(GST_TRIGGER.equals("Y")){%>
  			Refund Premium / <i>Premium Bayaran Balik</i><br>
  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  			Stamp Duty / <i>Duti Setem</i><br></font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	-<%=common.fnFormatComma(GPREM)%><br>
  	    	-<%=common.fnFormatComma(GST_AMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br></font></td>
  	    <%} else if(SST_TRIGGER.equals("Y")){%>
			Refund Premium / <i>Premium Bayaran Balik</i><br>
  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
  			Stamp Duty / <i>Duti Setem</i><br></font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	-<%=common.fnFormatComma(GPREM)%><br>
  	    	-<%=common.fnFormatComma(STAXAMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br></font></td>
  	    <%} %>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">4<br>5<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    -<%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%>-<%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%>-<%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>

<%}else if (MAINCLS.equals("WM")){%>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br>6<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		<%if(GST_TRIGGER.equals("Y")){%>
  			Refund Premium / <i>Premium Bayaran Balik</i><br>
  			Rebate / <i>Rebat</i><br>
  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			Service Fees / <i>Yuran Perkhidmatan</i><br>
  			GST on Service Fees / <i>GST Yuran Perkhidmatan</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	-<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
  	    	-<%=common.fnFormatComma(GST_AMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	-<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	-<%=common.fnFormatComma(GST_OTHAMT)%><br></font></td>
  	    <%} else if(SST_TRIGGER.equals("Y")){%>
  	    	Refund Premium / <i>Premium Bayaran Balik</i><br>
  			Rebate / <i>Rebat</i><br>
  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			Service Fees / <i>Yuran Perkhidmatan</i><br>
  			<%= common.getKey(STAXPCT,".") %>% Service Charge on Service Fees / <i><%= common.getKey(STAXPCT,".") %>% Caj Perkhidmatan pada Yuran Perkhidmatan</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	-<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
  	    	-<%=common.fnFormatComma(STAXAMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	-<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	-<%=common.fnFormatComma(STAXAMT_TPCA)%><br></font></td>
  	    	
  	    <%} %>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">7<br>8<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    -<%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%>-<%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%>-<%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>
	
<%}else if (MAINCLS.equals("FWHS")){%>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br>6<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		<%if(GST_TRIGGER.equals("Y")){%>  		
  			Refund Premium / <i>Premium Bayaran Balik</i><br>
  			Rebate / <i>Rebat</i><br>
  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			TPCA <br>
  			GST on TPCA / <i>GST TPCA</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	-<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
  	    	-<%=common.fnFormatComma(GST_AMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	-<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	-<%=common.fnFormatComma(GST_OTHAMT)%><br></font></td>
  	    <%} else if(SST_TRIGGER.equals("Y")){%>
  	    	Refund Premium / <i>Premium Bayaran Balik</i><br>
  			Rebate / <i>Rebat</i><br>
  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			TPCA <br> 
  			<%= common.getKey(STAXPCT,".") %>% Service Charge on TPCA / <i><%= common.getKey(STAXPCT,".") %>% Caj Perkhidmatan pada TPCA</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	-<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(REBATEAMT)%><br>
  	    	-<%=common.fnFormatComma(STAXAMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	-<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	-<%=common.fnFormatComma(STAXAMT_TPCA)%><br></font></td>

  	    <% }%>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">7<br>8<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    -<%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%>-<%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>
	
<% }%>

 <%}else if(NOTE_IND.equals("D")){ %> 

<%if (MAINCLS.equals("MT")){%>
 
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
 
  		Additional Premium / <i>Premium Bayaran Balik</i><br>
  		GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  		Stamp Duty / <i>Duti Setem</i><br>
  		Transfer fees / <i>Yuran Pemindahan</i><br>
  		GST on Tranfer Fees / <i>GST Yuran Pemindahan</i><br> </font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(GPREM)%><br>
  	    <%=common.fnFormatComma(GST_AMT)%><br>
  	    <%=common.fnFormatComma(STAMP)%><br>
  	    <%=common.fnFormatComma(TRANSFER_FEE)%><br> 
  	    <%=common.fnFormatComma(GST_TF_AMT)%><br></font></td>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">6<br>7<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>
	
<%}else if (MAINCLS.equals("DPPA")|| MAINCLS.equals("MCPA") || MAINCLS.equals("MCPI") || MAINCLS.equals("AUTO") || MAINCLS.equals("FI") || MAINCLS.equals("PA") || MAINCLS.equals("IG")){%>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
    	<%if(GST_TRIGGER.equals("Y")){%>  		 		
  			Additional Premium / <i>Premium Bayaran Balik</i><br>
  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  			Stamp Duty / <i>Duti Setem</i><br></font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(GST_AMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br></font></td>
  	    <%} else if(SST_TRIGGER.equals("Y")){%>
			Additional Premium / <i>Premium Bayaran Balik</i><br>
  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
  			Stamp Duty / <i>Duti Setem</i><br></font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(STAXAMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br></font></td>
  	    <%} %>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">4<br>5<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>
	
<%}else if (MAINCLS.equals("WM")){%>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br>6<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
    	<%if(GST_TRIGGER.equals("Y")){%>  		 		  		
  			Additional Premium / <i>Premium Bayaran Balik</i><br>
  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			Service Fees / <i>Yuran Perkhidmatan</i><br>
  			GST on Service Fees / <i>GST Yuran Perkhidmatan</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(GST_AMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	<%=common.fnFormatComma(GST_OTHAMT)%><br></font></td>
  	    <%} else if(SST_TRIGGER.equals("Y")){%>
  	    	Additional Premium / <i>Premium Bayaran Balik</i><br>
  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			Service Fees / <i>Yuran Perkhidmatan</i><br>
  			<%= common.getKey(STAXPCT,".") %>% Service Charge on Service Fees / <i><%= common.getKey(STAXPCT,".") %>% Caj Perkhidmatan pada Yuran Perkhidmatan</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(STAXAMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	<%=common.fnFormatComma(STAXAMT_TPCA)%><br></font></td>
  	    <%} %>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">7<br>8<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>
	
<%}else if (MAINCLS.equals("FWHS")){%>

	<tr>
  		<td width="5%" valign="top" bordercolor="#000000" align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>No </b></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Description</b></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Total (RM)</b></font></td>
	</tr>	
    <tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">1<br>2<br>3<br>4<br>5<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
    	<%if(GST_TRIGGER.equals("Y")){%>  		 		  		  		
  			Additional Premium / <i>Premium Bayaran Balik</i><br>
  			GST / <i>GST &nbsp;<%= common.getKey(GST_PCT,".") %>% &nbsp;<%=common.stringToHTMLString(GST_RT)%></i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			TPCA <br>
  			GST on TPCA / <i>GST TPCA</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(GST_AMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	<%=common.fnFormatComma(GST_OTHAMT)%><br></font></td>
  	    <%} else if(SST_TRIGGER.equals("Y")){%>
  	      	Additional Premium / <i>Premium Bayaran Balik</i><br>
  			Service Tax / <i>Cukai Perkhidmatan &nbsp;<%= common.getKey(STAXPCT,".") %>%</i><br>
  			Stamp Duty / <i>Duti Setem</i><br>
  			TPCA <br>
  			<%= common.getKey(STAXPCT,".") %>% Service Charge on TPCA / <i><%= common.getKey(STAXPCT,".") %>% Caj Perkhidmatan pada TPCA</i><br> </font></td>
  	    	<td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    	<%=common.fnFormatComma(GPREM)%><br>
  	    	<%=common.fnFormatComma(STAXAMT)%><br>
  	    	<%=common.fnFormatComma(STAMP)%><br>
  	    	<%=common.fnFormatComma(SERVICE_FEE)%><br>
  	    	<%=common.fnFormatComma(STAXAMT_TPCA)%><br></font></td>
  	    <%} %>
	</tr>
	<tr>
  		<td width="5%" valign="top" bordercolor="#000000"  align ="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">6<br>7<br></font></td>
  		<td colspan="4" valign="top" bordercolor="#000000" align ="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  		Total Payable (OTC) / <i>Jumlah Berbayar Di Kaunter</i><br>
  		Total Payable / <i>Jumlah Berbayar</i><br></font></td>
  	    <td colspan="2" valign="top"  bordercolor="#000000" align ="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  	    <%=common.fnFormatComma(TOTPREM)%><br>
  	    <%if((!TOTPREM.equals("0.0000"))|(!TOTPREM.equals("0.00"))){%><%=common.stringToHTMLString(common.fnFormatComma(common.roundTwoDecimal(common.fnCutComma(TOTPREM))))%><%}else{%><%=common.stringToHTMLString(TOTPREM)%><%}%><br></font></td>
	</tr>
	
<%}%>

<%}%>
</table>
<% if(!savedPath.equals("") && GST_TAX_NO_END.equals("")){ %>
<table  width="100%" border="1" cellpadding="3" cellspacing="0" bordercolor="#000000" >

		<tr>
			<td colspan="11"  valign="bottom" align="left"  style="width:95%; margin:0; padding:0;"><font  size="2" face="Verdana, Arial, Helvetica, sans-serif">
				UUID: <%=UUID%><br>
				Digital Signature<br>
				Date and Time of Validation: <%=VALIDATE_TIME%><br>
				This is a visual representative of the e-invoice. Scan the QR code for this e-invoice validation details.<br>
			</font>
			</td>
			<td colspan="1"  valign="top" align="right"  style="width:5%; margin:0; padding:0;">
				<img src="<%=savedPath%>" width="50" height="50" align="right" />
			</td>
	</tr>
		
</table>
<%} %>

<% if(!savedPath2.equals("") && !GST_TAX_NO_END.equals("")){ %>
<table  width="100%" border="1" cellpadding="3" cellspacing="0" bordercolor="#000000" >

		<tr>
			<td colspan="11"  valign="bottom" align="left"  style="width:95%; margin:0; padding:0;"><font  size="2" face="Verdana, Arial, Helvetica, sans-serif">
				UUID: <%=UUID2%><br>
				Digital Signature<br>
				Date and Time of Validation: <%=VALIDATE_TIME2%><br>
				This is a visual representative of the e-invoice. Scan the QR code for this e-invoice validation details.<br>
			</font>
			</td>
			<td colspan="1"  valign="top" align="right"  style="width:5%; margin:0; padding:0;">
				<img src="<%=savedPath2%>" width="50" height="50" align="right" />
			</td>
	</tr>
		
</table>
<%} %>
<table  width="100%" border="1" cellpadding="3" cellspacing="0" bordercolor="#000000" >
    <tr>
  		<td width="100%" colspan="7"  valign="top" bordercolor="#000000" align="justify"><font size="1.5" face="Verdana, Arial, Helvetica, sans-serif" ><br>This is a computer generated document and it does not require a signature. This document shall not be invalidated solely on the ground that it is not signed.<br> <i>Dokumen ini adalah cetakan komputer dan ia tidak memerlukan tandatangan.Dokumen ini tidak boleh dibatalkan atas alasan ia tidak ditandatangani.</i></font></td>
	</tr>
	
</table>
<%} %>
</body> 
</html>