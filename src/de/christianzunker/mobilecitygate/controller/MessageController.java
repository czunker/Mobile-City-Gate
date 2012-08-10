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
import de.christianzunker.mobilecitygate.beans.Message;
import de.christianzunker.mobilecitygate.beans.Poi;
import de.christianzunker.mobilecitygate.beans.PoiCategory;
import de.christianzunker.mobilecitygate.beans.Profile;
import de.christianzunker.mobilecitygate.beans.Route;
import de.christianzunker.mobilecitygate.dao.LanguageDao;
import de.christianzunker.mobilecitygate.dao.MessageDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MessageController { // NO_UCD
	
	private static final Logger logger = Logger.getLogger(MessageController.class);
	
	@Autowired
	private MessageDao messageDao;
	
	@RequestMapping(value = "/messages/{clientId}/{locale}", headers="Accept=application/json", method=RequestMethod.GET)
	public @ResponseBody List<Message> getMessagesByClientAndLocale(@PathVariable("clientId") int clientId, @PathVariable("locale") String locale) {
		logger.debug("entering method getMessagesByClientAndLocale");
		
		List<Message> messages = messageDao.getMessagesByClientIdLocale(clientId, locale);

		logger.debug("leaving method getMessagesByClientAndLocale");
		return messages;
	}
	
	@RequestMapping(value = "/message/{messageId}", headers="Accept=application/json", method=RequestMethod.GET)
	public @ResponseBody Message getMessageById(@PathVariable("messageId") int messageId) {
		logger.debug("entering method getMessageById");
		
		Message message = messageDao.getMessageById(messageId);
                
        logger.debug("leaving method getMessageById");
		return message;
	}
	
	@RequestMapping(value = "/message/{messageId}", headers="Accept=application/json", method=RequestMethod.POST)
	public @ResponseBody int setMessageById(@PathVariable("messageId") int messageId, @RequestBody Message mesg) {
		logger.debug("entering method setMessageById");
		int rc = 0;
        logger.debug("leaving method setMessageById");
        return rc;
	}
	
	@RequestMapping(value = "/message/{messageId}", method=RequestMethod.DELETE)
	public @ResponseBody int deleteMessageById(@PathVariable("languageId") int languageId) {
		logger.debug("entering method deleteMessageById");
		int rc = 0;
        logger.debug("leaving method deleteMessageById");
        return rc;
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}