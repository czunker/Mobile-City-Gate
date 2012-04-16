package de.christianzunker.mobilecitygate.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import de.christianzunker.mobilecitygate.beans.Client;
import de.christianzunker.mobilecitygate.beans.Language;
import de.christianzunker.mobilecitygate.dao.ClientDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ClientController { // NO_UCD
	
	private static final Logger logger = Logger.getLogger(ClientController.class);
	
	@Autowired
	private ClientDao clientDao;
	
	@RequestMapping(value = "/clients", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody List<Client> getClients() {
		logger.debug("entering method getClients");
		
		List<Client> clients = clientDao.getClientsWithoutGlobal();

		logger.debug("leaving method getClients");
		return clients;
	}
	
	@RequestMapping(value = "/client/{clientId}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody Client getClient(@PathVariable("clientId") int clientId) {
		logger.debug("entering method getClient");
		
		Client client = clientDao.getClientById(clientId);

		logger.debug("leaving method getClient");
		return client;
	}
	
	@RequestMapping(value = "/client/{clientId}", headers="Accept=application/json", method=RequestMethod.POST)
	public @ResponseBody int setClientById(@PathVariable("clientId") int clientId, @RequestBody Client client) {
		logger.debug("entering method setClientById");
		
		int rc = 0;
		if (clientId > 0) {
			rc = clientDao.updateClientById(client);
		}
		else {
			// TODO: good design? split it in multiple methods?
			rc = clientDao.createClient(client);
			clientId = rc;
		}
        logger.debug("leaving method setClientById");
        return rc;
	}
	
	@RequestMapping(value = "/client/{clientId}", method=RequestMethod.DELETE)
	public @ResponseBody int deleteClientById(@PathVariable("clientId") int clientId) {
		logger.debug("entering method deleteClientById");
		
		Client client = clientDao.getClientById(clientId);
        int rc = clientDao.deleteClientById(client);
        
        logger.debug("leaving method deleteClientById");
        return rc;
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}