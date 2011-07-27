package de.christianzunker.mobilecitygate.beans;

public class Profile {

	int id = 0;
	String name = "";
	String shortName = "";
	String icon = "";
	// TODO replace with array/List
	String nonUsablePoiIds = "";
	
	
	
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
	public String getNonUsablePoiIds() {
		return nonUsablePoiIds;
	}
	public void setNonUsablePoiIds(String nonUsablePoiIds) {
		this.nonUsablePoiIds = nonUsablePoiIds;
	}
	
	
	
}
