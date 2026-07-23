<%@ page language="java" import="java.io.*,java.net.*,java.util.*,java.util.Date,java.text.SimpleDateFormat" contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="common" scope="page" class="com.rexit.easc.common" />
<jsp:useBean id="DB_Contact" scope="page" class="com.rexit.easc.DB_Contact" />
<jsp:useBean id="DB_Template" scope="page" class="com.rexit.easc.DB_Template" />
<jsp:useBean id="mailsender" scope="page" class="com.rexit.easc.mailsender" />
<jsp:useBean id="DB_Workmen" scope="page" class="com.rexit.easc.DB_Workmen" />
<%
    String SESUSERID 	= common.setNullToString((String)session.getAttribute("SESUSERID"));
	String DOCTYPE 		= common.setNullToString(request.getParameter("DOCTYPE"));
    String CNCODE       = common.filterAttack(request.getParameter("CNCODE"));
    String EMP_NAME     = common.filterAttack(request.getParameter("EMP_NAME"));
    String STATUS       = common.filterAttack(request.getParameter("STATUS"));
    String CLASS        = common.filterAttack(request.getParameter("CLASS"));
    String BUTTONIND    = common.filterAttack(request.getParameter("BUTTONIND"));
    String QUICK_IND    = common.filterAttack(request.getParameter("QUICK_IND"));
    String MAINTABLE    = common.filterAttack(request.getParameter("MAINTABLE"));
    String SRC_URL      = common.filterAttack(request.getParameter("SRC_URL"));
	String FWCMSREF	    = common.filterAttack(request.getParameter("FWCMSREF"));
    String NOWORKER     = common.filterAttack(request.getParameter("NOWORKER"));
    String POLTYPE2	 	= common.setNullToString(request.getParameter("POLTYPE2")); 
    String FWCS_CONV_IND   	 	= common.setNullToString(request.getParameter("FWCS_CONV_IND"));
    String FWHS_CONV_IND   	 	= "Y";
 	String FWIG_CONV_IND   	 	= common.setNullToString(request.getParameter("FWIG_CONV_IND"));
 	
    String fileName     = SESUSERID + "-" +CLASS+ "-" + CNCODE + ".pdf";
    String ePLKS_MCN	 = common.setNullToString(request.getParameter("ePLKS_MCN")); 

    if(ePLKS_MCN.equals("Y")){
    	FWIG_CONV_IND   = "Y";
    	FWHS_CONV_IND	= "Y";
    	FWCS_CONV_IND	= "Y";
    	fileName     = SESUSERID + "-" +CLASS+ "-" + FWCMSREF + ".pdf";
    }
    
    String CUT_OFF		= common.setNullToString(request.getParameter("CUT_OFF"));
    String ISSDATE		= "";
    
    String PRN_IND		= "";
	String TABLE_MST	= "";
	String CNCODE2   	= "";
	String TABLE_SCH 	= "";	
	String ROC_NUMBER   = "";
	String EFFDATE 		= "";
	String ACCODE 		= "";
	String INS  		= "";
	String CNSTATUS 	= "";
	String PRINCIPLE 	= "";
	String SQL = "SELECT ISSDATE,CLASS,PRINCIPLE,STATUS,ACCODE,ENDORSE_NO,BUSINESS_NO,NEW_IC_NO,OLD_IC_NO,CONTACT_TYPE,CNTYPE,S.FWCMSREFNO FROM TB_FWHSCN C INNER JOIN TB_FWHSSCH S ON S.UKEY2=C.UKEY WHERE UKEY = '"+CNCODE+"' WITH UR";
	String INSCODE	    = "";
	String ENDORSE_NO   = "";
	String BUSINESS_NO  = "";
	String NEW_IC_NO    = "";
	String OLD_IC_NO    = "";
	String CONTACT_TYPE = "";
	String FWCMSREFNO	= "";
	String CNTYPE		= "";
 
 	
 
    DB_Workmen.makeConnection();     
    DB_Workmen.executeQuery(SQL);       
    if(DB_Workmen.getNextQuery())   
    {
       	CLASS 			= common.setNullToString(DB_Workmen.getColumnString("CLASS"));
       	STATUS			= common.setNullToString(DB_Workmen.getColumnString("STATUS"));               
   		INSCODE 		= common.setNullToString(DB_Workmen.getColumnString("PRINCIPLE"));
   		ACCODE 			= common.setNullToString(DB_Workmen.getColumnString("ACCODE"));
   		ENDORSE_NO		= common.setNullToString(DB_Workmen.getColumnString("ENDORSE_NO"));
   		BUSINESS_NO		= common.setNullToString(DB_Workmen.getColumnString("BUSINESS_NO"));
  	    NEW_IC_NO		= common.setNullToString(DB_Workmen.getColumnString("NEW_IC_NO"));
  	    OLD_IC_NO		= common.setNullToString(DB_Workmen.getColumnString("OLD_IC_NO"));
  	    CONTACT_TYPE	= common.setNullToString(DB_Workmen.getColumnString("CONTACT_TYPE"));      		
  	    FWCMSREFNO		= common.setNullToString(DB_Workmen.getColumnString("FWCMSREFNO")); 
  	    CNTYPE    		= common.setNullToString(DB_Workmen.getColumnString("CNTYPE"));
  	    ISSDATE			= common.setNullToString(DB_Workmen.getColumnString("ISSDATE"));
    }        
    DB_Workmen.takeDown();
    
	SimpleDateFormat timestampFormat = new SimpleDateFormat("yyyyMMdd");

	if(ISSDATE == null || ISSDATE.equals("")){
		Date todayDate = new Date();
		ISSDATE = timestampFormat.format(todayDate);
	}

    DB_Workmen.makeConnection();
    SQL	= "SELECT * FROM TB_FWHSSCH where UKEY2='"+CNCODE+"' WITH UR";
    
    DB_Workmen.executeQuery(SQL);
    while(DB_Workmen.getNextQuery())
    {
        FWCMSREF    = common.setNullToString(DB_Workmen.getColumnString("FWCMSREFNO"));
    }
    DB_Workmen.takeDown();
