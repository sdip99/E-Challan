<%@page import="org.echallan.valueObject.User"%>
<%@page import="org.echallan.dataAccessObject.LicenseDAO"%>
<%@page import="org.echallan.valueObject.License"%>
<%@page import="org.echallan.dataAccessObject.ChallanDAO"%>
<%@page import="org.echallan.valueObject.Challan"%>
<%@page import="org.echallan.valueObject.Rule"%>
<%@page import="org.echallan.dataAccessObject.RuleDAO"%>
<%@page import="org.echallan.dataAccessObject.CatagoryDAO"%>
<%@page import="org.echallan.valueObject.Catagory"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.Common"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Manage Challan : e-Challan System</title>
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
    <c:import url="stub_police_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Manage Challan</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Manage Challan</li>
	        </ul>
        </div>
        <div class="main-content">
        			
			<table class="table">
			  <thead>
			    <tr>
			      <th>#Challan ID</th>
			      <th>#License No</th>
			      <th>#vehicle No</th>
			      <th>#Name</th>
			      <th>#Rule ID</th>
			      <th>#Fine</th>
			      <th>#Police Name</th>
			      <th>#Is Suspend</th>
			      <th>#TimeStamp</th>
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
			  	User u =(User)session.getAttribute("user_info");
			  	List<Challan> ch = new ChallanDAO().getAllByPid(u.getUserID_pkey());
			  	for(Challan c : ch) {
			  		String licenseNo = c.getLicenseNo();
			  		License l = null;
			  		if(licenseNo != null)
			  			l = new LicenseDAO().getLicenseByNo(licenseNo);
			  		Set<Rule> ru = c.getRule();
			  		int fine=0;
			  		for(Rule rr : ru){	
			  			fine += rr.getFine();
			  		}
			  		String lno = l == null ? "-" : l.getLincenNo();
			  		out.println("<tr><td><a href='view_challan.jsp?cid=" + c.getChallan_id() + "'>" + c.getChallan_id() + "</a></td><td>" + lno + "</td>");
			  		out.println("<td>" + c.getVehicleNo() + "</td>");
			  		if(l != null)
			  			out.println("<td>" + l.getfName() +" "+ l.getlName() + "</td>");
			  		else
			  			out.println("<td>" + c.getFname() +" "+ c.getLname() + "</td>");
			  		out.println("<td>");
			  		StringBuffer sb = new StringBuffer();
			  		for(Rule r : ru)
			  			sb.append(r.getRuleId() + ", ");
			  		int length = sb.length();
			  		sb.delete(length - 2, length - 1);
			  		out.print(sb.toString());
			  		out.println("</td>");
			  		out.println("<td>" + fine +"</td>");
			  		out.println("<td>" + c.getPolice().getUserDetail().getFirstName() +"</td>");
			  		String va="";
			  		if(c.isIssuspend()){
			  			va = "YES";
			  		} else {
			  			va = "NO";
			  		}
			  		out.println("<td>" + va +"</td>");
			  		out.println("<td>" + c.getTimestamp() +"</td></tr>");
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
			            <p class="error-text"><i class="fa fa-warning modal-icon"></i> Are you sure you want to delete the Rule?</p>
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
                <p>CopyrightŠ 2014 Harsh Panchal, Deep Shah</p>
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
