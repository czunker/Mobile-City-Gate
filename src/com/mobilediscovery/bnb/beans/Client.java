package com.mobilediscovery.bnb.beans;

public class Client {
	
	private int id = 0;
	private String name = "";
	private String url = "";
	private double startLon = 0.0;
	private double startLat = 0.0;
	private int startZoom = 0;
	private String startPageImage = "";
	private String bgImage = "";
	private String homepage = "";
	private String shortUrl = "";
	private boolean social = false;
	
	
	
	
	public boolean getSocial() {
		return social;
	}
	public void setSocial(boolean social) {
		this.social = social;
	}
	public String getShortUrl() {
		return shortUrl;
	}
	public void setShortUrl(String shortUrl) {
		this.shortUrl = shortUrl;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getStartPageImage() {
		return startPageImage;
	}
	public void setStartPageImage(String startPageImage) {
		this.startPageImage = startPageImage;
	}
	public String getBgImage() {
		return bgImage;
	}
	public void setBgImage(String bgImage) {
		this.bgImage = bgImage;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public double getStartLon() {
		return startLon;
	}
	public void setStartLon(double startLon) {
		this.startLon = startLon;
	}
	public double getStartLat() {
		return startLat;
	}
	public void setStartLat(double startLat) {
		this.startLat = startLat;
	}
	public int getStartZoom() {
		return startZoom;
	}
	public void setStartZoom(int startZoom) {
		this.startZoom = startZoom;
	}
	
	

}
