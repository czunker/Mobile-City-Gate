package de.christianzunker.mobilecitygate.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.MediaType;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sun.jersey.api.client.ClientHandlerException;
import com.sun.jersey.api.client.WebResource;

import de.christianzunker.mobilecitygate.beans.Client;
import de.christianzunker.mobilecitygate.beans.Poi;
import de.christianzunker.mobilecitygate.beans.PoiCategory;
import de.christianzunker.mobilecitygate.beans.Profile;
import de.christianzunker.mobilecitygate.beans.Route;
import de.christianzunker.mobilecitygate.dao.ClientDao;
import de.christianzunker.mobilecitygate.dao.MessageDao;
import de.christianzunker.mobilecitygate.dao.PoiCategoryDao;
import de.christianzunker.mobilecitygate.dao.PoiDao;
import de.christianzunker.mobilecitygate.dao.ProfileDao;
import de.christianzunker.mobilecitygate.dao.RouteDao;

@Controller
public class PoiController {

	private static final Logger logger = Logger.getLogger(HomeController.class);
	
	@Autowired
	private PoiCategoryDao poiCatDao;
	
	@Autowired
	private ProfileDao profileDao;
	
	@Autowired
	private PoiDao poiDao;
	
	@Autowired
	private RouteDao routeDao;
	
	@Autowired
	private ClientDao clientDao;
	
	@Autowired
	private MessageDao messageDao;
	
	@RequestMapping(value = "/{client}/{locale}/pois")
	public String getPois(@PathVariable("client") String client, @PathVariable("locale") String locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("entering method getPois");
		
		//TODO locale genauer �berpr�fen? Tabelle languages?
		if (!locale.matches("[a-z]{2}") ||
			!client.matches("[0-9a-zA-Z_-]*") ||
			client.length() > 45) {
			logger.error("Fehlerhafte Parameter!");
			throw new Exception("Fehlerhafte Parameter!");
		}

		Client clientObj = clientDao.getClientByUrl(client);
		HashMap<String, String> hashMessagesPoiOverview = messageDao.getMessagesByPageClientIdLocale("poi-overview", clientObj.getId(), locale);
		HashMap<String, String> hashMessagesMap = messageDao.getMessagesByPageClientIdLocale("map", clientObj.getId(), locale);
        
		//get shortened URL for easier Twitter usage
		String longUrl = "http://" + request.getServerName() + request.getContextPath() + "/" + clientObj.getUrl() + "/" + locale + "/";
		try {
			com.sun.jersey.api.client.Client jsonClient = com.sun.jersey.api.client.Client.create();
			WebResource webResource = jsonClient.resource("https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyBgEIvyRpfOSZfD_JrPIg1blLhpW8MtBu8");
			String jsonRequest = "{ \"longUrl\": \"" + longUrl + "\" }";
			logger.debug("jsonRequest: " + jsonRequest);
			String jsonResponse = webResource.accept(
			        MediaType.APPLICATION_JSON_TYPE).
			        type(MediaType.APPLICATION_JSON_TYPE).
			        post(String.class, jsonRequest);
			logger.debug("jsonResponse: " + jsonResponse);
			
			String shortUrl = "";
			JsonParser jsonParser = new JsonParser();
			JsonObject jsonObj = (JsonObject)jsonParser.parse(jsonResponse);
			if ( jsonObj != null && jsonObj.has("id")) {
				shortUrl = jsonObj.get("id").toString();
				shortUrl = shortUrl.replace("\"", "");
			}
			clientObj.setShortUrl(shortUrl);
		}
		catch (ClientHandlerException ex) {
			logger.error("Couldn't connect to Google URL Shortener!", ex);
			clientObj.setShortUrl(longUrl);
		}


		
		List<PoiCategory> cats = poiCatDao.getActiveCategoriesByClientLocale(clientObj.getId(), locale);
        List<Profile> profiles = profileDao.getActiveProfilesByClientLocale(clientObj.getId(), locale);
        
        if (logger.isDebugEnabled()) {
	        List<Profile> allProfiles = profileDao.getProfiles();
	        for (Profile prof : allProfiles) {
	        	logger.debug("Profile: " + prof.getId() + " " + prof.getName());
	        }
        }
        
        
        //List<Poi> pois = poiDao.getPoisNotInRoute();
        List<Poi> pois = poiDao.getPoisNotInRouteByClientLocale(clientObj.getId(), locale);
        List<Route> routes = routeDao.getRouteListByClientLocale(clientObj.getId(), locale);
        
        if (logger.isDebugEnabled()) {
        	for (Route route : routes) {
        		logger.debug("route: " + route.getName());
			}
		}
        
        for (Route route : routes) {
			route.setPois(poiDao.getPoisByRouteLocale(route.getId(), locale));
			if (logger.isDebugEnabled()) {
        		logger.debug("#route pois: " + route.getPois().size());
			}
		}
        
        for (Profile profile : profiles) {
			List<Integer> ids = poiDao.getPoiIdsByProfileByClientLocale(profile.getId(), clientObj.getId(), locale);
			String stringIds = "";
			for (Integer id : ids) {
				stringIds += id.toString() + ",";				
			}
			//remove last ,
			if (stringIds.length() > 0) {
				stringIds = stringIds.substring(0, stringIds.length() - 1);
			}
			profile.setNonUsablePoiIds(stringIds);
		}
        
        for (PoiCategory cat : cats) {
			List<Integer> ids = poiDao.getPoiIdsByCategoryLocale(cat.getId(), locale);
			String stringIds = "";
			for (Integer id : ids) {
				stringIds += id.toString() + ",";				
			}
			//remove last ,
			if (stringIds.length() > 0) {
				stringIds = stringIds.substring(0, stringIds.length() - 1);
			}
			cat.setPois(stringIds);
		}
        
        model.addAttribute("profiles", profiles);
        model.addAttribute("poiCategories", cats);
        model.addAttribute("pois", pois);
        model.addAttribute("routes", routes);
        model.addAttribute("locale", locale);
        model.addAttribute("client", clientObj);
        model.addAttribute("messagesPoiOverview", hashMessagesPoiOverview);
        model.addAttribute("messagesMap", hashMessagesMap);
        
        logger.debug("leaving method getPois");
		return "poi-map";
	}
	
