package com.mobilediscovery.bnb.dao;

import java.util.HashMap;
import java.util.List;

import com.mobilediscovery.bnb.beans.Message;

public interface MessageDao {
	
	public List<Message> getMessages();
	
	public List<Message> getMessagesByClientId(int clientId);
	
	public List<Message> getMessagesByClientIdLocale(int clientId, String locale);
	
	public HashMap<String, String> getMessagesByPageClientIdLocale(String page, int clientId, String locale);

}
