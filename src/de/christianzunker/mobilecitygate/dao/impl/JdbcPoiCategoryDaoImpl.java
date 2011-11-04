package de.christianzunker.mobilecitygate.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import de.christianzunker.mobilecitygate.beans.PoiCategory;
import de.christianzunker.mobilecitygate.beans.Route;
import de.christianzunker.mobilecitygate.dao.PoiCategoryDao;

@Repository
public class JdbcPoiCategoryDaoImpl implements PoiCategoryDao {

	private static final Logger logger = Logger.getLogger(JdbcPoiCategoryDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<PoiCategory> getCategories() {
		logger.debug("entering method getCategories");
		List<PoiCategory> poiCategories = this.jdbcTemplate.query("SELECT id, name, short_name, icon, client_id, locale, published FROM poi_categories WHERE published = 1 ORDER BY poi_categories.name", new PoiCategoryMapper());
		logger.debug("leaving method getCategories");
		return poiCategories;
	}
	
	@Override
	public List<PoiCategory> getAllCategories() {
		logger.debug("entering method getCategories");
		List<PoiCategory> poiCategories = this.jdbcTemplate.query("SELECT id, name, short_name, icon, client_id, locale, published FROM poi_categories ORDER BY poi_categories.name", new PoiCategoryMapper());
		logger.debug("leaving method getCategories");
		return poiCategories;
	}
	
	@Override
	public List<PoiCategory> getCategoriesByClientLocale(int clientId, String locale) {
		logger.debug("entering method getCategories");
		List<PoiCategory> poiCategories = this.jdbcTemplate.query("SELECT id, name, short_name, icon, client_id, locale, published FROM poi_categories WHERE client_id = " + clientId + " AND locale = '" + locale + "' AND published = 1 ORDER BY poi_categories.name", new PoiCategoryMapper());
		logger.debug("leaving method getCategories");
		return poiCategories;
	}
	
	@Override
	public List<PoiCategory> getActiveCategoriesByClientLocale(int clientId, String locale) {
		logger.debug("entering method getCategories");
		List<PoiCategory> poiCategories = this.jdbcTemplate.query("SELECT DISTINCT poi_categories.id, poi_categories.name, poi_categories.short_name, poi_categories.icon, poi_categories.client_id, poi_categories.locale, poi_categories.published FROM poi_categories, rel_poi_category WHERE poi_categories.client_id = " + clientId + " AND poi_categories.id = rel_poi_category.category_id" + " AND poi_categories.locale = '" + locale + "' AND published = 1 ORDER BY poi_categories.name", new PoiCategoryMapper());
		logger.debug("leaving method getCategories");
		return poiCategories;
	}
	
	@Override
	public PoiCategory getCategoryByPoi(int poiId) {
		logger.debug("entering method getCategoryByPoi");
		PoiCategory cat = this.jdbcTemplate.queryForObject("SELECT poi_categories.id, poi_categories.name, poi_categories.short_name, poi_categories.icon, poi_categories.client_id, poi_categories.locale, poi_categories.published FROM poi_categories, rel_poi_category WHERE rel_poi_category.poi_id = " + poiId + " AND poi_categories.id = rel_poi_category.category_id", new PoiCategoryMapper());
		logger.debug("leaving method getCategoryByPoi");
		return cat;
	}
	
	@Override
	public PoiCategory getCategoryById(int categoryId) {
		logger.debug("entering method getCategoryById");
		PoiCategory cat = this.jdbcTemplate.queryForObject("SELECT id, name, short_name, icon, client_id, locale, published FROM poi_categories WHERE id = " + categoryId, new PoiCategoryMapper());
		logger.debug("leaving method getCategoryById");
		return cat;
	}
	
	@Override
	public int deleteCategoryById(int categoryId) {
		logger.debug("entering method deleteCategoryById");
		int rc = this.jdbcTemplate.update("DELETE FROM poi_categories WHERE id = " + categoryId);
		logger.debug("leaving method deleteCategoryById");
		return rc;
	}
	
	@Override
	public int updateCategoryById(int categoryId, PoiCategory category) {
    	logger.debug("entering method updateCategoryById");
    	int rc =  this.jdbcTemplate.update("UPDATE poi_categories SET name = '" + category.getName() + "', short_name = '" + category.getShortName() + "', icon = '" + category.getIcon() + "', locale = '" + category.getLocale() + "', client_id = " + category.getClientId() + " WHERE id = " + category.getId());
    	logger.debug("leaving method updateCategoryById");
    	return rc;
    }
	
	@Override
	public int publishCategoryById(int categoryId) {
    	logger.debug("entering method publishCategoryById");
    	int rc =  this.jdbcTemplate.update("UPDATE poi_categories SET published = 1 WHERE id = " + categoryId);
    	logger.debug("leaving method publishCategoryById");
    	return rc;
    }
	
	@Override
	public int publishCategories() {
    	logger.debug("entering method publishCategories");
    	int rc =  this.jdbcTemplate.update("UPDATE poi_categories SET published = 1");
    	logger.debug("leaving method publishCategories");
    	return rc;
    }
	
	@Override
    @Transactional (propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
    public int createCategory(PoiCategory category) {
    	logger.debug("entering method createCategory");
    	int rc =  this.jdbcTemplate.update("INSERT INTO poi_categories (name, short_name, icon, locale, client_id) VALUES ('" + category.getName() + "', '" + category.getShortName() + "', '" + category.getIcon() + "', '" + category.getLocale() + "'," + category.getClientId() + ")");
    	int categoryId = this.jdbcTemplate.queryForInt("SELECT last_insert_id() from poi_categories LIMIT 1", null, null);
    	logger.debug("leaving method createCategory");
    	return categoryId;
    }

	private static final class PoiCategoryMapper implements RowMapper<PoiCategory> {
    	
    	private static final Logger logger = Logger.getLogger(PoiCategoryMapper.class);

        public PoiCategory mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	PoiCategory poiCategory = new PoiCategory();
            poiCategory.setId(rs.getInt("id"));
            poiCategory.setClientId(rs.getInt("client_id"));
            poiCategory.setName(rs.getString("name"));
            poiCategory.setLocale(rs.getString("locale"));
            poiCategory.setShortName(rs.getString("short_name"));
            poiCategory.setIcon(rs.getString("icon"));
            poiCategory.setPublished(rs.getInt("published"));
            logger.debug("leaving method mapRow");
            return poiCategory;
        }        
    }
}
