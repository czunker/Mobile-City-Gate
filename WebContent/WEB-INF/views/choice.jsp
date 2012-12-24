<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta http-equiv="Content-Language" content="de">
		<title><c:out value="${messages.title}"/></title>
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery.mobile-1.0a4.1.min.css'/>" >
	</head>
	<body>
	<compress:html>
	<div data-role="page">
			<div data-role="header" data-backbtn="false">
				<h1><c:out value="${messages.header}"/></h1>
			</div>
			
			<div data-role="content">
				<p><c:out value="${messages.body}"/></p>
				<div data-role="controlgroup">
				<c:forEach var="client" items="${clients}">
					<a href="<c:url value='/${client.url}/de/'/>" data-role="button" data-ajax="false"><c:out value='${client.name}'/></a>				
				</c:forEach>
				</div>
			</div>
	</div>
	</compress:html>
	
	<script async>
	<compress:js>
	
		// it seems metatag isn't always enough
		//When ready...
		window.addEventListener("load",function() {
		  // Set a timeout...
		  setTimeout(function(){
		    // Hide the address bar!
		    window.scrollTo(0, 1);
		  }, 0);
		});
	</compress:js>
	</script>
	
	<%-- 
	<script type="text/javascript" src="<c:url value='/resources/global/js/jquery-1.5.1.min.js'/>"></script>
	<script async src="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js"></script>
	<script async src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
	<script async type="text/javascript" src="<c:url value='/resources/global/js/jquery.mobile-1.0a4.1.min.js'/>"></script>
	--%>
	
	<script async type="text/javascript" src="<c:url value='/resources/global/js/jquery+mobile-min.js'/>"></script>	
	<jsp:include page="footer.jsp"/>
	</body>
</html>