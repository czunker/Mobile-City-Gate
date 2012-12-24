package de.christianzunker.mobilecitygate.beans;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Config {
	
	private String googleApiKey;
	private String tilesServers;
	private String piwikServer;

	public String getPiwikServer() {
		return piwikServer;
	}

	@Value("${piwikServer}")
	public void setPiwikServer(String piwikServer) {
		this.piwikServer = piwikServer;
	}

	public String getGoogleApiKey() {
		return googleApiKey;
	}

	@Value("${googleApiKey}")
	public void setGoogleApiKey(String googleApiKey) {
		this.googleApiKey = googleApiKey;
	}
	
	public String getTilesServers() {
		return tilesServers;
	}

	@Value("${tilesServers}")
	public void setTilesServers(String tilesServers) {
		this.tilesServers = tilesServers;
	}
}
