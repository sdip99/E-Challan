
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
	Integer x = Integer.parseInt(request.getParameter("cid"));
	Challan ch = new ChallanDAO().getChallanById(x);
	String licenseNo = ch.getLicenseNo();
	License holer = null;
	if(licenseNo != null)
		holer = new LicenseDAO().getLicenseByNo(ch.getLicenseNo());
	UserDetail genDetail = ch.getPolice().getUserDetail();
	Set<Rule> rulez = ch.getRule();
	int fine = 0;
	User user = null;
	Object obj = session.getAttribute("user_info");
	if(obj != null)
		user = (User) obj;
%>

<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>
	<%    
		if(user != null && user.getUserType() == Common.USER_TYPE_ADMIN) {
	%>
    <c:import url="stub_admin_sidebar.jsp"></c:import>
    <%	} else { %>
    <c:import url="stub_police_sidebar.jsp"></c:import>
    <%	} %>

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
							<table style="width: 80%" cellspacing="20px;">
							<tr><td>
							<table>
								<input type="hidden" name="cid" value=<%out.print(x); %> />
								<tr><td>Date	:</td><td style="padding-left: 105px"><%out.print(new SimpleDateFormat("MM-dd-yyyy").format(new Date())); %></td></tr>
								<tr><td>Time	:</td><td style="padding-left: 105px"><%out.print(new SimpleDateFormat("HH:mm a").format(new Date())); %></td></tr>
							</table>
							<br/><br/>
							<table>
								<tr><td>License No	:</td><td style="padding-left: 25px"><%out.print(ch.getLicenseNo() == null ? "none" : ch.getLicenseNo()); %></td></tr>
								<% if(holer != null) { %>
								<tr><td>Name	:</td><td style="padding-left: 25px"><%out.print(holer.getfName()+" "+holer.getlName()); %></td></tr>
								<% } else { %>
								<tr><td>Name	:</td><td style="padding-left: 25px"><%out.print(ch.getFname()+" "+ch.getLname()); %></td></tr>
								<% } %>
								<tr><td>Name of Officer	:</td><td style="padding-left: 25px"><%out.print(ch.getPolice().getUserDetail().getFirstName()+" "+ch.getPolice().getUserDetail().getLastName()); %></td></tr>
								<%
									
								%>
								<tr><td>Act of violation	:</td><td style="padding-left: 25px"></td></tr>
								<%
											for(Rule r : rulez) {
												out.print("<tr><td></td><td style='padding-left: 25px'>" + r.getRuleId() + "  -  " + r.getRuleName() + "</td></tr>");
												fine += r.getFine();
											}
										%>
										<tr><td> Total Fine	: </td><td style="padding-left: 25px"><%out.print("Rs. " +  fine); %></td></tr>
							<%
							if(ch.isIssuspend()){
							%>
							<tr><td>Suspended Vehicle	:</td><td style="padding-left: 25px"><%out.print(ch.isIssuspend() ? "YES" : "NO"); %></td>></tr>
							<%} %>
							</table>
							</td>
							<td>
							<table>
								<tr><td>Challan Id	:</td><td style="padding-left: 25px"><%out.print(ch.getChallan_id()); %></td></tr>
								<tr><td>Vehicle No	:</td><td style="padding-left: 25px"><%out.print(ch.getVehicleNo()); %></td></tr>
							
							</table>
							
							
							
							
							</td>
							
							</table><br/><br/>
						<div align="center">		
							
							<input type="submit" name="submit" class="btn btn-primary" value="Print Challan" name="submit"/>
							
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