%>
<%
	Vector vITEM	= new Vector();
	DB_Workmen.makeConnection();
    SQL	= "SELECT * FROM TB_FWHSITEM WHERE UKEY LIKE '"+CNCODE+"$%' ORDER BY CAST(SEQNO AS INTEGER) WITH UR";
    
    DB_Workmen.executeQuery(SQL);
    while(DB_Workmen.getNextQuery())
    {
        String temp_UKEY    = common.setNullToString(DB_Workmen.getColumnString("UKEY"));
		vITEM.addElement(temp_UKEY);
    }
    DB_Workmen.takeDown();
    
    
    //language
	String privacyLang = "EN";
%>
<%
	boolean bFWCSallow = false;
	DB_Contact.makeConnection();
	SQL = "SELECT VALUE1 FROM TB_CONTROL WHERE INSCODE='"+PRINCIPLE+"' AND TYPE='FWCS' AND CODE='BLOCK_ISSUE' WITH UR";
	DB_Contact.executeQuery(SQL);
	if(DB_Contact.getNextQuery())
	{
		SimpleDateFormat temp_timestampFormat = new SimpleDateFormat("yyyyMMdd");
		String temp_value   = common.setNullToString(DB_Contact.getColumnString("VALUE1"));
		String today		= temp_timestampFormat.format(new Date());
		if(!temp_value.equals(""))
		{
			if(Integer.parseInt(today)<Integer.parseInt(temp_value))
			{
				bFWCSallow = true;
			}
		}
	}
		
	SQL = "SELECT VALUE1 FROM TB_CONTROL WHERE INSCODE='08' AND TYPE='PRIVACY_NOTICE' AND CODE='PRIVACY_NOTICE' WITH UR";
	DB_Contact.executeQuery(SQL);
	if(DB_Contact.getNextQuery())
	{
		SimpleDateFormat temp_timestampFormat = new SimpleDateFormat("yyyyMMdd");
		String temp_value   = common.setNullToString(DB_Contact.getColumnString("VALUE1"));

		if(!temp_value.equals(""))
		{
			if(Integer.parseInt(ISSDATE)<= Integer.parseInt(temp_value))
			{
				CUT_OFF = "OLD";
			}else {
				CUT_OFF = "NEW";
			}
		}
	}
	DB_Contact.takeDown();

	String SRC			= "/liberty/common/jpg/getPdf2.jsp?fn="+fileName+"&PRIVACY_NOTICE=Y&CUT_OFF="+CUT_OFF;
