package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import de.christianzunker.mobilecitygate.beans.Language;

public interface LanguageDao {

	public List<Language> getLanguages();

	public List<Language> getLanguagesByClient(int clientId);

}
