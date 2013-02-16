<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta http-equiv="Content-Language" content="de">
<title>Fehlermeldung / Errormessage</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery.mobile-min.css'/>" >
</head>
<% out.flush(); %>
<body>
	<div data-role="page">
		<div data-role="header" data-nobackbtn="true">
			<h1 align="center">Fehler / Error</h1>
		</div>
	
		<div data-role="content">	
			<p>
			Es ist leider ein Fehler in dieser Anwendung aufgetreten. Es wird bereits daran gearbeitet den Fehler zu beheben. Bitte versuchen Sie es in ein paar Minuten erneut.
			</p>
			<br>
			<p>
			We apologize for this error. We are currently trying to get the page back online again. Please try again later.
			</p>		
		</div>
	
	</div>
	
	<script>
	
		// it seems metatag isn't always enough
		//When ready...
		window.addEventListener("load",function() {
		  // Set a timeout...
		  setTimeout(function(){
		    // Hide the address bar!
		    window.scrollTo(0, 1);
		  }, 0);
		});
	
	</script>
	
	<script type="text/javascript" src="<c:url value='/resources/global/js/jquery+mobile-min.js'/>"></script>
	
	<%@ include file="footer.jsp" %>
</body>
</html>