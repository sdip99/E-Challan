var request;  
function sendInfo()  
{
	var v = document.getElementById("cat_name");
	if(window.XMLHttpRequest){
		request=new XMLHttpRequest();
	} else if(window.ActiveXObject) {
		request=new ActiveXObject("Microsoft.XMLHTTP");
	}
	try {
		request.onreadystatechange = getInfo;
		request.open("GET", "Controller?cat_id=" + v.value, true);
		request.send();
	} catch(e) {
		alert("Unable to connect to server");
	}
}

function getInfo(){
	if(request.readyState==4){
		var val = request.responseText;
		document.getElementById("rule_inner").innerHTML = val;
	}
}