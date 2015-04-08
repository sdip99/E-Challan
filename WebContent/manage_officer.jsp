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
    <title>Manage Officers : e-Challan System</title>
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
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Manage Officer</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Manage Officer</li>
	        </ul>
        </div>
        <%
			if(session.getAttribute("upd_off_status") != null) {
				if((Boolean) session.getAttribute("upd_off_status")) { 
		%>
		<div class="panel panel-default">
		    <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
	       	<div id="page-stats" class="panel-collapse panel-body collapse in">
	       		<center>Data Updated...!</center>
	       	</div>
		</div>
		<%
				} else {
		%>
		<div class="panel panel-default">
			<a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-times"></i> Error</a>
	       	<div id="page-stats" class="panel-collapse panel-body collapse in">
	       		<span style="color:red;"><center>Update failed...!<br />Please enter valid data.</center></span>
	       	</div>
	       </div>
		<%
				}
				session.removeAttribute("upd_off_status");
			}
		%>
        <div class="main-content">        
			<div class="btn-toolbar list-toolbar">
			    <a href="add_officer.jsp" class="btn btn-primary"><i class="fa fa-plus"></i> Add New</a>
			  <div class="btn-group">
			  </div>
			</div>
			<table class="table">
			  <thead>
			    <tr>
			      <th>#</th>
			      <th>Name</th>
			      <th>User/E-mail ID</th>
			      <th style="width: 3.5em;"></th>
			    </tr>
			  </thead>
			  <tbody>
			  <!-- 
			    <tr>
			      <td>1</td>
			      <td>Mark</td>
			      <td>Tompson</td>
			      <td>the_mark7</td>
			      <td>
			          <a href="user.html"><i class="fa fa-pencil"></i></a>
			          <a href="#myModal" role="button" data-toggle="modal"><i class="fa fa-trash-o"></i></a>
			      </td>
			    </tr>
			   -->
			  <%
			  	int i = 1;
				List<User> users = new UserDAO().getAllUsers();
			  	for(User u : users) {
			  		UserDetail uDetail = u.getUserDetail();
			  		out.println("<tr><td>" + i + "</td><td>" + uDetail.getFirstName() + " " + uDetail.getLastName() + "</td>");
			  		out.println("<td>" + u.getUserID() + "</td>");
			  		out.println("<td><a href='view_user.jsp?uid=" + u.getUserID_pkey() +"' role='button' data-toggle='modal'><i class='fa fa-eye'></i></a></td></tr>");
			  		i++;
			  	}
			  %>
			  </tbody>
			</table>
			
			<!-- This portion shows page numbers
			<ul class="pagination">
			  <li><a href="#">&laquo;</a></li>
			  <li><a href="#">1</a></li>
			  <li><a href="#">2</a></li>
			  <li><a href="#">3</a></li>
			  <li><a href="#">4</a></li>
			  <li><a href="#">5</a></li>
			  <li><a href="#">&raquo;</a></li>
			</ul>
			 -->
			 			
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
