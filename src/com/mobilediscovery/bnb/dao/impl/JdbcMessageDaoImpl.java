package com.mobilediscovery.bnb.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.mobilediscovery.bnb.beans.Message;
import com.mobilediscovery.bnb.dao.MessageDao;

@Repository
public class JdbcMessageDaoImpl implements MessageDao {

	private static final Logger logger = Logger.getLogger(JdbcMessageDaoImpl.class);
	
	private @Autowired JdbcTemplate jdbcTemplate;
	
	@Override
	public List<Message> getMessagesByClientId(int clientId) {
		logger.debug("entering method getMessagesByMandantId");
		List<Message> messages = this.jdbcTemplate.query("SELECT id, page, message_key, message_text, locale, mandant_id FROM messages WHERE client_id = " + clientId, new MessageMapper());
		logger.debug("leaving method getMessagesByMandantId");
		return messages;
	}
	
	@Override
	public List<Message> getMessagesByClientIdLocale(int clientId, String locale) {
		logger.debug("entering method getMessagesByMandantIdLocale");
		List<Message> messages = this.jdbcTemplate.query("SELECT id, page, message_key, message_text, locale, mandant_id FROM messages WHERE client_id = " + clientId + " AND locale = '" + locale + "'", new MessageMapper());
		logger.debug("leaving method getMessagesByMandantIdLocale");
		return messages;
	}
	
	@Override
	public HashMap<String, String> getMessagesByPageClientIdLocale(String page, int clientId, String locale) {
		logger.debug("entering method getMessagesByPageMandantIdLocale");
		List<Message> messages = this.jdbcTemplate.query("SELECT message_key, message_text FROM messages WHERE client_id = " + clientId + " AND locale = '" + locale + "' AND page = '" + page + "'", new MessageMapperShort());
		// TODO can this be integrated into the query call?
		HashMap<String, String> hashMessages = new HashMap<String, String>();
		for (Message message : messages) {
			hashMessages.put(message.getKey(), message.getText());
		}
		logger.debug("leaving method getMessagesByPageMandantIdLocale");
		return hashMessages;
	}
	
	@Override
	public List<Message> getMessages() {
		logger.debug("entering method getMessages");
		List<Message> messages = this.jdbcTemplate.query("SELECT id, page, message_key, message_text, locale, mandant_id FROM messages", new MessageMapper());
		logger.debug("leaving method getMessages");
		return messages;
	}
	
	private static final class MessageMapper implements RowMapper<Message> {
    	
    	private static final Logger logger = Logger.getLogger(MessageMapper.class);

        public Message mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	Message Message = new Message();
            Message.setId(rs.getInt("id"));
            Message.setPage(rs.getString("page"));
            Message.setKey(rs.getString("message_key"));
            Message.setText(rs.getString("message_text"));
            Message.setLocale(rs.getString("locale"));
            Message.setMandantId(rs.getInt("mandant_id"));
            logger.debug("leaving method mapRow");
            return Message;
        }        
    }
	
	private static final class MessageMapperShort implements RowMapper<Message> {
    	
    	private static final Logger logger = Logger.getLogger(MessageMapperShort.class);

        public Message mapRow(ResultSet rs, int rowNum) throws SQLException {
        	logger.debug("entering method mapRow");
        	Message Message = new Message();
            Message.setKey(rs.getString("message_key"));
            Message.setText(rs.getString("message_text"));
            logger.debug("leaving method mapRow");
            return Message;
        }        
    }
}
