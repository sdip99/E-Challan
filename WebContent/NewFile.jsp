<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="org.echallan.dataAccessObject.RuleDAO"%>
<%@page import="org.echallan.valueObject.Rule"%>
<%@page import="java.util.List"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
<script type="text/javascript" src="lib/cool.js"></script>
<script type="text/javascript">
$(function () {
	var x=0;
    $("#btnAdd").bind("click", function () {
        var div = $("<div />");
        div.html(GetDynamicTextBox(x));
        x++;
        $("#TextBoxContainer").append(div);
    });
    $("#btnGet").bind("click", function () {
        var values = "";
        $("select[name=DynamicTextBox]").each(function () {
            values += $(this).val() + "\n";
        });
        alert(values);
    });
    $("body").on("click", ".remove", function () {
        $(this).closest("div").remove();
    });
});
<%
	List<Rule> rules = new RuleDAO().getAll();
	StringBuffer buffer = new StringBuffer();
	for(Rule r : rules)
		buffer.append("<option value=" + r.getRuleName() + ">" + r.getRuleName() + "</option>");
	System.out.print(buffer.toString());
%>
function GetDynamicTextBox(value) {
    return '<select name = "test_' + value + '">' + '<% out.print(buffer.toString()); %>' +'</select> &nbsp;' +
            '<input type="button" value="Remove" class="remove" />'
}
</script>
</head>
<body>
<form action='Controller' method="post">
	<input id="btnAdd" type="button" value="Add" />
	<br />
	<br />
	<div id="TextBoxContainer">
	    <!--Textboxes will be added here -->
	</div>
	<br />
	<input id="btnGet" type="button" value="Get Values" />
	<input type="submit" name="submit" value="test"/> 
</form>
</body>
</html>
