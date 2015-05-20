var mailformat = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
var bloodGroup = /^(A|B|AB|O)[+-]$/i;
var numbersParttrn = /^[0-9]+$/;
var datePattrn = /^[0-9]{2}$/;
var yearparttrn = /^[0-9]{4}$/;
var zipPattrn = /^[0-9]{6}$/;
	
	
	
function validateAdminLogin() {
	var eid = document.forgot_pass.username;
	if(eid == null || eid.value == "" || !mailformat.test(eid.value)) {
		alert("Please enter valid email id");
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
	var mailformat = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	var phoneno = /^[0-9]{10}$/;
	var pass = document.add_officer.password;
	var pass2 =document.add_officer.password2;
	if(fn.value == "" || fn.value == null) {
		alert("Please enter First Name");
		fn.focus();
		return false;
	}if(ln.value == "" || ln.value == null) {
		alert("Please enter Last Name");
		ln.focus();
		return false;
	}if(mn.value == "" || mn.value == null || !phoneno.test(mn.value)) {
		alert("Please enter valid mobile no");
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
	} else if (mail.value == "" || mail.value == null || !mailformat.test(mail.value)) {
		alert("Please enter valid Email");
		mail.focus();
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
	}
}
function validateGeneratechallan()
{
	var vehicle = document.g_challan.vehicle_no;
	if (vehicle.value == "" || vehicle.value == null) {
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
			 
			 if (rid.value == "" || rid.value == null || !ruid.test(rid.value)) {
					alert("Please Rule ID");
					rid.focus();
					return false;
				}
			 
			 else if (rname.value == "" || r.name.value == null) {
					alert("Please enter Rule Name");
					rname.focus();
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

function validateEditUsrProf() {
	var fn = document.edit_user_prof.first_name;
	var ln = document.edit_user_prof.last_name;
	var mn = document.edit_user_prof.mobile_no;
	var zip = /^[0-9]{6}$/;
	var s = document.edit_user_prof.street;
	var c = document.edit_user_prof.city;
	var st = document.edit_user_prof.state;
	var pin = document.edit_user_prof.pincode;
	var mail = document.edit_user_prof.email;
	var mailformat = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	var phoneno = /^[0-9]{10}$/;
	if(fn.value == "" || fn.value == null) {
		alert("Please enter First Name");
		fn.focus();
		return false;
	}if(ln.value == "" || ln.value == null) {
		alert("Please enter Last Name");
		ln.focus();
		return false;
	}if(mn.value == "" || mn.value == null || !phoneno.test(mn.value)) {
		alert("Please enter valid mobile no");
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
	} else if (mail.value == "" || mail.value == null || !mailformat.test(mail.value)) {
		alert("Please enter valid Email");
		mail.focus();
		return false;
	}
}

function validateGenChlnLn() {
	var lno = document.gen_chln_ln.license_no;
	var fn = document.gen_chln_ln.first_name;
	var ln = document.gen_chln_ln.last_name;
	var mn = document.gen_chln_ln.middle_name;
	var bg= document.gen_chln_ln.blood_group;
	var date = document.gen_chln_ln.date;
	var month = document.gen_chln_ln.month;
	var year = document.gen_chln_ln.year;
	var pc = document.gen_chln_ln.pincode;
	if((lno.value == null || lno.value == "") && (fn.value == null || fn.value == "")) {
		alert("Please enter license no");
		lno.focus();
		return false;
	}
		
		if(fn.value == null || fn.value == "") {
			alert("Please enter first name");
			fn.focus();
			return false;
		} else if(ln.value == null || ln.value == "") {
			alert("Please enter last name");
			ln.focus();
			return false;
		} else if(mn.value == null || mn.value == "") {
			alert("Please enter middle name");
			mn.focus();
			return false;
		} else if(bg.value == null || bg.value == "" || !bloodGroup.test(bg.value)) {
			alert("Please enter valid blood group");
			bg.focus();
			return false;
		} else if(date.value == null || date.value == "" || !datePattrn.test(date.value)) {
			alert("Please enter valid date");
			date.focus();
			return false;
		} else if(year.value == null || year.value == ""  || !yearPattrn.test(year.value)) {
			alert("Please enter valid year");
			year.focus();
			return false;
		} else if(month.value == null || month.value == "" || !datePattrn.test(month.value)) {
			alert("Please enter valid month");
			month.focus();
			return false;
		} else if(pc.value == null || pc.value == "" || !zipPattrn.test(pc.value)) {
			alert("Please enter valid pincode");
			pc.focus();
			return false;
		}
}

function validateInsArea() {
	
}