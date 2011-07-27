package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import de.christianzunker.mobilecitygate.beans.Route;

public interface RouteDao {
    public List<Route> getRouteList();
    
    public List<Route> getRouteListByClientLocale(int clientId, String locale);
    
    public Route getRouteById(int routeId);
    
    public List<Route> getRoutesByIds(String routeIds);
    
}

