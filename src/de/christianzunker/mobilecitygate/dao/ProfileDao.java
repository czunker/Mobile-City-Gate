package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import de.christianzunker.mobilecitygate.beans.Profile;

public interface ProfileDao {
	
	public List<Profile> getProfiles();
	
	public List<Profile> getActiveProfilesByClientLocale(int clientId, String locale);
	
	public List<Profile> getProfilesByLocale(String locale);
	
	public List<Profile> getProfilesByPoi(int poiId);

}
