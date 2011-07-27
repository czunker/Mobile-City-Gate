package de.christianzunker.mobilecitygate.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import de.christianzunker.mobilecitygate.beans.Route;
import de.christianzunker.mobilecitygate.dao.PoiDao;
import de.christianzunker.mobilecitygate.dao.RouteDao;

@Controller
public class RouteController {

	private static final Logger logger = Logger.getLogger(RouteController.class);
	
	@Autowired
	private RouteDao routeDao;
	
	@Autowired
	private PoiDao poiDao;
	
	@RequestMapping(value = "/routes/{clientid}/{locale}", headers="Accept=*/*", method=RequestMethod.GET)
	// TODO Darf die Methode diese Exception werfen oder muss dort etwas anderes hin wegen REST + JSON?
	public @ResponseBody List<Route> getRoutes(@PathVariable("clientid") int clientId, @PathVariable("locale") String locale) throws Exception {
		logger.debug("entering method getRoutes");
		
		if (!locale.matches("[a-z]{2}")) {
			logger.error("Fehlerhafte Parameter!");
			throw new Exception("Fehlerhafte Parameter!");
		}
		
		List<Route> routes = routeDao.getRouteListByClientLocale(clientId, locale);
		
		for (Route route : routes) {
			route.setPois(poiDao.getPoisByRouteLocale(route.getId(), locale));
			if (logger.isDebugEnabled()) {
        		logger.debug("#route pois: " + route.getPois().size());
			}
		}
        
        logger.debug("leaving method getRoutes");
		return routes;
	}
	
	@RequestMapping(value = "/route/{routeId}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody Route getRouteById(@PathVariable("routeId") int routeId) {
		logger.debug("entering method getRouteById");
		
		Route route = routeDao.getRouteById(routeId);
        
        logger.debug("leaving method getRouteById");
		return route;
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}