%>
<!DOCTYPE html>
<html class="no-js css-menubar" lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
  <meta name="description" content="bootstrap admin template">
  <meta name="author" content="">

  <title>Client Profile | e-Cover</title>

  <link rel="apple-touch-icon" href="/liberty/assets/images/apple-touch-icon.png">
  <link rel="shortcut icon" href="/liberty/assets/images/favicon.ico">

  <!-- Stylesheets -->
  <link rel="stylesheet" href="/liberty/assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/bootstrap-extend.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/site.min.css">


  <!-- Plugins -->
  <link rel="stylesheet" href="/liberty/assets/css/asScrollable.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/switchery.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/introjs.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/slidePanel.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/flag-icon.min.css">

  <!-- Page -->
  <link rel="stylesheet" href="/liberty/assets/css/breadcrumbs.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/advanced.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/icons.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/buttons.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/datatable.min.css">
  
  <!-- Plugins For This Page -->
  <link rel="stylesheet" href="/liberty/assets/css/bootstrap-datepicker.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/tablesaw.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/select2.css">
  <link rel="stylesheet" href="/liberty/assets/css/bootstrap-select.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/icheck.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/multi-select.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/switchery.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/asRange.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/multi-select.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/typeahead.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/dataTables.bootstrap.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/dataTables.fixedHeader.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/dataTables.responsive.min.css">

  <!-- Fonts -->
  <link rel="stylesheet" href="/liberty/assets/css/web-icons.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/brand-icons.min.css">
  <link rel="stylesheet" href="/liberty/assets/css/font-awesome.min.css">

  <!--[if lt IE 9]>
    <script src="/liberty/assets/js/html5shiv.min.js"></script>
    <![endif]-->

  <!--[if lt IE 10]>
    <script src="/liberty/assets/js/media.match.min.js"></script>
    <script src="/liberty/assets/js/respond.min.js"></script>
    <![endif]-->

  <!-- Scripts -->
  <script src="/liberty/assets/js/modernizr.min.js"></script>
  <script src="/liberty/assets/js/breakpoints.min.js"></script>
  <script language="JavaScript" src="/liberty/common/check/fieldcheck.js"></script>
  <script>
    Breakpoints();
	
	function preview(){   
		if("<%=CNCODE%>" != "")   
	   		frames['iframePreview'].location.href = "<%=SRC%>";
	}	
	
	function emailPDF(){
		if(document.mainform.checkEmail.checked == true){
			if(document.mainform.EMAIL.value != ""){
				document.mainform.TYPE.value = "QUOEMAIL";
				document.mainform.EMAIL_TO.value = document.mainform.EMAIL.value;
				return true;
			}
			else{
				alert("Please enter a valid Email.");
				document.mainform.EMAIL.value = '';
				document.mainform.EMAIL.focus();
				return false;
			}
		}

		return true;
	}
	
	function fnCheckbox()
	{
		if(document.mainform.checkEmail.checked)
		{
			document.mainform.EMAIL.disabled  = false;
			document.mainform.EMAIL.focus();
		}
		else
		{	document.mainform.EMAIL.value	  = "";  
			document.mainform.EMAIL.disabled  = true;
		}
		
		
	}
	
	
	function confirmXML(){
	    var fwcmsref 	 = "<%=FWCMSREF%>";
	    var accode	 	 = "<%=ACCODE%>";
	    var principle	 = "<%=INSCODE%>";
	    var sesuserid	 = "<%=SESUSERID%>";
	    var ses_cls		 = "<%=CLASS%>";
	    var business_no	 = "<%=BUSINESS_NO%>";
	    var contact_type = "<%=CONTACT_TYPE%>";
	    var noworker	 = "<%=NOWORKER%>";
	    var cncode	 	 = "<%=CNCODE%>";
	    var transtype	 = "C";
	  
	    if (contact_type == "B")
	    {
	    	business_no	 = "<%=BUSINESS_NO%>";
	    }
	    else if (contact_type == "I")
	    {
	    	business_no	 = "<%=NEW_IC_NO%>";
	    }
	    else if (contact_type == "O")
	    {
	    	business_no	 = "<%=OLD_IC_NO%>";
	    }	  
	    
	    if(ses_cls == "FWHS")
	    {
	    	ses_cls = "H";
	    }
		if(fwcmsref != "" && "<%=STATUS%>"=="SAVED")
		{
		    document.checkFWCMSREF.action="/liberty/common/check/checkFWCMS.jsp?FWCMSREF="+fwcmsref+"&ACCODE="+accode+"&INSCODE="+principle+
		    						  "&BUSINESS_NO="+business_no+"&SESUSERID="+sesuserid+"&INSTYPE="+ses_cls+"&TRANSTYPE="+transtype+
		    							  "&CNCODE="+cncode+"&NOWORKER="+noworker+"&CONTACT_TYPE="+contact_type;
		    document.checkFWCMSREF.submit();
		}else{
			frames['pleasewait'].OnLoad('visible');
			document.mainform.submit();
		}
	}
	
	function successXML(){
	    var fwcmsref 	 = "<%=FWCMSREF%>";
	    var accode	 	 = "<%=ACCODE%>";
	    var principle	 = "<%=INSCODE%>";
	    var sesuserid	 = "<%=SESUSERID%>";
	    var ses_cls		 = "<%=CLASS%>";
	    var business_no	 = "<%=BUSINESS_NO%>";
	    var noworker	 = "<%=NOWORKER%>";
	    var cncode	 	 = "<%=CNCODE%>";
	    var transtype	 = "S";
	    
	    if(ses_cls == "FWHS")
	    {
	    	ses_cls = "H";
	    }
		if(fwcmsref != "" && "<%=STATUS%>"=="SAVED")
		{
		    document.checkFWCMSREF.action="/liberty/common/check/checkFWCMS.jsp?FWCMSREF="+fwcmsref+"&ACCODE="+accode+"&INSCODE="+principle+
		    							  "&BUSINESS_NO="+business_no+"&SESUSERID="+sesuserid+"&INSTYPE="+ses_cls+"&TRANSTYPE="+transtype+
		    							  "&CNCODE="+cncode+"&NOWORKER="+noworker;
		    document.checkFWCMSREF.submit();
		}        
	}
	
	function failureXML(){
	    var fwcmsref 	 = "<%=FWCMSREF%>";
	    var accode	 	 = "<%=ACCODE%>";
	    var principle	 = "<%=INSCODE%>";
	    var sesuserid	 = "<%=SESUSERID%>";
	    var ses_cls		 = "<%=CLASS%>";
	    var business_no	 = "<%=BUSINESS_NO%>";
	    var noworker	 = "<%=NOWORKER%>";
	    var cncode	 	 = "<%=CNCODE%>";
	    var transtype	 = "F";
	    
	    if(ses_cls == "FWHS")
	    {
	    	ses_cls = "H";
	    }
		if(fwcmsref != "" && "<%=STATUS%>"=="SAVED")
		{
		    document.checkFWCMSREF.action="/liberty/common/check/checkFWCMS.jsp?FWCMSREF="+fwcmsref+"&ACCODE="+accode+"&INSCODE="+principle+
		    							  "&BUSINESS_NO="+business_no+"&SESUSERID="+sesuserid+"&INSTYPE="+ses_cls+"&TRANSTYPE="+transtype+
		    							  "&CNCODE="+cncode+"&NOWORKER="+noworker;
		    document.checkFWCMSREF.submit();
		}        

	}
	
	function MyegXML()
	{
	    var accode	 	 = "<%=ACCODE%>";
	    var principle	 = "<%=INSCODE%>";
	    var sesuserid	 = "<%=SESUSERID%>";
	    var cls		 	 = "<%=CLASS%>";
	    var cncode 	 	 = "<%=CNCODE%>";
	    document.checkMYEG.action="/liberty/common/check/checkMYEG.jsp?UKEY="+cncode+"&ACCODE="+accode+"&INSCODE="+principle+"&USERID="+sesuserid+"&CLS="+cls;
	    document.checkMYEG.submit();
	}
	
	function fnDraft()
	{
   			document.mainform.SUBMITIND.value ="N";
   			document.mainform.BUTTONIND.value ="D";
	        frames['pleasewait'].OnLoad('visible');
	        document.mainform.submit();        
	} 
	function lockbutton()
	{
		frames['pleasewait'].OnLoad('visible');
		document.mainform.generate.disabled = true;
	}	
	
	function fncheckSubmit()
	{
		var button_ind = "<%=BUTTONIND%>";
		
		if(emailPDF()== true)
		{
			if(button_ind != "J"){
				psubmit();
			}else{
				//MyegXML();
				confirmXML();
			} 	
		}
	}

	function psubmit(){
	    frames['pleasewait'].OnLoad('visible');
	    document.mainform.SUBMITIND.value ="Y";
	    document.mainform.submit();
	}	
	
	function convertfwcs()
	{
		    frames['pleasewait'].OnLoad('visible');
	        location.href = "../fwhs/pop_cnFWHS_convert_CS.jsp?CNCODE=<%=CNCODE%>&ACCODE=<%=ACCODE%>&PRINCIPLE=<%=PRINCIPLE%>&FWCS_CONV_IND=<%=FWCS_CONV_IND%>&FWIG_CONV_IND=<%=FWIG_CONV_IND%>&FWHS_CONV_IND=<%=FWHS_CONV_IND%>";
	   
	}
	function convertfwig()
	{
		    frames['pleasewait'].OnLoad('visible');
	        location.href = "../fwhs/pop_cnFWHS_convert_IG.jsp?CNCODE=<%=CNCODE%>&ACCODE=<%=ACCODE%>&PRINCIPLE=<%=PRINCIPLE%>&FWCS_CONV_IND=<%=FWCS_CONV_IND%>&FWIG_CONV_IND=<%=FWIG_CONV_IND%>&FWHS_CONV_IND=<%=FWHS_CONV_IND%>";
	}
	
	function fnCheckbox_2()
	{
		if(document.mainform.MCN_IND.checked)
		{
			document.mainform.genMCN.value	= "Y";
		}
		else
		{	document.mainform.genMCN.value	= "N";  
		}
		
		
	}
	
	function fwcmscheck()
	{
		var fwcmsrefno = "<%=FWCMSREFNO%>";
		if(fwcmsrefno != '')
		{
			if (confirm('ITR number will NOT be captured, do you wish to proceed?')) {
			    return true;
			} else {
			    
			}
		}
		else
		{
			return true;
		}
	}
	
	function changePrivacyLang(lang)
	{
		if(lang =="EN"){
			document.mainform.privacyLang.value ="EN";
		}else if(lang == "BM"){
			document.mainform.privacyLang.value ="BM";
		}
	}
  </script>