	@RequestMapping(value = "/poi/{poiId}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody Poi getPoiById(@PathVariable("poiId") int poiId) {
		logger.debug("entering method getPoiById");
		
        Poi poi = poiDao.getPoiById(poiId);
        
        logger.debug("leaving method getPoiById");
		return poi;
	}
	
	@RequestMapping(value = "/pois/{routeId}", headers="Accept=*/*", method=RequestMethod.GET)
	// TODO Darf die Methode diese Exception werfen oder muss dort etwas anderes hin wegen REST + JSON?
	public @ResponseBody List<Poi> getPoisByRouteId(@PathVariable("routeId") int routeId) throws Exception {
		logger.debug("entering method getPois");
		
		List<Poi> pois = poiDao.getPoisByRoute(routeId);
        
        logger.debug("leaving method getPois");
		return pois;
	}
	
	@RequestMapping(value = "/pois/{clientid}/{locale}", headers="Accept=*/*", method=RequestMethod.GET)
	// TODO Darf die Methode diese Exception werfen oder muss dort etwas anderes hin wegen REST + JSON?
	public @ResponseBody List<Poi> getUnassignedPois(@PathVariable("clientid") int clientId, @PathVariable("locale") String locale) throws Exception {
		logger.debug("entering method getUnassignedPois");
		
		if (!locale.matches("[a-z]{2}")) {
			logger.error("Fehlerhafte Parameter!");
			throw new Exception("Fehlerhafte Parameter!");
		}
		
		List<Poi> pois = poiDao.getPoisNotInRouteByClientLocale(clientId, locale);
        
        logger.debug("leaving method getUnassignedPois");
		return pois;
	}
	
	@RequestMapping(value = "/pois", method=RequestMethod.POST)
	// TODO Darf die Methode diese Exception werfen oder muss dort etwas anderes hin wegen REST + JSON?
	public @ResponseBody List<Poi> getPois(@ModelAttribute Integer[] poiIds) throws Exception {
		logger.debug("entering method getPois");
		
		logger.debug("poiIds.toString(): " + poiIds.toString());
		List<Poi> pois = poiDao.getPoisByIds(poiIds.toString());
        
        logger.debug("leaving method getPois");
		return pois;
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}
