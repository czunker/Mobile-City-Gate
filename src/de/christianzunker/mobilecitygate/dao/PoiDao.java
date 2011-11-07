package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import de.christianzunker.mobilecitygate.beans.Poi;

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

	public int updatePoiById(int id, Poi poi);
	
	public int createPoi(Poi poi);
	
	public int createPoiRoute(int poiId, Poi poi);
	
	public int updatePoiRouteById(int poiId, int routeId);
	
	public int deletePoiRouteById(int poiId);
	
	public int deletePoiById(int poiId);

	public List<Poi> getAllPoisByClientLocale(int clientId, String locale);

	public int publishPoiById(int poiId);
	
	public int publishAllPois();

	public int updatePoiProfilesById(int id, Poi poi);

	public int deletePoiProfilesById(int id);

	public int deletePoiCategoryById(int poiId);

	public int updatePoiCategoryById(int poiId, int categoryId);	
}
