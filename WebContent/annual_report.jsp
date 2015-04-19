<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.dataAccessObject.StatisticsDAO"%>
<%@page import="java.util.Calendar"%>
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
        
        function handleFilterEvent() {
        	var id = document.getElementById("year").value;
			window.location.href = "annual_report.jsp?year=" + id;
		}
    </script>
    <%
    	int curYear = Calendar.getInstance().get(Calendar.YEAR);
    	StatisticsDAO sd = new StatisticsDAO();
    	List<Integer> availYear = sd.getDistinctYear();
    	Collections.sort(availYear);
    	int showingYear = curYear;
    	String paramYear = request.getParameter("year");
    	if(paramYear != null)
    		showingYear = Integer.parseInt(paramYear);
    	int challanGen = sd.getChallanCountForYear(showingYear);
    	int compCount = sd.getComplaintCountForYear(showingYear);
    	int vehicSusCount = sd.getVehicleSusCountForYear(showingYear);
    	int income = sd.getIncomeByYear(showingYear);
    %>
    <script type="text/javascript">
		$(function () {
		    $('#container').highcharts({
		        chart: {
		            type: 'column'
		        },
		        title: {
		            text: 'Annual Report for year: <%out.print(showingYear);%>'
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
		                ['Challans', <%out.print(challanGen);%>],
		                ['Complaint', <%out.print(compCount);%>],
		                ['Suspended Vehicles', <%out.print(vehicSusCount);%>]
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
						<select name="from_val" id="year">
							<%
								for(Integer x : availYear)
									out.print("<option value=" + x + ">" + x + "</option>");
							%>
						</select>
						<input type="button" value="Show" onclick="javascript: return handleFilterEvent()"></input>
					</center>
					<table width="100%">
						<tr>
							<td style="vertical-align: top;">
								<b>Annual Report for year : <%out.print(showingYear); %></b><br/>
								<br />Total Challans Generated: <%out.print(challanGen); %>
								<br />Total Complaints Received: <%out.print(compCount); %>
								<br />Total vehicles suspended: <%out.print(vehicSusCount); %>
								<br />Total Income: Rs. <%out.print(income); %>
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
