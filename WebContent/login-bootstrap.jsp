<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>

<head>
	<title>Login: CMS Mobiles Stadttor</title>
	<%-- <link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery-ui-1.8.16.custom.css'/>" >--%>
	<!-- <link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css"> -->
	<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/bootstrap.min.css'/>" >
	<style>
		#loginForm {
			position: absolute;
			top: 35%;
			left: 35%;
		}
	</style>
</head>

<body onload='document.loginForm.j_username.focus();'>

	<form id="loginForm" name="loginForm" action="j_spring_security_check" method="post" class="form-horizontal">
		<h1>CMS für das mobile Stadttor</h1>
		<h6>Kultur für jederman</h6>
		<br>
        <div class="control-group">
   			<label class="control-label" for="usernameField">Benutzername</label>
   			<div class="controls">
				<input id="usernameField" name="j_username" type="text" placeholder="Benutzername">
			</div>
		</div>
		<div class="control-group">
   			<label class="control-label" for="passwordField">Password</label>
   			<div class="controls">
              		<input id="passwordField" name="j_password" type="password" />
          	</div>
		</div>
         <div class="control-group">
  			<div class="controls">
        		<button type="submit" class="btn primary">Login</button>
        	</div>
		</div>
	</form>
	
	<script type="text/javascript" src="<c:url value='/resources/global/js/jquery-1.8.3.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/bootstrap.min.js'/>"></script>
	
</body>

</html>