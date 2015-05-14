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
		<%--
		the following line is needed to set the zoom factor on android mobile phones correctly
		http://stackoverflow.com/questions/6213868/jquery-mobile-android-browser
		http://engageinteractive.co.uk/blog/tutorial-building-a-website-for-the-iphone
		http://alxgbsn.co.uk/2011/11/23/make-sure-to-use-correct-meta-viewport-syntax/
		this does only work on mobile: <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		--%>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<title><c:out value="${messagesHome.title}"/></title>
		<style type="text/css">
		<compress:css>
			<c:if test="${fn:length(languages) > 1}">
				<c:forEach var="lang" items="${languages}">
					.ui-icon-<c:out value="${lang.shortName}"/> {
						background: url("<c:url value='/resources/global/images/${lang.icon}'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
					}
				</c:forEach>
			</c:if>

			/* order meters and it seems it has to be the reverse order of javascript */
<%--
			@media (min-width: 1px) and (max-width: 320px) and (max-height: 480px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_320_480.jpg");
    			}
			}
			@media (min-width: 321px) and (max-width: 480px) and (max-height: 320px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_480_320.jpg");
    			}
			}
			@media (min-width: 481px) and (max-width: 480px) and (max-height: 800px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_480_800.jpg");
    			}
			}
			@media (min-width: 481px) and (max-width: 600px) and (max-height: 800px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_600_800.jpg");
    			}
			}
			@media (min-width: 601px) and (max-width: 640px) and (max-height: 960px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_640_960.jpg");
    			}
			}
			@media (min-width: 641px) and (max-width: 768px) and (max-height: 1024px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_768_1024.jpg");
    			}
			}
			@media (min-width: 769px) and (max-width: 800px) and (max-height: 480px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_480.jpg");
    			}
			}
			@media (min-width: 801px) and (max-width: 800px) and (max-height: 600px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_600.jpg");
    			}
			}
			@media (min-width: 801px) and (max-width: 800px) and (max-height: 640px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_640.jpg");
    			}
			}
			@media (min-width: 801px) and (max-width: 960px) and (max-height: 640px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_960_640.jpg");
    			}
			}
			@media (min-width: 961px) and (max-width: 1024px) and (max-height: 768px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1024_768.jpg");
    			}
			}
			@media (min-width: 1025px) and (max-width: 1280px) and (max-height: 720px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1280_720.jpg");
    			}
			}
			@media (min-width: 1025px) and (max-width: 1280px) and (max-height: 1024px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1280_1024.jpg");
    			}
			}
			@media (min-width: 1281px) and (max-width: 1334px) and (max-height: 750px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1334_750.jpg");
    			}
			}
			@media (min-width: 1281px) and (max-width: 1920px) and (max-height: 1080px) {
    			#homepage {
        			background-image: url("<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1920_1080.jpg");
    			}
			}
			--%>
		</compress:css>
		</style>

		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery.mobile-min.css'/>" >
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/${client.url}/css/home-style-min.css'/>" >
	</head>
