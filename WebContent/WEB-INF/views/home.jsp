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
		<compress:css>
		<style type="text/css">
			<c:if test="${fn:length(languages) > 1}">
				<c:forEach var="lang" items="${languages}">
					.ui-icon-<c:out value="${lang.shortName}"/> {
						background: url("<c:url value='/resources/global/images/${lang.icon}'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
					}
				</c:forEach>
			</c:if>
			
			IMG.center {
			    display: block;
			    margin-left: auto;
			    margin-right: auto 
			}
			
			.bg-img {
				position: absolute;
				top: 0px;
				left: 0px;
			}
		</style>
		</compress:css>
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery.mobile-min.css'/>" >
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/${client.url}/css/home-style-min.css'/>" >
	</head>
	<body>
	<compress:html>
	<div data-role="page" id="homepage">
		<%-- 
		<div data-role="header" data-backbtn="false">
			<h1><c:out value="${messagesHome.start}"/></h1>
			<a data-ajax="false" href="#aboutpage" data-icon="info" class="ui-btn-rigth" data-iconpos="notext"><c:out value="${messagesHome.about}"/></a>
		</div>
		--%>
	
		<div data-role="content" id="homepage-content">
			<a id="aboutbutton" href="#aboutpage" data-icon="info" data-iconpos="notext" data-role="button"><c:out value="${messagesHome.about}"/></a>
			<img id="homepageBgImg" class="bg-img" alt="<c:out value="${messagesHome.alttext_startimage}"/>" src="<c:url value='/resources/global/css/images/ajax-loader.png' />" >
			
			<c:if test="${fn:length(languages) > 1}">
				<div id="language" data-role="controlgroup" data-type="vertical">
				<c:forEach var="lang" items="${languages}">
		           	<a data-ajax="false" data-role="button" data-iconpos="notext" data-icon="<c:out value='${lang.shortName}'/>" href="<c:url value='/${client.url}/${lang.shortName}/'/>"><c:out value="${lang.name}"/></a>
			    </c:forEach>
	        	</div>
	        </c:if>
	        <%-- TODO data-ajax="false" muss weg, allerdings funktionieren dann die Links f�r die Dialoge nicht mehr --%>
	        <a data-theme="z" id="startbutton" href="<c:url value='/${client.url}/${locale}/pois'/>" data-inline="true" data-ajax="false" data-role="button"><c:out value="${messagesHome.start_button}"/></a>		
		</div>

		<%-- 	
		<div data-role="footer" class="ui-bar" data-position="inline">
			
			<div data-role="navbar">
				<ul>
					<li>&nbsp;</li>
					<li>
						<a href="<c:url value='/${client.url}/${locale}/pois'/>" class="center-button" data-ajax="false" data-role="button"><c:out value="${messagesHome.start_button}"/></a>
					</li>
					<li>&nbsp;</li>
				</ul>
			</div>
		</div>
		--%>
	</div>
	
	
	<div data-role="page" id="aboutpage">
		<div data-role="header" data-backbtn="true">
			<h1><c:out value="${messagesAbout.header}"/></h1>
			<%--<a href="#" data-rel="back" data-icon="home" data-iconpos="notext" class="ui-btn-right jqm-home"><c:out value="${messagesAbout.home}"/></a>--%>
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
                <a href="http://creativecommons.org/licenses/by-sa/2.0/"><img src="<c:url value='/resources/global/images/cc-by-sa.png'/>" alt="[CC-BY-SA]" width="88" height="31" style="float:left; margin-right: 1em;"/></a> 
			</p>
			<br>
			<p>
				<c:out value="${messagesAbout.icons}"/><br>
				<a href="http://icons.anatom5.de/">http://icons.anatom5.de/</a><br>
			</p>
			<%--
			<a href="http://glyphish.com/">http://glyphish.com/</a><br>
			<a href="http://jquerymobile.com/">http://jquerymobile.com/</a>
			--%>
		</div>
	</div>
	</compress:html>
	
	<%-- 
	<script type="text/javascript" src="<c:url value='/resources/global/js/jquery-1.5.1.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/jquery.mobile-1.0a4.min.js'/>"></script>
	--%>
	<script type="text/javascript" src="<c:url value='/resources/global/js/jquery+mobile-min.js'/>"></script>
	
	<script>
	<compress:js>
	
		$(window).load($.mobile.silentScroll);
	
		function setBgImage() {  
			var contentwidth = $(window).width();  
			var contentheight = $(window).height();
			if ((contentwidth <= 320) && (contentheight <= 480)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_320_480.jpg");  
			}
			else if ((contentwidth <= 480) && (contentheight <= 320)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_480_320.jpg");  
			}
			else if ((contentwidth <= 480) && (contentheight <= 800)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_480_800.jpg");  
			}
			else if ((contentwidth <= 600) && (contentheight <= 800)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_600_800.jpg");  
			}
			else if ((contentwidth <= 640) && (contentheight <= 960)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_640_960.jpg");  
			}
			else if ((contentwidth <= 768) && (contentheight <= 1024)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_768_1024.jpg");  
			}
			else if ((contentwidth <= 800) && (contentheight <= 480)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_480.jpg");  
			}
			else if ((contentwidth <= 800) && (contentheight <= 640)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_640.jpg");  
			}
			else if ((contentwidth <= 800) && (contentheight <= 600)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_800_600.jpg");  
			}
			else if ((contentwidth <= 960) && (contentheight <= 640)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_960_640.jpg");  
			}
			else if ((contentwidth <= 1024) && (contentheight <= 768)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1024_768.jpg");  
			}
			else if ((contentwidth <= 1280) && (contentheight <= 1024)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1280_1024.jpg");  
			}
			else if ((contentwidth <= 1920) && (contentheight <= 1080)){  
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_1920_1080.jpg");  
			} 
			else {
				$('#homepageBgImg').attr('src',"<c:url value='/resources/${client.url}/images/${client.startPageImage}' />_320_480.jpg");
			}
		}
	
		$("#homepage").live('pagebeforeshow', setBgImage);
		
		$(document).ready(function() {
		  	$(window).bind("orientationchange resize", setBgImage);
		});
	</compress:js>
	</script>  
	
	<jsp:include page="footer.jsp"/>
	</body>
</html>
