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

        <script src="lib/jQuery-Knob/js/jquery.knob.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $(".knob").knob();
        });
        $("#e4").select2({
        	placeholder : "Select Rule",
        	width: 375,
        	allowclear:true
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
        
			
		
		     <div class="main-content">
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Search License</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							
							<p>
								<label> License no: </label>
								<input type="text" class="form-control span12" name="license_no"/>
							</p>
							<p>
								<label>Vehicle no: </label>
								<input type="text" class="form-control span12" name="vehicle_no"/>
							</p>
							<p>
								<label>vehicle category: </label>
								<select class="form-control " name="cat_name" >
								<%
									CatagoryDAO dao =  new CatagoryDAO();
									List<Catagory> cat = dao.getAll();
									for(Catagory c : cat)
										out.println("<option value='" + c.getCatID()+ "'>" + c.getCatName() + "</option>");
								%>
								</select>
							</p>
							<p>
								<label>Rules: </label>
								<select  class="form-control " id="e4" multiple>
								 
								 	<%
										out.print("<optgroup  lable='rule'>");								 	
										RuleDAO ru = new RuleDAO();
								 		List<Rule> rule = ru.getAll();
								 		for(Rule r : rule)
								 			out.println("<option value=" + r.getRuleId()+ " >" + r.getRuleName() + "</option>");
								 		out.print("</optgroup>");
								 	%>
								</select>
							</p>
							
							<input type="submit" name="submit" class="btn btn-primary form-control" value="Search License" name="submit"/>
						</div>
						<div class="clearfix"></div>
					</form>
				</div>
			</div>
			
            <footer>
                <hr>

                <p class="pull-right">E-Challan System</p>
                <p>Copyrightę 2014 Harsh Panchal, Deep Shah</p>
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
