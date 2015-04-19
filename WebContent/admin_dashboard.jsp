<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.echallan.dataAccessObject.GenericDAO"%>
<%@page import="org.hibernate.Session"%>
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
    <title>e-Challan System</title>
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
	String maxChallanVal = Common.MAX_CHALLAN_PER_DAY;
	String maxCompVal = Common.MAX_COMPLAINT_PER_DAY;
	int challanGenToday = 0;
	int compGenToday = 0;
	PreferenceManager prefManager = new PreferenceManager();
	Preference mxChallan = prefManager.getPreference(Common.PREF_MAX_CHALLAN_PER_DAY);
	Preference mxComp = prefManager.getPreference(Common.PREF_MAX_COMPLAINT_PER_DAY);
	
	// If preference doesn't exist, add it
	if(mxChallan == null) {
		Preference newMxChallan = new Preference();
		newMxChallan.setName(Common.PREF_MAX_CHALLAN_PER_DAY);
		newMxChallan.setValue(maxChallanVal);
		prefManager.insert(newMxChallan);
	} else maxChallanVal = mxChallan.getValue();
	if(mxComp == null) {
		Preference newMxComp = new Preference();
		newMxComp.setName(Common.PREF_MAX_COMPLAINT_PER_DAY);
		newMxComp.setValue(maxCompVal);
		prefManager.insert(newMxComp);
	} else maxCompVal = mxComp.getValue();
	
	Session hsession = new GenericDAO().getSession();
	Calendar calendar = Calendar.getInstance();
	if(hsession != null) {
		Query challan = hsession.createQuery("from Challan where YEAR(timestamp)=" + calendar.get(Calendar.YEAR) + " AND MONTH(timestamp)=" + (calendar.get(Calendar.MONTH) + 1) + " AND DAY(timestamp)=" + calendar.get(Calendar.DATE));
		Query query = hsession.createQuery("from Complaint where YEAR(date)=" + calendar.get(Calendar.YEAR) + " AND MONTH(date)=" + (calendar.get(Calendar.MONTH) + 1) + " AND DAY(date)=" + calendar.get(Calendar.DATE));
		challanGenToday = challan.list().size();
		compGenToday = query.list().size();
		System.out.print(compGenToday + " " + maxCompVal);
	}
%>
<body class=" theme-blue">
	<c:import url="stub_header.jsp"></c:import>    
	<c:import url="stub_admin_sidebar.jsp"></c:import>

    <div class="content">
        <div class="header">
	        <h1 class="page-title">Home</h1>
	       	<ul class="breadcrumb">
	            <li class="active">Home</li>
	            <li></li>
	        </ul>
        </div>
        <div class="main-content">
        
			<div class="panel panel-default">
			    <div class="panel-heading no-collapse">Welcome</div>
				<div id="widget1container" class="panel-body collapse in">
			        	<h2>Welcome Admin,</h2>
					<p>This interface provides easy GUI for managing E-Challan System.</p>
				</div>
			</div>
        
		    <div class="panel panel-default">
		        <a href="#page-stats" class="panel-heading" data-toggle="collapse">Latest Stats</a>
		        <div id="page-stats" class="panel-collapse panel-body collapse in">
		
		                    <div class="row">
		                        <div class="col-md-3 col-sm-6">
		                            <div class="knob-container">
		                                <input class="knob" data-width="200" data-min="0" data-max="<%out.print(maxChallanVal); %>" data-displayPrevious="true" value="<%out.print(challanGenToday); %>" data-fgColor="#92A3C2" data-readOnly=true;>
		                                <h3 class="text-muted text-center">Challan Generated</h3>
		                            </div>
		                        </div>
		                        <div class="col-md-3 col-sm-6">
		                            <div class="knob-container">
		                                <input class="knob" data-width="200" data-min="0" data-max="<%out.print(maxCompVal); %>" data-displayPrevious="true" value="<%out.print(compGenToday); %>" data-fgColor="#92A3C2" data-readOnly=true;>
		                                <h3 class="text-muted text-center">Complaints Received</h3>
		                            </div>
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
