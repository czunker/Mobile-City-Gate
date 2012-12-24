package de.christianzunker.mobilecitygate.controller;

import java.util.Collection;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import de.christianzunker.mobilecitygate.beans.Client;
import de.christianzunker.mobilecitygate.beans.Config;
import de.christianzunker.mobilecitygate.beans.Language;
import de.christianzunker.mobilecitygate.beans.Message;
import de.christianzunker.mobilecitygate.beans.Poi;
import de.christianzunker.mobilecitygate.beans.PoiCategory;
import de.christianzunker.mobilecitygate.beans.Route;
import de.christianzunker.mobilecitygate.dao.ClientDao;
import de.christianzunker.mobilecitygate.dao.LanguageDao;
import de.christianzunker.mobilecitygate.dao.MessageDao;
import de.christianzunker.mobilecitygate.dao.PoiCategoryDao;
import de.christianzunker.mobilecitygate.dao.PoiDao;
import de.christianzunker.mobilecitygate.dao.RouteDao;

@Controller
public class CmsController { // NO_UCD

	private static final Logger logger = Logger.getLogger(CmsController.class);
	
	@Autowired
	private Config config;
	
	@Autowired
	private PoiDao poiDao;
	
	@Autowired
	private ClientDao clientDao;
	
	@Autowired
	private RouteDao routeDao;
	
	@Autowired
	private PoiCategoryDao categoryDao;
	
	@Autowired
	private LanguageDao languageDao;
	
	@Autowired
	private MessageDao messageDao;
	
	@RequestMapping(value = "/cms/")
	public String getCmsData(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("entering method getCmsData");
		
		List<Poi> pois = new Vector<Poi>();
		Collection<GrantedAuthority> authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		for (GrantedAuthority grantedAuthority : authorities) {
			String authority = grantedAuthority.getAuthority();
			logger.debug("grantedAuthority: " + authority);
			if (authority.contains("client_")) {
				String clientUrl = authority.replaceFirst("client_", "");
				Client client = clientDao.getClientByUrl(clientUrl);
				logger.debug("authorized for Client: " + client.getName());
				List<Language> tempLanguages = languageDao.getLanguagesByClient(client.getId());
				for (Language language : tempLanguages) {
					List<Poi> tempPois = poiDao.getAllPoisByClientLocale(client.getId(), language.getShortName());
					pois.addAll(tempPois);
				}
				
			}
		}
		
		List<Route> routes = routeDao.getAllRoutes();
		
		List<PoiCategory> categories = categoryDao.getAllCategories();
		
		List<Message> messages = messageDao.getMessages();
		
		List<Language> languages = languageDao.getLanguages();
		
		List<Client> clients = clientDao.getClientsWithoutGlobal();
        
		model.addAttribute("tilesServers", config.getTilesServers());
        model.addAttribute("pois", pois);
        model.addAttribute("categories", categories);
        model.addAttribute("routes", routes);
        model.addAttribute("messages", messages);
        model.addAttribute("config", config);
        model.addAttribute("languages", languages);
        model.addAttribute("clients", clients);
        
        logger.debug("leaving method getCmsData");
		//return "cms-bootstrap";
		return "cms";
	}
	
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}
