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
<html lang="en"><head>
    <meta charset="utf-8">
    <title>View Report : e-Challan System</title>
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
		int from = 0, to = 0;
		if(request.getParameter("from") != null && request.getParameter("to") != null) {
			try {
				from = Integer.parseInt(request.getParameter("from"));
				to = Integer.parseInt(request.getParameter("to"));
			} catch (Exception ex) {
				from = to = 0;
			}
		}
		if(to < from)
			from = to = 0;
	%>
    <script type="text/javascript">
        $(function() {
            $(".knob").knob();
        });
        
        function handleFilterEvent() {
        	var from = document.getElementsByName("from_val")[0].value;
        	var to = document.getElementsByName("to_val")[0].value;
        	window.location.href = "history_report.jsp?from=" + from + "&to=" + to;
        }
        
        var request;  
        function sendInfo()  
        {
        	var v = document.getElementsByName("city_drop")[0];
        	if(window.XMLHttpRequest){
        		request=new XMLHttpRequest();
        	} else if(window.ActiveXObject) {
        		request=new ActiveXObject("Microsoft.XMLHTTP");
        	}
        	try {
        		request.onreadystatechange = getInfo;
        		request.open("GET", "Controller?hist_city_id=" + v.value, true);
        		request.send();
        	} catch(e) {
        		alert("Unable to connect to server");
        	}
        }

        function getInfo(){
        	if(request.readyState==4){
        		var val = request.responseText;
        		document.getElementById("area_inner").innerHTML = val;
        	}
        }
        
        function modalFilter(type) {
        	var cityId = document.getElementsByName("city_drop")[0].value;
        	var areaId = document.getElementsByName("area_drop")[0].value;
        	if(type == "city")
        		window.location.href = "stat_generic_line.jsp?type=" + type + "&id=" + cityId;
        	else
        		window.location.href = "stat_generic_line.jsp?type=" + type + "&id=" + areaId;
        }
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
			    <div class="panel-heading no-collapse">Past History of violations</div>
				<div id="widget1container" class="panel-body collapse in">
					<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
					<center>from:
						<select name="from_val">
							<option value="2001">2001</option>
						</select>
						to:
						<select name="to_val">
							<option value="2010">2010</option>
						</select>
						<input type="button" value="Filter" onclick="javascript: return handleFilterEvent()"></input>
						<br /><label>Click here to show history for : </label> <a href="#cityModal" role='button' data-toggle='modal'> City</a>|| <a href="#myModal" role='button' data-toggle='modal'> Area</a>
					</center>
				</div>
			</div>
			
			<div class="modal small fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			        <div class="modal-header">
			            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			            <h3 id="myModalLabel">Filter by Area</h3>
			        </div>
			        <div class="modal-body">
				    	<label>Select City:</label><br/>
					   	<select class="form-control" name="city_drop" onchange="return sendInfo();">
					    	<%
					    		List<City> city = new CityDAO().getAll();
					    		for(City c : city)
					    			out.print("<option value=" + c.getCityID() + ">" + c.getName() + "</option>");
					        %>
					    </select>
				        <label>Select Area:</label><br/>
				        <span id="area_inner">
				        	<select name="area_drop" class="form-control">
				        		<%
				        			Set<Area> a = city.get(0).getArea();
				        			for(Area z : a)
				        				out.print("<option value=" + z.getArea_id() + ">" + z.getName() + "</option>");
				        		%>
				        	</select>
				 		</span>
			        </div>
			        <div class="modal-footer">
			            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</button>
			            <button class="btn btn-danger" data-dismiss="modal" onclick="return modalFilter('area')">Show</button>
			        </div>
			      </div>
			    </div>
			</div>
			
			<div class="modal small fade" id="cityModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			        <div class="modal-header">
			            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			            <h3 id="myModalLabel">Filter by City</h3>
			        </div>
			        <div class="modal-body">
				    	<label>Select City:</label><br/>
					   	<select class="form-control" name="city_drop">
					    	<%
					    		for(City c : city)
					    			out.print("<option value=" + c.getCityID() + ">" + c.getName() + "</option>");
					        %>
					    </select>
			        </div>
			        <div class="modal-footer">
			            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</button>
			            <button class="btn btn-danger" data-dismiss="modal" onclick="return modalFilter('city')">Show</button>
			        </div>
			      </div>
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
