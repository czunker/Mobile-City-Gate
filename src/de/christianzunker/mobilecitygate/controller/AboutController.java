package de.christianzunker.mobilecitygate.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import de.christianzunker.mobilecitygate.beans.Client;
import de.christianzunker.mobilecitygate.dao.ClientDao;
import de.christianzunker.mobilecitygate.dao.MessageDao;

@Controller
public class AboutController { // NO_UCD
	
	private static final Logger logger = Logger.getLogger(AboutController.class);
	
	@Autowired
	private ClientDao clientDao;
	
	@Autowired
	private MessageDao messageDao;

	@RequestMapping(value = "/{client}/{locale}/about/")
	public String about(@PathVariable("client") String client, @PathVariable("locale") String locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("entering method about");
		
		if (!locale.matches("[a-z]{2}") ||
			!client.matches("[0-9a-zA-Z_-]*") ||
			client.length() > 45) {
			logger.error("Fehlerhafte Parameter!");
			throw new Exception("Fehlerhafte Parameter!");
		}
			
		Client clientObj = clientDao.getClientByUrl(client);
		HashMap<String, String> hashMessages = messageDao.getMessagesByPageClientIdLocale("about", clientObj.getId(), locale);
		
        model.addAttribute("client", clientObj);
        model.addAttribute("messages", hashMessages);
        model.addAttribute("locale", locale);
        logger.debug("leaving method about");
		return "about";
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "genqeral-error";
	}

}
