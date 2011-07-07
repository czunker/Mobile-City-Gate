package com.mobilediscovery.bnb.dao;

import java.util.List;

import com.mobilediscovery.bnb.beans.Poi;

public interface PoiDao {

	public List<Poi> getPois();
	
	public List<Integer> getPoiIdsByProfile(int profileId);
	
	public List<Integer> getPoiIdsByCategoryLocale(int categoryId, String locale);
	
	public List<Poi> getPoisByIds(String poiIds);

	public List<Poi> getPoisNotInRouteByLocale(String locale);
	
	public List<Poi> getPoisNotInRouteByClientLocale(int clientId, String locale);

	public List<Poi> getPoisByRouteLocale(int routeId, String locale);
	
	public List<Poi> getPoisByRoute(int routeId);

	public List<Integer> getPoiIdsByProfileByClientLocale(int profileId, int clientId, String locale);

	public Poi getPoiById(int id);
	
	public List<Poi> getPoisByClientLocale(int clientId, String locale);
}
