package com.mobilediscovery.bnb.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mobilediscovery.bnb.beans.Language;
import com.mobilediscovery.bnb.beans.Client;
import com.mobilediscovery.bnb.dao.LanguageDao;
import com.mobilediscovery.bnb.dao.ClientDao;
import com.mobilediscovery.bnb.dao.MessageDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = Logger.getLogger(HomeController.class);
	
	@Autowired
	private ClientDao clientDao;
	
	@Autowired
	private MessageDao messageDao;
	
	@Autowired
	private LanguageDao languageDao;

	@RequestMapping(value = "/{client}/{locale}/")
	public String home(@PathVariable("client") String client, @PathVariable("locale") String locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("entering method home");
		
		if (!locale.matches("[a-z]{2}") ||
			!client.matches("[0-9a-zA-Z_-]*") ||
			client.length() > 45) {
			logger.error("Fehlerhafte Parameter!");
			throw new Exception("Fehlerhafte Parameter!");
		}
		
		Client clientObj = clientDao.getClientByUrl(client);
		HashMap<String, String> hashMessagesHome = messageDao.getMessagesByPageClientIdLocale("home", clientObj.getId(), locale);
		HashMap<String, String> hashMessagesAbout = messageDao.getMessagesByPageClientIdLocale("about", clientObj.getId(), locale);
		List<Language> languages = languageDao.getLanguagesByClient(clientObj.getId());
		
        model.addAttribute("locale", locale);
        model.addAttribute("languages", languages);
        model.addAttribute("messagesHome", hashMessagesHome);
        model.addAttribute("messagesAbout", hashMessagesAbout);
        model.addAttribute("client", clientObj);
        logger.debug("leaving method home");
		return "home";
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}