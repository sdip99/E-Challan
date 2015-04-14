<%@page import="org.echallan.dataAccessObject.AreaDAO"%>
<%@page import="java.util.Set"%>
<%@page import="org.echallan.valueObject.Area"%>
<%@page import="org.echallan.valueObject.City"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.dataAccessObject.CityDAO"%>
<%@page import="java.util.Random"%>
<%@page import="org.echallan.valueObject.Preference"%>
<%@page import="org.echallan.dataAccessObject.PreferenceManager"%>
<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String type = request.getParameter("type");
	String id = request.getParameter("id");
	if(type == null || id == null)
		response.sendRedirect("history_report.jsp");
%>
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Statistics : e-Challan System</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">

    <script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="lib/highcharts.js"></script>
	<script src="lib/modules/exporting.js"></script>
	<script src="lib/jQuery-Knob/js/jquery.knob.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $(".knob").knob();
        });
    </script>
	<script type="text/javascript">
		$(function () {
		    $('#container').highcharts({
		        title: {
		            text: 'Challan Generated',
		            x: -20 //center
		        },
		        subtitle: {
		            text: 'Source: e-challan.com',
		            x: -20
		        },
		        xAxis: {
		            //categories: ['2001', '2002', '2003']
		        	<%
		        		out.print("categories: [");
		        		int from = 2001;
		        		int to = 2009;
		        		int tmp = from;
		        		while(tmp < to) {
		        			out.print("'" + tmp + "',");
		        			tmp++;
		        		}
		        		out.print("'" + tmp + "']");
		        	%>
		        },
		        yAxis: {
		            title: {
		                text: 'Number of challans'
		            },
		            plotLines: [{
		                value: 0,
		                width: 1,
		                color: '#808080'
		            }]
		        },
		        legend: {
		            layout: 'vertical',
		            align: 'right',
		            verticalAlign: 'middle',
		            borderWidth: 0
		        },
		        series: [{
		            name: 'Challan Generated',
		            //data: [500, 378, 652]
		            <%
		        		out.print("data: [");
		        		int i = from;
		        		Random rand = new Random();
		        		while(i <= to) {
		        			out.print(rand.nextInt(10000) + ",");
		        			i++;
		        		}
		        		out.print("]");
	        		%>
		        }, {
		        	name: 'Vehicles Suspended',
		            //data: [500, 378, 652]
		            <%
		        		out.print("data: [");
		        		int x = from;
		        		while(x <= to) {
		        			out.print(rand.nextInt(5000) + ",");
		        			x++;
		        		}
		        		out.print("]");
	        		%>
		        }]
		    });
		});
		</script>

    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
	<c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">View History</h1>
	       	<ul class="breadcrumb">
	       		<li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">View History</li>
	        </ul>
        </div>
        <div class="main-content">
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">History of violations for <%out.print(type); %>: <%if(type.equals("city")) out.print(new CityDAO().getCityById(id).getName()); else  out.print(new AreaDAO().getAreaById(id).getName());%></div>
			    <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
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
