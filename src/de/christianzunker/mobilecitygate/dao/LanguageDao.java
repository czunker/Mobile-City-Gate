package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import de.christianzunker.mobilecitygate.beans.Language;

public interface LanguageDao {

	public List<Language> getLanguages();

	public List<Language> getLanguagesByClient(int clientId);

	public Language getLanguageById(int languageId);

	public int createLanguage(Language lang);

	public int updateLanguageById(Language lang);

	public int deleteLanguageById(Language lang);
}
