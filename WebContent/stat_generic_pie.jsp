<%@page import="org.echallan.dataAccessObject.StatisticsDAO"%>
<%@page import="org.echallan.valueObject.SubArea"%>
<%@page import="java.util.Set"%>
<%@page import="org.echallan.dataAccessObject.AreaDAO"%>
<%@page import="org.echallan.valueObject.Area"%>
<%@page import="org.echallan.dataAccessObject.CityDAO"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.valueObject.Preference"%>
<%@page import="org.echallan.dataAccessObject.PreferenceManager"%>
<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@page import="org.echallan.valueObject.City"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String type = request.getParameter("type");
	String id = request.getParameter("id");
	City city = null;
	Area area = null;
	Set holder = null;
	StatisticsDAO sd = new StatisticsDAO();
	if(type == null || id == null)
		response.sendRedirect("stat_city.jsp");
	
	if(type.equals("city")) {
		city = new CityDAO().getCityById(id);
		holder = city.getArea();
	} else if(type.equals("area")) {
		area = new AreaDAO().getAreaById(id);
		holder = area.getSubarea();
	}
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
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: 'Rules broken in <%if(city != null) out.print(city.getName()); else out.print(area.getName());%>'
		        },
		        tooltip: {
		            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: 'Rules Broken',
		            data: [
		                //['Firefox',   45.0],
		                <%
			                if(city != null) {
			                	for(Object c : holder)
			                		out.print("['" + ((Area) c).getName() + "'," + sd.getChallanCountByArea(((Area) c).getArea_id()) + "],");
			                } else {
			                	for(Object c : holder)
			                		out.print("['" + ((SubArea) c).getName() + "'," + sd.getChallanCountBySubArea(((SubArea) c).getSubarea_id()) + "],");
			                }
		                %>
		            ]
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
	        <h1 class="page-title">Statistics</h1>
	       	<ul class="breadcrumb">
	       		<li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Statistics</li>
	        </ul>
        </div>
        <div class="main-content">
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Number of Rules Broken by City</div>
				<div id="widget1container" class="panel-body collapse in">
					<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
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
