package com.mobilediscovery.bnb.dao;

import java.util.List;

import com.mobilediscovery.bnb.beans.Client;

public interface ClientDao {
	
	public Client getClientByUrl(String url);
	
	public Client getClientById(int clientId);
	
	public List<Client> getClients();
	
	public List<Client> getClientsWithoutGlobal();

}
