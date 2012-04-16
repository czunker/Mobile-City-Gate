<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>

<head>
	<title>Login: CMS Mobiles Stadttor</title>
	<%-- <link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery-ui-1.8.16.custom.css'/>" >--%>
	<link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css">
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
			<h1>CMS für das mobile Stadttor</h1>
			<h6>Kultur für jederman</h6>
			<br>
            <div class="input">
              <div class="input-prepend">
                <span class="add-on">Benutzername</span>
                <input id="usernameField" name="j_username" type="text" />
              </div>
            </div>
            <br>
            <div class="input">
              <div class="input-prepend">
                <span class="add-on">Passwort&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <input id="passwordField" name="j_password" type="password" />
              </div>
              <span class="help-block">Replace with twipsy/tooltip</span>
            </div>
            <button type="submit" class="btn primary">Login</button>
	</form>
	
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	<script type="text/javascript" src="http://twitter.github.com/bootstrap/1.4.0/bootstrap-twipsy.js"></script>
	
	<script>
		$("#passwordField").css("height", "");
		$("#usernameField").css("height", "");
		var options = { animate: true,
						placement: 'right',
						trigger: 'focus',
						fallback: 'Bitte geben Sie hier Ihr Passwort ein.'
						};
		$('#passwordField').twipsy(options);
		options = { animate: true,
				placement: 'right',
				trigger: 'focus',
				fallback: 'Bitte geben Sie hier Ihren Benutzernamen ein.'
				};
		$('#usernameField').twipsy(options);
	</script>
</body>

</html>