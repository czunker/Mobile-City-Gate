package de.christianzunker.mobilecitygate.controller;

import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import de.christianzunker.mobilecitygate.beans.Language;
import de.christianzunker.mobilecitygate.beans.Poi;
import de.christianzunker.mobilecitygate.beans.PoiCategory;
import de.christianzunker.mobilecitygate.beans.Profile;
import de.christianzunker.mobilecitygate.beans.Route;
import de.christianzunker.mobilecitygate.dao.LanguageDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LanguageController { // NO_UCD
	
	private static final Logger logger = Logger.getLogger(LanguageController.class);
	
	@Autowired
	private LanguageDao languageDao;
	
	@RequestMapping(value = "/languages/{clientId}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody List<Language> getLanguagesByClient(@PathVariable("clientId") int clientId) {
		logger.debug("entering method getLanguagesByClient");
		
		List<Language> languages = languageDao.getLanguagesByClient(clientId);

		logger.debug("leaving method getLanguagesByClient");
		return languages;
	}
	
	@RequestMapping(value = "/language/{languageId}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody Language getLanguageById(@PathVariable("languageId") int languageId) {
		logger.debug("entering method getLanguageById");
		
		Language language = languageDao.getLanguageById(languageId);
                
        logger.debug("leaving method getLanguageById");
		return language;
	}
	
	@RequestMapping(value = "/language/{languageId}", headers="Accept=application/json", method=RequestMethod.POST)
	public @ResponseBody int setLanguageById(@PathVariable("languageId") int languageId, @RequestBody Language lang) {
		logger.debug("entering method setLanguageById");
		
		int rc = 0;
		if (languageId > 0) {
			rc = languageDao.updateLanguageById(lang);
		}
		else {
			// TODO: good design? split it in multiple methods?
			rc = languageDao.createLanguage(lang);
			languageId = rc;
		}
        logger.debug("leaving method setLanguageById");
        return rc;
	}
	
	@RequestMapping(value = "/language/{languageId}", method=RequestMethod.DELETE)
	public @ResponseBody int deleteLanguageById(@PathVariable("languageId") int languageId) {
		logger.debug("entering method deleteLanguageById");
		
		Language lang = languageDao.getLanguageById(languageId);
        int rc = languageDao.deleteLanguageById(lang);
        
        logger.debug("leaving method deleteLanguageById");
        return rc;
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}