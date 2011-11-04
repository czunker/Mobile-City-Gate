<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>

<head>
	<title>Login: CMS Mobiles Stadttor</title>
	<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery-ui-1.8.16.custom.css'/>" >
	<style>
		#loginForm {
			position: absolute;
			top: 40%;
			left: 40%;
		}
	</style>
</head>

<body onload='document.loginForm.j_username.focus();'>

	<form id="loginForm" name="loginForm" action="j_spring_security_check" method="post">
			<h2>CMS für das mobile Stadttor</h2>
	        <table>
	          <tr><td>Benutzername</td><td><input id="usernameField" type="text" name="j_username" /></td></tr>
	          <tr><td>Passwort</td><td><input id="passwordField" type="password" name="j_password" /></td></tr>
	
	          <tr><td colspan="2" align="right"><button>Login</button></td></tr>
	        </table>
	</form>

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
	<script>
		$(document).ready(function() {
			$("button").button();
		});
	</script>
</body>

</html>