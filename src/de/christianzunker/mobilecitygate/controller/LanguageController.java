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


import de.christianzunker.mobilecitygate.beans.Language;
import de.christianzunker.mobilecitygate.dao.LanguageDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LanguageController {
	
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
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}