package de.christianzunker.mobilecitygate.beans;

public class Message {
	
	private int id = 0;
	private String page = "";
	private String key = "";
	private String text = "";
	private String locale = "";
	private int clientId = 0;
	private String client = "";
	
	
	
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int id) {
		this.clientId = id;
	}
	
	

}
