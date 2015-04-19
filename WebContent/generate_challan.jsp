<%@page import="java.util.Set"%>
<%@page import="org.echallan.dataAccessObject.RuleDAO"%>
<%@page import="org.echallan.valueObject.Rule"%>
<%@page import="org.echallan.valueObject.Catagory"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.dataAccessObject.CatagoryDAO"%>
<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Generate Challan : e-Challan System</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">
	<script src="js/validation.js" type="text/javascript"></script>
    <script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="lib/cool.js"></script>
    <script src="lib/jQuery-Knob/js/jquery.knob.js" type="text/javascript"></script>
    <script type="text/javascript">
    var x=0;    
    var val;
    var count=0;
    var s=0;
    $(function() {
            $(".knob").knob();
            
            $("#btnAdd").bind("click", function () {
            	var div = $("<div />");
                div.html(GetDynamicTextBox(x));
                $("#newRule").append(div);
                x++;
               
            });
            
            $("body").on("click", ".remove", function () {
                $(this).closest("div").remove();
            });
        });
        
        
        var request;  
        function sendInfo()  
        {
        	
	        var v = document.getElementById("cat_name");
	        
	        if(window.XMLHttpRequest){  
	        	request=new XMLHttpRequest();  
	        }  
		        else if(window.ActiveXObject){  
		        request=new ActiveXObject("Microsoft.XMLHTTP");  
	        }  
	          
	        try  
	        {  
		        request.onreadystatechange = getInfo;  
		        request.open("GET", "Controller?cat_id=" + v.value, true);  
		        request.send();  
	        }  
	        catch(e)  
	        {  
	        	alert("Unable to connect to server");  
	        }
        }  
          
        function getInfo(){  
	        if(request.readyState==4){  
		     	val = request.responseText;
		     	var i=0;
		        while(i<=x){
		        	
		        	document.getElementsByName("rule_inner")[i].innerHTML=val;
					i++;		        
		        }
	        }  
        }
       
       
        function GetDynamicTextBox(value) {
        	
        	sendInfo();
        	return '<span name="rule_inner" ></span> &nbsp;' +
                    '<input type="button" value="Remove" class="remove" />'
        }
        
    </script>


    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_police_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Generate Challan</h1>
	       	<ul class="breadcrumb">
	            <li><a href="police_dashboard.jsp">Home</a> </li>
	            <li class="active">Generate Challan</li>
	        </ul>
        </div>
		<div class="main-content">
        <%
        	String licenseNo = request.getParameter("licenseno");
        	// do not accept empty string
        	if(licenseNo != null && licenseNo.equals(""))
        		licenseNo = null;
        %>
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Generate Challan</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post" name="g_challan" onsubmit="return validateGeneratechallan();">
						<div class="form-group">
							
							<p>
								<label> License no: </label>
								<input type="text" class="form-control span12" name="license_no" <% if(licenseNo != null) out.print("value='" + licenseNo + "'"); %>/>
							</p>
							<p>
								<label>Vehicle no: </label>
								<input type="text" class="form-control span12" name="vehicle_no"/>
							</p>
					
							<p>
								<label>vehicle category: </label>
								<select class="form-control" id="cat_name" name="cat_name" onChange="return sendInfo();">
								<%
									CatagoryDAO dao =  new CatagoryDAO();
									List<Catagory> cat = dao.getAll();
									for(Catagory c : cat)
										out.println("<option value='" + c.getCatID()+ "'>" + c.getCatName() + "</option>");
								%>
								</select>
							</p>
							<p>
								<label>Rules: </label>
								<input id="btnAdd" type="button" value="Add" />
								<span id="newRule" >
									
								</span>
							</p>
								
								
							<p>
								<label>Suspend Vehicle: </label>
								<input type="checkbox" name="status" />
							</p>
						<div align="center">		
							<input type="submit"  class="btn btn-primary" value="Search For Challan" name="submit" onclick="return valuee();"/>
						 
						</div>
							
						</div>
						<div class="clearfix"></div>
					</form>
				</div>
			</div>
			
            <footer>
                <hr>

                <p class="pull-right">E-Challan System</p>
                <p>Copyright� 2014 Harsh Panchal, Deep Shah</p>
            </footer>
        </div>
    </div>


    <script src="lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
    </script>
    
  
</body></html>