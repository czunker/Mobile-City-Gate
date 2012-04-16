package de.christianzunker.mobilecitygate.beans;

import java.util.List;
import java.util.Vector;

public class Poi {

	private int id = 0;
	private String name = "";
	private String description = "";
	private double lon = 0.0;
	private double lat = 0.0;
	private String icon = "";
	private String iconSize = "";
	private String iconOffset = "";
	private String ivrNumber = "";
	private String ivrTextUrl = "";
	private String locale = "";
	private int clientId = 0;
	private String client = "";
	private int published = 0;
	
	private String poiCategory = "";
	private int poiCategoryId = 0;
	
	private String route = "";
	private int routeId = 0;
	
	private List<String> poiProfiles = new Vector<String>();
	private List<Integer> poiProfileIds = new Vector<Integer>();
	
	
	
	
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
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
	public String getPoiCategory() {
		return poiCategory;
	}
	public void setPoiCategory(String poiCategory) {
		this.poiCategory = poiCategory;
	}
	public int getPoiCategoryId() {
		return poiCategoryId;
	}
	public void setPoiCategoryId(int poiCategoryId) {
		this.poiCategoryId = poiCategoryId;
	}
	public String getRoute() {
		return route;
	}
	public void setRoute(String route) {
		this.route = route;
	}
	public int getRouteId() {
		return routeId;
	}
	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
	public List<String> getPoiProfiles() {
		return poiProfiles;
	}
	public void setPoiProfiles(List<String> poiProfiles) {
		this.poiProfiles = poiProfiles;
	}
	public List<Integer> getPoiProfileIds() {
		return poiProfileIds;
	}
	public void setPoiProfileIds(List<Integer> poiProfileIds) {
		this.poiProfileIds = poiProfileIds;
	}
	public int getPublished() {
		return published;
	}
	public void setPublished(int published) {
		this.published = published;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	
	
	
}
