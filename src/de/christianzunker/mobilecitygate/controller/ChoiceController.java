package de.christianzunker.mobilecitygate.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;


import de.christianzunker.mobilecitygate.beans.Client;
import de.christianzunker.mobilecitygate.dao.ClientDao;
import de.christianzunker.mobilecitygate.dao.MessageDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ChoiceController {
	
	private static final Logger logger = Logger.getLogger(ChoiceController.class);
	
	@Autowired
	private ClientDao clientDao;
	
	@Autowired
	private MessageDao messageDao;

	@RequestMapping(value = "/")
	public String choice(Model model, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("entering method choice");
		
		List<Client> clients = clientDao.getClientsWithoutGlobal();
		HashMap<String, String> hashMessages = messageDao.getMessagesByPageClientIdLocale("choice", 0, "de");
		
        model.addAttribute("clients", clients);
        model.addAttribute("messages", hashMessages);
        logger.debug("leaving method choice");
		return "choice";
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}