</head>

<body style="padding:0px;background-color:#E0E0E0" onload="preview();">
 <jsp:include page="../menu/defaultbar.jsp">
  <jsp:param name="menu" value="e-Business" />
  </jsp:include>
  <!-- Page -->
  
  <form name="mainform" AUTOCOMPLETE="off" action="pop_quoFWHS_pdfpreview_rep.jsp"  onSubmit="lockbutton();">
  <input type="hidden" name="POLTYPE2" value="<%=POLTYPE2%>">     
  <input type="hidden" name="ERRORDESCP" >   
  <input type="hidden" name="RESP_CODE" >
  <input type="hidden" name="RESP_STATUS" >     
  <input type="hidden" name="NOWORKER" value="<%=NOWORKER%>">     
  <input type="hidden" name="FWCMSREF" value="<%=FWCMSREF%>">  
  <input type="hidden" name="CNCODE" value="<%=CNCODE%>">    
  <input type="hidden" name="MAINCLS" value="<%=CLASS%>">   
  <input type="hidden" name="BUTTONIND" value="<%=BUTTONIND%>"> 
  <input type="hidden" name="QUICK_IND" value="<%=QUICK_IND%>"> 
  <input type="hidden" name="AMTDESC" value=""> 
  <input type="hidden" name="SUBMITIND" value="Y"> 
  <input type="hidden" name="TYPE" value="PRINT">
  <input type="hidden" name="EMAIL_TO" value="">
  <input type="hidden" name="genMCN">
  <input type="hidden" name="privacyLang" value="<%=privacyLang%>">
  <input type="hidden" id="CUT_OFF" name="CUT_OFF" value="<%=CUT_OFF%>">
  <input type="text" name="fileName" value="<%=fileName %>">
  <div class="page">
    <div class="page-header">
        <div class="page-header padding-top-15 padding-bottom-15 padding-left-15">
           <ol class="breadcrumb" data-plugin="breadcrumb">
                    <li><a href="../clientProfile/clientProfile.jsp">Home</a></li>
                    <li>e-Business</li>
                    <li class="active">Document</li>
           </ol>
    	  <h3 class="page-title">Generate Document (Preview)</h3>
 	    </div>
   		<iframe id="iframePreview" name="iframePreview" src="/liberty/common/blank.jsp" width="100%" height="600px" border="0" frameborder="1"></iframe> 
		
