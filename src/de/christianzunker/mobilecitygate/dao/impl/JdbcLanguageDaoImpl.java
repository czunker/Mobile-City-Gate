package de.christianzunker.mobilecitygate.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import de.christianzunker.mobilecitygate.beans.Language;
import de.christianzunker.mobilecitygate.beans.Poi;
import de.christianzunker.mobilecitygate.dao.LanguageDao;

@Repository
public class JdbcLanguageDaoImpl implements LanguageDao { // NO_UCD

	private static final Logger logger = Logger.getLogger(JdbcLanguageDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<Language> getLanguages() {
		logger.debug("entering method getLanguages");
		List<Language> languages = this.jdbcTemplate.query("SELECT languages.id, language_long, language_short, icon, client_id, clients.name as client FROM clients, languages WHERE client_id = clients.id", new LanguageMapper());
		logger.debug("leaving method getLanguages");
		return languages;
	}
	
	@Override
	public Language getLanguageById(int languageId) {
		logger.debug("entering method getLanguageById");
		Language lang = this.jdbcTemplate.queryForObject("SELECT languages.id, language_long, language_short, icon, client_id, clients.name as client FROM clients, languages WHERE client_id = clients.id AND languages.id = " + languageId, new LanguageMapper());
		logger.debug("leaving method getLanguageById");
		return lang;
	}
	
	@Override
	public List<Language> getLanguagesByClient(int clientId) {
		logger.debug("entering method getLanguagesByClient");
		List<Language> languages = this.jdbcTemplate.query("SELECT languages.id, language_long, language_short, icon, client_id, clients.name as client FROM clients, languages WHERE client_id = clients.id AND client_id = " + clientId, new LanguageMapper());
		logger.debug("leaving method getLanguagesByClient");
		return languages;
	}
	
	@Override
	public int deleteLanguageById(Language lang) {
		logger.debug("entering method deleteLanguageById");
		int rc =  this.jdbcTemplate.update("DELETE FROM messages WHERE client_id = " + lang.getClientId() + " AND locale = '" + lang.getShortName() + "'");
		rc =  this.jdbcTemplate.update("DELETE FROM languages WHERE id = " + lang.getId());
		logger.debug("leaving method deleteLanguageById");
		return rc;
	}
	
	@Override
	public int updateLanguageById(Language lang) {
		logger.debug("entering method updateLanguageById");
		int rc =  this.jdbcTemplate.update("UPDATE languages SET language_long = '" + lang.getName() + "', language_short = '" + lang.getShortName() + "', icon = '" + lang.getIcon() + "' WHERE id = " + lang.getId());
		logger.debug("leaving method updateLanguageById");
		return rc;
	}
	
	@Override
	@Transactional (propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int createLanguage(Language lang) {
		logger.debug("entering method createLanguage");
		int rc = 0;
		Language srcLang = null;
		try {
			srcLang = this.jdbcTemplate.queryForObject("SELECT * FROM languages WHERE language_short = '" + lang.getShortName() + "' LIMIT 0,1", new LanguageMapper());
		}
		catch (EmptyResultDataAccessException ex) {
			logger.info("Noone has language with shortname " + lang.getShortName());
		}
		rc = this.jdbcTemplate.update("INSERT INTO languages (language_long, language_short, icon, client_id) VALUES ('" + lang.getName() + "', '" + lang.getShortName() + "', '" + lang.getIcon() + "', " + lang.getClientId() + ")");
		int langId = this.jdbcTemplate.queryForInt("SELECT last_insert_id() from languages LIMIT 1", null, null);
		if (srcLang != null && srcLang.getId() > 0) {
			// language already exisits for other client => use it to prepopulate messages
			rc = this.jdbcTemplate.update("INSERT INTO messages (message_key, message_text, page, locale, client_id) SELECT message_key, message_text, page, locale, " + lang.getClientId() + " FROM messages WHERE client_id = " + srcLang.getClientId() + " AND locale = '" + lang.getShortName() + "'");
		}
		else {
			// language doesn't exist in system, prepopulate with german
			rc = this.jdbcTemplate.update("INSERT INTO messages (message_key, message_text, page, locale, client_id) SELECT message_key, message_text, page, '" + lang.getShortName() + "', " + lang.getClientId() + " FROM messages WHERE client_id = " + lang.getClientId() + " AND locale = 'de'");
		}
		logger.debug("added new language with id: " + langId);
		logger.debug("leaving method createLanguage");
		return langId;
	}

	private static final class LanguageMapper implements RowMapper<Language> {
    	
    	private static final Logger logger = Logger.getLogger(LanguageMapper.class);

        public Language mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	Language lang = new Language();
            lang.setId(rs.getInt("id"));
            lang.setName(rs.getString("language_long"));
            lang.setShortName(rs.getString("language_short"));
            lang.setIcon(rs.getString("icon"));
            try {
            	lang.setClient(rs.getString("client"));
            }
            catch (SQLException ex) {
            	logger.warn("Couldn't find column client, but it isn't needed by all SQL queries!");
            }
            lang.setClientId(rs.getInt("client_id"));
            logger.debug("leaving method mapRow");
            return lang;
        }        
    }
}
