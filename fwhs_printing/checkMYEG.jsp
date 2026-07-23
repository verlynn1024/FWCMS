<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
import="org.jdom.*,java.text.*,java.sql.*,java.util.*,java.util.Date,java.text.SimpleDateFormat,java.lang.reflect.Method,com.rexit.easc.StringUtil,org.jdom.input.SAXBuilder,java.io.*,org.jdom.JDOMException,org.jdom.Namespace,org.jdom.Document,org.jdom.Element,org.jdom.output.XMLOutputter"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="DB_Template" scope="page" class="com.rexit.easc.DB_Template" />
<jsp:useBean id="postXML" scope="page" class="com.rexit.easc.postXML" />
<jsp:useBean id="DB_MYEG" scope="page" class="com.rexit.easc.DB_MYEG" />

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<%//System.out.println("dddaaaaa");
	SimpleDateFormat timestampFormat  = new SimpleDateFormat("yyyyMMddHHmmss");
	SimpleDateFormat timestampFormat2 = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat timestampFormat3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat timestampFormat4 = new SimpleDateFormat("yyyyMMdd");

	String INSCODE      = common.setNullToString(request.getParameter("INSCODE"));
	String USERID		= common.setNullToString(request.getParameter("USERID"));
	String UKEY	    	= common.setNullToString(request.getParameter("UKEY"));
	String CLS			= common.setNullToString(request.getParameter("CLS"));
	String ACCODE		= common.setNullToString(request.getParameter("ACCODE"));
	String TABLE	 	= common.setNullToString(request.getParameter("TABLE"));

	String SQL 			= "";
	String NAME			= "";
	String NEW_IC_NO	= "";
	String OLD_IC_NO	= "";
	String CONTACT_TYPE	= "";
	String BUSINESS_NO	= "";
	String EFFDATE		= "";
	String EXPDATE		= "";
	String CNCODE		= "";
	String SEQNO		= "";
	String EMP_NAME		= "";
	String PASSPORT		= "";
	String DOB			= "";
	String WORK_EXP		= "";
	String INSURED_FOR 	= "";
	String sINSURED_FOR	= "";
	String MYEG_REFNO	= "";
	String TRX_ID		= "";
	String workerpassport = "";
	String ResponseCode	= "";

	String TABLE_CN		= "";
	String TABLE_ITEM	= "";
	int iRowAffected	= 0;	
		
	Vector vMyegWorker 	= new Vector();	
		
	//String sURL 			= "https://uat4.myeg.com.my/InsuranceGatewayFW/WS/INSGatFW?wsdl";	
	String sURL 			= "";
	String sINS_COMPCODE 	= "";
	String sUSERNAME 		= "";
	String sPASSWORD 		= "";
	
	SQL = "SELECT * FROM TB_MYEG_INFO WHERE INSCODE='"+INSCODE+"' WITH UR";
    DB_Contact.makeConnection();     
    DB_Contact.executeQuery(SQL);      
    while(DB_Contact.getNextQuery())   
    {
   		sINS_COMPCODE		= common.setNullToString(DB_Contact.getColumnString("INS_COMPCODE"));            
        sUSERNAME			= common.setNullToString(DB_Contact.getColumnString("USERNAME"));            
   	   	sPASSWORD			= common.setNullToString(DB_Contact.getColumnString("PASSWORD"));
   	   	sURL				= common.setNullToString(DB_Contact.getColumnString("URL"));
    }       
    DB_Contact.takeDown();
		
	if(CLS.equals("FWCS"))
	{
		TABLE_CN 	= "TB_FWCSCN";
		TABLE_ITEM	= "TB_FWCSSUB";
	}
	else if(CLS.equals("FWHS"))
	{
		TABLE_CN 	= "TB_FWHSCN";
		TABLE_ITEM	= "TB_FWHSITEM";	
	}
	else if(CLS.equals("FWIG"))
	{
		TABLE_CN 	= "TB_FWIGCN";
		TABLE_ITEM	= "TB_FWIGMAST";	
		
		if(!TABLE.equals(TABLE_CN))	
		{
			TABLE_CN 	= TABLE;
			TABLE_ITEM	= "TB_FWIGREFMAST";			
		}		
	}
		
	SQL = "SELECT CNCODE,NAME,EFFDATE,EXPDATE,NEW_IC_NO,OLD_IC_NO,BUSINESS_NO,CONTACT_TYPE FROM "+TABLE_CN+" WHERE UKEY = '"+UKEY+"' WITH UR";
    DB_Contact.makeConnection();     
    DB_Contact.executeQuery(SQL);      
    while(DB_Contact.getNextQuery())   
    {
   		CNCODE			= common.setNullToString(DB_Contact.getColumnString("CNCODE"));            
        NAME			= common.setNullToString(DB_Contact.getColumnString("NAME"));            
   	   	EFFDATE			= common.setNullToString(DB_Contact.getColumnString("EFFDATE"));
   	   	EXPDATE			= common.setNullToString(DB_Contact.getColumnString("EXPDATE"));
   	   	NEW_IC_NO		= common.setNullToString(DB_Contact.getColumnString("NEW_IC_NO"));
   	   	OLD_IC_NO		= common.setNullToString(DB_Contact.getColumnString("OLD_IC_NO"));
   	   	BUSINESS_NO		= common.setNullToString(DB_Contact.getColumnString("BUSINESS_NO"));
   	   	CONTACT_TYPE	= common.setNullToString(DB_Contact.getColumnString("CONTACT_TYPE"));
    }       
    DB_Contact.takeDown();

	if(CONTACT_TYPE.equals("I"))
		BUSINESS_NO = NEW_IC_NO;
	else if(CONTACT_TYPE.equals("O"))
		BUSINESS_NO = OLD_IC_NO;
	else if(CONTACT_TYPE.equals("B"))
		BUSINESS_NO = BUSINESS_NO;

	//EFFDATE 	= timestampFormat2.format(timestampFormat4.parse(EFFDATE));
	//EXPDATE 	= timestampFormat2.format(timestampFormat4.parse(EXPDATE));
		
	if(CLS.equals("FWCS"))	
	{
	    DB_Contact.makeConnection();
	    SQL = "SELECT * FROM "+TABLE_ITEM+" WHERE UKEY LIKE '"+UKEY+"%' WITH UR";
	    DB_Contact.executeQuery(SQL);
	    while(DB_Contact.getNextQuery())
	    {
	    	SEQNO		= common.setNullToString(DB_Contact.getColumnString("SEQNO"));
	    	EMP_NAME	= common.setNullToString(DB_Contact.getColumnString("EMP_NAME"));
	    	PASSPORT	= common.setNullToString(DB_Contact.getColumnString("PASSPORT"));
	    	DOB			= common.setNullToString(DB_Contact.getColumnString("DOB"));
	    	WORK_EXP	= common.setNullToString(DB_Contact.getColumnString("WORK_EXP"));
	        INSURED_FOR = common.setNullToString(DB_Contact.getColumnString("INSURED_FOR"));
	    }
	    DB_Contact.takeDown();	
	
		StringTokenizer stSEQNO 		= new StringTokenizer(SEQNO,"^");
	    StringTokenizer stEMP_NAME 		= new StringTokenizer(EMP_NAME,"^");
	    StringTokenizer stPASSPORT 		= new StringTokenizer(PASSPORT,"^");
	    StringTokenizer stDOB 			= new StringTokenizer(DOB,"^");
	    StringTokenizer stWORK_EXP 		= new StringTokenizer(WORK_EXP,"^");
	    StringTokenizer stINSURED_FOR 	= new StringTokenizer(INSURED_FOR,"^");
	     
	    while(stSEQNO.hasMoreTokens())
	    {
	       	Vector vRow	= new Vector();
	       	
	       	String work_exp 	= "";
	       	String seqno	 	= stSEQNO.nextToken();
			String emp_name 	= stEMP_NAME.nextToken();
			String passport 	= stPASSPORT.nextToken();
			String dob 			= stDOB.nextToken();
			String insured_for 	= stINSURED_FOR.nextToken();
			if(insured_for.equals("P"))
				work_exp 	= stWORK_EXP.nextToken();
	
			vRow.addElement(emp_name);
			vRow.addElement(passport);
			vRow.addElement(dob);
			vRow.addElement(work_exp);

			vMyegWorker.addElement(vRow);
			
		}

	}else if(CLS.equals("FWHS")){
	
	    DB_Contact.makeConnection();
	    SQL = "SELECT * FROM "+TABLE_ITEM+" WHERE UKEY LIKE '"+UKEY+"%' WITH UR";
	    DB_Contact.executeQuery(SQL);
	    while(DB_Contact.getNextQuery())
	    {
	    	SEQNO		= common.setNullToString(DB_Contact.getColumnString("SEQNO"));
	    	EMP_NAME	= common.setNullToString(DB_Contact.getColumnString("EMP_NAME"));
	    	PASSPORT	= common.setNullToString(DB_Contact.getColumnString("PASSPORT"));
	    	DOB			= common.setNullToString(DB_Contact.getColumnString("DOB"));
	    	WORK_EXP	= common.setNullToString(DB_Contact.getColumnString("WORK_EXP"));
	        INSURED_FOR = common.setNullToString(DB_Contact.getColumnString("INSURED_FOR"));
	        
	        Vector vRow	= new Vector();
	        
			vRow.addElement(EMP_NAME);
			vRow.addElement(PASSPORT);
			vRow.addElement(DOB);
			vRow.addElement(WORK_EXP);

			vMyegWorker.addElement(vRow);
	    }
	    DB_Contact.takeDown();	
	    	
	}else if(CLS.equals("FWIG")){

	    DB_Contact.makeConnection();
	    SQL = "SELECT * FROM "+TABLE_ITEM+" WHERE UKEY2 LIKE '"+UKEY+"%' WITH UR";
	    DB_Contact.executeQuery(SQL);
	    while(DB_Contact.getNextQuery())
	    {
	    	EMP_NAME	= common.setNullToString(DB_Contact.getColumnString("EMP_NAME"));
	    	PASSPORT	= common.setNullToString(DB_Contact.getColumnString("EMP_PASSPORT"));
	    }
	    DB_Contact.takeDown();	
	
	    StringTokenizer stEMP_NAME 		= new StringTokenizer(EMP_NAME,"^");
	    StringTokenizer stPASSPORT 		= new StringTokenizer(PASSPORT,"^");
	     
	    while(stPASSPORT.hasMoreTokens())
	    {
	       	Vector vRow	= new Vector();
	       	
	       	String work_exp 	= "";
	       	
			String emp_name 	= stEMP_NAME.nextToken();
			String passport 	= stPASSPORT.nextToken();
	
			vRow.addElement(emp_name);
			vRow.addElement(passport);

			vMyegWorker.addElement(vRow);
		}	
	}
	
			
	for(int i=0; i<vMyegWorker.size(); i++)
	{
		String TIMESTAMP	= timestampFormat3.format(new Date());
		
		Vector vEmployerList 	= (Vector) vMyegWorker.elementAt(i);
		String emp_name 		= (String)vEmployerList.elementAt(0);
		String emp_passport 	= (String)vEmployerList.elementAt(1);
		String emp_dob 			= "";
		String emp_workexp 		= "";		
			
		if(!CLS.equals("FWIG"))
		{
			emp_dob 			= (String)vEmployerList.elementAt(2);
			emp_workexp 		= (String)vEmployerList.elementAt(3);		
		
			if(!emp_dob.equals("")){emp_dob 		= timestampFormat2.format(timestampFormat4.parse(emp_dob));};
			if(!emp_workexp.equals("")){emp_workexp = timestampFormat2.format(timestampFormat4.parse(emp_workexp));};
		}
		
	    DB_MYEG.makeConnection();  
		MYEG_REFNO = DB_MYEG.getMYEGRefno(INSCODE,"MYEG"); 
		if(MYEG_REFNO.equals("")){
		   throw new NullPointerException("generate MYEGRefno Failed");
		}			      
	    DB_MYEG.takeDown();  
	    
	    
		//INSERT FWCMS REQUEST TRANSACTION RECORDS
		DB_MYEG.makeConnection();
		iRowAffected = DB_MYEG.insertMYEG_TRANS(INSCODE,TIMESTAMP,MYEG_REFNO,CLS,CNCODE,emp_passport,USERID,ACCODE);
		if(iRowAffected == 0){
		   throw new NullPointerException("Insert DB_MYEG transaction Failed");
		}	
		DB_MYEG.takeDown();
		
		DB_MYEG.makeConnection();
	  	String sXML = DB_MYEG.genMYEG_AES_XML(INSCODE,CLS,MYEG_REFNO,CNCODE,EFFDATE,EXPDATE,NAME,BUSINESS_NO,emp_name,emp_passport,emp_dob,emp_workexp,sINS_COMPCODE,sUSERNAME,sPASSWORD);
		sXML = sXML.replace("&","&amp;");
	  	DB_MYEG.takeDown(); 
	  	
		//Store request XML Value (Rexit XML Request)
		DB_MYEG.makeConnection();
		iRowAffected = DB_MYEG.insertMyegXML_REQ(INSCODE, TIMESTAMP, MYEG_REFNO,CLS,sXML);
		if(iRowAffected == 0){
		   throw new NullPointerException("Insert FWCMS XML Failed");
		}	
		DB_MYEG.takeDown(); 	
	
		String sReturn  = "";
		if(sURL.indexOf("https")>-1)
	    	sReturn  = postXML.httpsposting(sURL,sXML);
	    else
	    	sReturn  = postXML.posting(sURL,sXML);
	
		String RESP_TIMESTAMP = timestampFormat3.format(new Date());
	
		sReturn = common.searchReplace(sReturn,"soap:","");
		sReturn = common.searchReplace(sReturn,"ns2:","");
		
		//Get root from XML 
		SAXBuilder builder = new SAXBuilder(false);
	    ByteArrayInputStream inMain = new ByteArrayInputStream(sReturn.getBytes());
	    Document doc2 = builder.build(inMain);
	    Element root = doc2.getRootElement();
	
	    //list 1
	    List rootTreej = root.getChildren("Body",root.getNamespace());
	    Iterator j = rootTreej.iterator();
		
		//response first layer
		while (j.hasNext())
		{
			Element Element1 	= (Element) j.next();
			List sub1 			= Element1.getChildren("INSRes");
			Iterator isub1 		= sub1.iterator();
			
			while (isub1.hasNext()){
				Element Element2 	= (Element) isub1.next();
				List sub2 			= Element2.getChildren("header");
				Iterator isub2 		= sub2.iterator();
			
				ResponseCode 		= common.setNullToString(Element2.getChildText("data1"));
				
				while (isub2.hasNext()){
					Element Element3 	= (Element) isub2.next();
					
					TRX_ID 				= common.setNullToString(Element3.getChildText("trx_id"));
				}	
			}
		}	
		
		if(!ResponseCode.equals("")){//AES data returns "companyrocno~workerpassportno~responsecode"
			String tempA	= "";
			com.rexit.easc.StringTokenizer stResponseCode = new com.rexit.easc.StringTokenizer(ResponseCode,"~","",true);
			
			while (stResponseCode.hasMoreTokens())
		   	{
		   		try { tempA = stResponseCode.nextToken();	 		} catch (Exception exp) { }
		   		
		   		if(stResponseCode.hasMoreTokens())
		   		{
		   			tempA			= stResponseCode.nextToken();
		   			ResponseCode	= stResponseCode.nextToken();
		   		}
		   		else
		   		{
		   			ResponseCode = tempA;
		   		}
		   	}
		}
		//System.err.println("Response Code : " + ResponseCode);
		//INSERT FWCMS REQUEST TRANSACTION RECORDS
		DB_MYEG.makeConnection();
		iRowAffected = DB_MYEG.updateMYEG_TRANS(RESP_TIMESTAMP,ResponseCode,TRX_ID,INSCODE);
		if(iRowAffected == 0){
		   throw new NullPointerException("Update DB_MYEG_trans Failed");
		}	
		DB_MYEG.takeDown();
	
		//Store request XML Value (Rexit XML Request)
		DB_MYEG.makeConnection();
		iRowAffected = DB_MYEG.insertMyegXML_RESP(INSCODE, RESP_TIMESTAMP, MYEG_REFNO,CLS,sReturn);
		if(iRowAffected == 0){
		   throw new NullPointerException("Insert FWCMS XML Failed");
		}	
		DB_MYEG.takeDown(); 	//gggg
		
	}
	
%>
</head>
<script language="Javascript">
	
	//parent.window.close();
</script>

</html>