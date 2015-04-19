<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.Set"%>
<%@page import="org.echallan.valueObject.Rule"%>
<%@page import="org.echallan.dataAccessObject.ChallanDAO"%>
<%@page import="org.echallan.dataAccessObject.LicenseDAO"%>
<%@page import="org.echallan.valueObject.Challan"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.echallan.valueObject.License"%>
<%@page import="org.echallan.valueObject.UserDetail"%>
<%@page import="org.echallan.dataAccessObject.UserDAO"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>View Challan : e-Challan System</title>
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
	String obj = (String)session.getAttribute("holder");
	License _ho = new LicenseDAO().getLicenseByNo(obj);
	String name="", address="", uname="";
	name = _ho.getfName() + " " + _ho.getlName();
	address = _ho.getAddress();
	Object ob = session.getAttribute("user_info");
	User u = (User)ob;
	uname = u.getUserDetail().getFirstName() + " " + u.getUserDetail().getLastName();
	Integer i = (Integer)session.getAttribute("chaallan");
	Challan ch = new ChallanDAO().getChallanById(i);
	Set<Rule> rule = ch.getRule();
	int fine=0;
	if(ch.isIssuspend()){
		fine = 2000;
	}
	else{
		
		for(Rule rr : rule){
			
			fine += rr.getFine();
		}
		
	}

%>

<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_police_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">View Challan</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li><a href="generate_challan.jsp">Generate Challan</a> </li>
	            <li class="active">View Challan</li>
	        </ul>
        </div>
        <div class="main-content">
        
        	<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Challan</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							<table>
								<tr><td> Date:</td><td style="padding-left: 95px"></td></tr>
								<tr><td> Time:</td><td style="padding-left: 95px"></td></tr>
							</table>
							<table>
								<tr><td> Vehicle Type: </td><td style="padding-left: 25px"><%out.print(""); %></td></tr>
								<tr><td> License No: </td><td style="padding-left: 25px"><%out.print(ch.getLicenseNo()); %></td></tr>
								<tr><td> Name: </td><td style="padding-left: 25px"><%out.print(name); %></td></tr>
								<tr><td> Address: </td><td style="padding-left: 25px"><%out.print(address); %></td></tr>
								<tr><td> Name of Officer: </td><td style="padding-left: 25px"><%out.print(uname); %></td></tr>
								<tr><td> Violated Rules: </td><td style="padding-left: 25px"><%for(Rule r : rule){out.print(r.getRuleId()+",");}%></td></tr>
								<tr><td> Total Fine: </td><td style="padding-left: 25px"><%out.print(fine); %></td></tr>
							</table>
							<br/><br/>
						<div align="center">		
							
							<input type="submit" name="submit" class="btn btn-primary" value="Generate Challan" name="submit"/>
							
						</div>	
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
