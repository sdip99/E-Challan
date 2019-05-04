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
    <title>Manage Rule : e-Challan System</title>
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
			window.location.href = "manage_rule.jsp?delete=true&paramid=" + paramid;
		}
        
        function handleFilterEvent() {
        	var id = document.getElementsByName("cat_drop")[0].value;
        	window.location.href = "manage_rule.jsp?filterBy=" + id;
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
	        <h1 class="page-title">Manage Rule</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Manage Rule</li>
	        </ul>
        </div>
        <div class="main-content">
        	<%
				if(session.getAttribute("rule_update_success") != null) {
					if((Boolean) session.getAttribute("rule_update_success")) { 
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
					session.removeAttribute("rule_update_success");
				}
			%>
			<%
				String str = request.getParameter("delete");
				if(str != null && str.equals("true")) {
					String param = request.getParameter("paramid");
					if(param != null) {
						int id = Integer.parseInt(param);
						if(new RuleDAO().removeRule(id)) {
			%>
					<div class="panel panel-default">
						        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
					        	<div id="page-stats" class="panel-collapse panel-body collapse in">
					        		<center>Rule deleted successfully...!</center>
					        	</div>
					</div>
			<%
						}
					}
				}
			%>        
			<div class="btn-toolbar list-toolbar">
			    <a href="add_rule.jsp" class="btn btn-primary"><i class="fa fa-plus"></i> New Rule</a><br></br>
			    <p>
			    	Filter By:
			    	<select class="form-control inline-ele-left" name="cat_drop"  style="width: 25%;">
			    		<%
							List<Catagory> _cat = new CatagoryDAO().getAll();
							for(Catagory c : _cat)
								out.println("<option value='" + c.getCatID() + "'>" + c.getCatName() + "</option>");
						%>
			    	</select>
			    	<a href="#" class="btn btn-primary btn-toolbar list-toolbar inline-ele-left" style="margin-bottom: 5px;" onclick="javascript: return handleFilterEvent()"> Filter</a>
			    	<a href="manage_rule.jsp" class="btn btn-danger btn-toolbar list-toolbar inline-ele" style="margin-bottom: 5px;"> X</a>
			    </p>
			</div>
			<table class="table">
			  <thead>
			    <tr>
			      <th>Rule Id</th>
			      <th>Rule Name</th>
			      <th>Fine</th>
			      <th>Category</th>
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
			  	int i = 1;
			  	String _tmp = request.getParameter("filterBy");
			  	Object[] rule;
			  	if(_tmp != null && _tmp != "") {
			  		Catagory c = new CatagoryDAO().getCatagoryById(_tmp);
			  		rule = c.getRule().toArray();
			  	} else {
			  		// If none filter is specified show all areas
					rule = new RuleDAO().getAll().toArray();
			  	}
			  	for(Object obj : rule) {
			  		
			  		Rule r = (Rule)obj;
			  		out.println("<tr><td>" + r.getRuleId() + "</td><td>" + r.getRuleName() + "</td>");
			  		out.println("<td>" + r.getFine() + "</td>");
			  		out.println("<td>" + r.getCat().getCatName() + "</td>");
			  		out.println("<td><a href='update_rule.jsp?paramid=" + r.getRuleId() + "'><i class='fa fa-pencil'></i></a>");
			  		out.println("<a href='#myModal' role='button' data-toggle='modal' onclick='setParamID(" + r.getRuleId() + ")'><i class='fa fa-trash-o'></i></a></td></tr>");
			  		i++;
			  	}
			  %>
			  </tbody>
			</table>
			
			
			
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
