package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import de.christianzunker.mobilecitygate.beans.Route;

public interface RouteDao {
    public List<Route> getRouteList();
    
    public List<Route> getAllRoutes();
    
    public List<Route> getRouteListByClientLocale(int clientId, String locale);
    
    public Route getRouteById(int routeId);
    
    public int deleteRouteById(int routeId);
    
    public int updateRouteById(int routeId, Route route);
    
    public int publishRouteById(int routeId);
    
    public int publishAllRoutes();
    
    public int createRoute(Route route);
    
    public List<Route> getRoutesByIds(String routeIds);

	public Route getRouteByPoiId(int poiId) throws EmptyResultDataAccessException;
	
}

