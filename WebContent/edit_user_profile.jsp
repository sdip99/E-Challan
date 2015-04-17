<%@page import="org.echallan.valueObject.UserDetail"%>
<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Edit Profile : e-Challan System</title>
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
            </script>


    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<%
User user = (User)session.getAttribute("user_info");
UserDetail u = user.getUserDetail();

%>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_police_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Edit Profile</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li><a href="profile.jsp">My Profile</a> </li>
	            <li class="active">Edit Profile</li>
	        </ul>
        </div>
        <div class="main-content">
        
        	<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Edit Profile</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							<p>
								<label>First Name: </label>
								<input type="text" class="form-control span12" name="first_name" value="<% out.print(u.getFirstName()); %>" />
							</p>
							<p>
								<label>Last Name: </label>
								<input type="text" class="form-control span12" name="last_name" value="<% out.print(u.getLastName()); %>" />
							</p>
							
							<p>
								<label>Street: </label>
								<input type="text" class="form-control span12" name="street" value="<% out.print(u.getStreet()); %>" />
							</p>
							<p>
								<label>City: </label>
								<input type="text" class="form-control span12" name="city" value="<% out.print(u.getCity()); %>" />
							</p>
							<p>
								<label>State: </label>
								<input type="text" class="form-control span12" name="state" value="<% out.print(u.getState()); %>" />
							</p>
							<p>
								<label>Pincode: </label>
								<input type="text" class="form-control span12" name="pincode" value="<% out.print(u.getPincode()); %>" />
							</p>
							<p>
								<label>E-mail ID: </label>
								<input type="text" class="form-control span12" name="email" value="<% out.print(user.getUserID()); %>"/>
							</p>
							<p>
								<label>Mobile Number: </label>
								<input type="text" class="form-control span12" name="mobile_no" value="<% out.print(u.getMobileNo()); %>" />
							</p>
							
							<input type="submit" name="submit" class="btn btn-primary form-control" value="Edit Profile" name="submit"/>
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