<%-- 		<div class="row padding-left-5 padding-right-5 padding-top-15 padding-bottom-0"  <%if(CNTYPE.equals("RN")){ %>hidden<%} %> >
   		<div class="radio-custom radio-primary">
		   		<div class="col-md-2 padding-top-10 padding-bottom-10"">
	                 <input type="radio" name="privacyLang2" id="inputRadiosUnchecked" <% if (privacyLang.equals("EN")) {out.println("checked");}%> value="EN" onclick="changePrivacyLang('EN');" >
	                 <label for="inputRadiosUnchecked">Privacy Notice (EN)</label>
	           </div>
	    		<div class="col-md-2 padding-top-10 padding-bottom-10"">
	                 <input type="radio" name="privacyLang2" id="inputRadioschecked" value="BM" onclick="changePrivacyLang('BM');" >
	                 <label for="inputRadioschecked">Notis Privasi (BM)</label>
	           </div>
         </div>
         </div> --%>
		
		
		 <div class="row padding-left-5 padding-right-5 padding-top-15 padding-bottom-0" >
         <%if(!FWIG_CONV_IND.equals("Y")){%>
        	 <div class="col-md-2  padding-bottom-10" >
    			<a class="btn btn-block btn-outline btn-primary4" href="javascript:void(0)" onclick="if(fwcmscheck()==true){convertfwig();}">Issue FWIG</a>
        	 </div>
         <%}%>
         
         <%if(!FWHS_CONV_IND.equals("Y")){%>
        	 <div class="col-md-2  padding-bottom-10" >
    			<a class="btn btn-block btn-outline btn-primary4" href="javascript:void(0)" onclick="if(fwcmscheck()==true){convertfwhs();}">Issue FWHS</a>
         	</div>
         <%}%>
         
         <%if(!FWCS_CONV_IND.equals("Y") && bFWCSallow){%>
        	 <div class="col-md-2  padding-bottom-10" >
    			<a class="btn btn-block btn-outline btn-primary4" href="javascript:void(0)" onclick="if(fwcmscheck()==true){convertfwcs();}">Issue FWCS</a>
        	 </div>
         <%}%>
         <%if(vITEM.size() > 1 && BUTTONIND.equals("J") && FWCMSREF.equals("")){%>
	         <div class="col-md-3 padding-top-10 padding-bottom-10" >
	         	<div class="checkbox-custom checkbox-primary btn-block">
	           		<input type="checkbox" id="inputUnchecked" name="MCN_IND" onclick="fnCheckbox_2();">
	           		<label for="inputUnchecked">Tick to Print Individual Policy</label>
	            </div>
	         </div>
	     <%}else{%>
	     	<input type="hidden" name="MCN_IND">
	     <%}%>
	   
       </div> 
       
       <div class="row padding-left-5 padding-right-5 padding-top-15 padding-bottom-0" >
           <%if(!BUTTONIND.equals("P") && !BUTTONIND.equals("C")){%>
	           <div class="col-md-3  padding-bottom-10" >
			    	<a class="btn btn-block btn-outline btn-primary5" href="/liberty/clientProfile/clientProfile.jsp" >Leave the Page & Saved</a>
	           </div>
           <%}else{ %>
	           <div class="col-md-2  padding-bottom-10" >
			    	<a class="btn btn-block btn-outline btn-primary6" href="/liberty/clientProfile/clientProfile.jsp" >Close</a>
	           </div>
           <%}%>
           
		   <%if(!BUTTONIND.equals("P") && !BUTTONIND.equals("C")){%>
  		   <div class="col-md-2 padding-bottom-10" >
		        <input type="button" name="printdraft" class="btn btn-block btn-outline btn-primary4" onclick="fnDraft();" value="Print Draft">
           </div>
           
           <div class="col-md-2 padding-bottom-10" >
		        <input type="button" name="generate" class="btn btn-block btn-outline btn-primary4" value="Purchase Policy" onClick="fncheckSubmit();">
           </div>

 
           <%}else{%>
           <div class="col-md-2 padding-bottom-10" >
		        <input type="submit" name="generate" class="btn btn-block btn-outline btn-primary4" value="Print to PDF" onclick="return emailPDF();">
           </div>
           <%} %>
           <div class="col-md-5 " >
           	<div class="col-md-1 padding-left-0 padding-top-15 padding-bottom-10">
	           		<div class="checkbox-custom checkbox-primary btn-block">
		           		<input type="checkbox" id="inputUnchecked" name="checkEmail" onclick="fnCheckbox();">
		           		<label for="inputUnchecked"></label>
		            </div>
	           	</div>	
	           		<div class="col-md-7  padding-left-0">
		    		 <input type="text" id="exampleTypeaheadBasic" name="EMAIL" class="form-control tt-input" autocomplete="off" spellcheck="false"  disabled>
	           </div>
       	 	</div>
       	</div>
        <div class="row padding-left-0 ">
		    <div class="col-md-12 padding-left-0  ">
		          <h5 class="page-aside-title2 textLeft padding-left-20  margin-0 textRed">Take Note : Kindly check on the box and key in the Recipient's E-Mail Address if you wish to send out the E-Mail. </h5>
		          <input type="hidden" id="inputHiddenInline" />	
		    </div>
		</div>
        
    </div>
         
		
   </div>
   </div>
   
   </form>
  
  <div id="splashScreen2" name="splashScreen2"  STYLE="position: fixed; left: 0; top:0; z-index: 9999; width: 100%; background: rgba(255, 255, 255, .5);height: 100%; overflow: visible;visibility:hidden " align="center">
  <div  style="margin-top: 150px;display: block;" class="bld"><BR><br/><IMG SRC="/liberty/assets/images/preload.gif" BORDER=1 name="wait"><br/><br/>
  <FONT style="font-family: Arial;font-size:19px;color:#BC0204;font-weight:bold;text-align:center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please Wait . . . </FONT>
  </div>
  </div>
  <div ID="splashScreen" name="splashScreen" STYLE="position:absolute;z-index:5;top:0%;left:0%;border: 5px;visibility:hidden">
  <iframe id="pleasewait" name="pleasewait" scrolling="no" border="0" frameborder="0" src="/liberty/common/popup/pleasewait.jsp" style="width:0px; height:0px; border: 0px; overflow-x: hidden; overflow-y: hidden; "></iframe>
  </div>
  <div style="display:none">
  <iframe id="RSIFrame" name="RSIFrame" src="/liberty/common/blank.jsp" style="width:0px; height:0px; border: 0px"></iframe>
  <form name="checkFWCMSREF" method="post" target="RSIFrame" AUTOCOMPLETE="off"></form>
  <form name="checkMYEG" method="post" target="RSIFrame" AUTOCOMPLETE="off"></form>
  </div>
  <!-- Core  -->
  <script src="/liberty/assets/js/jquery.min.js"></script>
  <script src="/liberty/assets/js/bootstrap.min.js"></script>
  <script src="/liberty/assets/js/jquery-asScroll.min.js"></script>
  <script src="/liberty/assets/js/jquery.mousewheel.min.js"></script>
  <script src="/liberty/assets/js/jquery.asScrollable.all.min.js"></script>
  <script src="/liberty/assets/js/jquery-asHoverScroll.min.js"></script>

  <!-- Plugins -->
  <script src="/liberty/assets/js/switchery.min.js"></script>
  <script src="/liberty/assets/js/intro.min.js"></script>
  <script src="/liberty/assets/js/screenfull.js"></script>
  <script src="/liberty/assets/js/jquery-slidePanel.min.js"></script>


  <!-- Plugins For This Page -->
  <script src="/liberty/assets/js/jquery-asBreadcrumbs.min.js"></script>
  <script src="/liberty/assets/js/jquery.sparkline.min.js"></script>
  <script src="/liberty/assets/js/jquery.matchHeight-min.js"></script>
  <script src="/liberty/assets/js/jquery-asPieProgress.min.js"></script>
  <script src="/liberty/assets/js/tablesaw.js"></script>
  <script src="/liberty/assets/js/jquery.dataTables.min.js"></script>
  <script src="/liberty/assets/js/dataTables.fixedHeader.js"></script>
  <script src="/liberty/assets/js/dataTables.bootstrap.min.js"></script>
  <script src="/liberty/assets/js/dataTables.responsive.js"></script>
  <script src="/liberty/assets/js/dataTables.tableTools.js"></script>
  <script src="/liberty/assets/js/jquery-asRange.min.js"></script>
  <script src="/liberty/assets/js/bootbox.js"></script>

  <!-- Scripts -->
  <script src="/liberty/assets/js/core.min.js"></script>
  <script src="/liberty/assets/js/site.min.js"></script>
  <script src="/liberty/assets/js/menu.min.js"></script>
  <script src="/liberty/assets/js/menubar.min.js"></script>
  <script src="/liberty/assets/js/gridmenu.min.js"></script>
  <script src="/liberty/assets/js/sidebar.min.js"></script>
  <script src="/liberty/assets/js/asscrollable.min.js"></script>
  <script src="/liberty/assets/js/slidepanel.min.js"></script>
  <script src="/liberty/assets/js/nprogress.min.js"></script>
  <script src="/liberty/assets/js/matchheight.min.js"></script>
  <script src="/liberty/assets/js/asscrollable.min.js"></script>
  
  <!-- Scripts For This Page -->
  <script src="/liberty/assets/js/bootstrap-tagsinput.js"></script>
  <script src="/liberty/assets/js/bootstrap-tokenfield.js"></script>
  <script src="/liberty/assets/js/jquery.multi-select.js"></script>
  <script src="/liberty/assets/js/typeahead.jquery.js"></script>
  <script src="/liberty/assets/js/bloodhound.js"></script>
  <script src="/liberty/assets/js/jquery-asSpinner.js"></script>

  <script src="/liberty/assets/js/bootstrap-datepicker.min_2.js"></script>
  <script src="/liberty/assets/js/bootstrap-datepicker.min.js"></script>
  <script src="/liberty/assets/js/advanced.js"></script>
  <script src="/liberty/assets/js/aspieprogress.min.js"></script>
  <script src="/liberty/assets/js/pie-progress.js"></script>
  <script src="/liberty/assets/js/panel.min.js"></script>
  <script src="/liberty/assets/js/panel-actions.js"></script>
  <script src="/liberty/assets/js/asbreadcrumbs.min.js"></script>
  <script src="/liberty/assets/js/select2.min.js"></script>
  <script src="/liberty/assets/js/bootstrap-select.min.js"></script>
  <script src="/liberty/assets/js/icheck.min.js"></script>
  <script src="/liberty/assets/js/jquery-asRange.min.js"></script>
  <script src="/liberty/assets/js/bootstrap-datepicker.min.js"></script>
  <script src="/liberty/assets/js/datepair-js.min.js"></script>
  <script src="/liberty/assets/js/jquery.datepair.min.js"></script>
  <script src="/liberty/assets/js/jquery.multi-select.js"></script>
  <script src="/liberty/assets/js/select2.js"></script>
  <script src="/liberty/assets/js/bootstrap-select.js"></script>
  <script src="/liberty/assets/js/bootstrap-datepicker.min.js"></script>
  <script type="text/javascript" src="/liberty/assets/js/tableAction.js"></script>
  <script type="text/javascript" src="/liberty/assets/js/tableExport.js"></script>
  <script type="text/javascript" src="/liberty/assets/js/jquery.base64.js"></script>
  <script type="text/javascript" src="/liberty/assets/js/sprintf.js"></script>
  <script type="text/javascript" src="/liberty/assets/js/jspdf.js"></script>
  <script type="text/javascript" src="/liberty/assets/js/base64.js"></script>

  <script>
    (function(document, window, $) {
      'use strict';

      var Site = window.Site;
      $(document).ready(function() {
        Site.run();
      });
    })(document, window, jQuery);
  </script>
</body>

</html>