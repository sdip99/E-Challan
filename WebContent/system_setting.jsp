<%@page import="org.echallan.valueObject.Preference"%>
<%@page import="org.echallan.dataAccessObject.PreferenceManager"%>
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
    <title>System Settings : e-Challan System</title>
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
	String chDef;
	String cmpDef;
	PreferenceManager preferenceManager = new PreferenceManager();
	Preference chPref = preferenceManager.getPreference(Common.PREF_MAX_CHALLAN_PER_DAY);
	Preference cmPref = preferenceManager.getPreference(Common.PREF_MAX_COMPLAINT_PER_DAY);
	chDef = chPref == null ? Common.MAX_CHALLAN_PER_DAY : chPref.getValue();
	cmpDef = cmPref == null ? Common.MAX_COMPLAINT_PER_DAY : cmPref.getValue();
%>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">System Settings</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">System Settings</li>
	        </ul>
        </div>
        <div class="main-content">
        	<%
				if(session.getAttribute("pref_update_success") != null) {
			%>
			<div class="panel panel-default">
		        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
	        	<div id="page-stats" class="panel-collapse panel-body collapse in">
	        		<center>Settings Updated Successfully...!</center>
	        	</div>
		    </div>
		    <%
					session.removeAttribute("pref_update_success");
				}
			%>
        	<div class="panel panel-default">
			    <div class="panel-heading no-collapse">System Settings</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							<table style="border-collapse: separate; border-spacing: 0 1em">
								<tr><td>Dashboard Maximum Challans per day: </td><td style="padding-left: 25px"><input type="text" name="max_chalan_day" value="<%out.print(chDef); %>" class="fa form-control" /></td></tr>
								<tr><td>Dashboard Maximum Complaints per day: </td><td style="padding-left: 25px"><input type="text" name="max_comp_day" value="<%out.print(cmpDef); %>" class="fa form-control" /></td></tr>
							</table>
							<input type="submit" name="submit" class="btn btn-primary form-control" value="Update Settings" name="submit"/>
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
