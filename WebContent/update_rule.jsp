<%@page import="org.echallan.valueObject.Rule"%>
<%@page import="org.echallan.valueObject.Catagory"%>
<%@page import="org.echallan.dataAccessObject.CatagoryDAO"%>
<%@page import="org.echallan.dataAccessObject.RuleDAO"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.Common"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Update Rule : e-Challan System</title>
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
	String id = request.getParameter("paramid");
	int oldid=0;
	String oldname="",olddesc="",oldcatname="";
	int oldfine=0;
	
	if(id != null) {
		Rule rule = new RuleDAO().getRuleById(Integer.parseInt(id));
		oldid = rule.getRuleId();
		oldname= rule.getRuleName();
		oldfine= rule.getFine();
		olddesc= rule.getRuleDesc();
		oldcatname= rule.getCat().getCatName();
		session.setAttribute("target_id", id);
	} else response.sendRedirect("add_rule.jsp");
%>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
    <c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Update Rule</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Update Rule</li>
	        </ul>
        </div>
        <div class="main-content">			
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Edit Rule: <% out.print(oldid); %></div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							<p class="inline-field">
								<label>Enter new Rule Category:</label>
								<select class="form-control " name="cat_name">
								<%
									CatagoryDAO dao =  new CatagoryDAO();
									List<Catagory> cat = dao.getAll();
									for(Catagory c : cat){
										if(c.getCatName().equals(oldcatname))
											out.println("<option value='" + c.getCatID()+ "'selected='selected'>" + c.getCatName() + "</option>");
										else
											out.println("<option value='" + c.getCatID()+ "'>" + c.getCatName() + "</option>");
									}	%>
								</select>
							</p>
							<p>
								<label>Enter new Rule Id:</label>
								<input type="text" class="form-control span12" name="rule_id" value="<% out.print(oldid); %>"/>
							</p>
							<p>
								<label>Enter new Rule Name:</label>
								<input type="text" class="form-control span12" name="rule_name" value="<% out.print(oldname); %>"/>
							</p>
							<p>
								<label>Enter new Rule Fine:</label>
								<input type="text" class="form-control span12" name="rule_fine" value="<% out.print(oldfine); %>"/>
							</p>
							<p>
								<label>Enter new Rule Description:</label>
								<textarea rows="5" cols="108" name="rule_desc" class="form-control span12" ><% out.print(olddesc); %></textarea>
							</p>
						<input type="submit" name="submit" class="btn btn-primary form-control" value="Update Rule" name="submit"/>
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
