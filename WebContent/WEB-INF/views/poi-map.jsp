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
<%-- should hide browser address bar --%>
<meta name="apple-mobile-web-app-capable" content="yes">
<%-- is needed for screen readers --%>
<meta http-equiv="Content-Language" content="${locale}">
<title><c:out value="${messages.title}"/></title>
<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery.mobile-min.css'/>" >
<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/ol-theme/default/style.css'/>" >
<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/map-style-min.css'/>" >

<style type="text/css">
	<compress:css>
	<%--can not be externalized, otherwise the map will not be displayed--%>
	#mapdiv {
		position: absolute;
	    top: 0px;
	    bottom: 0px;
	    left: 0px;
	    right: 0px;
	    <%-- for ie --%>
	    width:expression((document.documentElement.clientWidth ? document.documentElement.clientWidth : document.body.clientWidth)-200);
	    height:expression((document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight)-86);
	    padding: 1px;
	}
	
	.ui-icon-phone {
		background: url("<c:url value='/resources/global/images/phone.png'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
	}
	
	.ui-icon-notepad {
		background: url("<c:url value='/resources/global/images/notepad.png'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
	}
	
	.ui-icon-location {
		background: url("<c:url value='/resources/${client.url}/images/location.png'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
	}
	
	.ui-icon-map {
		background: url("<c:url value='/resources/global/images/compass.png'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
	}
	
	.ui-icon-twitter {
		background: url("<c:url value='/resources/global/images/twitter.png'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
	}
	
	.ui-icon-facebook {
		background: url("<c:url value='/resources/global/images/facebook.png'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
	}
	
	.ui-icon-email {
		background: url("<c:url value='/resources/global/images/email.png'/>") no-repeat rgba(0, 0, 0, 0.4) !important;
	}
	
	<%--remove then this fix is integrated https://github.com/jquery/jquery-mobile/commit/a881ae79d7310e45294ed2f0e24a825b3191429c --%>
	.ui-footer .ui-btn-left { position: absolute; left: 10px; top: .4em;  }
	
	.ui-footer .ui-btn-right { position: absolute; right: 10px; top: .4em; }
	</compress:css>
</style>
</head>
<body>
<compress:html>
<div data-role="page" id="poi-overview">
	<%-- isn't working correctly on iPhone:  data-position="fixed" --%>
	<div data-role="header" data-backbtn="false">
		<div data-role="navbar">
			<ul>
				<li id="navCategories">
					<a href="#optCategories" onClick='closedPoiOverviewDialog = true;' data-rel="dialog" data-icon="gear" data-transition="pop" data-iconpos="left"><c:out value='${messagesPoiOverview.categoryheader}'/></a>
				</li>
				<li id="buttonMap">
					<a onClick="submitMap()" data-role="button" data-icon="map" data-iconpos="left"><c:out value='${messagesPoiOverview.mapbutton}'/></a>
				</li>
				<li id="navProfiles">
					<a href="#optProfiles" onClick='closedPoiOverviewDialog = true;' data-rel="dialog" data-icon="gear" data-transition="pop" data-iconpos="left"><c:out value='${messagesPoiOverview.profileheader}'/></a>
				</li>
			</ul>
		</div>
	</div>

	<div data-role="content" align="center" id="poi-content">	
			<!-- <ul data-role="listview" data-filter="true" id="poi-list"> -->
			<ul data-role="listview" id="poi-list">
			</ul>
	</div>
	
	<div data-role="footer" class="ui-bar">
		<%--
		<a href="#" class="ui-btn-left" data-rel="back" data-icon="arrow-l" data-role="button"><c:out value='${messagesPoiOverview.backbutton}'/></a>
		<a href="#" class="ui-btn-right" onClick="$.mobile.silentScroll();" data-icon="arrow-u" data-role="button" title="<c:out value='${messagesPoiOverview.topbutton}'/>"><c:out value='${messagesPoiOverview.topbutton}'/></a>
		--%>		
		<div data-role="navbar">
			<ul>
				<li id="navBackButton">
					<a href="#" data-rel="back" data-icon="arrow-l" data-role="button"><c:out value='${messagesPoiOverview.backbutton}'/></a>
				</li>
				<li id="navEmpty">
				</li>
				<li id="navTopButton">
					<a href="#" onClick="$.mobile.silentScroll();" data-icon="arrow-u" data-role="button" title="<c:out value='${messagesPoiOverview.topbutton}'/>"><c:out value='${messagesPoiOverview.topbutton}'/></a>
				</li>
			</ul>
		</div>
	</div>
</div>

<div data-role="page" id="mappage">
	
	<div data-role="content" id="mappage-content">
		<div id="mapdiv"> 
              <noscript><c:out value="${messagesMap.javascript}"/></noscript> 
         </div> 
     </div>
     
      <div id="navigation" data-role="controlgroup" data-type="horizontal"> 
        <a href="#" data-role="button" data-icon="plus" id="plus" data-iconpos="notext"><c:out value="${messagesMap.zoomin}"/></a> 
        <a href="#" data-role="button" data-icon="minus" id="minus" data-iconpos="notext"><c:out value="${messagesMap.zoomout}"/></a>
      </div>
      
      <a href="#" data-role="button" data-icon="arrow-u" id="north" data-iconpos="notext" class="nav-button"><c:out value="${messagesMap.north}"/></a>
      <a href="#" data-role="button" data-icon="arrow-d" id="south" data-iconpos="notext" class="nav-button"><c:out value="${messagesMap.south}"/></a>
      <a href="#" data-role="button" data-icon="arrow-l" id="west" data-iconpos="notext" class="nav-button"><c:out value="${messagesMap.west}"/></a>
      <a href="#" data-role="button" data-icon="arrow-r" id="east" data-iconpos="notext" class="nav-button"><c:out value="${messagesMap.east}"/></a>
      <a href="#" data-role="button" data-icon="location" id="location" data-iconpos="notext" class="nav-button"><c:out value="${messagesMap.location}"/></a>
      <a href="<c:url value='/${client.url}/${locale}/'/>" data-role="button" data-icon="home" id="home" data-iconpos="notext" class="nav-button" data-ajax="false"><c:out value="${messagesMap.home}"/></a>
      
 </div>
 
 <div data-role="dialog" id="optCategories">
	<div data-role="header" data-backbtn="false">
		<h1><c:out value='${messagesPoiOverview.categoryheader}'/></h1>
	</div>
	<div data-role="content">
		<div  data-role="fieldcontain">
			 	<fieldset data-role="controlgroup">
			 		<c:forEach var="category" items="${poiCategories}">
			 			<input type="checkbox" name="checkbox-category-<c:out value='${category.id}'/>" id="checkbox-category-<c:out value='${category.id}'/>" class="custom" />
			 			<label for="checkbox-category-<c:out value='${category.id}'/>" id="label-category-<c:out value='${category.id}'/>">
							<img height="20px" width="20px" id="img-<c:out value='${category.shortName}'/>" src="<c:url value='/resources/${client.url}/images/${category.icon}'/>" alt="<c:out value='${category.name}'/>">
							<c:out value='${category.name}'/>
						</label>
					</c:forEach>
				</fieldset>
		</div>
		<a href='#' data-role='button' data-rel='back' data-transition='pop'><c:out value='${messagesPoiOverview.closebutton}'/></a>
	</div>
</div>

<div data-role="dialog" id="optProfiles">
	<div data-role="header" data-backbtn="false">
		<h1><c:out value='${messagesPoiOverview.profileheader}'/></h1>
	</div>
	<div data-role="content">
		<p><c:out value='${messagesPoiOverview.profilehelp}'/></p>
		<div  data-role="fieldcontain">
			 	<fieldset data-role="controlgroup">
			 		<c:forEach var="profile" items="${profiles}">
			 			<input type="checkbox" name="checkbox-profile-<c:out value='${profile.id}'/>" id="checkbox-profile-<c:out value='${profile.id}'/>" class="custom" />
			 			<label for="checkbox-profile-<c:out value='${profile.id}'/>" id="label-profile-<c:out value='${profile.id}'/>">
							<img height="20px" width="20px" id="img-<c:out value='${profile.shortName}'/>" src="<c:url value='/resources/global/images/${profile.icon}' />" alt="<c:out value='${profile.name}'/>">
							<c:out value='${profile.name}'/>
						</label>
					</c:forEach>
				</fieldset>
		</div>
		<a href='#' data-role='button' data-rel='back' data-transition='pop'><c:out value='${messagesPoiOverview.closebutton}'/></a>
	</div>
</div>
</compress:html>

<%--
<script type="text/javascript" src="<c:url value='/resources/global/js/OpenLayers.mobile.js'/>" ></script>            
<script type="text/javascript" src="<c:url value='/resources/global/js/OpenStreetMap-min.js'/>" ></script>
--%>
<%-- needed for map --%>
<script type="text/javascript" src="<c:url value='/resources/global/js/ol+osm-min.js'/>" ></script>

<%-- needed for map + poi overview--%> 
<script type="text/javascript" src="<c:url value='/resources/global/js/jquery+mobile-min.js'/>"></script>

<%--
<script type="text/javascript" src="<c:url value='/resources/global/js/geo-min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/global/js/gears-init-min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/global/js/poi-map.js'/>" ></script>
--%> 
<%-- needed for map --%>
<script type="text/javascript" src="<c:url value='/resources/global/js/map-min.js'/>" ></script>

<script>
<compress:js>

	var map;
	var selectControl;
	
	var currentPopupGuid;
	var currentIvrGuid;
	var closedDialog = false;
	var closedPoiOverviewDialog = false;
	var centerRouteId = -1;
	var centerPoiId = -1;
	
	var longitude = <c:out value="${client.startLon}"/>;
	var latitude = <c:out value="${client.startLat}"/>;
	
	var poiLayer = new OpenLayers.Layer.Vector("Points of interest");	    	
	var iconSize = new OpenLayers.Size(24, 24);
	
	<%--
	$(document).bind("mobileinit", function(){
		$.mobile.ajaxEnabled(false);
	});
	
	$(window).unload(function(){
	 	$.mobile.hidePageLoadingMsg();
	});
	--%>
	
	<%-- create event listern for case of call to poi#mappage as bookmark --%>
	$("#mappage").live('pageshow', function() {
		//work around for closing dialogs
		//when dialogs are closed this event is fired an the map is recreated, but this shouldn't be
		if (!closedDialog) {
			createMap();
			createPoisOnMap(getVisiblePOIs(), centerPoiId);
			if (centerRouteId >= 0) {
				createRoutesOnMap([centerRouteId]);
				centerMapOnRoute(centerRouteId);
				centerRouteId = -1;
			} 
			else if (centerPoiId >= 0) {
				createRoutesOnMap(getVisibleRoutes());
				centerMapOnPoi(centerPoiId);
				centerPoiId = -1;
			} 
			else {
				createRoutesOnMap(getVisibleRoutes());
			}
		}
		else {
			closedDialog = false;
		}
	});
	
	$("#poi-overview").live('pagebeforeshow', function() {
		$("input.ui-input-text.ui-body-null").attr('placeholder', "<c:out value='${messagesPoiOverview.filter}'/>");
	});
	
	$("#poi-overview").live('pageshow', function(event, ui) {
		// ui.prevPage[0] will not be defined on first call with a bookmark, so the dummy is a work around for this situation
		var prevPage = "dummy";
		if (ui.prevPage[0]) {
			prevPage = ui.prevPage[0].id;	
		}
		// when comming back from mappage (e.g. browser back button), don't get POI and routes a second or third time
		if (!closedPoiOverviewDialog && prevPage != "mappage") {
			getRoutesWithPois();
			getUnassignedPois();
		}
		else {
			closedPoiOverviewDialog = false;
		}
	});
	
	<%--remove close icon from header--%>
	$("#optCategories").live('pagebeforeshow', function() {
		$("div.ui-corner-top.ui-overlay-shadow.ui-bar-a.ui-header > a").remove();
	});
	
	<%--remove close icon from header--%>
	$("#optProfiles").live('pagebeforeshow', function() {
		$("div.ui-corner-top.ui-overlay-shadow.ui-bar-a.ui-header > a").remove();
	});
	
	function getRoutesWithPois() {
		$.getJSON("<c:url value='/routes/${client.id}/${locale}'/>", function(data) {
			$.each(data, function(i, route) {
				var li_html = '<li data-theme="b" id="route-' + route.id + '" ><span class="ui-li-count" id="count-route-' + route.id + '">' + route.pois.length + '</span>';
				li_html += '<a href="#" onClick="submitMapRoute(' + route.id + ')">';
				li_html += '<h3><c:out value="${messagesPoiOverview.route}"/> ' + route.name + '</h3>';
				li_html += '<p>' + route.description + '</p>';
				if (route.length) {
					li_html += '<p class="ui-li-aside">(<c:out value="${messagesPoiOverview.length}"/>: ' + route.length + route.lengthUnit + ')</p>';					
				}
				li_html += '</a>'; 
				$.each(route.pois, function(j, poi) {
					li_html += '<li id="' + poi.id + '">';
					li_html += '<a href="#" onClick="submitMapPoi(' + poi.id +')">';
					li_html += '<img height="20px" width="20px" src="<c:url value="/resources/${client.url}/images/' + poi.icon + '"/>" class="ui-li-icon" alt="' + poi.name + '">';
					li_html += poi.name;
					li_html += '</a>';
					li_html += '</li>';
				});	
				li_html += '</li>';				
			    $("#poi-list").append(li_html);
			    $("#poi-list").listview('refresh');
			});
		});
	}
	
		
	function getUnassignedPois() {
		$.getJSON("<c:url value='/pois/${client.id}/${locale}'/>", function(pois) {
			var li_html = '<li data-role="list-divider" id="dummy-route"><span class="ui-li-count" id="count-dummy-route">' + pois.length + '</span>';
			li_html += '<h3><c:out value="${messagesPoiOverview.generalitems}"/></h3><p>&nbsp;</p>';
			$.each(pois, function(j, poi) {
					li_html += '<li id="' + poi.id + '">';
					li_html += '<a href="#" onClick="submitMapPoi(' + poi.id +')">';
					li_html += '<img height="20px" width="20px" src="<c:url value="/resources/${client.url}/images/' + poi.icon + '"/>" class="ui-li-icon" alt="' + poi.name + '">';
					li_html += poi.name;
					li_html += '</a>';
					li_html += '</li>';
			});
			li_html += '</li>';				
		    $("#poi-list").append(li_html);
		    $("#poi-list").listview('refresh');
		});
	}
	
	function geo_error(error) {
		if (error.code == 1) {
			alert("<c:out value='${messagesMap.gpserror1}'/>");
		}
		else if (error.code == 2) {
			alert("<c:out value='${messagesMap.gpserror2}'/>");
		}
		else if (error.code == 3) {
			alert("<c:out value='${messagesMap.gpserror3}'/>");
		}
		else {
			alert("<c:out value='${messagesMap.gpserror}'/>");
		}
		
	}
	
	function geo_success(position) {
		latitude = position.coords.latitude;
	  	longitude = position.coords.longitude;
	  	var lonLat = new OpenLayers.LonLat(longitude, latitude).transform(map.displayProjection,  map.projection);
	    map.setCenter (lonLat, <c:out value="${client.startZoom}"/>);
	    
	    var point = new OpenLayers.Geometry.Point(longitude, latitude);
		point.transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
		var iconFeature = new OpenLayers.Feature.Vector(point);
		iconFeature.style = {
				externalGraphic: "<c:url value='/resources/${client.url}/images/location_map.png'/>",
		        graphicXOffset:-iconSize.w/2,
		        graphicYOffset:-iconSize.h,
		        graphicWidth:iconSize.w,
		        graphicHeight:iconSize.h,
		        pointRadius:0
		};
		iconFeature.attributes = {
				"header": '<c:out value="${messagesMap.hereheader}"/>',
				"content": '<c:out value="${messagesMap.heretext}"/>' + "<br><br><a href='#' onClick='closedDialog = true;' data-role='button' data-rel='back' data-transition='pop'><c:out value='${messagesMap.closebutton}'/></a>"
				};
		poiLayer.addFeatures(iconFeature);
	}
	
	function createPoisOnMap(poiIds, localCenterPoiId) {
		var baseStyle = {
		        graphicXOffset:-iconSize.w/2,
		        graphicYOffset:-iconSize.h,
		        graphicWidth:iconSize.w,
		        graphicHeight:iconSize.h,
		        pointRadius:0
		        };
		var iconFeature;
		//just in case method is called more than once
		poiLayer.removeAllFeatures();
		for (var i=0; i<poiIds.length; i++) {
			$.getJSON("<c:url value='/poi/'/>" + poiIds[i], function(poi) {
				var point = new OpenLayers.Geometry.Point(poi.lon, poi.lat);
	    		point.transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
	    		iconFeature = new OpenLayers.Feature.Vector(point);
	    		iconFeature.fid = poi.id.toString();
	    		var icon = poi.icon;
	    		if (poi.id == localCenterPoiId) {
					icon = icon.replace(".png", "_selected.png");
					iconSize = new OpenLayers.Size(48, 48);
				}
	    		else {
	    			iconSize = new OpenLayers.Size(24, 24);
	    		}
				iconFeature.style = {
	    				externalGraphic: "<c:url value='/resources/${client.url}/images/'/>" + icon,
		    	        graphicXOffset:-iconSize.w/2,
		    	        graphicYOffset:-iconSize.h,
		    	        graphicWidth:iconSize.w,
		    	        graphicHeight:iconSize.h,
		    	        pointRadius:0
		    	};
	    		var tel_url = "";
		        if (poi.ivrNumber != "") {
					tel_url = "<a data-role='button' data-rel='external' data-icon='phone' data-iconpos='left' href='tel:" + poi.ivrNumber + "'><c:out value='${messagesMap.ivr_phone}'/></a>";
		        }
				
				var text_url = "";
		        if (poi.ivrTextUrl != "") {
					text_url = "<a data-role='button' data-icon='notepad' data-iconpos='left' href='#' onClick='openIvrPopup(\"<c:url value='/resources/${client.url}/ivr-html/'/>" + poi.ivrTextUrl + "\", \"" + poi.name + "\", \"<c:out value='${messagesMap.closebutton}'/>\")' ><c:out value='${messagesMap.ivr_text}'/></a>";
		        }
		        
		        var social = "";
		        <c:if test='${client.social}'>
			        var host =  window.location.hostname;
			        var twitter = "http://twitter.com/home?status=Das mobile Stadttor%20<c:out value='${client.name}'/>%20<c:out value='${client.shortUrl}'/>";
				    var facebook = 'http://www.facebook.com/sharer.php?u=http://'+host+"<c:url value='/${client.url}/${locale}/' />";
				    
				    social = "<br><a href='mailto:?subject=<c:out value='${client.name}'/>&body=http://"+host+"<c:url value='/${client.url}/${locale}/' />' data-icon='email' data-role='button' rel='external' data-transition='pop'>E-Mail</a>";
				    social += "<a href='" + twitter + "' target='_blank' data-icon='twitter' data-role='button' rel='external' data-transition='pop'>Twitter</a>";
				    social += "<a href='" + facebook + "' target='_blank' data-icon='facebook' data-role='button' rel='external' data-transition='pop'>Facebook</a>";
				    social += "<c:out value='${messagesMap.facebookprivacy}'/>";
				</c:if>
		        
		        var closebutton = "<br><br><a href='#' onClick='closedDialog = true;' data-role='button' data-rel='back' data-transition='pop'><c:out value='${messagesMap.closebutton}'/></a>";
				
				var poi_description = "";
				if (poi.description != "") {
					poi_description = poi.description + "<br>";
				}
		    	
		    	var content = poi_description + "<br>" + tel_url + text_url + social + closebutton;
		    	iconFeature.attributes = {
		    			"header": poi.name,
		    			"content": content
		    			};
		    	poiLayer.addFeatures(iconFeature);
			});
		}
	}

	
	function createRoutesOnMap(routeIds) {
		//remove all routes, just in case the method gets called more than once
		var routeLayers = map.getLayersByName(/^Route .*/);
		for (var i=0; i<routeLayers.length; i++) {
			map.removeLayer(routeLayers[i]);
		}
		
		for (var i=0; i<routeIds.length; i++) {
			$.getJSON("<c:url value='/route/'/>" + routeIds[i], function(route) {
	     		if (route.mapKML != "") {
		    		var lkml = new OpenLayers.Layer.Vector("Route " + route.name, {style: {strokeColor: route.color, strokeWidth: 5, strokeOpacity: 0.5},
	                 			projection: map.displayProjection,
	                 			strategies: [new OpenLayers.Strategy.Fixed()],
	                 			protocol: new OpenLayers.Protocol.HTTP({
	                     			url: "<c:url value='/resources/${client.url}/kml/'/>" + route.mapKML + "/",
	                     			format: new OpenLayers.Format.KML()
	                 			})
	             	});
		    		
		    		var routeIconLayer = new OpenLayers.Layer.Vector("Points of interest");
	    			var pointStart = new OpenLayers.Geometry.Point(route.startLon, route.startLat);
		    		pointStart.transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
		    		var iconFeatureStart = new OpenLayers.Feature.Vector(pointStart);
		    		iconFeatureStart.style = {
		    				externalGraphic: "<c:url value='/resources/${client.url}/images/start_flag.png'/>",
		    		        graphicXOffset:-iconSize.w/2,
		    		        graphicYOffset:-iconSize.h,
		    		        graphicWidth:iconSize.w,
		    		        graphicHeight:iconSize.h,
		    		        pointRadius:0
		    		};
		    		routeIconLayer.addFeatures(iconFeatureStart);		    		
		    		
		    		var pointEnd = new OpenLayers.Geometry.Point(route.endLon, route.endLat);
		    		pointEnd.transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
		    		var iconFeatureEnd = new OpenLayers.Feature.Vector(pointEnd);
		    		iconFeatureEnd.style = {
		    				externalGraphic: "<c:url value='/resources/${client.url}/images/finish_flag.png'/>",
		    		        graphicXOffset:-iconSize.w/2,
		    		        graphicYOffset:-iconSize.h,
		    		        graphicWidth:iconSize.w,
		    		        graphicHeight:iconSize.h,
		    		        pointRadius:0
		    		};
		    		routeIconLayer.addFeatures(iconFeatureEnd);
		    		
		    		map.addLayer(lkml);
		    		map.addLayer(routeIconLayer);
	     		}
			});
		}
	}
	
	function createMap() {
		// don't create map a second time
		if (map) { return false; }
		OpenLayers.Lang.setCode('de');
		<%-- must be explicitly set, otherwise ol would search for images and css in the wrong location --%>
		OpenLayers.ImgPath = "<c:url value='/resources/global/images/ol-images/'/>";
		OpenLayers.ThemePath = "<c:url value='/resources/global/css/ol-theme/'/>";
		
		var touchNav = new OpenLayers.Control.TouchNavigation({ dragPanOptions: {interval: 100, enableKinetic: true} });
		
		map = new OpenLayers.Map({
	        div: "mapdiv",
	        theme: null,
	        projection: new OpenLayers.Projection("EPSG:900913"),
	        displayProjection: new OpenLayers.Projection("EPSG:4326"),
	        units: "m",
	        numZoomLevels: 19,
	        maxResolution: 156543.0339,
	        maxExtent: new OpenLayers.Bounds(
	            -20037508.34, -20037508.34, 20037508.34, 20037508.34
	        ),
	        controls: [touchNav]
	    });
	    
	    var layerMapnik = new OpenLayers.Layer.OSM.Mapnik("OSM Standard (engl. Server)", { attribution: '', keyname: 'mapnik' });
	
	    map.addLayer(layerMapnik);
	 	var lonLat = new OpenLayers.LonLat(longitude, latitude).transform(map.displayProjection,  map.projection);
	    map.setCenter (lonLat, <c:out value="${client.startZoom}"/>); <%-- Zoomstufe einstellen--%>
	    
	    <%-- don't call in getPois(), otherwise the layer is added multiple times and the event is registered multiple times--%>
	    poiLayer.events.register("featureselected", poiLayer, openPopup);
	    map.addLayer(poiLayer);
	    
	    selectControl = new OpenLayers.Control.SelectFeature(poiLayer);
	    map.addControl(selectControl);
	    selectControl.activate();
	}

	

		<c:forEach var="category" items="${poiCategories}">
			$("#checkbox-category-<c:out value='${category.id}'/>").live("change", function() { changeSelected("<c:out value='${category.shortName}'/>"); });
		</c:forEach>
		
		<c:forEach var="profile" items="${profiles}">
			$("#checkbox-profile-<c:out value='${profile.id}'/>").live("change", function() { changeSelected("<c:out value='${profile.shortName}'/>"); });
		</c:forEach>
		
		var numVisiblePois = new Array();
		var routePois = new Array();
		<c:forEach var="route" items="${routes}">
			numVisiblePois["route-<c:out value='${route.id}'/>"] = <c:out value='${fn:length(route.pois)}'/>;
			<%--
			<c:forEach var="poi" items="${route.pois}">
				<%-- one POI can be associated with multiple routes --%>
				<%-- first initialize, otherwise push will throw error --%>
				<%--
				routePois["<c:out value='${poi.id}'/>"] = [];
			</c:forEach>
			--%>
			<c:forEach var="poi" items="${route.pois}">
				routePois["<c:out value='${poi.id}'/>"] = "route-<c:out value='${route.id}'/>";
				<%-- one POI can be associated with multiple routes --%>
				//routePois["<c:out value='${poi.id}'/>"].push("route-<c:out value='${route.id}'/>");
				//numVisiblePois["route-<c:out value='${route.id}'/>"] += 1;
			</c:forEach>
		</c:forEach>
		numVisiblePois["dummy-route"] = <c:out value='${fn:length(pois)}'/>;
		<c:forEach var="poi" items="${pois}">
			routePois["<c:out value='${poi.id}'/>"] = "dummy-route";
			<%-- one POI can be associated with multiple routes --%>
			//routePois["<c:out value='${poi.id}'/>"].push("route-<c:out value='${route.id}'/>");
			//numVisiblePois["dummy-route"] += 1;
		</c:forEach>
		
		<c:forEach var="profile" items="${profiles}">
			var <c:out value="${profile.shortName}"/>Pressed = false;
			var <c:out value="${profile.shortName}"/>Array = [<c:out value='${profile.nonUsablePoiIds}'/>];
			
			function runEffect<c:out value="${profile.shortName}"/>() {
				<%-- most effect types need no options passed by default--%>
				var options = {};

				<%-- run the effect--%>
				for (i=0;i<<c:out value="${profile.shortName}"/>Array.length;i++) {
					<%-- das && visible ist noetig, damit elemente nicht doppelt versteckt werden, was in der oberflaeche sehr unschoen aussieht--%>
					<%-- mit jQm ist visible scheinbar anders gesetzt --%>
					<%--if (<c:out value="${profile.shortName}"/>Pressed && $("#" + <c:out value="${profile.shortName}"/>Array[i].toString()).is(':visible')) {--%>
					if (<c:out value="${profile.shortName}"/>Pressed) {
						if ($( "#" + <c:out value="${profile.shortName}"/>Array[i].toString() ).css('display') != 'none') {
							$( "#" + <c:out value="${profile.shortName}"/>Array[i].toString() ).hide( "blind", options, 500);
							if (routePois[<c:out value="${profile.shortName}"/>Array[i].toString()]) {
			   					var routeName = routePois[<c:out value="${profile.shortName}"/>Array[i].toString()].toString();
			   					numVisiblePois[routeName] -= 1;
								$("#count-" + routeName).html(numVisiblePois[routeName]);
			   				}
						}
					}
					else if (!<c:out value="${profile.shortName}"/>Pressed) {
						if (
							<c:forEach var="profile2" items="${profiles}">
								<c:if test='${profile2.shortName != profile.shortName}'>
									(!<c:out value="${profile2.shortName}"/>Pressed || (<c:out value="${profile2.shortName}"/>Pressed && <c:out value="${profile2.shortName}"/>Array.indexOf(<c:out value="${profile.shortName}"/>Array[i]) == -1)) &&
								</c:if>
							</c:forEach>
							true && (
							<c:forEach var="category" items="${poiCategories}">
								(<c:out value="${category.shortName}"/>Pressed && <c:out value="${category.shortName}"/>Array.indexOf(<c:out value="${profile.shortName}"/>Array[i]) != -1) ||
							</c:forEach>
							<%-- das false ist noetig, damit das letzte || nicht abgeschnitten werden muss--%>
							false || (
							<c:forEach var="category" items="${poiCategories}">
								!<c:out value="${category.shortName}"/>Pressed &&
							</c:forEach>
							true))) {
							if ($( "#" + <c:out value="${profile.shortName}"/>Array[i].toString() ).css('display') == 'none') {
								$( "#" + <c:out value="${profile.shortName}"/>Array[i].toString() ).show( "blind", options, 500);
								if (routePois[<c:out value="${profile.shortName}"/>Array[i].toString()]) {
				   					var routeName = routePois[<c:out value="${profile.shortName}"/>Array[i].toString()].toString();
				   					numVisiblePois[routeName] += 1;
									$("#count-" + routeName).html(numVisiblePois[routeName]);
				   				}
							}
						}
					}
				}
			};
			
		</c:forEach>
		
		<c:forEach var="category" items="${poiCategories}">
			var <c:out value="${category.shortName}"/>Pressed = false;
			var <c:out value="${category.shortName}"/>Array = [<c:out value='${category.pois}'/>];
			
			
			function runEffect<c:out value="${category.shortName}"/>() {
				<%-- most effect types need no options passed by default--%>
				var options = {};

				<%-- knopf wird gedrückt und kein anderer ist gedrückt--%>
				if (<c:out value="${category.shortName}"/>Pressed &&
						<c:forEach var="category2" items="${poiCategories}">
							<c:if test='${category2.shortName != category.shortName}'>
								!<c:out value="${category2.shortName}"/>Pressed && 
							</c:if>
						</c:forEach>
						true) {
					var arrElements = document.getElementsByTagName("li");

					for (var i=0; i<arrElements.length; i++) {
						//if (!arrElements[i].id.match("route.*") && !arrElements[i].id.match("nav.*") && !arrElements[i].id.match("button.*")) {
						if (arrElements[i].id.match(/^\d+$/)) {
							if ((<c:out value="${category.shortName}"/>Array.indexOf(parseInt(arrElements[i].id)) == -1) &&
								<c:forEach var="category2" items="${poiCategories}">
									<c:if test='${category2.shortName != category.shortName}'>
										(!<c:out value="${category2.shortName}"/>Pressed || (<c:out value="${category2.shortName}"/>Pressed && <c:out value="${category2.shortName}"/>Array.indexOf(parseInt(arrElements[i].id)) != -1)) && 
									</c:if>
								</c:forEach>									
									true) {
								if ($( "#" + arrElements[i].id ).css('display') != 'none') {
					   				$( "#" + arrElements[i].id ).hide( "blind", options, 0);
					   				<%--remove from array of visible elemnts--%>
					   				if (routePois[arrElements[i].id.toString()]) {
					   					var routeName = routePois[arrElements[i].id.toString()].toString();
					   					numVisiblePois[routeName] -= 1;
										$("#count-" + routeName).html(numVisiblePois[routeName]);
						   			}
								}
							}
						}
				   	}
				}
				<%-- es ist bereits eine andere kategorie aktiv--%>
				else if (<c:out value="${category.shortName}"/>Pressed && (
						<c:forEach var="category2" items="${poiCategories}">
							<c:if test='${category2.shortName != category.shortName}'>
								<c:out value="${category2.shortName}"/>Pressed ||
							</c:if>
						</c:forEach>
						false)) {
					for (i=0;i<<c:out value="${category.shortName}"/>Array.length;i++) {
						if (
								<c:forEach var="profile" items="${profiles}">
									(!<c:out value="${profile.shortName}"/>Pressed || (<c:out value="${profile.shortName}"/>Pressed && <c:out value="${profile.shortName}"/>Array.indexOf(<c:out value="${category.shortName}"/>Array[i]) == -1)) &&
								</c:forEach>
									<%-- das true ist noetig, damit ich das letzte && nicht abschneiden muss--%>							
								true) {
							if ($( "#" + <c:out value="${category.shortName}"/>Array[i].toString() ).css('display') == 'none') {
								$( "#" + <c:out value="${category.shortName}"/>Array[i].toString() ).show( "blind", options, 0);
								if (routePois[<c:out value="${category.shortName}"/>Array[i].toString()]) { 
									var routeName = routePois[<c:out value="${category.shortName}"/>Array[i].toString()].toString();
									numVisiblePois[routeName] += 1;
									$("#count-" + routeName).html(numVisiblePois[routeName]);
								}
							}
						}
					}
				}
				<%-- "knopf wurde losgelassen"--%>
				else {
					<%-- etwas anderes gedrückt, nur diese Kategorie ausblenden--%>
					if (<c:forEach var="category2" items="${poiCategories}">
							<c:if test='${category2.shortName != category.shortName}'>
								<c:out value="${category2.shortName}"/>Pressed ||
							</c:if>
						</c:forEach>
						<%-- mit dem false brauche ich das letzte || nicht abschneiden--%>
						false) {
						for (i=0;i<<c:out value="${category.shortName}"/>Array.length;i++) {
							if ($( "#" + <c:out value="${category.shortName}"/>Array[i].toString() ).css('display') != 'none') {
								$( "#" + <c:out value="${category.shortName}"/>Array[i].toString() ).hide( "blind", options, 0);
								if (routePois[<c:out value="${category.shortName}"/>Array[i].toString()]) {
									var routeName = routePois[<c:out value="${category.shortName}"/>Array[i].toString()].toString(); 
									numVisiblePois[routeName] -= 1;
									$("#count-" + routeName).html(numVisiblePois[routeName]);
								}
							}
						}
					}
					else {
						<%-- nichts gedrückt => alles einblenden (profiles checken)--%>
						<%-- es ist kein Kategorieknopf gedrueckt, alles wieder einblenden, was nicht durch eine Einschraenkung ausgeblendet ist--%>
						var arrElements = document.getElementsByTagName("li");
					   	for (var i=0; i<arrElements.length; i++) {
					   		var element = arrElements[i];
						<%-- parseInt(element.id) ist noetig, da element.id einen String liefert, im Array aber Integer sind--%>
					   		if (
					   		<c:forEach var="profile" items="${profiles}">
								(!<c:out value="${profile.shortName}"/>Pressed || (<c:out value="${profile.shortName}"/>Pressed && <c:out value="${profile.shortName}"/>Array.indexOf(parseInt(element.id)) == -1)) &&
							</c:forEach>
					   			true) {
					   			if ($( "#" + element.id ).css('display') == 'none') {
						   			$( "#" + element.id ).show("blind", options, 0);
						   			if (routePois[element.id.toString()]) {
						   				var routeName = routePois[element.id.toString()].toString();
										numVisiblePois[routeName] += 1;
										$("#count-" + routeName).html(numVisiblePois[routeName]);
						   			}
					   			}
					   		}
					   	}
					}
				}
				return false;
			};
			
			
		</c:forEach>

		<%--
		wenn die Funktion aus runEffect aufgerufen wird klappt es nicht
		werden die visible Attribute evtl. erst richtig gesetzt, wenn eine Funktion abgeschlossen ist?
		auch mit eigener Funktion klappt es nicht
		kann ich das evtl. über die callback funtion von hide/show machen? Könnte einige Loops sparen
				--%>
		function verifyRoutesVisible() {
			var options = {};
			<%-- funktioniert das auch? 
			$("#content li:visible")--%>
			var arrElements = document.getElementsByTagName("li");
		    <%-- hide routes which don't have visible pois  --%>
		   	for (var i=0; i<arrElements.length; i++) {
		   		var element = arrElements[i];
				<%-- Kann ich daraus direkt ein getElementsById("route.*") machen? --%>
		   		if (element.id.match(/^route.*/)) {
		   			if (numVisiblePois[element.id.toString()] == 0) {
		   				<%-- bei jQm gibt das Probleme --%>
		   				//if ($( "#" + element.id ).is(":visible")) {
		   				if ($( "#" + element.id ).css('display') != 'none') {
				   			$( "#" + element.id ).hide( "blind", options, 0);
				   		}
		   			}
		   			else {
		   				if ($( "#" + element.id ).css('display') == 'none') {
			   				$( "#" + element.id ).show( "blind", options, 0);
			   			}
		   			}
		   		}
		   	}
		   	return false;
		};
	
	function getVisibleRoutes() {
		//nothing selected, so return all items (special case, when poi#mappage is called with bookmark)
		if (<c:forEach var="category" items="${poiCategories}">
				!<c:out value="${category.shortName}"/>Pressed &&
			</c:forEach>
			<c:forEach var="profile" items="${profiles}">
				!<c:out value="${profile.shortName}"/>Pressed &&
			</c:forEach>
			true) {
			return getLoadedRoutes();
		}
		var arrElements = document.getElementsByTagName("li");
		var visibleRoutes = [];
	   	for (var i=0; i<arrElements.length; i++) {
	   		var element = arrElements[i];
			
			<%-- in case a li element has no id--%>
			if (!element.id == "") {
		   		//if ($( "#" + element.id ).is(':visible') && element.id.match(/^route.*/)) {
		   		if (($( "#" + element.id ).css('display') != 'none') && element.id.match(/^route.*/)) {
					visibleRoutes.push(element.id.substring(element.id.indexOf("-") + 1));		   			
		   		}
			}
	   	}
		return visibleRoutes;
	};
	
	function getLoadedRoutes() {
		var arrElements = document.getElementsByTagName("li");
	      
		var loadedRoutes = [];
	   	for (var i=0; i<arrElements.length; i++) {
	   		var element = arrElements[i];
			
			<%-- in case a li element has no id--%>
			if (!element.id == "") {
		   		if (element.id.match(/^route.*/)) {
					loadedRoutes.push(element.id.substring(element.id.indexOf("-") + 1));		   			
		   		}
			}
	   	}
		return loadedRoutes;
	};
	
	function getVisiblePOIs() {
		//nothing selected, so return all items (special case, when poi#mappage is called with bookmark)
		if (<c:forEach var="category" items="${poiCategories}">
				!<c:out value="${category.shortName}"/>Pressed &&
			</c:forEach>
			<c:forEach var="profile" items="${profiles}">
				!<c:out value="${profile.shortName}"/>Pressed &&
			</c:forEach>
			true) {
			return getLoadedPOIs();
		}
		
		
		var arrElements = document.getElementsByTagName("li");
		var visiblePOIs = [];
	   	for (var i=0; i<arrElements.length; i++) {
	   		var element = arrElements[i];
			
			<%-- in case a li element has no id--%>
			if (!element.id == "") {
		   		if (($( "#" + element.id ).css('display') != 'none') && element.id.match(/^\d+$/)) {
		   			visiblePOIs.push(element.id);
		   		}
			}
	   	}
		return visiblePOIs;
	};
	
	function getLoadedPOIs() {
		var arrElements = document.getElementsByTagName("li");
	      
		var loadedPOIs = [];
	   	for (var i=0; i<arrElements.length; i++) {
	   		var element = arrElements[i];
			
			<%-- in case a li element has no id--%>
			if (!element.id == "") {
		   		if (element.id.match(/^\d+$/)) {
		   			loadedPOIs.push(element.id);
		   		}
			}
	   	}
		return loadedPOIs;
	};
	
	function changeSelected(name) {
		window[name + 'Pressed'] = !window[name + 'Pressed'];
		window["runEffect" + name]();
		verifyRoutesVisible();				
		return false;
	};

	function submitMap() {
		$.mobile.changePage("#mappage", "pop");
		return false;
	};

	function submitMapRoute(routeId) {
		centerRouteId = routeId;
		$.mobile.changePage("#mappage", "pop");
		return false;
	};
	
	function submitMapPoi(poiId) {
		centerPoiId = poiId;
		$.mobile.changePage("#mappage", "pop");
		return false;
	};
	
	function centerMapOnPoi(poiId) {
		$.getJSON("<c:url value='/poi/'/>" + poiId + "/", function(poi) {
			var lonLat = new OpenLayers.LonLat(poi.lon, poi.lat).transform(map.displayProjection, map.projection);
			map.setCenter (lonLat, <c:out value="${client.startZoom}"/>);
		});
	}
	
	function centerMapOnRoute(routeId) {
		$.getJSON("<c:url value='/route/'/>" + routeId + "/", function(route) {
			var lonLat = new OpenLayers.LonLat(route.startLon, route.startLat).transform(map.displayProjection,  map.projection);
			map.setCenter (lonLat, <c:out value="${client.startZoom}"/>);
		});
	}
	
</compress:js>
</script>

<jsp:include page="footer.jsp"/>
</body>
</html>