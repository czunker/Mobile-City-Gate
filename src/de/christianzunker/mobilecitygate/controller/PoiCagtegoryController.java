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


import de.christianzunker.mobilecitygate.beans.PoiCategory;
import de.christianzunker.mobilecitygate.beans.Route;
import de.christianzunker.mobilecitygate.dao.PoiCategoryDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class PoiCagtegoryController {
	
	private static final Logger logger = Logger.getLogger(PoiCagtegoryController.class);
	
	@Autowired
	private PoiCategoryDao catDao;
	
	@RequestMapping(value = "/poicategories/{clientId}/{locale}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody List<PoiCategory> getPoiCategories(@PathVariable("clientId") int clientId, @PathVariable("locale") String locale) {
		logger.debug("entering method getPoiCategories");
		
		List<PoiCategory> cats = catDao.getCategoriesByClientLocale(clientId, locale);

		logger.debug("leaving method getPoiCategories");
		return cats;
	}
	
	@RequestMapping(value = "/poicategory/poi/{poiId}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody PoiCategory getPoiCategoryByPoi(@PathVariable("poiId") int poiId) {
		logger.debug("entering method getPoiCategoryByPoi");
		
		PoiCategory cat = catDao.getCategoryByPoi(poiId);

		logger.debug("leaving method getPoiCategoryByPoi");
		return cat;
	}
	
	@RequestMapping(value = "/poicategory/{categoryId}", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody PoiCategory getPoiCategoryById(@PathVariable("categoryId") int categoryId) {
		logger.debug("entering method getPoiCategoryById");
		
		PoiCategory category = catDao.getCategoryById(categoryId);
        
        logger.debug("leaving method getPoiCategoryById");
		return category;
	}
	
	@RequestMapping(value = "/poicategory/{categoryId}", headers="Accept=*/*", method=RequestMethod.DELETE)
	public @ResponseBody int deletePoiCategoryById(@PathVariable("categoryId") int categoryId) {
		logger.debug("entering method deletePoiCategoryById");
		
		int rc = catDao.deleteCategoryById(categoryId);
        
        logger.debug("leaving method deletePoiCategoryById");
		return rc;
	}
	
	@RequestMapping(value = "/poicategory/{categoryId}", headers="Accept=application/json", method=RequestMethod.POST)
	public @ResponseBody int setPoiCategoryById(@PathVariable("categoryId") int categoryId, @RequestBody PoiCategory category) {
		logger.debug("entering method setPoiCategoryById");
		
		int rc = 0;
		if (categoryId > 0) {
			rc = catDao.updateCategoryById(categoryId, category);
		}
		else {
			// TODO: verify shortName is unique, DB constraint?
			rc = catDao.createCategory(category);
		}
        
        logger.debug("leaving method setPoiCategoryById");
        return rc;
	}
	
	@RequestMapping(value = "/poicategory/publish/{categoryId}", headers="Accept=application/json", method=RequestMethod.POST)
	public @ResponseBody int publishPoiCategoryById(@PathVariable("categoryId") int categoryId) {
		logger.debug("entering method publishPoiCategoryById");
		
		int	rc = catDao.publishCategoryById(categoryId);
        
        logger.debug("leaving method publishPoiCategoryById");
        return rc;
	}
	
	@RequestMapping(value = "/poicategory/publish", headers="Accept=application/json", method=RequestMethod.POST)
	public @ResponseBody int publishPoiCategories() {
		logger.debug("entering method publishPoiCategoryById");
		
		// TODO: Publish routes by client and locale depending on the logged in user and his rights
		int	rc = catDao.publishCategories();
        
        logger.debug("leaving method publishPoiCategoryById");
        return rc;
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		logger.error("Error in " + this.getClass(), ex);
		return "general-error";
	}
}