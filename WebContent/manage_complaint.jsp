<%@page import="org.echallan.dataAccessObject.ComplaintDAO"%>
<%@page import="org.echallan.valueObject.Complaint"%>
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
    <title>Manage Complaints : e-Challan System</title>
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
        
        // functions for setting delete flags
        function setParamID(id) {
           	paramid = id;
		}
        
        function redirectAfterConfirm() {
			window.location.href = "manage_complaint.jsp?delete=true&paramid=" + paramid;
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
	        <h1 class="page-title">Manage Complaints</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Manage Complaints</li>
	        </ul>
        </div>
        <div class="main-content">
        	<%
				if(session.getAttribute("upd_comp") != null) {
					if((Boolean) session.getAttribute("upd_comp")) { 
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
					session.removeAttribute("upd_comp");
				}
			%>
			<%
				String str = request.getParameter("delete");
				if(str != null && str.equals("true")) {
					String param = request.getParameter("paramid");
					if(param != null) {
						int id = Integer.parseInt(param);
						if(new ComplaintDAO().removeComplaint(id)) {
			%>
					<div class="panel panel-default">
						        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
					        	<div id="page-stats" class="panel-collapse panel-body collapse in">
					        		<center>Complaint deleted successfully...!</center>
					        	</div>
					</div>
			<%
						}
					}
				}
			%>
			<table class="table">
			  <thead>
			    <tr>
			      <th>ID</th>
			      <th>Title</th>
			      <th>User</th>
			      <th style="width: 3.5em;">Status</th>
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
				List<Complaint> compList = new ComplaintDAO().getAll();
			  	for(Complaint c : compList) {
			  		out.println("<tr><td><a href='view_complaint.jsp?paramid=" + c.getId() + "'>" + c.getId() + "</td><td><a href='view_complaint.jsp?paramid=" + c.getId() + "'>" + c.getTitle() + "</a></td>");
			  		out.println("<td>" + c.getLicense_no() + "</td><td>");
			  		if(c.isAcknowledged())
			  			out.print("<a href='#' title='Acknowledged'><i class='fa fa-check'></i></a>");
			  		else
			  			out.print("<a href='#' title='Unacknowledged'><i class='fa fa-times'></i></a>");
			  		out.println("<a href='#myModal' class='pull-right' role='button' data-toggle='modal' onclick='setParamID(" + c.getId() + ")'><i class='fa fa-trash-o'></i></a></td></tr>");
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
			
			<div class="modal small fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			        <div class="modal-header">
			            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			            <h3 id="myModalLabel">Delete Confirmation</h3>
			        </div>
			        <div class="modal-body">
			            <p class="error-text"><i class="fa fa-warning modal-icon"></i>Are you sure you want to delete this complaint?</p>
			        </div>
			        <div class="modal-footer">
			            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</button>
			            <button class="btn btn-danger" data-dismiss="modal" onclick='redirectAfterConfirm()'>Delete</button>
			        </div>
			      </div>
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
