package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import de.christianzunker.mobilecitygate.beans.PoiCategory;

public interface PoiCategoryDao {

	public List<PoiCategory> getCategories();
	
	public List<PoiCategory> getAllCategories();
	
	public List<PoiCategory> getCategoriesByClientLocale(int clientId, String locale);
	
	public List<PoiCategory> getActiveCategoriesByClientLocale(int clientId, String locale);
	
	public PoiCategory getCategoryByPoi(int poiId);

	public PoiCategory getCategoryById(int categoryId);

	public int deleteCategoryById(int categoryId);

	public int createCategory(PoiCategory category);

	public int updateCategoryById(int categoryId, PoiCategory category);

	public int publishCategories();

	public int publishCategoryById(int categoryId);
		
}
