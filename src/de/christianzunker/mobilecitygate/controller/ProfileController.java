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


import de.christianzunker.mobilecitygate.beans.Profile;
import de.christianzunker.mobilecitygate.dao.ProfileDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ProfileController { // NO_UCD
	
	private static final Logger logger = Logger.getLogger(ProfileController.class);
	
	@Autowired
	private ProfileDao profileDao;
	
	@RequestMapping(value = "/profiles/{locale}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody List<Profile> getProfiles(@PathVariable("locale") String locale) {
		logger.debug("entering method getProfiles");
		
		List<Profile> profiles = profileDao.getProfilesByLocale(locale);

		logger.debug("leaving method getProfiles");
		return profiles;
	}
	
	@RequestMapping(value = "/profiles/poi/{poiId}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody List<Profile> getProfilesByPoi(@PathVariable("poiId") int poiId) {
		logger.debug("entering method getProfilesByPoi");
		
		List<Profile> profiles = profileDao.getProfilesByPoi(poiId);

		logger.debug("leaving method getProfilesByPoi");
		return profiles;
	}

	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}