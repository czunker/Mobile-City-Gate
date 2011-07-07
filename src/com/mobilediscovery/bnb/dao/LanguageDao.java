package com.mobilediscovery.bnb.dao;

import java.util.List;

import com.mobilediscovery.bnb.beans.Language;

public interface LanguageDao {

	public List<Language> getLanguages();

	public List<Language> getLanguagesByClient(int clientId);

}
