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


import de.christianzunker.mobilecitygate.beans.Poi;
import de.christianzunker.mobilecitygate.dao.PoiDao;

@Repository
public class JdbcPoiDaoImpl implements PoiDao{

	private static final Logger logger = Logger.getLogger(JdbcPoiDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<Poi> getPois() {
		logger.debug("entering method getPois");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND published = 1", new PoiMapper());
		logger.debug("leaving method getPois");
		return pois;
	}
	
	@Override
	public Poi getPoiById(int id) {
		logger.debug("entering method getPoiById");
		Poi poi = this.jdbcTemplate.queryForObject("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND pois.id = " + id, new PoiMapper());
		logger.debug("leaving method getPoiById");
		return poi;
	}
	
	@Override
	@Transactional (propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int updatePoiById(int id, Poi poi) {
		logger.debug("entering method setPoiById");
		int rc = 0;
		rc =  this.jdbcTemplate.update("UPDATE pois SET name = '" + poi.getName() + "', description = '" + poi.getDescription() + "', lon = " + poi.getLon() + ", lat = " + poi.getLat() + ", ivr_number = '" + poi.getIvrNumber() + "', locale = '" + poi.getLocale() + "' WHERE id = " + id);
		logger.debug("leaving method setPoiById");
		return rc;
	}
	
	@Override
	@Transactional (propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int createPoi(Poi poi) {
		logger.debug("entering method setPoiById");
		int rc = 0;
		rc = this.jdbcTemplate.update("INSERT INTO pois (name, description, lon, lat, ivr_number, locale, client_id) VALUES ('" + poi.getName() + "', '" + poi.getDescription() + "', " + poi.getLon() + ", " + poi.getLat() + ", '" + poi.getIvrNumber() + "', '" + poi.getLocale() + "', " + poi.getClientId() + ")");
		int poiId = this.jdbcTemplate.queryForInt("SELECT last_insert_id() from pois LIMIT 1", null, null);
		rc = this.jdbcTemplate.update("INSERT INTO rel_poi_category (poi_id, category_id) VALUES (" + poiId + ", " + poi.getPoiCategoryId() + ")");
		if (!poi.getPoiProfileIds().isEmpty()) {
			for (Integer profileId : poi.getPoiProfileIds()) {
				rc = this.jdbcTemplate.update("INSERT INTO rel_poi_profile (poi_id, category_id) VALUES (" + poiId + ", " + profileId + ")");
			}
		}
		rc = poiId;
		logger.debug("added new poi with id: " + poiId);
		logger.debug("leaving method setPoiById");
		return rc;
	}
	
	@Override
	public int deletePoiById(int id) {
		logger.debug("entering method deletePoiById");
		int rc =  this.jdbcTemplate.update("DELETE FROM pois WHERE id = " + id);
		logger.debug("leaving method deletePoiById");
		return rc;
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
		List<Integer> poiIds = this.jdbcTemplate.queryForList("SELECT poi_id FROM pois, rel_poi_profile WHERE profile_id = " + profileId + " AND pois.id = poi_id AND pois.client_id = " + clientId + " AND pois.locale ='" + locale + "' AND published = 1", Integer.class);
		logger.debug("leaving method getPoiIdsByProfileByClientLocale");
		return poiIds;
	}
	
	@Override
	public List<Integer> getPoiIdsByCategoryLocale(int categoryId, String locale) {
		logger.debug("entering method getPoiIdsByCategoryLocale");
		List<Integer> poiIds = this.jdbcTemplate.queryForList("SELECT poi_id FROM rel_poi_category, pois WHERE category_id = " + categoryId + " AND pois.id = rel_poi_category.poi_id AND pois.locale ='" + locale + "' AND published = 1", Integer.class);
		logger.debug("leaving method getPoiIdsByCategoryLocale");
		return poiIds;
	}
	
	@Override
	public List<Poi> getPoisByRouteLocale(int routeId, String locale) {
		logger.debug("entering method getPoisByRouteLocale");
		String sql = "SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.id IN (SELECT poi_id from rel_poi_route WHERE route_id = " + routeId + ") AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND pois.locale ='" + locale + "' AND pois.published = 1";
		logger.debug("sql: " + sql);
		List<Poi> pois = this.jdbcTemplate.query(sql, new PoiMapper());
		logger.debug("leaving method getPoisByRouteLocale");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisByRoute(int routeId) {
		logger.debug("entering method getPoisByRouteLocale");
		String sql = "SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.id IN (SELECT poi_id from rel_poi_route WHERE route_id = " + routeId + ") AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND published = 1";
		logger.debug("sql: " + sql);
		List<Poi> pois = this.jdbcTemplate.query(sql, new PoiMapper());
		logger.debug("leaving method getPoisByRouteLocale");
		return pois;
	}
	
	@Override
	public int createPoiRoute(int poiId, Poi poi) {
		logger.debug("entering method updatePoiRoute");
		int rc =  this.jdbcTemplate.update("INSERT INTO rel_poi_route (route_id, poi_id) VALUES (" + poi.getRouteId() + ", " + poiId + ")");
		logger.debug("leaving method updatePoiRoute");
		return rc;
	}
	
	@Override
	public int updatePoiRoute(int poiId, Poi poi) {
		logger.debug("entering method updatePoiRoute");
		int rc =  this.jdbcTemplate.update("UPDATE rel_poi_route SET route_id = " + poi.getRouteId() + " WHERE poi_id = " + poiId);
		logger.debug("leaving method updatePoiRoute");
		return rc;
	}
	
	@Override
	public int deletePoiRoute(int poiId, Poi poi) {
		logger.debug("entering method setPoiRoute");
		int rc =  this.jdbcTemplate.update("DELETE FROM rel_poi_route WHERE poi_id = " + poiId);
		logger.debug("leaving method setPoiRoute");
		return rc;
	}
	
	@Override
	public int publishPoiById(int poiId) {
		logger.debug("entering method publishPoiById");
		int rc =  this.jdbcTemplate.update("UPDATE pois set published = 1 WHERE poi_id = " + poiId);
		logger.debug("leaving method publishPoiById");
		return rc;
	}
	
	@Override
	public int publishAllPois() {
		logger.debug("entering method publishAllPois");
		int rc =  this.jdbcTemplate.update("UPDATE pois set published = 1");
		logger.debug("leaving method publishAllPois");
		return rc;
	}
	
	@Override
	public List<Poi> getPoisNotInRouteByLocale(String locale) {
		logger.debug("entering method getPoisNotInRouteByLocale");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.id NOT IN (SELECT poi_id FROM rel_poi_route) AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND pois.locale ='" + locale + "'  AND published = 1", new PoiMapper());
		logger.debug("leaving method getPoisNotInRouteByLocale");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisNotInRouteByClientLocale(int clientId, String locale) {
		logger.debug("entering method getPoisNotInRouteByClientLocale");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.id NOT IN (SELECT poi_id FROM rel_poi_route) AND pois.client_id = " + clientId + " AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id AND pois.locale ='" + locale + "'  AND pois.published = 1", new PoiMapper());
		logger.debug("leaving method getPoisNotInRouteByClientLocale");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisByIds(String poiIds) {
		logger.debug("entering method getPoisByIds");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.id IN (" + poiIds + ") AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id", new PoiMapper());
		logger.debug("leaving method getPoisByIds");
		return pois;
	}
	
	@Override
	public List<Poi> getPoisByClientLocale(int clientId, String locale) {
		logger.debug("entering method getPoisByClientLocale");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.client_id = " + clientId + " AND pois.locale = '" + locale + "' AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id WHERE published = 1", new PoiMapper());
		logger.debug("leaving method getPoisByClientLocale");
		return pois;
	}
	
	@Override
	public List<Poi> getAllPoisByClientLocale(int clientId, String locale) {
		logger.debug("entering method getPoisByClientLocale");
		List<Poi> pois = this.jdbcTemplate.query("SELECT pois.id, pois.name, pois.description, pois.lon, pois.lat, poi_categories.icon, pois.ivr_number, pois.ivr_text_url, pois.locale, pois.client_id, pois.published FROM pois, poi_categories, rel_poi_category WHERE pois.client_id = " + clientId + " AND pois.locale = '" + locale + "' AND pois.id = rel_poi_category.poi_id AND rel_poi_category.category_id = poi_categories.id", new PoiMapper());
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
            poi.setClientId(rs.getInt("client_id"));
            poi.setPublished(rs.getInt("published"));
            logger.debug("leaving method mapRow");
            return poi;
        }        
    }

}
