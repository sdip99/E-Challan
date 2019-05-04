<%@page import="org.echallan.dataAccessObject.UserDAO"%>
<%@page import="java.util.Date"%>
<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>e-Challan System</title>
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
	Object obj = session.getAttribute("user_info");
	User user = null;
	if(obj != null) {
		user = (User) obj;
	}
	// terminate session when logout flag is set
	if(user != null && request.getParameter("logout") != null) {
		user.setUuid("");
		new UserDAO().update(user);
		session.invalidate();
	} else if(user != null) {
		response.sendRedirect((user.getUserType() == Common.USER_TYPE_ADMIN) ? "admin_dashboard.jsp" : "police_dashboard.jsp");
	}
%>
<body class=" theme-blue">
    
    <c:import url="stub_header.jsp"></c:import>
    <c:import url="stub_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Welcome</h1>
        </div>
        <div class="main-content">
        	<%
				if(request.getParameter("noMatch") != null) {
			%>
			<div class="panel panel-default">
		        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
	        	<div id="page-stats" class="panel-collapse panel-body collapse in">
	        		<center>The email id you entered doesn't exist...!</center>
	        	</div>
		    </div>
		   <%
		   			session.removeAttribute("noMatch");
				}
			%>
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Message</div>
				<div id="widget1container" class="panel-body collapse in">
			        <p>Welcome to e-Challan System. </p>
			        <p></>e-Challan System provides easy solution or generating traffic challan & easy management of challans. </p>
			        <p>To continue with System either login or enter License No/Vehicle no. to get history regarding to it.</p>
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
