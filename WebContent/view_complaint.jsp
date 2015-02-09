<%@page import="org.echallan.dataAccessObject.ComplaintDAO"%>
<%@page import="org.echallan.valueObject.Complaint"%>
<%@page import="org.echallan.dataAccessObject.SubAreaDAO"%>
<%@page import="org.echallan.valueObject.SubArea"%>
<%@page import="org.echallan.dataAccessObject.AreaDAO"%>
<%@page import="org.echallan.valueObject.Area"%>
<%@page import="org.echallan.valueObject.UserDetail"%>
<%@page import="org.echallan.dataAccessObject.UserDAO"%>
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
    <title>View Complaint : e-Challan System</title>
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
	String paramid = request.getParameter("paramid");
	Complaint complaint = null;
	if(paramid != null)
		complaint = new ComplaintDAO().getComplaintById(paramid);
	else
		response.sendRedirect("manage_complaint.jsp");
	session.setAttribute("paramid", paramid);
%>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">View Complaint</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li><a href="manage_complaint.jsp">Manage Complaints</a> </li>
	            <li class="active">View Complaint</li>
	        </ul>
        </div>
        <div class="main-content">
        
        	<div class="panel panel-default">
			    <div class="panel-heading no-collapse">View Complaint</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							<table>
								<tr><td><%out.print("<h2>" + complaint.getTitle() + "</h2>"); %></td></tr>
								<tr><td><%out.print("<p>" + complaint.getDescription() + "</p>"); %></td></tr>
							</table>
							<br />
							<table>
								<tr><td>Complaint Number: </td><td style="padding-left: 25px"><%out.print(complaint.getId()); %></td></tr>
								<tr><td>From: </td><td style="padding-left: 25px"><%out.print(complaint.getUser_name()); %></td></tr>
								<tr><td>E-mail ID: </td><td style="padding-left: 25px"><%out.print(complaint.getEmail()); %></td></tr>
								<tr><td>License Number: </td><td style="padding-left: 25px"><%out.print(complaint.getLicense_no()); %></td></tr>
								<tr><td>Acknowledged: </td><td style="padding-left: 25px"><input type="checkbox" name="status" <% if(complaint.isAcknowledged()) out.print("checked"); %>/></td></tr>
							</table>
							<p>
								<label>Response:</label>
								<textarea rows="10" cols="12" class="form-control" name="response"><%out.print(complaint.getResponse()); %></textarea>
							</p>
							<input type="submit" name="submit" class="btn btn-primary form-control" value="Update Complaint" name="submit"/>
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
