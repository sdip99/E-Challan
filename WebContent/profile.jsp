<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.dataAccessObject.SubAreaDAO"%>
<%@page import="org.echallan.valueObject.SubArea"%>
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


    <link rel="stylesheet" type="text/css" href="stylesheets/theme1.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium1.css">

</head>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
	<%
	User u =(User)session.getAttribute("user_info");
	if(u.getUserType() == Common.USER_TYPE_NORMAL){
	%>
    <c:import url="stub_police_sidebar.jsp"></c:import>
	<%
		}else{
	%>
    <c:import url="stub_admin_sidebar.jsp"></c:import>
    <%
	}    
    %>
    <div class="content">
        <div class="header">
	        <h1 class="page-title">Profile</h1>
	       	<ul class="breadcrumb">
	            <li><a href="police_dashboard.jsp">Home</a> </li>
				<li class="active">My Profile</li>
	        </ul>
        </div>
        <div class="main-content">
        
        	<div class="panel1 panel-default">
        		<div class="panel-body gallery">
        			<img class="user" src="images/people/<%out.print(u.getUserID() + ".jpg"); %>"></img><br />
        			
        		</div>
        		<center>
        		<strong>
        			<%
        				User obj = (User)session.getAttribute("user_info");
        				
        				out.println(obj.getUserDetail().getFirstName()+ " " +obj.getUserDetail().getLastName());
						int sub_id = obj.getUserDetail().getCurrentPosting();
						System.out.print(sub_id);
						SubArea sub = new SubAreaDAO().getSubArea(sub_id);
						System.out.print(sub);
        			
        			%>
        			</strong>
        		</center>
           	</div>
           	<div class="row">
           		<div class="col-md-8 col-md-offset-2">
           			
           				<center>
           				<table width="500" align="center">
           					<tr><td><span class="glyphicon glyphicon-user padding-right-small"></span>First Name:</td><td><%out.println(obj.getUserDetail().getFirstName()); %></td></tr>           
           					<tr><td><span class="text-info fa fa-user fa-fw"></span>Last Name:</td><td><%out.println(obj.getUserDetail().getLastName()); %></td></tr>
           					<tr><td><span class="text-info fa fa-home fa-fw"></span>Address:</td><td><%out.println(obj.getUserDetail().getStreet()); %></td></tr>
           					<tr><td></td><td><%out.println(obj.getUserDetail().getCity()+" - "+obj.getUserDetail().getPincode());%></td></tr>
           					<tr><td></td><td><%out.println(obj.getUserDetail().getState()); %></td></tr>
           					<tr><td><span class="text-info fa fa-envelope fa-fw"></span>User ID:</td><td><%out.println(obj.getUserID()); %></td></tr>
           					<tr><td><span class="text-info fa fa-phone fa-fw"></span>Mobile No:</td><td><%out.println(obj.getUserDetail().getMobileNo()); %></td></tr>
           					<tr><td><span class="text-info fa fa-map-marker fa-fw"></span>Current Posting:</td><td><%out.println(sub.getArea().getCity().getName()+">"+sub.getArea().getName()+">"+sub.getName()); %></td></tr>
							<tr><td> </td><td> </td></tr>
							<tr><td><a href="change_pass.jsp"><span class="text-info fa fa-key fa-fw"></span>Change Password</a></td><td></td></tr>           				
           				</table>
           				
           			</center><br></br>
           			<div align="center">		
					<a href="edit_user_profile.jsp"><span class="btn btn-primary">Edit Profile</span></a>							 
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
