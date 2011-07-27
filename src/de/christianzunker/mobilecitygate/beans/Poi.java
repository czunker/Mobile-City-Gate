package de.christianzunker.mobilecitygate.beans;

public class Poi {

	int id = 0;
	String name = "";
	String description = "";
	double lon = 0.0;
	double lat = 0.0;
	String icon = "";
	String iconSize = "";
	String iconOffset = "";
	String ivrNumber = "";
	String ivrTextUrl = "";
	String locale = "";
	
	
	
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public String getIvrTextUrl() {
		return ivrTextUrl;
	}
	public void setIvrTextUrl(String ivrTextUrl) {
		this.ivrTextUrl = ivrTextUrl;
	}
	public String getIvrNumber() {
		return ivrNumber;
	}
	public void setIvrNumber(String ivrNumber) {
		this.ivrNumber = ivrNumber;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getIconSize() {
		return iconSize;
	}
	public void setIconSize(String iconSize) {
		this.iconSize = iconSize;
	}
	public String getIconOffset() {
		return iconOffset;
	}
	public void setIconOffset(String iconOffset) {
		this.iconOffset = iconOffset;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	
	
}
