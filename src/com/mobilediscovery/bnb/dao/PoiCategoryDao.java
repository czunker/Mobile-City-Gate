package com.mobilediscovery.bnb.dao;

import java.util.List;

import com.mobilediscovery.bnb.beans.PoiCategory;

public interface PoiCategoryDao {

	public List<PoiCategory> getCategories();
	
	public List<PoiCategory> getCategoriesByClientLocale(int clientId, String locale);
	
	public List<PoiCategory> getActiveCategoriesByClientLocale(int clientId, String locale);
	
}
