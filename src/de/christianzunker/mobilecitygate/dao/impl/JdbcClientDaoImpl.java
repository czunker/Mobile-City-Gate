package de.christianzunker.mobilecitygate.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;


import de.christianzunker.mobilecitygate.beans.Client;
import de.christianzunker.mobilecitygate.dao.ClientDao;

@Repository
public class JdbcClientDaoImpl implements ClientDao { // NO_UCD
	
private static final Logger logger = Logger.getLogger(JdbcClientDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<Client> getClients() {
		logger.debug("entering method getclients");
		List<Client> clients = this.jdbcTemplate.query("SELECT id, name, url, start_lon, start_lat, start_zoom, start_page_image, bg_image, homepage, social FROM clients", new ClientMapper());
		logger.debug("leaving method getclients");
		return clients;
	}
	
	@Override
	public List<Client> getClientsWithoutGlobal() {
		logger.debug("entering method getclients");
		List<Client> clients = this.jdbcTemplate.query("SELECT id, name, url, start_lon, start_lat, start_zoom, start_page_image, bg_image, homepage, social FROM clients WHERE id != 0", new ClientMapper());
		logger.debug("leaving method getclients");
		return clients;
	}
	
	@Override
	public Client getClientByUrl(String url) {
		logger.debug("entering method getclientByUrl");
		Client client = this.jdbcTemplate.queryForObject("SELECT id, name, url, start_lon, start_lat, start_zoom, start_page_image, bg_image, homepage, social FROM clients WHERE url = '" + url + "'", new ClientMapper());
		logger.debug("leaving method getclientByUrl");
		return client;
	}
	
	@Override
	public Client getClientById(int clientId) {
		logger.debug("entering method getclientByUrl");
		Client client = this.jdbcTemplate.queryForObject("SELECT id, name, url, start_lon, start_lat, start_zoom, start_page_image, bg_image, homepage, social FROM clients WHERE id = " + clientId, new ClientMapper());
		logger.debug("leaving method getclientByUrl");
		return client;
	}
	
	private static final class ClientMapper implements RowMapper<Client> {
    	
    	private static final Logger logger = Logger.getLogger(ClientMapper.class);

        public Client mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	Client client = new Client();
            client.setId(rs.getInt("id"));
            client.setName(rs.getString("name"));
            client.setUrl(rs.getString("url"));
            client.setStartZoom(rs.getInt("start_zoom"));
            client.setStartLat(rs.getDouble("start_lat"));
            client.setStartLon(rs.getDouble("start_lon"));
            client.setStartPageImage(rs.getString("start_page_image"));
            client.setBgImage(rs.getString("bg_image"));
            client.setHomepage(rs.getString("homepage"));
            client.setSocial(rs.getBoolean("social"));
            logger.debug("leaving method mapRow");
            return client;
        }        
    }

}
