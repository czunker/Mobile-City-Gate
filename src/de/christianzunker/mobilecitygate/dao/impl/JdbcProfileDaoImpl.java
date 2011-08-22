package de.christianzunker.mobilecitygate.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;


import de.christianzunker.mobilecitygate.beans.Profile;
import de.christianzunker.mobilecitygate.dao.ProfileDao;

@Repository
public class JdbcProfileDaoImpl implements ProfileDao {

	private static final Logger logger = Logger.getLogger(JdbcProfileDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<Profile> getProfiles() {
		logger.debug("entering method getDisabilities");
		List<Profile> profiles = this.jdbcTemplate.query("SELECT id, name, short_name, icon FROM profiles ORDER BY profiles.name", new ProfileMapper());
		logger.debug("leaving method getDisabilities");
		return profiles;
	}
	
	@Override
	public List<Profile> getActiveProfilesByClientLocale(int clientId, String locale) {
		logger.debug("entering method getDisabilities");
		List<Profile> profiles = this.jdbcTemplate.query("SELECT DISTINCT profiles.id, profiles.name, profiles.short_name, profiles.icon FROM profiles, rel_poi_profile, pois WHERE profiles.id = rel_poi_profile.profile_id AND pois.id = rel_poi_profile.poi_id AND pois.client_id = " + clientId + " AND profiles.locale = '" + locale + "' ORDER BY profiles.name", new ProfileMapper());
		logger.debug("leaving method getDisabilities");
		return profiles;
	}
	
	private static final class ProfileMapper implements RowMapper<Profile> {
    	
    	private static final Logger logger = Logger.getLogger(ProfileMapper.class);

        public Profile mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	Profile profile = new Profile();
            profile.setId(rs.getInt("id"));
            profile.setName(rs.getString("name"));
            profile.setShortName(rs.getString("short_name"));
            profile.setIcon(rs.getString("icon"));
            logger.debug("leaving method mapRow");
            return profile;
        }        
    }
}
