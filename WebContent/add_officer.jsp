<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Add Officer : e-Challan System</title>
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
    

    <div class="sidebar-nav">
    	<ul>
    	<li><a href="#" data-target=".dashboard-menu" class="nav-header" data-toggle="collapse"><i class="fa fa-fw fa-arrow-circle-right"></i> Manage Staff<i class="fa fa-collapse"></i></a></li>
	    <li>
	    	<ul class="dashboard-menu nav nav-list collapse in">
	            <li><a href="add_officer.jsp"><span class="fa fa-caret-right"></span> Add Officer</a></li>
	            <li ><a href="#"><span class="fa fa-caret-right"></span> List Officers</a></li>
	        </ul>
	    </li>

    	<li><a href="#" data-target=".legal-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-fw fa-arrow-circle-right"></i> Manage Complaints<i class="fa fa-collapse"></i></a></li>
        <li>
        	<ul class="legal-menu nav nav-list collapse">
	            <li ><a href="privacy-policy.html"><span class="fa fa-caret-right"></span> View Complaints</a></li>
            </ul>
        </li>
    </div>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Add Officer</h1>
	       	<ul class="breadcrumb">
	            <li><a href="#">Home</a> </li>
	            <li class="active">Add Officer</li>
	        </ul>
        </div>
        <div class="main-content">
        
	        <%
				if(session.getAttribute("success") != null) {
			%>
			<div class="panel panel-default">
		        <a href="#page-stats" class="panel-heading" data-toggle="collapse"><i class="fa fa-info-cicle"></i> Information</a>
	        	<div id="page-stats" class="panel-collapse panel-body collapse in">
	        		<center>User Added Successfully...!</center>
	        	</div>
		    </div>
		    <%
				}
				session.removeAttribute("success");
			%>
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Add Officer</div>
				<div id="widget1container" class="panel-body collapse in">
			        <form action="Controller" method="post">
						<div class="form-group">
							<p>
								<label>First Name: </label>
								<input type="text" class="form-control span12" name="first_name"/>
							</p>
							<p>
								<label>Last Name: </label>
								<input type="text" class="form-control span12" name="last_name"/>
							</p>
							<p>
								<label>Mobile Number: </label>
								<input type="text" class="form-control span12" name="mobile_no"/>
							</p>
							<p>
								<label>Street: </label>
								<input type="text" class="form-control span12" name="street"/>
							</p>
							<p>
								<label>City: </label>
								<input type="text" class="form-control span12" name="city"/>
							</p>
							<p>
								<label>State: </label>
								<input type="text" class="form-control span12" name="state"/>
							</p>
							<p>
								<label>Pincode: </label>
								<input type="text" class="form-control span12" name="pincode"/>
							</p>
							<p>
								<label>E-mail ID: </label>
								<input type="text" class="form-control span12" name="email"/>
							</p>
							<p>
								<label>Password: </label>
								<input type="password" class="form-control span12" name="password"/>
							</p>
							<p>
								<label>Confirm Password: </label>
								<input type="password" class="form-control span12" name="password2"/>
							</p>
							<p class="inline-field">
								<label>City Assigned:</label>
								<select class="form-control" name="city_drop">
									<option value="1">Ahmedabad</option>
								</select>
							</p>
							<p class="inline-field" >
								<label>Area Assigned:</label>
								<select class="form-control" name="area_drop">
									<option value="1">Maninagar</option>
									<option value="2">Kankaria</option>
								</select>
							</p>
								<label>SubArea Assigned:</label>
								<select class="form-control " name="subarea_drop">
									<option value="1">Maninagar Cross Road</option>
									<option value="2">Railway Station</option>
								</select>
							</p>
							<input type="submit" name="submit" class="btn btn-primary form-control" value="Insert Officer" name="submit"/>
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
