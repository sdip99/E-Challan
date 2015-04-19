<%@page import="org.echallan.dataAccessObject.AreaDAO"%>
<%@page import="org.echallan.valueObject.Area"%>
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
    <title>Insert Checkpost : e-Challan System</title>
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
        var request;  
        function sendInfo()  
        {
        	var v = document.getElementsByName("city_drop")[0];
        	if(window.XMLHttpRequest){
        		request=new XMLHttpRequest();
        	} else if(window.ActiveXObject) {
        		request=new ActiveXObject("Microsoft.XMLHTTP");
        	}
        	try {
        		request.onreadystatechange = getInfo;
        		request.open("GET", "Controller?ins_chk_city_id=" + v.value, true);
        		request.send();
        	} catch(e) {
        		alert("Unable to connect to server");
        	}
        }

        function getInfo(){
        	if(request.readyState==4){
        		var val = request.responseText;
        		document.getElementById("area_inner").innerHTML = val;
        	}
        }
    </script>


    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<body class=" theme-blue" onload="sendInfo()">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Insert Checkpost</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Insert Checkpost</li>
	        </ul>
        </div>
        <div class="main-content">
        
	        <%
				if(session.getAttribute("insert_chkpost_status") != null) {
					if((Boolean) session.getAttribute("insert_chkpost_status")) { 
			%>
			<div class="panel panel-default">
		        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
	        	<div id="page-stats" class="panel-collapse panel-body collapse in">
	        		<center>CheckPost added successfully...!</center>
	        	</div>
		    </div>
		   <%
					} else {
			%>
			<div class="panel panel-default">
				<a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-times"></i> Error</a>
	        	<div id="page-stats" class="panel-collapse panel-body collapse in">
	        		<span style="color:red;"><center>Insert failed...!<br />Please enter valid data.</center></span>
	        	</div>
	        </div>
			<%
					}
					session.removeAttribute("insert_chkpost_status");
				}
			%>
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Insert Checkpost</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							<p>
								<p class="pull-right"><a href="insert_city.jsp" style="font-size: 12px">Click here to add new city</a></p>
								<label>City Assigned:</label>
								<select class="form-control " name="city_drop" onchange="return sendInfo();">
								<%
									List<City> city = new CityDAO().getAll();
									for(City c : city)
										out.println("<option value='" + c.getCityID() + "'>" + c.getName() + "</option>");
								%>
								</select>
							</p>
							<p>
								<p class="pull-right"><a href="insert_area.jsp" style="font-size: 12px">Click here to add new area</a></p>
								<label>Area Assigned:</label>
								<span id="area_inner">
									<select class="form-control " name="area_drop"></select>
								</span>
							</p>
							<p>
								<label>SubArea Name:</label>
								<input type="text" class="form-control span12" name="subarea_name"/>
							</p>
							<input type="submit" name="submit" class="btn btn-primary form-control" value="Insert CheckPost" name="submit"/>
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
