package com.mobilediscovery.bnb.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.mobilediscovery.bnb.beans.Language;
import com.mobilediscovery.bnb.dao.LanguageDao;

@Repository
public class JdbcLanguageDaoImpl implements LanguageDao {

	private static final Logger logger = Logger.getLogger(JdbcLanguageDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<Language> getLanguages() {
		logger.debug("entering method getCategories");
		List<Language> languages = this.jdbcTemplate.query("SELECT id, language_long, language_short, icon FROM languages", new LanguageMapper());
		logger.debug("leaving method getCategories");
		return languages;
	}
	
	@Override
	public List<Language> getLanguagesByClient(int clientId) {
		logger.debug("entering method getCategories");
		List<Language> languages = this.jdbcTemplate.query("SELECT id, language_long, language_short, icon FROM languages WHERE client_id = " + clientId, new LanguageMapper());
		logger.debug("leaving method getCategories");
		return languages;
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
            logger.debug("leaving method mapRow");
            return lang;
        }        
    }
}
