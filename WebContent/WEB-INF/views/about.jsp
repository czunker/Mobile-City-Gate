<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta http-equiv="Content-Language" content="${locale}">
		<title><c:out value="${messagesHome.title}"/></title>
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery.mobile-min.css'/>" >
	</head>
<% out.flush(); %>
	<body>
	<compress:html>		
	<div data-role="page" id="aboutpage">
		<div data-role="header" data-backbtn="true">
			<h1><c:out value="${messagesAbout.header}"/></h1>
			</div>
			<div data-role="content">
			<p>
			<c:out value="${messagesAbout.responsible}" escapeXml="false" /><br>
			</p>
			<p>
			<c:out value="${messagesAbout.technical}" escapeXml="false" /><br>
			<a href="http://www.mobile-discovery.com">www.mobile-discovery.com</a>
			</p>
			<p>
			<c:out value="${messagesAbout.privacy}"/>
			</p>
			<p>
			<c:out value="${messagesAbout.license}"/><br>
			<a href="http://creativecommons.org/licenses/by-sa/2.0/"><img src="<c:url value="/resources/global/images/cc-by-sa.png" />" alt="[CC-BY-SA]" width="88" height="31" style="float:left; margin-right: 1em;"/></a> 
			</p>
			<br>
			<p>
			<c:out value="${messagesAbout.icons}"/><br>
			<a href="http://icons.anatom5.de/">http://icons.anatom5.de/</a><br>
			</p>
			</div>
	</div>
	</compress:html>
	<script async type="text/javascript" src="<c:url value='/resources/global/js/jquery+mobile-min.js'/>" ></script>
	
	<%@ include file="footer.jsp" %>
	</body>
</html>
