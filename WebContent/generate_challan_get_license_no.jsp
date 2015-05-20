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
    <c:import url="stub_police_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Generate Challan</h1>
	       	<ul class="breadcrumb">
	            <li><a href="police_dashboard.jsp">Home</a> </li>
	            <li class="active">Generate Challan</li>
	        </ul>
        </div>
        <%
			if(session.getAttribute("wrongInput") != null) {
		%>
		<div class="panel panel-default">
	        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-times"></i> Error</a>
        	<div id="page-stats" class="panel-collapse panel-body collapse in">
        		<span style="color:red;"><center>Invalid License Number !</center></span>
        	</div>
	    </div>
	    <%
			}
			session.removeAttribute("wrongInput");
		%>
		<%
			if(session.getAttribute("noMatch") != null) {
		%>
		<div class="panel panel-default">
	        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-times"></i> Error</a>
        	<div id="page-stats" class="panel-collapse panel-body collapse in">
        		<span style="color:red;"><center>System couldn't find any matching records !<br/>Please re try or skip to <a href="generate_challan.jsp">Challan Generation</a></center></span>
        	</div>
	    </div>
	    <%
			}
			session.removeAttribute("noMatch");
		%>
        <div class="main-content">
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Search License</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" name="gen_chln_ln" method="post" onsubmit="return validateGenChlnLn();">
						<div class="form-group">
							<p>
								<label>License No:</label>
								<input type="text" class="form-control span12" name="license_no"/>
							</p>
							<br/><center>OR<br /> Fill below details to obtain license no</center><br/>
							<p>
								<label>License Holder's First Name: </label>
								<input type="text" class="form-control span12" name="first_name"/>
							</p>
							<p>
								<label>License Holder's Last Name: </label>
								<input type="text" class="form-control span12" name="last_name"/>
							</p>
							<p>
								<label>License Holder's Middle Name: </label>
								<input type="text" class="form-control span12" name="middle_name"/>
							</p>
							<p>
								<label>License Holder's Blood Group: </label>
								<input type="text" class="form-control span12" name="blood_group"/>
							</p>
							<p>
								<label>License Holder's Date of Birth: </label><br />
								Date:
								<input type="text" class="form-control inline-ele-left" name="date" style="width: 10%;"/>
								Month:
								<input type="text" class="form-control inline-ele-left" name="month" style="width: 10%;"/>
								Year:
								<input type="text" class="form-control inline-ele-left" name="year" style="width: 20%;"/>
							</p>
							<p>
								<label>Pincode: </label>
								<input type="text" class="form-control span12" name="pincode"/>
							</p>
							<input type="submit" name="submit" class="btn btn-primary form-control" value="Search License" name="submit"/>
							<br/><br/><center>OR<br /> <a href="generate_challan.jsp">If user don't have license then Click here to proceed to Challan Generation</a></center>
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
