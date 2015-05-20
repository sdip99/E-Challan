<%@page import="org.echallan.dataAccessObject.LicenseDAO"%>
<%@page import="org.echallan.valueObject.License"%>
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

    <script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="lib/cool.js"></script>
        <script src="lib/jQuery-Knob/js/jquery.knob.js" type="text/javascript"></script>
    <script type="text/javascript">
    	$(function() {
            $(".knob").knob();
        });
        var isVerifiedVehicle = true;
        var request; 
        function fetchNameUpdate()  
        {
        	
	        var v = document.getElementsByName("license_no")[0];
	        if(v.value == "")
	        	return;
	        
	        if(window.XMLHttpRequest){  
	        	request=new XMLHttpRequest();  
	        }  
		        else if(window.ActiveXObject){  
		        request=new ActiveXObject("Microsoft.XMLHTTP");  
	        }  
	          
	        try  
	        {  
		        request.onreadystatechange = updateNames;  
		        request.open("GET", "Controller?license_fetch_req=" + v.value, true);  
		        request.send();  
	        }  
	        catch(e)  
	        {  
	        	alert("Unable to connect to server");  
	        }
        }
        
        function sendInfo()  
        {
        	
        	var v = document.getElementById("cat_drop");
        	var x = document.getElementsByName("license_no")[0];
        	if(window.XMLHttpRequest){
        		request=new XMLHttpRequest();
        	} else if(window.ActiveXObject) {
        		request=new ActiveXObject("Microsoft.XMLHTTP");
        	}
        	try {
        		request.onreadystatechange = getInfo;
        		request.open("GET", "Controller?cat_id=" + v.value + "&lno=" + x.value, true);
        		request.send();
        	} catch(e) {
        		alert("Unable to connect to server");
        	}
        }
        
        function verifyVehicle() {
        	var v = document.getElementsByName("vehicle_no")[0];
	        if(v.value == "")
	        	return;
	        
	        if(window.XMLHttpRequest){  
	        	request=new XMLHttpRequest();  
	        }  
		        else if(window.ActiveXObject){  
		        request=new ActiveXObject("Microsoft.XMLHTTP");  
	        }  
	          
	        try  
	        {  
		        request.onreadystatechange = notifyVehicleIsStolen;  
		        request.open("GET", "Controller?veify_vehicle=" + v.value, true);  
		        request.send();  
	        }  
	        catch(e)  
	        {  
	        	alert("Unable to connect to server");  
	        }
        }
        
        function sendVehicleVerified() {
        	var v = document.getElementsByName("vehicle_no")[0];
	        if(v.value == "")
	        	return;
	        
	        if(window.XMLHttpRequest){  
	        	request=new XMLHttpRequest();  
	        }  
		        else if(window.ActiveXObject){  
		        request=new ActiveXObject("Microsoft.XMLHTTP");  
	        }  
	          
	        try  
	        {
		        request.open("GET", "Controller?vehicle_verifed=" + v.value, true);  
		        request.send();  
	        }  
	        catch(e)  
	        {  
	        	alert("Unable to connect to server");  
	        }
        }
        
        function notifyVehicleIsStolen() {
        	if(request.readyState==4) {
        		var val = request.responseText;
        		if(val != "") {
            		document.getElementsByName("submit")[0].disabled = true;
            		isVerifiedVehicle = false;
        		}
        		document.getElementById("vehicle_stolen_notify").innerHTML = val;
        		document.getElementById('confirm_but').addEventListener('click', function(evt) {
        			isVerifiedVehicle = true;
        			sendVehicleVerified();
        			document.getElementById("vehicle_stolen_notify").innerHTML = '';
        			document.getElementsByName("submit")[0].disabled = false;
        			evt.preventDefault();
        		}, false);
        		document.getElementById('cancel_but').addEventListener('click', function(evt) {
        			document.getElementById("vehicle_stolen_notify").innerHTML = '';
        			document.getElementsByName("vehicle_no")[0].value = '';
        			evt.preventDefault();
        		}, false);
        	}
        }

        function getInfo(){
        	if(request.readyState==4){
        		var val = request.responseText;
        		document.getElementById("rule-inner").innerHTML = val;
        	}
        }
        
        function updateNames(){  
	        if(request.readyState==4){  
		     	val2 = request.responseText;
		     	var delim = val2.split(",");
		     	document.getElementsByName("first_name")[0].value  = (delim[0] != null) ? delim[0] : "";
		     	document.getElementsByName("last_name")[0].value = (delim[1] != null) ? delim[1] : "";
	        }  
        }
        
	    function addRow(tableID) { 
	    	var table = document.getElementById(tableID);
	    	var rowCount = table.rows.length;
	    	var row = table.insertRow(rowCount);
	    	if(checkDuplicate(table)) {
	    		alert('Rule is already added...!');
	    		return;
	    	}
	    	var colCount = table.rows[0].cells.length;
	    	var newcell = row.insertCell(0);
	    	newcell.innerHTML = '<p style="margin-top: 12px;"><INPUT type="checkbox" name="chk"/></p>';
	    	newcell = row.insertCell(1);
	    	var ruleDrop = document.getElementById("rule_drop");
	    	newcell.innerHTML = '<p style="margin-top: 12px;">' + $("#rule_drop option:selected").val(); + '</p>';
	    	newcell = row.insertCell(2);
	    	newcell.innerHTML = '<p style="margin-top: 12px;">' + $("#rule_drop option:selected").html(); + '</p>';
	    }
	    
	    function checkDuplicate(table) {
	    	try { 
				var rowCount = table.rows.length;
				for(var i=1 ; i < rowCount ; i++) { 
					var row = table.rows[i];
					if(row.cells[1].childNodes[0].innerHTML == $("#rule_drop option:selected").val())
						return true;
				}
			} catch(e) { 
				//alert("exp" + e);
			}
			return false;
	    }
	    
		function deleteRow(tableID) {
			try { 
				var table = document.getElementById(tableID);
				var rowCount = table.rows.length;
				for(var i=1 ; i < rowCount ; i++) { 
					var row = table.rows[i];
					var chkbox = row.cells[0].childNodes[0].childNodes[0];
					if(null != chkbox && true == chkbox.checked) { 
						if(rowCount<=1) {
							alert("Cannot delete all the rows.");
							break;
						}
						table.deleteRow(i);
						rowCount--;
						i--;
					}
				}
			} catch(e) { 
				alert(e);
			}
		}
		
		function validateAndSend() {
			var lno = document.myForm.license_no;
			var veh = document.myForm.vehicle_no;
			var fn = document.myForm.first_name;
			var ln = document.myForm.last_name;
		
			if(lno.value == "" && fn.value == "" && ln.value == "") {
				alert("Please enter either license no or first naem & last name")
				return false;
			}
			
			if(veh.value == "") {
				veh.focus();
				alert("Please enter vehicle number");
				return false;
			}
			
			
			
			var response = "";
			var table = document.getElementById('rule_table');
			var rowCount = table.rows.length;

			if(rowCount < 2) {
				alert("Please enter atleast one rule");
				return false;
			}

			if(!isVerifiedVehicle) {
				alert("Please verify vehicle first...!")
				return false;
			}
			for(var i=1 ; i < rowCount ; i++) {
				var row = table.rows[i];
				//alert(row.cells[1].childNodes[0].innerHTML);
				response += (row.cells[1].childNodes[0].innerHTML + ",");
			}
			var input = document.createElement("input");
			input.type = 'hidden';
		    input.name = 'rule_drop';
		    input.value = response;
			document.getElementsByName("myForm")[0].appendChild(input);
			return true;
		}
        
    </script>


    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<body class=" theme-blue" onload="sendInfo();">
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
        	License license = null;
        	// do not accept empty string
        	if(licenseNo != null && !licenseNo.equals("")) {
            	license = new LicenseDAO().getLicenseByNo(licenseNo);
        	}
			if(session.getAttribute("error") != null) {
				if((Boolean) session.getAttribute("error")) { 
		%>
			<div class="panel panel-default">
		        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
	        	<div id="page-stats" class="panel-collapse panel-body collapse in">
	        		<center><span  style="color:red;">Oops...! Something went wrong.<br />Please enter valid data.</span></center>
	        	</div>
		    </div>
	   <%
				}
				session.removeAttribute("error");
			}
		%>
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Generate Challan</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" name="myForm" method="post" onsubmit="return validateAndSend();">
						<div class="form-group">
							
							<p>
								<label> License no: </label>
								<input type="text" class="form-control span12" name="license_no" <% if(licenseNo != null) out.print("value='" + licenseNo + "'"); %> onblur="return fetchNameUpdate();"/>
							</p>
							<p>
								<label>Vehicle no: </label>
								<input type="text" class="form-control span12" name="vehicle_no" onblur="return verifyVehicle();"/>
							</p>
							<p>
								<span id="vehicle_stolen_notify">
								</span>
							</p>
							<p>
								<label>First Name: </label>
								<input type="text" class="form-control span12" name="first_name" <% if(license != null) out.print("value='" + license.getfName() + "'"); %>/>
							</p>
							<p>
								<label>Last Name: </label>
								<input type="text" class="form-control span12" name="last_name" <% if(license != null) out.print("value='" + license.getlName() + "'"); %>/>
							</p>
							<p>
								<label>Suspend Vehicle: </label>
								<input type="checkbox" name="status" />
							</p>
							<label>Select Catagory:</label>
							<select id="cat_drop" class="form-control" onchange="return sendInfo();">
								<%
									List<Catagory> cat = new CatagoryDAO().getAll();
									for(Catagory c : cat)
										out.print("<option value=" + c.getCatID() + ">" + c.getCatName() + "</option>");
								%>
							</select>
							<label>Select Rule:</label>
							<span id="rule-inner">
								<select id="rule_drop" class="form-control">
								</select>
							</span>
							<br />
							<center>
								<input type="button" class="form-control inline-ele-left" value="Add" style="width: 25%; background-color: #315E8A; color: #ffffff" onClick="addRow('rule_table');"/>
								<input type="button" class="form-control inline-ele" value="Delete" style="width: 25%; background-color: #315E8A; color: #ffffff" onClick="deleteRow('rule_table');"/>
							</center>
							<table class="table table-bordered table-striped" id="rule_table">
				              <thead>
				                <tr>
				                  <th></th>
				                  <th>Rule ID</th>
				                  <th>Rule Name</th>
				                </tr>
				              </thead>
				              <tbody>
				              </tbody>
				            </table>
						<div align="center">		
							<input type="submit"  class="btn btn-primary" value="Generate Challan" name="submit" onclick="return valuee();"/>
						 
						</div>
							
						</div>
						<div class="clearfix"></div>
					</form>
				</div>
			</div>
			
            <footer>
                <hr>

                <p class="pull-right">E-Challan System</p>
                <p>Copyright© 2014 Harsh Panchal, Deep Shah</p>
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
