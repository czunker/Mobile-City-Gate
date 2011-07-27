package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import de.christianzunker.mobilecitygate.beans.PoiCategory;

public interface PoiCategoryDao {

	public List<PoiCategory> getCategories();
	
	public List<PoiCategory> getCategoriesByClientLocale(int clientId, String locale);
	
	public List<PoiCategory> getActiveCategoriesByClientLocale(int clientId, String locale);
	
}
