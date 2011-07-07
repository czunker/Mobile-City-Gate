package com.mobilediscovery.bnb.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.mobilediscovery.bnb.beans.PoiCategory;
import com.mobilediscovery.bnb.dao.PoiCategoryDao;

@Repository
public class JdbcPoiCategoryDaoImpl implements PoiCategoryDao {

	private static final Logger logger = Logger.getLogger(JdbcPoiCategoryDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<PoiCategory> getCategories() {
		logger.debug("entering method getCategories");
		List<PoiCategory> poiCategories = this.jdbcTemplate.query("SELECT id, name, short_name, icon FROM poi_categories", new PoiCategoryMapper());
		logger.debug("leaving method getCategories");
		return poiCategories;
	}
	
	@Override
	public List<PoiCategory> getCategoriesByClientLocale(int clientId, String locale) {
		logger.debug("entering method getCategories");
		List<PoiCategory> poiCategories = this.jdbcTemplate.query("SELECT id, name, short_name, icon FROM poi_categories WHERE client_id = " + clientId + " AND locale = '" + locale + "'", new PoiCategoryMapper());
		logger.debug("leaving method getCategories");
		return poiCategories;
	}
	
	@Override
	public List<PoiCategory> getActiveCategoriesByClientLocale(int clientId, String locale) {
		logger.debug("entering method getCategories");
		List<PoiCategory> poiCategories = this.jdbcTemplate.query("SELECT DISTINCT poi_categories.id, poi_categories.name, poi_categories.short_name, poi_categories.icon FROM poi_categories, rel_poi_category WHERE poi_categories.client_id = " + clientId + " AND poi_categories.id = rel_poi_category.category_id" + " AND poi_categories.locale = '" + locale + "'", new PoiCategoryMapper());
		logger.debug("leaving method getCategories");
		return poiCategories;
	}

	private static final class PoiCategoryMapper implements RowMapper<PoiCategory> {
    	
    	private static final Logger logger = Logger.getLogger(PoiCategoryMapper.class);

        public PoiCategory mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	PoiCategory poiCategory = new PoiCategory();
            poiCategory.setId(rs.getInt("id"));
            poiCategory.setName(rs.getString("name"));
            poiCategory.setShortName(rs.getString("short_name"));
            poiCategory.setIcon(rs.getString("icon"));
            logger.debug("leaving method mapRow");
            return poiCategory;
        }        
    }
}
