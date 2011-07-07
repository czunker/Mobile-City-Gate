package com.mobilediscovery.bnb.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.mobilediscovery.bnb.beans.Poi;
import com.mobilediscovery.bnb.dao.PoiDao;

@Repository
public class JdbcPoiDaoImpl implements PoiDao{

	private static final Logger logger = Logger.getLogger(JdbcPoiDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<Poi> getPois() {
		logger.debug("entering method getPois");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale FROM pois, poi_categories, rel_poi_category WHERE pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id", new PoiMapper());
		logger.debug("leaving method getPois");
		return pois;
	}
	
	@Override
	public Poi getPoiById(int id) {
		logger.debug("entering method getPoiById");
		Poi poi = this.jdbcTemplate.queryForObject("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale FROM pois, poi_categories, rel_poi_category WHERE pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND pois.id = " + id, new PoiMapper());
		logger.debug("leaving method getPoiById");
		return poi;
	}
	
	@Override
	public List<Integer> getPoiIdsByProfile(int profileId) {
		logger.debug("entering method getPoiIdsByProfile");
		List<Integer> poiIds = this.jdbcTemplate.queryForList("SELECT poi_id FROM rel_poi_profile WHERE profile_id = " + profileId, Integer.class);
		logger.debug("leaving method getPoiIdsByProfile");
		return poiIds;
	}
	
	@Override
	public List<Integer> getPoiIdsByProfileByClientLocale(int profileId, int clientId, String locale) {
		logger.debug("entering method getPoiIdsByProfileByClientLocale");
		List<Integer> poiIds = this.jdbcTemplate.queryForList("SELECT poi_id FROM pois, rel_poi_profile WHERE profile_id = " + profileId + " AND pois.id = poi_id AND pois.client_id = " + clientId + " AND pois.locale ='" + locale + "'", Integer.class);
		logger.debug("leaving method getPoiIdsByProfileByClientLocale");
		return poiIds;
	}
	
	@Override
	public List<Integer> getPoiIdsByCategoryLocale(int categoryId, String locale) {
		logger.debug("entering method getPoiIdsByCategoryLocale");
		List<Integer> poiIds = this.jdbcTemplate.queryForList("SELECT poi_id FROM rel_poi_category, pois WHERE category_id = " + categoryId + " AND pois.id = rel_poi_category.poi_id AND pois.locale ='" + locale + "'", Integer.class);
		logger.debug("leaving method getPoiIdsByCategoryLocale");
		return poiIds;
	}
	
	@Override
	public List<Poi> getPoisByRouteLocale(int routeId, String locale) {
		logger.debug("entering method getPoisByRouteLocale");
		String sql = "SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale FROM pois, poi_categories, rel_poi_category WHERE pois.id IN (SELECT poi_id from rel_poi_route WHERE route_id = " + routeId + ") AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND pois.locale ='" + locale + "'";
		logger.debug("sql: " + sql);
		List<Poi> pois = this.jdbcTemplate.query(sql, new PoiMapper());
		logger.debug("leaving method getPoisByRouteLocale");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisByRoute(int routeId) {
		logger.debug("entering method getPoisByRouteLocale");
		String sql = "SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale FROM pois, poi_categories, rel_poi_category WHERE pois.id IN (SELECT poi_id from rel_poi_route WHERE route_id = " + routeId + ") AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id";
		logger.debug("sql: " + sql);
		List<Poi> pois = this.jdbcTemplate.query(sql, new PoiMapper());
		logger.debug("leaving method getPoisByRouteLocale");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisNotInRouteByLocale(String locale) {
		logger.debug("entering method getPoisNotInRouteByLocale");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale FROM pois, poi_categories, rel_poi_category WHERE pois.id NOT IN (SELECT poi_id FROM rel_poi_route) AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND pois.locale ='" + locale + "'", new PoiMapper());
		logger.debug("leaving method getPoisNotInRouteByLocale");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisNotInRouteByClientLocale(int clientId, String locale) {
		logger.debug("entering method getPoisNotInRouteByClientLocale");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale FROM pois, poi_categories, rel_poi_category WHERE pois.id NOT IN (SELECT poi_id FROM rel_poi_route) AND pois.client_id = " + clientId + " AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND pois.locale ='" + locale + "'", new PoiMapper());
		logger.debug("leaving method getPoisNotInRouteByClientLocale");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisByIds(String poiIds) {
		logger.debug("entering method getPoisByIds");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale FROM pois, poi_categories, rel_poi_category WHERE pois.id IN (" + poiIds + ") AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id", new PoiMapper());
		logger.debug("leaving method getPoisByIds");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisByClientLocale(int clientId, String locale) {
		logger.debug("entering method getPoisByClientLocale");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale FROM pois, poi_categories, rel_poi_category WHERE pois.client_id = " + clientId + " AND locale = '" + locale + "' AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id", new PoiMapper());
		logger.debug("leaving method getPoisByClientLocale");
		return pois;
	}

	private static final class PoiMapper implements RowMapper<Poi> {
    	
    	private static final Logger logger = Logger.getLogger(PoiMapper.class);

        public Poi mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	Poi poi = new Poi();
            poi.setId(rs.getInt("id"));
            poi.setName(rs.getString("name"));
            poi.setDescription(rs.getString("description"));
            poi.setLon(rs.getDouble("lon"));
            poi.setLat(rs.getDouble("lat"));
            poi.setIcon(rs.getString("icon"));
            poi.setIvrNumber(rs.getString("ivr_number"));
            poi.setIvrTextUrl(rs.getString("ivr_text_url"));
            poi.setLocale(rs.getString("locale"));
            logger.debug("leaving method mapRow");
            return poi;
        }        
    }

}
