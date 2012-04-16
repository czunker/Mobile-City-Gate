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
				position: float;
			    left: 0px;
			    width: 100%;
			    height: 400px;
			    padding: 10px;
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
			.wide-modal {
			  position: fixed;
			  top: 5%;
			  left: 5%;
			  z-index: 11000;
			  width: 90%;
			  height: 90%;
			  /*margin: -250px 0 0 -280px;*/
			  background-color: #ffffff;
			  border: 1px solid #999;
			  border: 1px solid rgba(0, 0, 0, 0.3);
			  *border: 1px solid #999;
			  /* IE6-7 */
			
			  -webkit-border-radius: 6px;
			  -moz-border-radius: 6px;
			  border-radius: 6px;
			  -webkit-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
			  -moz-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
			  box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
			  -webkit-background-clip: padding-box;
			  -moz-background-clip: padding-box;
			  background-clip: padding-box;
			}
			
		</compress:css>
		</style>
		<link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/ol-theme/default/style.css'/>" >
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/global/css/colorpicker.css'/>" />
</head>
<body style="padding-top: 40px;">
		<div class="topbar-wrapper" style="z-index: 5;">
		    <div class="topbar" data-dropdown="dropdown" >
		      <div class="topbar-inner">
		        <div class="container">
		          <h3><a href="#">CMS Mobiles Stadttor</a></h3>
		          <ul class="nav">
		            <li id="nav-pois" class="active"><a href="#" onClick="showPois()">Pois</a></li>
					<li id="nav-routes"><a href="#" onClick="showRoutes()">Routen</a></li>
					<li id="nav-poi-categories"><a href="#" onClick="showCategories()">Kategorien</a></li>
					<li id="nav-languages"><a href="#" onClick="showLanguages()">Sprachen</a></li>
					<li id="nav-messages"><a href="#" onClick="showMessages()">Texte</a></li>
					<%--
					<li><a href="#tabs-clients">Klienten</a></li>
					<li><a href="#tabs-users">CMS - Userverwaltung</a></li>
		            <li class="dropdown">
		              <a href="#" class="dropdown-toggle">Dropdown</a>
		              <ul class="dropdown-menu">
		                <li><a href="#">Secondary link</a></li>
		                <li><a href="#">Something else here</a></li>
		                <li class="divider"></li>
		                <li><a href="#">Another link</a></li>
		              </ul>
		            </li>
		            --%>
		          </ul>
		          <%-- 
		          <form class="pull-left" action="">
		            <input type="text" placeholder="Search" />
		          </form>
		          --%>
		          <ul class="nav secondary-nav">
					<a href="<c:url value='/j_spring_security_logout' />">Logout</a>
		          </ul>
		        </div>
		      </div><!-- /topbar-inner -->
		    </div><!-- /topbar -->
		   </div>
		    
		    
		<div>
			<div id="tabs-pois">
				<%--
				<sec:authorize access="hasRole('publishPoi')">
					<div>
						<button>
							<a href="#" onClick="publishAllPois()">
								<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
							</a>
							Alle POIs veröffentlichen
						</button>
					</div>
				</sec:authorize>
				--%>		
					<table id="poi-list" class="zebra-striped condensed-table">
						<thead>
							<tr>
					            <th>Name</th>
					            <th>Kunde</th>
					            <th>Kategorie</th>
					            <th>Route</th>
					            <th>Sprache</th>
					            <th></th>
					          </tr>
						</thead>
						<c:forEach var="poi" items="${pois}" varStatus="status">
							    <tr id="poi-<c:out value='${poi.id}'/>">
								<td><c:out value='${poi.name}'/></td>
								<td><c:out value='${poi.client}'/></td>
								<td><c:out value='${poi.poiCategory}'/></td>
								<td><c:out value='${poi.route}'/></td>
								<td><c:out value='${poi.locale}'/></td>
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
				
				<div id="poidiv" class="wide-modal hide">
					<div class="modal-header">
		              <a href="#" class="close">&times;</a>
		              <h3 id="edit-poi-heading">POI editieren</h3>
		              <img id="poi-icon" height="24px" width="24px" src="" alt=""><div id="poi-status"></div>
		            </div>
		            
	            	<div class="modal-body">
						<form id="poiForm" class="form-stacked">
							<input type="hidden" name="id" id="poi-id" value=""  />
							<input type="hidden" name="published" id="poi-published" value=""  />
							<input type="hidden" name="clientId" id="poi-client-id" value=""  />
							<div class="row">
								<div class="span4">
									<label for="name">Name</label>
							    	<input type="text" size="30" name="name" id="poi-name" value=""  />
							    	<label for="locale" class="select">Sprache</label>
									<select name="locale" id="poi-locale">
									</select>
							   	</div>
							   	<div class="span4">
							   		<label for="poiCategoryId" class="select">Kategorie:</label>
									<select name="poiCategoryId" id="poi-category">
									</select>
								    <label for="routeId" class="select">Route:</label>
									<select name="routeId" id="poi-route">
									</select>
								</div>
							   	<div class="span4">
									<label for="description">Beschreibung</label>
						    		<textarea class="xxlarge" name="description" rows="4" id="poi-description"></textarea>
								</div>
							</div>
						    <div class="row">
						    	<div class="span4">
								    <label for="ivrTextUrl">IVR Text URL</label>
								    <input type="text" size="15" name="ivrTextUrl" id="poi-ivr-text-url" value="" readonly />
								</div>
								<div class="span4">
								    <label for="ivrNumber">IVR Nummer</label>
								    <input type="text" size="15" name="ivrNumber" id="poi-ivr-number" value=""  />
								</div>
								<div class="span4">
									<label for="lon">Längengrad</label>
							    	<input type="text" size="10" name="lon" id="poi-lon" value=""  />
								</div>
								<div class="span4">
								    <label for="lat">Breitengrad</label>
							    	<input type="text" size="10" name="lat" id="poi-lat" value=""  />
								</div>
						    </div>
						    <div class="row">
						    	<div class="span16">
								    <div id="container-ivrtext">
										<div id="filelist-ivrtext">Browser unterstütz leider keinen Dateiupload.</div>
										<br />
										<a id="pickfiles-ivrtext" href="#">[HTML Datei auswählen]</a>
										<a id="uploadfiles-ivrtext" href="#">[Dateien hochladen]</a>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="span4">
									<label for="profileIds">Profile:</label>
						            <div id="poi-profiles">
						            </div>
						        </div>
						        <div class="span10">
						        	<div id="poi-mapdiv"> 
							              <noscript>Ihr Browser unterstütz kein Javascript oder es ist nicht aktiviert.</noscript> 
							        </div>
							    </div>
					        </div>
						</form>
			        </div>
			        
			        <div class="modal-footer">
					  	<a href="#" class="btn primary" onClick="savePoi()">Speichern</a>
						<sec:authorize access="hasRole('publishPoi')">
							<%--<button id="poi-publish" >--%>
								<a href="#" class="btn success" onClick="publishPoi()">
									<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">
									Publizieren								
								</a>
							<%--</button>--%>
						</sec:authorize>
						<a href="#" class="btn secondary close">Abbrechen</a>
		            </div>
					
				</div>
			
			
			
			<div id="tabs-routes" class="hide">
				<%--
				<sec:authorize access="hasRole('publishRoute')">
					<div>
					<button>
						<a href="#" onClick="publishAllRoutes()">
							<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
						</a>
						Alle Routen veröffentlichen
					</button>
					</div>
				</sec:authorize>
				--%>
					<table id="route-list" class="zebra-striped condensed-table">
						<thead>
							<tr>
					            <th>Name</th>
					            <th colspan="3"></th>
					          </tr>
						</thead>
						<c:forEach var="route" items="${routes}" varStatus="status">
						    	<tr id="route-<c:out value='${route.id}'/>">
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
				
				<%-- 
				<div class="right-column" id ="routediv">
					<div data-role="fieldcontain">
						<form id="routeForm">
							<input type="hidden" name="id" id="route-id" value=""  />
							<input type="hidden" name="published" id="route-published" value=""  />
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
				--%>
			</div>
			
			<div id="tabs-poi-categories" class="hide">
				<%-- 
				<sec:authorize access="hasRole('publishCategory')">
					<div>
					<button>
					<a href="#" onClick="publishAllCategories()">
						<img height="16px" width="16px" src="<c:url value='/resources/global/images/publish.png'/>" alt="Veröffentlichen">								
					</a>
					Alle Kategorien veröffentlichen
					</button>
					</div>
				</sec:authorize>
				--%>
					<table id="category-list" class="zebra-striped condensed-table">
						<thead>
							<tr>
					            <th>Name</th>
					            <th colspan="3"></th>
					          </tr>
						</thead>
						<c:forEach var="category" items="${categories}" varStatus="status">
						    	<tr id="category-<c:out value='${category.id}'/>">
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
				
				<%-- 
				<div class="right-column" id ="categorydiv">
					<form id="categoryForm">
						<input type="hidden" name="id" id="category-id" value=""  />
						<input type="hidden" name="published" id="category-published" value=""  />
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
				--%>			
			</div>
			
			
			<div id="tabs-languages" class="hide">
				<table id="language-list" class="zebra-striped condensed-table">
					<thead>
						<tr>
				            <th>Name</th>
				            <th>Kurzname</th>
				            <th>Mandant</th>
				            <th colspan="3"></th>
				          </tr>
					</thead>
					<c:forEach var="language" items="${languages}" varStatus="status">
					    	<tr id="language-<c:out value='${language.id}'/>">
							<td><c:out value='${language.name}'/></td>
							<td><c:out value='${language.shortName}'/></td>
							<td><c:out value='${language.client}'/></td>
								<sec:authorize access="hasRole('changeLanguage')">
									<td>
									<a href="#" onClick="editLanguage(<c:out value='${language.id}'/>, false)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-document-edit-icon.png'/>" alt="Editieren">								
									</a>
									</td>
								</sec:authorize>
								<sec:authorize access="hasRole('createLanguage')">
									<td>
									<a href="#" onClick="editLanguage(<c:out value='${language.id}'/>, true)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-edit-copy-icon.png'/>" alt="Kopieren">								
									</a>
									</td>
								</sec:authorize>
								<sec:authorize access="hasRole('deleteLanguage')">
									<td>
									<a href="#" onClick="deleteLanguage(<c:out value='${language.id}'/>)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-edit-delete-shred-icon.png'/>" alt="Löschen">								
									</a>
									</td>
								</sec:authorize>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<div id="languagediv" class="small-modal hide">
					<div class="modal-header">
		              <a href="#" class="close">&times;</a>
		              <h3 id="edit-language-heading">Sprache editieren</h3>
		            </div>
		            
	            	<div class="modal-body">
						<form id="languageForm" class="form-stacked">
							<input type="hidden" name="id" id="language-id" value=""  />
							<input type="hidden" name="clientId" id="language-client-id" value=""  />
							<input type="hidden" name="icon" id="language-icon" value=""  />
							<div class="row">
								<div class="span3">
									<img id="language-image" height="24px" width="24px" src="" alt="">
							   	</div>
								<div class="span3">
									<label for="name">Name</label>
							    	<input type="text" size="30" name="name" id="language-name" value=""  />
							   	</div>
							   	<div class="span3">
									<label for="shortName">Kurzname</label>
							    	<input type="text" size="30" name="shortName" id="language-short-name" value=""  />
							   	</div>
							</div>
							<div class="row">
							</div>
							<div class="row">
						    	<div class="span16">
								    <div id="container-language-icon">
										<div id="filelist-language-icon">Browser unterstütz leider keinen Dateiupload.</div>
										<br />
										<a id="pickfiles-language-icon" href="#">[Icon Datei auswählen]</a>
										<a id="uploadfiles-language-icon" href="#">[Datei hochladen]</a>
									</div>
								</div>
							</div>
						</form>
			        </div>
			        
			        <div class="modal-footer">
					  	<a href="#" class="btn primary" onClick="saveLanguage()">Speichern</a>
						<a href="#" class="btn secondary close">Abbrechen</a>
		            </div>
					
				</div>
			
			<div id="tabs-messages" class="hide">
				<table id="message-list" class="zebra-striped condensed-table">
					<thead>
						<tr>
				            <th>Text</th>
				            <th>Seite</th>
				            <th>Sprache</th>
				            <th>Mandant</th>
				            <th></th>
				          </tr>
					</thead>
					<c:forEach var="message" items="${messages}" varStatus="status">
					    	<tr id="message-<c:out value='${message.id}'/>">
							<td><c:out value='${message.text}'/></td>
							<td><c:out value='${message.page}'/></td>
							<td><c:out value='${message.locale}'/></td>
							<td><c:out value='${message.client}'/></td>
								<sec:authorize access="hasRole('changeMessage')">
									<td>
									<a href="#" onClick="editMessage(<c:out value='${message.id}'/>, false)">
										<img height="16px" width="16px" src="<c:url value='/resources/global/images/Actions-document-edit-icon.png'/>" alt="Editieren">								
									</a>
									</td>
								</sec:authorize>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			
			<%--
			<div id="tabs-clients" class="hide">
			</div>
			
			<div id="tabs-users" class="hide">
			</div>
			--%>
		</div>

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	<script type="text/javascript" src="http://twitter.github.com/bootstrap/1.4.0/bootstrap-modal.js"></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/colorpicker.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/json.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/OpenLayers.js'/>" ></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/OpenStreetMap-min.js'/>" ></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/cms-bootstrap.js'/>" ></script>
	<!-- Third party script for BrowserPlus runtime (Google Gears included in Gears runtime now) -->
	<script type="text/javascript" src="http://bp.yahooapis.com/2.4.21/browserplus-min.js"></script>
	<!-- Load plupload and all it's runtimes and finally the jQuery queue widget -->
	<script type="text/javascript" src="<c:url value='/resources/global/js/plupload/js/plupload.full.js'/>" ></script>
	<script type="text/javascript" src="<c:url value='/resources/global/js/jquery.tablesorter.min.js'/>" ></script>
	
	<script>
	<%--<compress:js>--%>
	
		var poimap;
		var routemap;
		var selectControl;
		var uploaderKML;
		var uploaderCategory;
		var uploaderLanguageIcon;
		var poiLayer;
		var iconSize = new OpenLayers.Size(24, 24);
	
		var clients = new Array();
		var languages = new Array();
		var poicategories = new Array();
		
		function showPois() {
			$("#tabs-pois").show();
			$("#tabs-routes").hide();
			$("#tabs-poi-categories").hide();
			$("#tabs-languages").hide();
			$("#tabs-messages").hide();
			$("#nav-poi-categories").removeClass('active');
			$("#nav-routes").removeClass('active');
			$("#nav-pois").addClass('active');
			$("#nav-languages").removeClass('active');
			$("#nav-messages").removeClass('active');
		}
		
		function showRoutes() {
			$("#tabs-pois").hide();
			$("#tabs-routes").show();
			$("#tabs-poi-categories").hide();
			$("#tabs-languages").hide();
			$("#tabs-messages").hide();
			$("#nav-poi-categories").removeClass('active');
			$("#nav-routes").addClass('active');
			$("#nav-pois").removeClass('active');
			$("#nav-languages").removeClass('active');
			$("#nav-messages").removeClass('active');
		}
		
		function showCategories() {
			$("#tabs-pois").hide();
			$("#tabs-routes").hide();
			$("#tabs-poi-categories").show();
			$("#tabs-languages").hide();
			$("#tabs-messages").hide();
			$("#nav-poi-categories").addClass('active');
			$("#nav-routes").removeClass('active');
			$("#nav-pois").removeClass('active');
			$("#nav-languages").removeClass('active');
			$("#nav-messages").removeClass('active');
		}
		
		function showLanguages() {
			$("#tabs-pois").hide();
			$("#tabs-routes").hide();
			$("#tabs-poi-categories").hide();
			$("#tabs-languages").show();
			$("#tabs-messages").hide();
			$("#nav-poi-categories").removeClass('active');
			$("#nav-routes").removeClass('active');
			$("#nav-pois").removeClass('active');
			$("#nav-languages").addClass('active');
			$("#nav-messages").removeClass('active');
		}
		
		function showMessages() {
			$("#tabs-pois").hide();
			$("#tabs-routes").hide();
			$("#tabs-poi-categories").hide();
			$("#tabs-languages").hide();
			$("#tabs-messages").show();
			$("#nav-poi-categories").removeClass('active');
			$("#nav-routes").removeClass('active');
			$("#nav-pois").removeClass('active');
			$("#nav-languages").removeClass('active');
			$("#nav-messages").addClass('active');
		}
		
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
				<%-- modal dialog must be visible bevor map can be created
				otherwise you will get an error
				 --%>
				$("#poidiv").modal('show');
				$("#poi-id").val(poi.id);
				$("#poi-published").val(poi.published);
				$("#poi-client-id").val(poi.clientId);
				$("#poi-name").val(poi.name);
				$("#poi-description").val(poi.description);
				$("#poi-ivr-number").val(poi.ivrNumber);
				$("#poi-lon").val(poi.lon);
				$("#poi-lat").val(poi.lat);
				$("#edit-poi-heading").html('"' + poi.name + '" editieren');
				var iconFeature;
				createPoiMap();
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
				updatePoiProfiles(poi.locale, poi.poiProfileIds);
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
				alert(poi.published);
				if (poi.published > 0) {
					$("#poi-status").html('<span class="label success">Veröffentlicht!</span>');
					$("#poi-publish").hide();
				}
				else {
					$("#poi-status").html('<span class="label important">Noch nicht Veröffentlicht!</span>');
					$("#poi-publish").show();
				}
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
		
		function deleteLanguage(languageId) {
			$.ajax({
				   type: "DELETE",
				   url: "<c:url value='/language/'/>" + languageId,
				   success: function(msg){
				     alert( "Data Saved: " + msg );
				     $("#language-" + languageId).remove();
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
		
		function updatePoiProfiles(locale, profileIds) {
			var profilesOptions = '<ul class="inputs-list">';
			$.getJSON("<c:url value='/profiles/'/>" + locale, function(profiles) {
				$.each(profiles, function(i, profile) {
					profilesOptions += '<li><label>';
					if ($.inArray(profile.id, profileIds) > -1) {
						profilesOptions += '<input type="checkbox" checked id="profile-' + profile.id + '" value="' + profile.id + '" /><label for="profile-' + profile.id + '">' + profile.name + '</label><br>';
					}
					else {
						profilesOptions += '<input type="checkbox" id="profile-' + profile.id + '" value="' + profile.id + '" /><label for="profile-' + profile.id + '">' + profile.name + '</label><br>';
					}
					profilesOptions += '<span>' + profile.name + '</span>';
					profilesOptions += '</label></li>';
				});
				profilesOptions += '</ul>';
				profilesOptions += '<span class="help-block">';
				profilesOptions += '<strong>Hinweis:</strong> Für diese Personengruppen ist der Punkt <u>nicht</u> geeignet';
				profilesOptions += '</span>';
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
				$("#route-published").val(route.published);
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
				$("#category-published").val(category.published);
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
		
		function createUploaderLanguageIcon(url) {
			uploaderLanguageIcon = new plupload.Uploader({
				runtimes : 'gears,html5,browserplus',
				browse_button : 'pickfiles-language-icon',
				container : 'container-language-icon',
				url : url,
				max_file_size : '50kb',
				filters : [
					{title : "PNG files", extensions : "png"},
				],
				multipart : true
			});
		
			$('#uploadfiles-language-icon').click(function(e) {
				uploaderLanguageIcon.start();
				e.preventDefault();
			});
		
			uploaderLanguageIcon.bind('Init', function(up, params) {
				//$('#filelist-ivrtext').html("<div>Current runtime: " + params.runtime + "</div>");
				$('#filelist-language-icon').html("<div>Diese Icon Datei hochladen:</div>");
			});
			
			uploaderLanguageIcon.init();
			
			uploaderLanguageIcon.bind('FilesAdded', function(up, files) {
				$.each(files, function(i, file) {
					$('#filelist-language-icon').append(
						'<div id="' + file.id + '">' +
						file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
					'</div>');
				});
		
				up.refresh(); // Reposition Flash/Silverlight
			});
		
			uploaderLanguageIcon.bind('UploadProgress', function(up, file) {
				$('#' + file.id + " b").html(file.percent + "%");
			});
		
			uploaderLanguageIcon.bind('Error', function(up, err) {
				$('#filelist-language-icon').append("<div>Fehler: " + err.code +
					", Fehlertext: " + err.message +
					(err.file ? ", Datei: " + err.file.name : "") +
					"</div>"
				);
		
				up.refresh(); // Reposition Flash/Silverlight
			});
		
			uploaderLanguageIcon.bind('FileUploaded', function(up, file, response) {
				$('#' + file.id + " b").html("100%");
			    $("#language-icon").val(response['response']);
			    $("#language-image").attr("src", "<c:url value='/resources/global/images/" + $("#language-icon").val() + "' />");
			    setTimeout(function () { $('#filelist-language-icon').html("<div>Diese Icon Datei hochladen:</div>"); },2000);
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
		    var poiProfileIds = [];
		    $('#poi-profiles :checked').each(function() {
		    	poiProfileIds.push($(this).val());
		    });
		    poi.poiProfileIds = poiProfileIds;
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
		
		function saveLanguage() {
		    var language = $("#languageForm").serializeObject();
		    $.postJSON("<c:url value='/language/'/>" + $("#language-id").val(), language, function(data) { 
		    	alert("Data Loaded: " + data);
		    	if (language.id == 0) {
		    		addLanguageToList(data);
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
		
		function addLanguageToList(languageId) {
			$.getJSON("<c:url value='/language/'/>" + languageId, function(language) {
				var html = '<tr id="language-' + languageId + '">';
				html += '<td>' + language.name + '</td>';
				html += '<td>' + language.shortName + '</td>';
				html += '<td>' + language.client + '</td>';
				<sec:authorize access="hasRole('changeLanguage')">
				html += '<td><a href="#" onClick="editLanguage(' + languageId + ', false)">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-document-edit-icon.png"/>" alt="Editieren">';								
				html += '</a></td>';
				</sec:authorize>
				<sec:authorize access="hasRole('createLanguage')">
				html += '<td><a href="#" onClick="editLanguage(' + languageId + ', true)">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-edit-copy-icon.png"/>" alt="Kopieren">';								
				html += '</a></td>';
				</sec:authorize>
				<sec:authorize access="hasRole('deleteLanguage')">
				html += '<td><a href="#" onClick="deleteLanguage(' + languageId + ')">';
				html += '<img height="16px" width="16px" src="<c:url value="/resources/global/images/Actions-edit-delete-shred-icon.png"/>" alt="Löschen">';								
				html += '</a></td>';
				</sec:authorize>
				html += '</tr>';
				$("#language-list").append(html);
			});
		}
		
		function createPoiMap() {
			if (poimap) { return false; }
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
		        maxExtent: new OpenLayers.Bounds(5.185546875,46.845703125,15.46875,55.634765625),
		        controls: [touchNav]
		    });
			
			poiLayer = new OpenLayers.Layer.Vector("Points of interest");
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
		
		function editLanguage(languageId, copy) {
			$.getJSON("<c:url value='/language/'/>" + languageId, function(language) {
				$("#languagediv").modal('show');
				$("#language-id").val(language.id);
				$("#language-client-id").val(language.clientId);
				$("#language-name").val(language.name);
				$("#language-short-name").val(language.shortName);
				$("#language-icon").val(language.icon);
				$("#language-image").attr("src", "<c:url value='/resources/global/images/" + language.icon + "' />");
				$("#language-image").attr("alt", language.name);
				$("#edit-language-heading").html('"' + language.name + '" editieren');
				if (copy) {
					$("#language-id").val(0);
				}
				createUploaderLanguageIcon('<c:url value="/upload/icon"/>');
			});
		}
		
		$("#poi-locale").live('change', function () {
			var locale = $("#poi-locale").val();
			var clientId = $("#poi-client-id").val();
			updatePoiProfiles(locale, []);
			updatePoiCategories(clientId, locale, 0);
			updatePoiRoutes(clientId, locale, 0);
		});	
		
		$("#poi-category").live('change', function () {
			var client = clients[$("#poi-client-id").val()];
			$.getJSON("<c:url value='/poicategory/'/>" + $("#poi-category").val(), function(category) {
				$("#poi-icon").attr("src", "<c:url value='/resources/'/>" + client.url + "/images/" + category.icon);
				$("#poi-icon").attr("alt", category.name);
			});
		});
		
	<%--</compress:js>--%>
	</script>
	
</body>
</html>