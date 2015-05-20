<%@page import="org.echallan.dataAccessObject.CityDAO"%>
<%@page import="org.echallan.valueObject.City"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Violation History : e-Challan System</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">

    <script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>

        <script src="lib/jQuery-Knob/js/jquery.knob.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $(".knob").knob();
        });
        
        function fetchResult()  
        {
        	
	        var v = document.getElementById("lno")
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
		        request.onreadystatechange = updateRes;  
		        request.open("GET", "Controller?view_viol_hist=" + v.value, true);  
		        request.send();  
	        }  
	        catch(e)  
	        {  
	        	alert("Unable to connect to server");  
	        }
        }

        function updateRes() {
	        if(request.readyState==4) {
	        	var table = document.getElementById("resTab");
	        	emptyTable(table);
	        	var rows = request.responseText.split("\n");
	        	var out;
	        	for(out=0; out < (rows.length - 1); out++) {
	        		var row = rows[out].split(",");
	        		var newRow = table.insertRow(table.rows.length);
	        		var inner;
	        		for(inner in row) {
	        			var cell = newRow.insertCell(inner);
	        			cell.innerHTML = row[inner];
	        		}
	        	}
	        		
	        }
        }
        
        function emptyTable(table) {
        	var counter = 1;
        	while(counter < table.rows.length) {
        		table.deleteRow(1);
        	}
        }
        
    </script>


    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Violation History</h1>
        </div>
        <div class="main-content">
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">View violation history</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
								<label>License No:</label>
								<table width="100%">
									<tr>
										<td width="90%"><input type="text" class="form-control" id="lno"/></td>
										<td><center><input type="button" name="submit" class="btn btn-primary" value="Show" onClick="return fetchResult();"/></center></td>
									</tr>
								</table>
								<br/>
								<table class="table" id="resTab">
								  <thead>
								    <tr>
								      <th>Challan ID</th>
								      <th>vehicle No</th>
								      <th>Vehicle Suspended</th>
								      <th>TimeStamp</th>
								      <th style="width: 3.5em;"></th>
								    </tr>
								  </thead>
								</table>
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
