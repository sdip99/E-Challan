function validateAdminLogin() {
	var u_n = document.admin_login.username;
	var pass = document.admin_login.password;
	if(u_n.value == "" || u_n.value == null) {
		alert("Please enter User Name");
		u_n.focus();
		return false;
	} else if (pass.value == "" || pass.value == null) {
		alert("Please enter Password");
		pass.focus();
		return false;
	}
}

function validateAddofficer(){
	var fn = document.add_officer.first_name;
	var ln = document.add_officer.last_name;
	var mn = document.add_officer.mobile_no;
	var zip = /^[0-9]{6}$/;
	var s = document.add_officer.street;
	var c = document.add_officer.city;
	var st = document.add_officer.state;
	var pin = document.add_officer.pincode;
	var mail = document.add_officer.email;
	var mailformat = /^[a-zA-Z0-9_\.\-])+\@(([a-zA-Z])+\.)+([a-zA-Z]{2,4}+$/;
	var phoneno = /^[0-9]{10}$/;
	var pass = document.add_officer.password;
	var pass2 =document.add_officer.password2;
	if(fn.value == "" || fn.value == null) {
		alert("Please enter First Name");
		fn.focus();
		return false;
	} else if (pass.value == "" || pass.value == null) {
		alert("Please enter valid Passwords");
		pass.focus();
		return false;
	} else if (pass2.value == "" || pass2.value == null) {
		alert("Please enter Confirm Password");
		pass2.focus();
		return false;
	} else if (!pass2.value.test(pass1.value)) {
		alert("Please enter Same Password");
		pass2.focus();
		return false;
	} else if (ln.value == "" || ln.value == null) {
		alert("Please enter Last Name");
		ln.focus();
		return false;
	} else if (mail.value == "" || mail.value == null || !mailformat.test(mail.value)) {
		alert("Please enter valid Email");
		mail.focus();
		return false;
	} else if (mn.value == "" || mn.value == null || !phoneno.test(mn.value)) {
		alert("Please enter Mobile Number");
		mn.focus();
		return false;
	} else if (s.value == "" || s.value == null) {
		alert("Please enter Street");
		s.focus();
		return false;
	} else if (c.value == "" || c.value == null) {
		alert("Please enter City Name");
		c.focus();
		return false;
	} else if (st.value == "" || st.value == null) {
		alert("Please enter State");
		st.focus();
		return false;
	} else if (pin.value == "" || pin.value == null || !zip.test(pin.value)) {
		alert("Please enter Pincode");
		pin.focus();
		return false;
	}
}
function validateGeneratechallan()
{
	var lic = document.g_challan.license_no;
	var vehicle = document.g_challan.vehicle_no;
	 if (lic.value == "" || lic.value == null) {
		alert("Please enter License No");
		lic.focus();
		return false;
	}else if (vehicle.value == "" || vehicle.value == null) {
		alert("Please enter Vehicle No");
		vehicle.focus();
		return false;
	}
}	 
function validateaddCat(){
		 
		 var cat = document.add_cat.cat_name;
		 var catdesc = document.add_cat.cat_desc;
		 if (cat.value == "" || cat.value == null) {
				alert("Please enter Category Name");
				cat.focus();
				return false;
			}
		 
		 else if (catdesc.value == "" || catdesc.value == null) {
				alert("Please enter Category Description");
				catdesc.focus();
				return false;
			}
		 }
function validateaddRule(){
			 
			 var rname = document.add_rul.rule_name;
			 var rid = document.add_rul.rule_id;
			 var ruid = /^[0-9]$/;
			 var rufine = /^[0-9]$/;
			 var fine = document.add_rul.fine;
			 var rdesc = document.add_rul.rule_desc;
			 if (rname.value == "" || r.name.value == null) {
					alert("Please enter Rule Name");
					rname.focus();
					return false;
				}
			 else if (rid.value == "" || rid.value == null || !ruid.test(rid.value)) {
					alert("Please Rule ID");
					rid.focus();
					return false;
				}
			 
			 else if (fine.value == "" || fine.value == null || !rufine.test(fine.value)) {
					alert("Please enter Rule Fine");
					fine.focus();
					return false;
				}
			 else if (rdesc.value == "" || rdesc.value == null) {
					alert("Please enter Rule Description");
					rdesc.focus();
					return false;
				}
}
