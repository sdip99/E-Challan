<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
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
<link rel="stylesheet" type="text/css" href="stylesheets/theme1.css">
 <link rel="stylesheet" type="text/css" href="stylesheets/premium1.css">
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
<%
	Object obj = session.getAttribute("user_info");
	String homeURL = "index.jsp";
	String userName = null;
	User user = null;
	if(obj != null) {
		user = (User) obj;
		if(user.getUserType() == Common.USER_TYPE_ADMIN) {
			homeURL = "admin_dashboard.jsp";
			userName = "Administrator";
		} else {
			homeURL = "police_dashboard.jsp";
			userName = user.getUserDetail().getFirstName() + " " + user.getUserDetail().getLastName();
		}
	}
%>
    <div class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href=<%out.print("'" + homeURL + "'"); %>><span class="navbar-brand"><img class="user1" src="images/faces/i3.jpg" style="max-width:35px;max-height:35px;"></img>  e-Challan System</span></a>
        </div>
        <%
        	if(obj != null) {
       	%>
          <ul id="main-menu" class="nav navbar-nav navbar-right">
            <li class="dropdown hidden-xs">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span class="" style="position:relative;top: 3px;"></span>
                    <%
                    	if(user.getUserType() != Common.USER_TYPE_ADMIN) {
                    %>
                    <img class="user1" src="images/people/<%out.print(user.getUserID() + ".jpg"); %>" style="max-width:25px;max-height:20px;border-radius:48px"></img>
                    <%
                    	}
                    %>
                    <% out.print(userName); %>
                    <i class="fa fa-caret-down"></i>
                </a>

              <ul class="dropdown-menu">
              	<%
              		if(user.getUserType() == Common.USER_TYPE_NORMAL) {
              	%>
                <li><a href="profile.jsp"><span class="text-info fa fa-user fa-fw"></span>My Account</a></li>
                <%
              		}
                %>
                <li><a tabindex="-1" href="index.jsp?logout=1"><span class="text-info fa fa-sign-out fa-fw"></span>Logout</a></li>
              </ul>
            </li>
          </ul>
        <%
        	}
        %>
      </div>
    </div>