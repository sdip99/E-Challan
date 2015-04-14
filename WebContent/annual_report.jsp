<%@page import="java.util.Random"%>
<%@page import="org.echallan.valueObject.Preference"%>
<%@page import="org.echallan.dataAccessObject.PreferenceManager"%>
<%@page import="org.echallan.Common"%>
<%@page import="org.echallan.valueObject.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Annual Report : e-Challan System</title>
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
		            type: 'column'
		        },
		        title: {
		            text: 'Annual Report for year: 2009'
		        },
		        subtitle: {
		            text: 'Source: e-challan.org'
		        },
		        xAxis: {
		            type: 'category',
		            labels: {
		                rotation: -45,
		                style: {
		                    fontSize: '13px',
		                    fontFamily: 'Verdana, sans-serif'
		                }
		            }
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: 'Amount'
		            }
		        },
		        legend: {
		            enabled: false
		        },
		        series: [{
		            name: 'Count',
		            data: [
		                ['Challans', 500],
		                ['Complaint', 200],
		                ['Suspended Vehicles', 32]
		            ],
		            dataLabels: {
		                enabled: true,
		                rotation: -90,
		                color: '#FFFFFF',
		                align: 'right',
		                format: '{point.y:}', // one decimal
		                y: 10, // 10 pixels down from the top
		                style: {
		                    fontSize: '13px',
		                    fontFamily: 'Verdana, sans-serif'
		                }
		            }
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
	        <h1 class="page-title">Annual Report</h1>
	       	<ul class="breadcrumb">
	       		<li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Annual Report</li>
	        </ul>
        </div>
        <div class="main-content">
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Annual Report</div>
				<div id="widget1container" class="panel-body collapse in">
					<center><b>Select year:</b>
						<select name="from_val">
							<option value="2001">2001</option>
							<option value="2001">2001</option>
							<option value="2001">2001</option>
						</select>
						<input type="button" value="Show" onclick="javascript: return handleFilterEvent()"></input>
					</center>
					<table width="100%">
						<tr>
							<td style="vertical-align: top;">
								<b>Annual Report for year : 2009</b><br/>
								<br />Total Challans Generated: 500
								<br />Total vehicles suspended: 200
								<br />Total Complaints Received: 32
								<br />Total Income: 250000
								<br />
							</td>
							<td><div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div></td>
						</tr>
					</table>
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
