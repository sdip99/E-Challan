<%@page import="org.echallan.dataAccessObject.RuleDAO"%>
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
    <title>Update City : e-Challan System</title>
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
	String oldname="",olddesc="";
	int oldfine=0;
	// If city id is not provided then send to insert city page
	if(id != null) {
		oldid = new RuleDAO().getRuleById(Integer.parseInt(id)).getRuleid();
		oldname = new RuleDAO().getRuleById(Integer.parseInt(id)).getRulename();
		oldfine = new RuleDAO().getRuleById(Integer.parseInt(id)).getFine();
		olddesc = new RuleDAO().getRuleById(Integer.parseInt(id)).getRuledesc();
		// Save city id to session scope for updating record in database
		session.setAttribute("city_id", id);
	} else response.sendRedirect("addRule.jsp");
%>
<body class=" theme-blue">

    <!-- Demo page code -->

    <script type="text/javascript">
        $(function() {
            var match = document.cookie.match(new RegExp('color=([^;]+)'));
            if(match) var color = match[1];
            if(color) {
                $('body').removeClass(function (index, css) {
                    return (css.match (/\btheme-\S+/g) || []).join(' ')
                })
                $('body').addClass('theme-' + color);
            }

            $('[data-popover="true"]').popover({html: true});
            
        });
    </script>
    <style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .navbar-default .navbar-brand, .navbar-default .navbar-brand:hover { 
            color: #fff;
        }
    </style>

    <script type="text/javascript">
        $(function() {
            var uls = $('.sidebar-nav > ul > *').clone();
            uls.addClass('visible-xs');
            $('#main-menu').append(uls.clone());
        });
    </script>

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
  

  <!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
  <!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
  <!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
  <!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
  <!--[if (gt IE 9)|!(IE)]><!--> 
   
  <!--<![endif]-->

    <div class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="index.jsp"><span class="navbar-brand"><span class="fa fa-paper-plane"></span> e-Challan System</span></a></div>

        <div class="navbar-collapse collapse" style="height: 1px;">
          <ul id="main-menu" class="nav navbar-nav navbar-right">
            <li class="dropdown hidden-xs">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-user padding-right-small" style="position:relative;top: 3px;"></span>
                    <%
	                    Object obj = session.getAttribute("user_info");
	                	if(obj != null) {
							User user = (User) obj;
							out.print(user.getUserID());
							if(user.getUserType() == Common.USER_TYPE_ADMIN)
								out.print(" (Administrator)");
						}
					%>
                    <i class="fa fa-caret-down"></i>
                </a>

              <ul class="dropdown-menu">
                <li><a href="./">My Account</a></li>
                <li><a tabindex="-1" href="index.jsp?logout=1">Logout</a></li>
              </ul>
            </li>
          </ul>

        </div>
      </div>
    </div>
    
    <c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Update City</h1>
	       	<ul class="breadcrumb">
	            <li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Update City</li>
	        </ul>
        </div>
        <div class="main-content">			
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Edit City: <% out.print(oldname); %></div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							<p>
								<label>Enter new Rule Name:</label>
								<input type="text" class="form-control span12" name="rule_name" value="<% out.print(oldname); %>"/>
							</p>
							<p>
								<label>Enter new Rule Id:</label>
								<input type="text" class="form-control span12" name="rule_id" value="<% out.print(oldid); %>"/>
							</p>
							<p>
								<label>Enter new Rule Fine:</label>
								<input type="text" class="form-control span12" name="rule_fine" value="<% out.print(oldfine); %>"/>
							</p>
							<p>
								<label>Enter new Rule Description:</label>
								<input type="text" class="form-control span12" name="rul_desc" value="<% out.print(olddesc); %>"/>
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
