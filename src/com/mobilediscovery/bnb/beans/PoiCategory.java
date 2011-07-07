package com.mobilediscovery.bnb.beans;

public class PoiCategory {
	
	int id = 0;
	String name = "";
	String shortName = "";
	String icon = "";
	// TODO replace with array/List
	String pois = "";
	
	
	
	
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
	
	

}