<% out.flush(); %>
	<body>
	<compress:html>
	<div id="loading">
  		<%--<img id="loading-image" src="<c:url value='/resources/global/images/ajax-loader.gif'/>" alt="Loading..." />--%>
  		<span id="loading-text"><c:out value="${messagesHome.loading}"/></span>
	</div>
		<div data-role="page" id="homepage">
			<div data-role="content" id="homepage-content">
			<a id="aboutbutton" href="<c:url value="/${client.url}/${locale}/about" />" data-icon="info" data-iconpos="notext" data-role="button"><c:out value="${messagesHome.about}"/></a>
			<img id="homepageBgImg" class="bg-img" alt="<c:out value="${messagesHome.alttext_startimage}"/>" src="<c:url value="/resources/global/css/images/ajax-loader.png" />" >
			<c:if test="${fn:length(languages) > 1}" >
				<div id="language" data-role="controlgroup" data-type="vertical">
				<c:forEach var="lang" items="${languages}">
					<a data-ajax="false" data-role="button" data-iconpos="notext" data-icon="<c:out value="${lang.shortName}" />" href="<c:url value="/${client.url}/${lang.shortName}/" />"><c:out value="${lang.name}"/></a>
				</c:forEach>
				</div>
			</c:if>
			<a data-theme="z" id="startbutton" href="<c:url value="/${client.url}/${locale}/pois" />" data-inline="true" data-ajax="false" data-role="button"><c:out value="${messagesHome.start_button}" /></a>
			</div>
		</div>

	</compress:html>

	<%-- TODO: make the async when bg image is set by css --%>
	<script type="text/javascript" src="<c:url value='/resources/global/js/jquery+mobile-min.js'/>" ></script>

	<script>
	<compress:js>
		$(window).load(function () { $.mobile.silentScroll(); $('#loading').hide(); });
		function setBgImage() {
			var contentwidth = $(window).width();
			var contentheight = $(window).height();
			if ((contentwidth <= 320) && (contentheight <= 480)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_320_480.jpg");
				$('#homepageBgImg').attr('width', '320');
				$('#homepageBgImg').attr('height', '480');
			}
			else if ((contentwidth <= 480) && (contentheight <= 320)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_480_320.jpg");
				$('#homepageBgImg').attr('width', '480');
				$('#homepageBgImg').attr('height', '320');
			}
			else if ((contentwidth <= 480) && (contentheight <= 800)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_480_800.jpg");
				$('#homepageBgImg').attr('width', '480');
				$('#homepageBgImg').attr('height', '800');
			}
			else if ((contentwidth <= 600) && (contentheight <= 800)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_600_800.jpg");
				$('#homepageBgImg').attr('width', '600');
				$('#homepageBgImg').attr('height', '800');
			}
			else if ((contentwidth <= 640) && (contentheight <= 960)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_640_960.jpg");
				$('#homepageBgImg').attr('width', '640');
				$('#homepageBgImg').attr('height', '960');
			}
			else if ((contentwidth <= 768) && (contentheight <= 1024)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_768_1024.jpg");
				$('#homepageBgImg').attr('width', '768');
				$('#homepageBgImg').attr('height', '1024');
			}
			else if ((contentwidth <= 800) && (contentheight <= 480)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_480.jpg");
				$('#homepageBgImg').attr('width', '800');
				$('#homepageBgImg').attr('height', '480');
			}
			else if ((contentwidth <= 800) && (contentheight <= 640)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_640.jpg");
				$('#homepageBgImg').attr('width', '800');
				$('#homepageBgImg').attr('height', '640');
			}
			else if ((contentwidth <= 800) && (contentheight <= 600)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_600.jpg");
				$('#homepageBgImg').attr('width', '800');
				$('#homepageBgImg').attr('height', '600');
			}
			else if ((contentwidth <= 960) && (contentheight <= 640)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_960_640.jpg");
				$('#homepageBgImg').attr('width', '960');
				$('#homepageBgImg').attr('height', '640');
			}
			else if ((contentwidth <= 1024) && (contentheight <= 768)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1024_768.jpg");
				$('#homepageBgImg').attr('width', '1024');
				$('#homepageBgImg').attr('height', '768');
			}
			else if ((contentwidth <= 1280) && (contentheight <= 720)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1280_720.jpg");
				$('#homepageBgImg').attr('width', '1280');
				$('#homepageBgImg').attr('height', '720');
			}
			else if ((contentwidth <= 1280) && (contentheight <= 1024)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1280_1024.jpg");
				$('#homepageBgImg').attr('width', '1280');
				$('#homepageBgImg').attr('height', '1024');
			}
			else if ((contentwidth <= 1334) && (contentheight <= 750)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1280_1024.jpg");
				$('#homepageBgImg').attr('width', '1334');
				$('#homepageBgImg').attr('height', '750');
			}
			else if ((contentwidth <= 1920) && (contentheight <= 1080)){
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1920_1080.jpg");
				$('#homepageBgImg').attr('width', '1920');
				$('#homepageBgImg').attr('height', '1080');
			}
			else {
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_320_480.jpg");
				$('#homepageBgImg').attr('width', '320');
				$('#homepageBgImg').attr('height', '480');
			}
		}

		$("#homepage").live('pagebeforecreate', setBgImage);

		$(document).ready(function() {
		  	$(window).bind("orientationchange resize", setBgImage);
		});
	</compress:js>
	</script>

	<%@ include file="footer.jsp" %>
	</body>
</html>
