<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta http-equiv="Content-Language" content="${locale}">
		<title><c:out value="${messagesHome.title}"/></title>
		<style type="text/css">
		<compress:css>
			#poi-mapdiv {
				position: absolute;
			    right: 0px;
			    width: 100%;
			    height: 400px;
			    padding: 1px;
			}
			
			#route-mapdiv {
				position: absolute;
			    right: 0px;
			    width: 100%;
			    height: 400px;
			    padding: 1px;
			}
			
			div.left-column {
				width: 50%;
				position: absolute;
				display: block;
				left: 0;
				background-color: #dddddd;
			}
			div.right-column {
				width: 50%;
				position: absolute;
				display: block;
				right: 0;
				background-color: #dddddd;
			}
			#colorSelector {
				position: relative;
				width: 36px;
				height: 36px;
				background: url(<c:url value='/resources/global/images/select.png'/>);
			}
			#colorSelector div {
				position: absolute;
				top: 3px;
				left: 3px;
				width: 30px;
				height: 30px;
				background: url(<c:url value='/resources/global/images/select.png'/>) center;
			}
			.alignright {
				float: right;
			}
			.alignleft {
				float: left;
			}
			.row-even {
				background: #dddddd;
			}
			.row-odd {
				background: #fafafa;
			}
		</compress:css>
		</style>
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/jquery-ui-1.8.16.custom.css'/>" >
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/ol-theme/default/style.css'/>" >
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/colorpicker.css'/>" />
</head>
<body>
	
	<div>
		<button>
			<a href="<c:url value='/j_spring_security_logout' />">Logout</a>
		</button>
	</div>
	
	<div id="tabs">
		<ul>
			<li><a href="#tabs-pois">Pois</a></li>
			<li><a href="#tabs-routes">Routes</a></li>
			<li><a href="#tabs-poi-categories">Kategorien</a></li>
			<%--
			<li><a href="#tabs-languages">Sprachen + Texte</a></li>
			<li><a href="#tabs-clients">Klienten</a></li>
			<li><a href="#tabs-users">CMS - Userverwaltung</a></li>
			--%>
		</ul>
		<div id="tabs-pois">
			<sec:authorize access="hasRole('publishPoi')">
				<%--<div class="alignright">--%>
				<div>
					<button>
						<a href="#" onClick="publishAllPois()">
							<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
						</a>
						Alle POIs veröffentlichen
					</button>
				</div>
			</sec:authorize>		
			<div class="left-column">
				<table id="poi-list" border="0" width="100%">
					<c:forEach var="poi" items="${pois}" varStatus="status">
						<c:choose>
						  	<c:when test="${status.count % 2 == 0}">
						    	<tr class="row-even" id="poi-<c:out value='${poi.id}'/>">
						  	</c:when>
						  	<c:otherwise>
						    	<tr class="row-odd" id="poi-<c:out value='${poi.id}'/>">
						  	</c:otherwise>
						</c:choose>
							<td><c:out value='${poi.name}'/></td>
								<sec:authorize access="hasRole('changePoi')">
									<td>
									<a href="#" onClick="editPoi(<c:out value='${poi.id}'/>, false)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-document-edit-icon.png'/>" alt="Editieren">								
									</a>
									</td>
								</sec:authorize>
								<sec:authorize access="hasRole('createPoi')">
									<td>
									<a href="#" onClick="editPoi(<c:out value='${poi.id}'/>, true)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-edit-copy-icon.png'/>" alt="Kopieren">								
									</a>
									</td>
								</sec:authorize>
								<sec:authorize access="hasRole('deletePoi')">
									<td>
									<a href="#" onClick="deletePoi(<c:out value='${poi.id}'/>)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-edit-delete-shred-icon.png'/>" alt="Löschen">								
									</a>
									</td>
								</sec:authorize>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<div class="right-column" id ="poidiv">
				<form id="poiForm">
					<div data-role="fieldcontain">
						<input type="hidden" name="id" id="poi-id" value=""  />
						<input type="hidden" name="id" id="poi-published" value=""  />
						<input type="hidden" name="clientId" id="poi-client-id" value=""  />
					    <label for="name">Name</label>
					    <input type="text" size="30" name="name" id="poi-name" value=""  />
					    <label for="locale" class="select">Sprache</label>
						<select name="locale" id="poi-locale">
						</select>
					    <br>
					    <label for="description">Beschreibung</label>
					    <textarea name="description" cols="40" rows="5" id="poi-description"></textarea>
					    <br>
					    <label for="ivrNumber">IVR Nummer</label>
					    <input type="text" size="15" name="ivrNumber" id="poi-ivr-number" value=""  />
					    <br>
					    <label for="ivrTextUrlL">IVR Text URL</label>
					    <input type="text" size="15" name="ivrTextUrl" id="poi-ivr-text-url" value="" readonly />
					    <br>
					    <div id="container-ivrtext">
							<div id="filelist-ivrtext">Browser unterstütz leider keinen Dateiupload.</div>
							<br />
							<a id="pickfiles-ivrtext" href="#">[HTML Datei auswählen]</a>
							<a id="uploadfiles-ivrtext" href="#">[Dateien hochladen]</a>
						</div>
						<br>
					    <label for="lon">Längengrad</label>
					    <input type="text" size="10" name="lon" id="poi-lon" value=""  />
					    <label for="lat">Breitengrad</label>
					    <input type="text" size="10" name="lat" id="poi-lat" value=""  />
					    <br>
					    <label for="routeId" class="select">Route:</label>
						<select name="routeId" id="poi-route">
						<%-- will be filled by javascript --%>
						</select>
						<label for="poiCategoryId" class="select">Kategorie:</label>
						<select name="poiCategoryId" id="poi-category">
						<%-- will be filled by javascript --%>
						</select>
						<img id="poi-icon" height="24px" width="24px" src="" alt="">
						<br>
						<fieldset data-role="controlgroup">
							<legend>Profile: (für diese Personengruppen ist der Punkt <u>nicht</u> geeignet)</legend>
							<div id="poi-profiles" name="profileIds">
							<%-- will be filled by javascript --%>
							</div>
					    </fieldset>
					</div>
					<button>
						<a href="#" onClick="savePoi()">Speichern</a>
					</button>
					<sec:authorize access="hasRole('publishPoi')">
						<button id="poi-publish" >
							<a href="#" onClick="publishPoi()">
								<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
							</a>
							Publizieren
						</button>
						<div id="poi-status"></div>
					</sec:authorize>
				</form>
				
				<div id="poi-mapdiv"> 
		              <noscript></noscript> 
		        </div>
				
			</div>
		</div>
		
		
		<div id="tabs-routes">
			<sec:authorize access="hasRole('publishRoute')">
				<%--<div class="alignright">--%>
				<div>
				<button>
					<a href="#" onClick="publishAllRoutes()">
						<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
					</a>
					Alle Routen veröffentlichen
				</button>
				</div>
			</sec:authorize>
			<div class="left-column">
				<table id="route-list" width="100%" border="0">
					<c:forEach var="route" items="${routes}" varStatus="status">
						<c:choose>
						  	<c:when test="${status.count % 2 == 0}">
						    	<tr class="row-even" id="route-<c:out value='${route.id}'/>">
						  	</c:when>
						  	<c:otherwise>
						    	<tr class="row-odd" id="route-<c:out value='${route.id}'/>">
						  	</c:otherwise>
						</c:choose>
							<td><c:out value='${route.name}'/></td>
							<sec:authorize access="hasRole('changeRoute')">
								<td>
								<a href="#" onClick="editRoute(<c:out value='${route.id}'/>, false)">
									<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-document-edit-icon.png'/>" alt="Editieren">								
								</a>
								</td>
							</sec:authorize>
							<sec:authorize access="hasRole('createRoute')">
								<td>
								<a href="#" onClick="editRoute(<c:out value='${route.id}'/>, true)">
									<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-edit-copy-icon.png'/>" alt="Kopieren">								
								</a>
								</td>
							</sec:authorize>
							<sec:authorize access="hasRole('deleteRoute')">
								<td>
								<a href="#" onClick="deleteRoute(<c:out value='${route.id}'/>)">
									<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-edit-delete-shred-icon.png'/>" alt="Löschen">								
								</a>
								</td>
							</sec:authorize>
						</tr>
					</c:forEach>
				</table>		
			</div>
			
			<div class="right-column" id ="routediv">
				<div data-role="fieldcontain">
					<form id="routeForm">
						<input type="hidden" name="id" id="route-id" value=""  />
						<input type="hidden" name="id" id="route-published" value=""  />
						<input type="hidden" name="clientId" id="route-client-id" value=""  />
					    <label for="name">Name</label>
					    <input type="text" name="name" id="route-name" value=""  />
					    <label for="locale" class="select">Sprache</label>
						<select name="locale" id="route-locale">
						</select>
					    <br>
					    <label for="description">Beschreibung</label>
					    <textarea name="description" cols="40" rows="3" id="route-description"></textarea>
					    <br>
					    <label for="length">Länge</label>
					    <input type="text" size="5" name="length" id="route-length" value=""  />
					    <label for="lengthUnit">Einheit</label>
					    <input type="text" size="4" name="lengthUnit" id="route-length-unit" value=""  />
					    <br>
					    <label for="color">Farbe</label>
					    <input type="text" name="color" id="route-color" value=""  />
					    <div id="colorSelector">
					    	<div style="background-color: #0000ff">
					    	</div>
					    </div>
					    <fieldset data-role="controlgroup">
							<legend>Startpunkt:</legend>
							    <label for="startLon">Längengrad</label>
							    <input type="text" size="10" name="startLon" id="route-start-lon" value=""  />
							    <label for="startLat">Breitengrad</label>
							    <input type="text" size="10" name="startLat" id="route-start-lat" value=""  />
						</fieldset>
						<fieldset data-role="controlgroup">
							<legend>Endpunkt:</legend>
							    <label for="endLon">Längengrad</label>
							    <input type="text" size="10" name="endLon" id="route-end-lon" value=""  />
							    <label for="endLat">Breitengrad</label>
							    <input type="text" size="10" name="endLat" id="route-end-lat" value=""  />
						</fieldset>
						<br>
						<label for="mapKML">KML Datei</label>
						<input type="text" size="30" name="mapKML" id="route-kml-file" value="" readonly />
						<div id="container-kml">
							<div id="filelist-kml">Browser unterstütz leider keinen Dateiupload.</div>
							<br />
							<a id="pickfiles-kml" href="#">[KML Datei auswählen]</a>
							<a id="uploadfiles-kml" href="#">[Dateien hochladen]</a>
						</div>
						<button>
							<a href="#" onClick="saveRoute()">Speichern</a>
						</button>
						<sec:authorize access="hasRole('publishRoute')">
							<button id="route-publish">
								<a href="#" onClick="publishRoute()">
									<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
								</a>
								Publizieren
							</button>
							<div id="route-status"></div>
						</sec:authorize>
					</form>
					<div id="route-mapdiv"> 
		              <noscript></noscript> 
		        	</div>
				</div>
				
			</div>
		</div>
		
		<div id="tabs-poi-categories">
			<sec:authorize access="hasRole('publishCategory')">
				<%--<div class="alignright">--%>
				<div>
				<button>
				<a href="#" onClick="publishAllCategories()">
					<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
				</a>
				Alle Kategorien veröffentlichen
				</button>
				</div>
			</sec:authorize>
			<div class="left-column">
				<table id="category-list" border="0" width="100%">
					<c:forEach var="category" items="${categories}" varStatus="status">
						<c:choose>
						  	<c:when test="${status.count % 2 == 0}">
						    	<tr class="row-even" id="category-<c:out value='${category.id}'/>">
						  	</c:when>
						  	<c:otherwise>
						    	<tr class="row-odd" id="category-<c:out value='${category.id}'/>">
						  	</c:otherwise>
						</c:choose>
							<td><c:out value='${category.name}'/></td>
								<sec:authorize access="hasRole('changeCategory')">
									<td>
									<a href="#" onClick="editCategory(<c:out value='${category.id}'/>, false)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-document-edit-icon.png'/>" alt="Editieren">								
									</a>
									</td>
								</sec:authorize>
								<sec:authorize access="hasRole('createCategory')">
									<td>
									<a href="#" onClick="editCategory(<c:out value='${category.id}'/>, true)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-edit-copy-icon.png'/>" alt="Kopieren">								
									</a>
									</td>
								</sec:authorize>
								<sec:authorize access="hasRole('deleteCategory')">
									<td>
									<a href="#" onClick="deleteCategory(<c:out value='${category.id}'/>)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-edit-delete-shred-icon.png'/>" alt="Löschen">								
									</a>
									</td>
								</sec:authorize>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<div class="right-column" id ="categorydiv">
				<form id="categoryForm">
					<input type="hidden" name="id" id="category-id" value=""  />
					<input type="hidden" name="id" id="category-published" value=""  />
					<img id="category-icon" name="icon" height="24px" width="24px" src="" alt="">
					<img id="category-icon-selected" height="48px" width="48px" src="" alt="">
					<br>
				    <label for="name">Name</label>
				    <input type="text" name="name" id="category-name" value=""  />
				    <label for="locale" class="select">Sprache</label>
					<select name="locale" id="category-locale">
					</select>
					<label for="clientId" class="select">Kunde</label>
					<select name="clientId" id="category-client">
					</select>
				    <br>
				    <label for="shortName" class="select">Kurzname (wird für den Programmablauf benötigt)</label>
				    <input type="text" name="shortName" id="category-shortname" value=""  />
				    <br>
					<label for="icon" class="select">Dateiname</label>
					<input type="text" name="icon" id="category-icon-name" value="" readonly />
					<div id="container-category">
						<div id="filelist-category">Browser unterstütz leider keinen Dateiupload.</div>
						<br />
						<a id="pickfiles-category" href="#">[Icon Dateien auswählen]</a>
						<a id="uploadfiles-category" href="#">[Dateien hochladen]</a>
					</div>
					<button>
						<a href="#" onClick="saveCategory()">Speichern</a>
					</button>
					<sec:authorize access="hasRole('publishCategory')">
						<button id="poi-category-publish">
							<a href="#" onClick="publishCategory()">
								<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
							</a>
							Publizieren
						</button>
						<div id="poi-category-status"></div>
					</sec:authorize>
				</form>
				
			</div>
						
		</div>
		
		<%--
		<div id="tabs-languages">
		</div>
		
		<div id="tabs-clients">
		</div>
		
		<div id="tabs-users">
		</div>
		--%>
	</div>

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/colorpicker.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/json.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/OpenLayers.js'/>" ></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/OpenStreetMap-min.js'/>" ></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/cms-min.js'/>" ></script>
	<!-- Third party script for BrowserPlus runtime (Google Gears included in Gears runtime now) -->
	<script type="text/javascript" src="http://bp.yahooapis.com/2.4.21/browserplus-min.js"></script>
	<!-- Load plupload and all it's runtimes and finally the jQuery queue widget -->
	<script type="text/javascript" src="<c:url value='/resources/global/js/plupload/js/plupload.full.js'/>" ></script>
	
	<script>
	<compress:js>
	
		var poimap;
		var routemap;
		var selectControl;
		var uploaderKML;
		var uploaderCategory;
		var poiLayer = new OpenLayers.Layer.Vector("Points of interest");
		var iconSize = new OpenLayers.Size(24, 24);
	
		var clients = new Array();
		var languages = new Array();
		var poicategories = new Array();
		
		
		
		function getClientsAndTheirData() {
			$.getJSON("<c:url value='/clients'/>", function(tmpClients) {
				$.each(tmpClients, function(i, client) {
					clients[client.id] = client;
					$.getJSON("<c:url value='/languages/'/>" + client.id, function(tempLanguages) {
						var tempLangArray = new Array();
						$.each(tempLanguages, function(i, language) {
							tempLangArray.push(language);
						});
						languages[client.id] = tempLangArray; 
					});
				});
			});
		}
		
		function editPoi(poiId, copy) {
			$.getJSON("<c:url value='/poi/'/>" + poiId, function(poi) {
				$("#poidiv").css('backgroundColor', $("#poi-" + poiId).css('backgroundColor'));
				$("#poi-id").val(poi.id);
				$("#poi-client-id").val(poi.clientId);
				$("#poi-name").val(poi.name);
				$("#poi-description").val(poi.description);
				$("#poi-ivr-number").val(poi.ivrNumber);
				$("#poi-lon").val(poi.lon);
				$("#poi-lat").val(poi.lat);
				var iconFeature;
				poiLayer.removeAllFeatures();
				var point = new OpenLayers.Geometry.Point(poi.lon, poi.lat);
	    		point.transform(new OpenLayers.Projection("EPSG:4326"), poimap.getProjectionObject());
	    		iconFeature = new OpenLayers.Feature.Vector(point);
	    		iconFeature.fid = poi.id.toString();
	    		var icon = poi.icon;
	    		var client = clients[poi.clientId];
				iconFeature.style = {
	    				externalGraphic: "<c:url value='/resources/'/>" + client.url + "/images/" + icon,
		    	        graphicXOffset:-iconSize.w/2,
		    	        graphicYOffset:-iconSize.h,
		    	        graphicWidth:iconSize.w,
		    	        graphicHeight:iconSize.h,
		    	        pointRadius:0
		    	};
				var content = "";
		    	iconFeature.attributes = {
		    			"header": poi.name,
		    			"content": content
		    			};
		    	poiLayer.addFeatures(iconFeature);
				var lonLat = new OpenLayers.LonLat(poi.lon, poi.lat).transform(poimap.displayProjection, poimap.projection);
			    poimap.setCenter (lonLat, 15); <%-- Zoomstufe einstellen--%>
				updatePoiRoutes(poi.clientId, poi.locale, poi.routeId);
				$.getJSON("<c:url value='/poicategory/poi/'/>" + poi.id, function(category) {
					$("#poi-icon").attr("src", "<c:url value='/resources/'/>" + client.url + "/images/" + category.icon);
					$("#poi-icon").attr("alt", category.name);
					updatePoiCategories(poi.clientId, poi.locale, category.id);
				});
				updatePoiProfiles(poi.locale);
				<%-- set asigned profiles for this poi --%>
				var profileArray = [];
				$.each(poi.poiProfileIds, function(i, profileId) {
					profileArray.push(profileId);
				});
				$("#poi-profiles").val(profileArray);
				var langOptions = "";
				$.each(languages[poi.clientId], function(i, lang) {
					langOptions += '<option value="' + lang.shortName + '">' + lang.name + '</option>';
				});
				$("#poi-locale").html(langOptions);
				$("#poi-locale").val(poi.locale);
				if (copy) {
					$("#poi-id").val(0);
					poi.published = 0;
					$("#poi-published").val(0);
				}
				if (poi.published > 0) {
					$("#poi-status").html("Veröffentlicht!");
					$("#poi-publish").hide();
				}
				else {
					$("#poi-status").html("Noch nicht veröffentlicht!");
					$("#poi-publish").show();
				}
				$("poidiv").show();
				createUploaderIVRText('<c:url value="/upload/"/>' + poi.clientId + '/ivrtext');
			});
		}
		
		function deletePoi(poiId) {
			$.ajax({
				   type: "DELETE",
				   url: "<c:url value='/poi/'/>" + poiId,
				   success: function(msg){
				     alert( "Data Saved: " + msg );
				     $("#poi-" + poiId).remove();
				   }
				 });
		}
		
		function deleteRoute(routeId) {
			$.ajax({
				   type: "DELETE",
				   url: "<c:url value='/route/'/>" + routeId,
				   success: function(msg){
				     alert( "Data Saved: " + msg );
				     $("#route-" + routeId).remove();
				   }
				 });
		}
		
		function deleteCategory(categoryId) {
			$.ajax({
				   type: "DELETE",
				   url: "<c:url value='/poicategory/'/>" + categoryId,
				   success: function(msg){
				     alert( "Data Saved: " + msg );
				     $("#category-" + categoryId).remove();
				   }
				 });
		}
		
		function publishCategory() {
			var categoryId = $("#poi-category-id").val();
			if (categoryId) {
				$.postJSON("<c:url value='/poicategory/publish/'/>" + categoryId, null, function(data) { 
			    	alert("Data Loaded: " + data);
			    });				
			}
		    return false;
		}
		
		function publishAllCategories() {
		    $.postJSON("<c:url value='/poicategory/publish'/>", null, function(data) { 
		    	alert("Data Loaded: " + data);
		    });
		    return false;
		}
		
		function publishPoi() {
			var poiId = $("#poi-id").val();
			if (poiId) {
				$.postJSON("<c:url value='/poi/publish/'/>" + poiId, null, function(data) {
					if (data > 1) {
						$("#poi-publish").hide();
						$("#poi-status").html("Veröffentlicht!");
					}
			    	alert("Data Loaded: " + data);
			    });				
			}
		    return false;
		}
		
		function publishAllPois() {
		    $.postJSON("<c:url value='/poi/publish'/>", null, function(data) { 
		    	alert("Data Loaded: " + data);
		    });
		    return false;
		}
		
		function publishRoute() {
			var routeId = $("#route-id").val();
			if (routeId) {
				$.postJSON("<c:url value='/route/publish/'/>" + routeId, null, function(data) { 
			    	alert("Data Loaded: " + data);
			    });				
			}
		    return false;
		}
		
		function publishAllRoutes() {
		    $.postJSON("<c:url value='/route/publish'/>", null, function(data) { 
		    	alert("Data Loaded: " + data);
		    });
		    return false;
		}
		
		function updatePoiProfiles(locale) {
			var profilesOptions = "";
			$.getJSON("<c:url value='/profiles/'/>" + locale, function(profiles) {
				$.each(profiles, function(i, profile) {
					profilesOptions += '<input type="checkbox" name="profile-' + profile.id + ' id="profile-' + profile.id + '/><label for="profile-' + profile.id + '">' + profile.name + '</label><br>';
				});
				$("#poi-profiles").html(profilesOptions);
			});
		}
		
		function updatePoiRoutes(clientId, locale, routeId) {
			var routesOptions = "";
			$.getJSON("<c:url value='/routes/'/>" + clientId + "/" + locale, function(routes) {
				routesOptions += '<option value="0">Keiner Route zugeordnet</option>';
				$.each(routes, function(i, route) {
					routesOptions += '<option value="' + route.id + '">' + route.name + '</option>';
				});
				$("#poi-route").html(routesOptions);
				$("#poi-route").val(routeId);
			});
		}
		
		function updatePoiCategories(clientId, locale, catId) {
			var catOptions = "";
			$.getJSON("<c:url value='/poicategories/'/>" + clientId + "/" + locale, function(categories) {
				$.each(categories, function(i, cat) {
					catOptions += '<option value="' + cat.id + '">' + cat.name + '</option>';
				});
				$("#poi-category").html(catOptions);
				$("#poi-category").val(catId);
			});
		}
		
		function editRoute(routeId, copy) {
			$.getJSON("<c:url value='/route/'/>" + routeId, function(route) {
				$("#routediv").css('backgroundColor', $("#route-" + routeId).css('backgroundColor'));
				$("#route-id").val(route.id);
				$("#route-client-id").val(route.clientId);
				$("#route-name").val(route.name);
				$("#route-description").val(route.description);
				$("#route-kml-file").val(route.mapKML);
				$("#route-length").val(route.length);
				$("#route-length-unit").val(route.lengthUnit);
				$("#route-start-lon").val(route.startLon);
				$("#route-start-lat").val(route.startLat);
				$("#route-end-lon").val(route.endLon);
				$("#route-end-lat").val(route.endLat);
				$("#route-color").val(route.color);
				$("#colorSelector").ColorPickerSetColor(route.color);
				$("#colorSelector div").css('backgroundColor', route.color);
				var langOptions = "";
				$.each(languages[route.clientId], function(i, lang) {
					langOptions += '<option value="' + lang.shortName + '">' + lang.name + '</option>';
				});
				$("#route-locale").html(langOptions);
				$("#route-locale").val(route.locale);
				var lonLat = new OpenLayers.LonLat(route.startLon, route.startLat).transform(routemap.displayProjection, routemap.projection);
				routemap.setCenter (lonLat, 15); <%-- Zoomstufe einstellen--%>
			    if (copy) {
					$("#route-id").val(0);
					route.published = 0;
					$("#route-published").val(0);
				}
				if (route.published > 0) {
					$("#route-status").html("Veröffentlicht!");
					$("#route-publish").hide();
				}
				else {
					$("#route-status").html("Noch nicht veröffentlicht!");
					$("#route-publish").show();
				}
				$("routediv").show();
			    
			    //remove old layers
			    var routeLayers = routemap.getLayersByName(/^Route .*/);
				for (var i=0; i<routeLayers.length; i++) {
					routemap.removeLayer(routeLayers[i]);
				}
			    
				var client = clients[route.clientId];
				createUploaderKML('<c:url value="/upload/"/>' + route.clientId + '/mapkml');
				
			    var lkml = new OpenLayers.Layer.Vector("Route " + route.name, {style: {strokeColor: route.color, strokeWidth: 5, strokeOpacity: 0.5},
			     			projection: routemap.displayProjection,
			     			strategies: [new OpenLayers.Strategy.Fixed()],
			     			protocol: new OpenLayers.Protocol.HTTP({
			         			url: "<c:url value='/resources/' />" + client.url + '/kml/' + route.mapKML + "/",
			         			format: new OpenLayers.Format.KML()
			     			})
			 	});
				
				var routeIconLayer = new OpenLayers.Layer.Vector("Points of interest");
				var pointStart = new OpenLayers.Geometry.Point(route.startLon, route.startLat);
				pointStart.transform(new OpenLayers.Projection("EPSG:4326"), routemap.getProjectionObject());
				var iconFeatureStart = new OpenLayers.Feature.Vector(pointStart);
				iconFeatureStart.style = {
						externalGraphic: "<c:url value='/resources/'/>" + client.url + '/images/start_flag.png',
				        graphicXOffset:-iconSize.w/2,
				        graphicYOffset:-iconSize.h,
				        graphicWidth:iconSize.w,
				        graphicHeight:iconSize.h,
				        pointRadius:0
				};
				routeIconLayer.addFeatures(iconFeatureStart);		    		
				
				var pointEnd = new OpenLayers.Geometry.Point(route.endLon, route.endLat);
				pointEnd.transform(new OpenLayers.Projection("EPSG:4326"), routemap.getProjectionObject());
				var iconFeatureEnd = new OpenLayers.Feature.Vector(pointEnd);
				iconFeatureEnd.style = {
						externalGraphic: "<c:url value='/resources/'/>" + client.url + '/images/finish_flag.png',
				        graphicXOffset:-iconSize.w/2,
				        graphicYOffset:-iconSize.h,
				        graphicWidth:iconSize.w,
				        graphicHeight:iconSize.h,
				        pointRadius:0
				};
				routeIconLayer.addFeatures(iconFeatureEnd);
				
				routemap.addLayer(lkml);
				routemap.addLayer(routeIconLayer);
			    
			});
		}
		
		function editCategory(categoryId, copy) {
			$.getJSON("<c:url value='/poicategory/'/>" + categoryId, function(category) {
				$("#categorydiv").css('backgroundColor', $("#category-" + categoryId).css('backgroundColor'));
				$("#category-id").val(category.id);
				$("#category-name").val(category.name);
				$("#category-shortname").val(category.shortName);
				$("#category-icon-name").val(category.icon);
				$("#category-icon").attr('src', '<c:url value="/resources/"/>' + clients[category.clientId].url + '/images/' + category.icon);
				$("#category-icon").attr('alt', category.name); 
				var iconSelected = category.icon.replace(".png", "_selected.png");
				$("#category-icon-selected").attr('src', '<c:url value="/resources/"/>' + clients[category.clientId].url + '/images/' + iconSelected);
				$("#category-icon-selected").attr('alt', category.name + " ausgewählt");
				var langOptions = "";
				$.each(languages[category.clientId], function(i, lang) {
					langOptions += '<option value="' + lang.shortName + '">' + lang.name + '</option>';
				});
				$("#category-locale").html(langOptions);
				$("#category-locale").val(category.locale);
				var clientOptions = "";
				//$.each(clients, function(i, client) {
				// dump workaround because clients[0] ist not defined
				for (var i = 1; i <= clients.length - 1; i += 1) {
						clientOptions += '<option value="' + clients[i].id + '">' + clients[i].name + '</option>';	
				}
				//});
				$("#category-client").html(clientOptions);
				$("#category-client").val(category.clientId);
				createUploaderCategory('<c:url value="/upload/"/>' + category.clientId + '/poicategory');
				if (copy) {
					$("#category-id").val(0);
					category.published = 0;
					$("#category-published").val(0);
				}
				if (category.published > 0) {
					$("#poi-category-status").html("Veröffentlicht!");
					$("#poi-category-publish").hide();
				}
				else {
					$("#poi-category-status").html("Noch nicht veröffentlicht!");
					$("#poi-category-publish").show();
				}
				$("categorydiv").show();
			});
		}
		
		function createUploaderCategory(url) {
			uploaderCategory = new plupload.Uploader({
				runtimes : 'gears,html5,browserplus',
				browse_button : 'pickfiles-category',
				container : 'container-category',
				url : url,
				max_file_size : '500kb',
				filters : [
					{title : "Icon files", extensions : "png"},
				],
				multipart : true
			});
		
			$('#uploadfiles-category').click(function(e) {
				uploaderCategory.start();
				e.preventDefault();
			});
		
			uploaderCategory.init();
		
			uploaderCategory.bind('Init', function(up, params) {
				//$('#filelist-category').html("<div>Current runtime: " + params.runtime + "</div>");
				$('#filelist-category').html("<div>Diese Dateien hochladen:</div>");
			});
			
			uploaderCategory.bind('BeforeUpload', function(up, file) {
				if (up.files.length != 2) {
					alert("Bitte geben Sie zwei Dateien an!\nDie zweite Datei muss folgendes Format haben: <Name Datei1>_selected.png");
					up.stop();
				}
				else {
					var found = false;
					$.each(up.files, function(i, file) {
						if (file.name.match(/.*_selected.png/)) {
							found = true;	
						}
					});
					if (!found) {
						alert("Die zweite Datei muss dem Muster <Name Datei1>_selected.png entsprechen!");
						var file = up.files[up.files.length - 1];
						$('#file-' + file.id).remove();
						up.removeFile(file);
						up.stop();
					}
				}
			});
			
			
			uploaderCategory.bind('FilesAdded', function(up, files) {
				$.each(files, function(i, file) {
					$('#filelist-category').append(
						'<div id="file-' + file.id + '">' +
						file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
					'</div>');
				});
		
				up.refresh(); // Reposition Flash/Silverlight
			});
		
			uploaderCategory.bind('UploadProgress', function(up, file) {
				$('#file-' + file.id + " b").html(file.percent + "%");
			});
		
			uploaderCategory.bind('Error', function(up, err) {
				$('#filelist-category').append("<div>Fehler: " + err.code +
					", Fehlertext: " + err.message +
					(err.file ? ", Datei: " + err.file.name : "") +
					"</div>"
				);
		
				up.refresh(); // Reposition Flash/Silverlight
			});
		
			uploaderCategory.bind('FileUploaded', function(up, file, response) {
				$('#file-' + file.id + " b").html("100%");
				if (!response['response'].match(/.*_selected.png/)) {
					$("#category-icon-name").val(response['response']);
					$("#category-icon").attr('src', '<c:url value="/resources/"/>' + clients[$("#category-client").val()].url + '/images/' + response['response']);
					$("#category-icon").attr('alt', $("#category-name").val());
				}
				else {
					$("#category-icon-selected").attr('src', '<c:url value="/resources/"/>' + clients[$("#category-client").val()].url + '/images/' + response['response']);
					$("#category-icon-selected").attr('alt', $("#category-name").val() + " ausgewählt");	
				}
				setTimeout(function () { $('#filelist-category').html("<div>Diese Dateien hochladen:</div>"); },2000);
			});
		}
		
		function saveRoute() {
		    var route = $("#routeForm").serializeObject();
		    $.postJSON("<c:url value='/route/'/>" + $("#route-id").val(), route, function(data) { 
		    	alert("Data Loaded: " + data);
		    	if (route.id == 0) {
		    		addRouteToList(data);
		    	}
		    	if (data > 0) {
		    		<%-- category exists in db and can be published --%>
		    		$("#route-publish").show();	
		    	}
		    });
		    return false;
		}
		
		function savePoi() {
		    var poi = $("#poiForm").serializeObject();
		    $.postJSON("<c:url value='/poi/'/>" + $("#poi-id").val(), poi, function(data) { 
		    	alert("Data Loaded: " + data);
		    	if (poi.id == 0) {
		    		addPoiToList(data);
		    	}
		    	if (data > 0) {
		    		<%-- category exists in db and can be published --%>
		    		$("#poi-publish").show();	
		    	}
		    });
		    return false;
		}
		
		function saveCategory() {
		    var category = $("#categoryForm").serializeObject();
		    $.postJSON("<c:url value='/poicategory/'/>" + $("#category-id").val(), category, function(data) { 
		    	alert("Data Loaded: " + data);
		    	if (category.id == 0) {
		    		addCategoryToList(data);
		    	}
		    	if (data > 0) {
		    		<%-- category exists in db and can be published --%>
		    		$("#poi-category-publish").show();	
		    	}
		    });
		    return false;
		}
		
		function addPoiToList(poiId) {
			$.getJSON("<c:url value='/poi/'/>" + poiId, function(poi) {
				var html = '<tr id="poi-' + poiId + '">';
				html += '<td>' + poi.name + '</td>';
				<sec:authorize access="hasRole('changePoi')">
				html += '<td><a href="#" onClick="editPoi(' + poiId + ', false)">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-document-edit-icon.png"/>" alt="Editieren">';								
				html += '</a></td>';
				</sec:authorize>
				<sec:authorize access="hasRole('createPoi')">
				html += '<td><a href="#" onClick="editPoi(' + poiId + ', true)">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-edit-copy-icon.png"/>" alt="Kopieren">';								
				html += '</a></td>';
				</sec:authorize>
				<sec:authorize access="hasRole('deletePoi')">
				html += '<td><a href="#" onClick="deletePoi(' + poiId + ')">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-edit-delete-shred-icon.png"/>" alt="Löschen">';								
				html += '</a></td>';
				</sec:authorize>
				html += '</tr>';
				$("#poi-list").append(html);
			});
		}
		
		function addCategoryToList(categoryId) {
			$.getJSON("<c:url value='/poicategory/'/>" + categoryId, function(category) {
				var html = '<tr id="category-' + categoryId + '">';
				html += '<td>' + category.name + '</td>';
				<sec:authorize access="hasRole('changeCategory')">
				html += '<td><a href="#" onClick="editCategory(' + categoryId + ', false)">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-document-edit-icon.png"/>" alt="Editieren">';								
				html += '</a></td>';
				</sec:authorize>
				<sec:authorize access="hasRole('createCategory')">
				html += '<td><a href="#" onClick="editCategory(' + categoryId + ', true)">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-edit-copy-icon.png"/>" alt="Kopieren">';								
				html += '</a></td>';
				</sec:authorize>
				<sec:authorize access="hasRole('deleteCategory')">
				html += '<td><a href="#" onClick="deleteCategory(' + categoryId + ')">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-edit-delete-shred-icon.png"/>" alt="Löschen">';								
				html += '</a></td>';
				</sec:authorize>
				html += '</tr>';
				$("#category-list").append(html);
			});
		}
		
		function addRouteToList(routeId) {
			$.getJSON("<c:url value='/route/'/>" + routeId, function(route) {
				var html = '<tr id="route-' + routeId + '">';
				html += '<td>' + route.name + '</td>';
				<sec:authorize access="hasRole('changeRoute')">
				html += '<td><a href="#" onClick="editRoute(' + routeId + ', false)">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-document-edit-icon.png"/>" alt="Editieren">';								
				html += '</a></td>';
				</sec:authorize>
				<sec:authorize access="hasRole('createRoute')">
				html += '<td><a href="#" onClick="editRoute(' + routeId + ', true)">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-edit-copy-icon.png"/>" alt="Kopieren">';								
				html += '</a></td>';
				</sec:authorize>
				<sec:authorize access="hasRole('deleteRoute')">
				html += '<td><a href="#" onClick="deleteRoute(' + routeId + ')">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-edit-delete-shred-icon.png"/>" alt="Löschen">';								
				html += '</a></td>';
				</sec:authorize>
				html += '</tr>';
				$("#route-list").append(html);
			});
		}
		
		function createPoiMap() {
			OpenLayers.Lang.setCode('de');
			<%-- must be explicitly set, otherwise ol would search for images and css in the wrong location --%>
			OpenLayers.ImgPath = "<c:url value='/resources/global/images/ol-images/'/>";
			OpenLayers.ThemePath = "<c:url value='/resources/global/css/ol-theme/'/>";
			
			var touchNav = new OpenLayers.Control.TouchNavigation({ dragPanOptions: {interval: 100, enableKinetic: true} });
						
			poimap = new OpenLayers.Map({
		        div: "poi-mapdiv",
		        theme: null,
		        projection: new OpenLayers.Projection("EPSG:900913"),
		        displayProjection: new OpenLayers.Projection("EPSG:4326"),
		        units: "m",
		        numZoomLevels: 18,
		        maxResolution: 156543.0339,
		      	//-20037508.34, -20037508.34, 20037508.34, 20037508.34
		        maxExtent: new OpenLayers.Bounds(
		            5.185546875,46.845703125,15.46875,55.634765625
		        ),
		        controls: [touchNav]
		    });
			
			var dragFeature = new OpenLayers.Control.DragFeature(poiLayer, { onComplete: function(feature, pixel) { 
					var position = poimap.getLonLatFromPixel(pixel).transform(new OpenLayers.Projection("EPSG:900913"), new OpenLayers.Projection("EPSG:4326"));
					$("#poi-lon").val(position.lon);
					$("#poi-lat").val(position.lat); 
				} 
			});
			
			<c:choose>
			    <c:when test="${!empty tilesServers}">
				    var layerMapnik = new OpenLayers.Layer.OSM.Mapnik("OSM Standard (engl. Server)", 
				    													{ 
				    														attribution: '', 
				    														keyname: 'mapnik', 
				    														type: 'png', 
				    														getURL: createTileUrl
				    													});
				    layerMapnik.url = <c:out value="${tilesServers}" escapeXml="false" />;
			    </c:when>
			    <c:otherwise>
					var layerMapnik = new OpenLayers.Layer.OSM.Mapnik("OSM Standard (engl. Server)", { attribution: '', keyname: 'mapnik'});
				</c:otherwise>
			</c:choose>
		
			poimap.addLayer(layerMapnik);
			poimap.addLayer(poiLayer);
			poimap.addControl(dragFeature);
			dragFeature.activate();
			<%--
			var lonLat = new OpenLayers.LonLat(51, 7).transform(poimap.displayProjection,  poimap.projection);
		    poimap.setCenter (lonLat, 15);  Zoomstufe einstellen--%>
		}
		
		<c:if test="${!empty tilesServers}">
			function createTileUrl (bounds) {
		        var res = this.map.getResolution();
		        var x = Math.round((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
		        var y = Math.round((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));
		        var z = this.map.getZoom();
		        var limit = Math.pow(2, z);
		        if (y < 0 || y >= limit) {
		            return ""; // Tile not found. Use Firefox and Firebug to see url requested
		        }
		        else {
		            x = ((x % limit) + limit) % limit;       
		            var url = this.url;
		            var path = z + "/" + x + "/" + y + ".png";
		            if (url instanceof Array) {
		                url = this.selectUrl(path, url);
		            }
		            return url + path;
		        }
		    }
		</c:if>
		
		
		function createRouteMap() {
			OpenLayers.Lang.setCode('de');
			<%-- must be explicitly set, otherwise ol would search for images and css in the wrong location --%>
			OpenLayers.ImgPath = "<c:url value='/resources/global/images/ol-images/'/>";
			OpenLayers.ThemePath = "<c:url value='/resources/global/css/ol-theme/'/>";
			
			var touchNav = new OpenLayers.Control.TouchNavigation({ dragPanOptions: {interval: 100, enableKinetic: true} });
						
			routemap = new OpenLayers.Map({
		        div: "route-mapdiv",
		        theme: null,
		        projection: new OpenLayers.Projection("EPSG:900913"),
		        displayProjection: new OpenLayers.Projection("EPSG:4326"),
		        units: "m",
		        numZoomLevels: 18,
		        maxResolution: 156543.0339,
		      	//-20037508.34, -20037508.34, 20037508.34, 20037508.34
		        maxExtent: new OpenLayers.Bounds(
		            5.185546875,46.845703125,15.46875,55.634765625
		        ),
		        controls: [touchNav]
		    });
			
			<c:choose>
			    <c:when test="${!empty tilesServers}">
				    var layerMapnik = new OpenLayers.Layer.OSM.Mapnik("OSM Standard (engl. Server)", 
				    													{ 
				    														attribution: '', 
				    														keyname: 'mapnik', 
				    														type: 'png', 
				    														getURL: createTileUrl
				    													});
				    layerMapnik.url = <c:out value="${tilesServers}" escapeXml="false" />;
			    </c:when>
			    <c:otherwise>
					var layerMapnik = new OpenLayers.Layer.OSM.Mapnik("OSM Standard (engl. Server)", { attribution: '', keyname: 'mapnik'});
				</c:otherwise>
			</c:choose>
		
			routemap.addLayer(layerMapnik);
			<%--
			var lonLat = new OpenLayers.LonLat(51, 7).transform(routemap.displayProjection, routemap.projection);
		    routemap.setCenter (lonLat, 15);  Zoomstufe einstellen--%>
		}
		
		$("#poi-locale").live('change', function () {
			var locale = $("#poi-locale").val();
			var clientId = $("#poi-client-id").val();
			updatePoiProfiles(locale);
			updatePoiCategories(clientId, locale, 0);
			updatePoiRoutes(clientId, locale, 0);
		});	
		
	</compress:js>
	</script>
	
</body>
</html>