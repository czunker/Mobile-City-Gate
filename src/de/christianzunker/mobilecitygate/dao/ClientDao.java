package de.christianzunker.mobilecitygate.dao;

import java.util.List;

import de.christianzunker.mobilecitygate.beans.Client;

public interface ClientDao {
	
	public Client getClientByUrl(String url);
	
	public Client getClientById(int clientId);
	
	public List<Client> getClients();
	
	public List<Client> getClientsWithoutGlobal();

	public int updateClientById(Client client);

	public int createClient(Client client);

	public int deleteClientById(Client client);

}
