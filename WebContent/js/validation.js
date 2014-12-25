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