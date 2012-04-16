package de.christianzunker.mobilecitygate.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import de.christianzunker.mobilecitygate.beans.Route;
import de.christianzunker.mobilecitygate.dao.RouteDao;

@Repository
public class JdbcRouteDaoImpl implements RouteDao { // NO_UCD
	
	private static final Logger logger = Logger.getLogger(JdbcRouteDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
    public List<Route> getRouteList() {
    	logger.debug("entering method getRouteList");
        List<Route> routes = this.jdbcTemplate.query("SELECT id, name, description, length, kml_file, locale, length_unit, start_lon, start_lat, color, end_lon, end_lat, client_id, published FROM routes WHERE published = 1", new RouteMapper());
        logger.debug("leaving method getRouteList");
        return routes;
    }
    
    public List<Route> getAllRoutes() {
    	logger.debug("entering method getRouteList");
        List<Route> routes = this.jdbcTemplate.query("SELECT id, name, description, length, kml_file, locale, length_unit, start_lon, start_lat, color, end_lon, end_lat, client_id, published FROM routes", new RouteMapper());
        logger.debug("leaving method getRouteList");
        return routes;
    }
    
    public List<Route> getRouteListByClientLocale(int clientId, String locale) {
    	logger.debug("entering method getRouteList");
        List<Route> routes = this.jdbcTemplate.query("SELECT id, name, description, length, kml_file, locale, length_unit, start_lon, start_lat, color, end_lon, end_lat, client_id, published FROM routes WHERE client_id = " + clientId + " AND locale = '" + locale + "' AND published = 1", new RouteMapper());
        logger.debug("leaving method getRouteList");
        return routes;
    }
    
    public int deleteRouteById(int routeId) {
    	logger.debug("entering method getRouteById");
    	int rc = this.jdbcTemplate.update("DELETE FROM routes WHERE id = " + routeId);
    	logger.debug("leaving method getRouteById");
    	return rc;
    }
    
    public Route getRouteById(int routeId) {
    	logger.debug("entering method getRouteById");
    	Route route = this.jdbcTemplate.queryForObject("SELECT id, name, description, length, kml_file, locale, length_unit, start_lon, start_lat, color, end_lon, end_lat, client_id, published FROM routes WHERE id = " + routeId, new RouteMapper());
    	logger.debug("leaving method getRouteById");
    	return route;
    }
    
    public Route getRouteByPoiId(int poiId) throws EmptyResultDataAccessException {
    	logger.debug("entering method getRouteByPoiId");
    	Route route = this.jdbcTemplate.queryForObject("SELECT routes.id, name, description, length, kml_file, locale, length_unit, start_lon, start_lat, color, end_lon, end_lat, client_id, published FROM routes, rel_poi_route WHERE rel_poi_route.route_id = routes.id AND rel_poi_route.poi_id = " + poiId, new RouteMapper());
    	logger.debug("leaving method getRouteByPoiId");
    	return route;
    }
    
    public int updateRouteById(int routeId, Route route) {
    	logger.debug("entering method updateRouteById");
    	int rc =  this.jdbcTemplate.update("UPDATE routes SET name = '" + route.getName() + "', description = '" + route.getDescription() + "', length = " + route.getLength() + ", length_unit = '" + route.getLengthUnit() + "', start_lon = " + route.getStartLon() + ", start_lat = " + route.getStartLat() + ", end_lon = " + route.getEndLon() + ", end_lat = " + route.getEndLat() + ", color = '" + route.getColor() + "', locale = '" + route.getLocale() + "', client_id = " + route.getClientId() + ", kml_file = '" + route.getMapKML() + "' WHERE id = " + routeId);
    	logger.debug("leaving method updateRouteById");
    	return rc;
    }
    
    public int publishRouteById(int routeId) {
    	logger.debug("entering method publishRouteById");
    	int rc =  this.jdbcTemplate.update("UPDATE routes SET published = 1 WHERE id = " + routeId);
    	logger.debug("leaving method publishRouteById");
    	return rc;
    }
    
    public int publishAllRoutes() {
    	logger.debug("entering method publishAllRoutes");
    	int rc =  this.jdbcTemplate.update("UPDATE routes SET published = 1");
    	logger.debug("leaving method publishAllRoutes");
    	return rc;
    }
    
    @Transactional (propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
    public int createRoute(Route route) {
    	logger.debug("entering method createRouteById");
    	int rc =  this.jdbcTemplate.update("INSERT INTO routes (name, description, length, length_unit, start_lon, start_lat, end_lon, end_lat, color, locale, kml_file, client_id) VALUES ('" + route.getName() + "', '" + route.getDescription() + "', " + route.getLength() + ", '" + route.getLengthUnit() + "', " + route.getStartLon() + ", " + route.getStartLat() + ", " + route.getEndLon() + ", " + route.getEndLat() + ", '" + route.getColor() + "', '" + route.getLocale() + "', '" + route.getMapKML() + "'," + route.getClientId() + ")");
    	int routeId = this.jdbcTemplate.queryForInt("SELECT last_insert_id() from routes LIMIT 1", null, null);
    	logger.debug("leaving method createRouteById");
    	return routeId;
    }
    
    public List<Route> getRoutesByIds(String routeIds) {
    	logger.debug("entering method getRouteList");
        List<Route> routes = this.jdbcTemplate.query("SELECT id, name, description, length, kml_file, locale, length_unit, start_lon, start_lat, color, end_lon, end_lat, client_id, published FROM routes WHERE id IN (" + routeIds + ")", new RouteMapper());
        logger.debug("leaving method getRouteList");
        return routes;
    }
    
    private static final class RouteMapper implements RowMapper<Route> {
    	
    	private static final Logger logger = Logger.getLogger(RouteMapper.class);

        public Route mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	Route route = new Route();
            route.setId(rs.getInt("id"));
            route.setName(rs.getString("name"));
            route.setLength(rs.getDouble("length"));
            route.setDescription(rs.getString("description"));
            route.setMapKML(rs.getString("kml_file"));
            route.setLocale(rs.getString("locale"));
            route.setLengthUnit(rs.getString("length_unit"));
            route.setStartLon(rs.getDouble("start_lon"));
            route.setStartLat(rs.getDouble("start_lat"));
            route.setEndLon(rs.getDouble("end_lon"));
            route.setEndLat(rs.getDouble("end_lat"));
            route.setColor(rs.getString("color"));
            route.setClientId(rs.getInt("client_id"));
            route.setPublished(rs.getInt("published"));
            logger.debug("leaving method mapRow");
            return route;
        }        
    }
}