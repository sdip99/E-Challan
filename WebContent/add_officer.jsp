<%@page import="java.util.Set"%>
<%@page import="org.echallan.dataAccessObject.SubAreaDAO"%>
<%@page import="org.echallan.valueObject.SubArea"%>
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
    <title>Add Officer : e-Challan System</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">

    <script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="js/validation.js" type="text/javascript"></script>

        <script src="lib/jQuery-Knob/js/jquery.knob.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $(".knob").knob();
        });
        var request;
        var v;
        var target;
        function sendInfo(type)  
        {
        	target = type;
        	if(type == "city") {
        		v = document.getElementById("city_assigned");
        		removeOptions(document.getElementById("subarea_drop"));
        	} else {
        		v = document.getElementById("area_assigned");
        	}
        	if(window.XMLHttpRequest){
        		request=new XMLHttpRequest();
        	} else if(window.ActiveXObject) {
        		request=new ActiveXObject("Microsoft.XMLHTTP");
        	}
        	try {
        		request.onreadystatechange = getInfo;
        		if(type == "city")
        			request.open("GET", "Controller?city_id=" + v.value, true);
        		else
        			request.open("GET", "Controller?area_id=" + v.value, true);
        		request.send();
        	} catch(e) {
        		alert("Unable to connect to server");
        	}
        }

        function getInfo(){
        	if(request.readyState==4){
        		var val = request.responseText;
        		if(target == "city")
        			document.getElementById("area_inner").innerHTML = val;
        		else
        			document.getElementById("sarea_inner").innerHTML = val;
        	}
        }
        
        function removeOptions(selectbox)
        {
            var i;
            for(i=selectbox.options.length-1;i>=0;i--)
            {
                selectbox.remove(i);
            }
        }
    </script>


    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>
    <c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Add Officer</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Add Officer</li>
	        </ul>
        </div>
        <div class="main-content">
        
	        <%
				if(session.getAttribute("add_officer_status") != null) {
					if((Boolean) session.getAttribute("add_officer_status")) { 
			%>
			<div class="panel panel-default">
		        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
	        	<div id="page-stats" class="panel-collapse panel-body collapse in">
	        		<center>User added successfully...!</center>
	        	</div>
		    </div>
		   <%
					} else {
			%>
			<div class="panel panel-default">
				<a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-times"></i> Error</a>
	        	<div id="page-stats" class="panel-collapse panel-body collapse in">
	        		<span style="color:red;"><center>Cannot add User...!<br />Please enter valid data.</center></span>
	        	</div>
	        </div>
			<%
					}
					session.removeAttribute("add_officer_status");
				}
			%>
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Add Officer</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post" name="add_officer" onsubmit="return validateAddofficer();">
						<div class="form-group">
							<p>
								<label>First Name: </label>
								<input type="text" class="form-control span12" name="first_name"/>
							</p>
							<p>
								<label>Last Name: </label>
								<input type="text" class="form-control span12" name="last_name"/>
							</p>
							<p>
								<label>Mobile Number: </label>
								<input type="text" class="form-control span12" name="mobile_no"/>
							</p>
							<p>
								<label>Street: </label>
								<input type="text" class="form-control span12" name="street"/>
							</p>
							<p>
								<label>City: </label>
								<input type="text" class="form-control span12" name="city"/>
							</p>
							<p>
								<label>State: </label>
								<input type="text" class="form-control span12" name="state"/>
							</p>
							<p>
								<label>Pincode: </label>
								<input type="text" class="form-control span12" name="pincode"/>
							</p>
							<p>
								<label>E-mail ID: </label>
								<input type="text" class="form-control span12" name="email"/>
							</p>
							<p>
								<label>Password: </label>
								<input type="password" class="form-control span12" name="password"/>
							</p>
							<p>
								<label>Confirm Password: </label>
								<input type="password" class="form-control span12" name="password2"/>
							</p>
							<p class="inline-field">
								<label>City Assigned:</label>
								<select class="form-control " name="city_assigned" id="city_assigned" onChange="return sendInfo('city');">
								<%
									List<City> city = new CityDAO().getAll();
									for(City c : city)
										out.println("<option value='" + c.getCityID() + "'>" + c.getName() + "</option>");
								%>
								</select>
							</p>
							<p class="inline-field" >
								<label>Area Assigned:</label>
								<span id="area_inner">
									<select class="form-control " name="area_assigned" id="area_assigned" onChange="return sendInfo('area');">
									<%
										Set<Area> area = city.get(0).getArea();
										for(Area a : area)
											out.println("<option value='" + a.getArea_id() + "'>" + a.getName() + "</option>");
									%>
									</select>
								</span>
							</p>
								<label>SubArea Assigned:</label>
								<span id="sarea_inner">
									<select class="form-control " name="subarea_assigned" id="subarea_drop">
									<%
										Set<SubArea> sarea = area.iterator().next().getSubarea();
										for(SubArea a : sarea)
											out.println("<option value='" + a.getSubarea_id() + "'>" + a.getName() + "</option>");
									%>
									</select>
								</span>
							</p>
							<input type="submit" name="submit"  class="btn btn-primary form-control" value="Insert Officer" name="submit"/>
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
