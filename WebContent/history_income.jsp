<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="org.echallan.dataAccessObject.StatisticsDAO"%>
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
    <title>Income History : e-Challan System</title>
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
	<%
		StatisticsDAO sd = new StatisticsDAO();
		int from = sd.getMinYear(), to = sd.getMaxYear();
		List<Integer> availYear = sd.getDistinctYear();
		System.out.print("min " + from + " to " + to);
		if(request.getParameter("from") != null && request.getParameter("to") != null) {
			try {
				from = Integer.parseInt(request.getParameter("from"));
				to = Integer.parseInt(request.getParameter("to"));
			} catch (Exception ex) {
				from = sd.getMinYear();
				to = sd.getMaxYear();
			}
		}
		if(to < from) {
			from = sd.getMinYear();
			to = sd.getMaxYear();
		}
	%>
    <script type="text/javascript">
        $(function() {
            $(".knob").knob();
        });
        
        function handleFilterEvent() {
        	var from = document.getElementsByName("from_val")[0].value;
        	var to = document.getElementsByName("to_val")[0].value;
        	window.location.href = "history_income.jsp?from=" + from + "&to=" + to;
        }
    </script>
	<script type="text/javascript">
		$(function () {
		    $('#container').highcharts({
		        title: {
		            text: 'Total Income',
		            x: -20 //center
		        },
		        subtitle: {
		            text: 'Source: e-challan.org',
		            x: -20
		        },
		        xAxis: {
		            //categories: ['2001', '2002', '2003']
		        	<%
		        		out.print("categories: [");
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
		                text: 'Amount Earned (in rupees)'
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
		            name: 'Earnings',
		            //data: [500, 378, 652]
		            <%
		        		out.print("data: [");
		        		int i = from;
		        		while(i <= to) {
		        			out.print(sd.getIncomeByYear(i) + ",");
		        			i++;
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
	        <h1 class="page-title">Income History</h1>
	       	<ul class="breadcrumb">
	       		<li><a href="admin_dashboard.jsp">Home</a> </li>
	            <li class="active">Income History</li>
	        </ul>
        </div>
        <div class="main-content">
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Past History of Income</div>
				<div id="widget1container" class="panel-body collapse in">
					<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
					<center>from:
						<select name="from_val">
							<%
								Collections.sort(availYear);
								for(Integer w : availYear) {
									out.print("<option value=" + w + ">" + w + "</option>");
								}
							%>
						</select>
						to:
						<select name="to_val">
							<%
								Collections.reverse(availYear);
								for(Integer d : availYear) {
									out.print("<option value=" + d + ">" + d + "</option>");
								}
							%>
						</select>
						<input type="button" value="Filter" onclick="javascript: return handleFilterEvent()"></input>
					</center>
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
