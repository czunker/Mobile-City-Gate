package de.christianzunker.mobilecitygate.beans;

public class PoiCategory {
	
	private int id = 0;
	private String name = "";
	private String shortName = "";
	private String icon = "";
	private int clientId = 0;
	private String locale = "";
	private int published = 0;
	// TODO replace with array/List
	private String pois = "";
	
	
	
	
	public String getPois() {
		return pois;
	}
	public void setPois(String pois) {
		this.pois = pois;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public int getPublished() {
		return published;
	}
	public void setPublished(int published) {
		this.published = published;
	}
	
	
	

}
