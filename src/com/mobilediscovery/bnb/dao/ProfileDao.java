package com.mobilediscovery.bnb.dao;

import java.util.List;

import com.mobilediscovery.bnb.beans.Profile;

public interface ProfileDao {
	
	public List<Profile> getProfiles();
	
	public List<Profile> getActiveProfilesByClientLocale(int clientId, String locale);

}
