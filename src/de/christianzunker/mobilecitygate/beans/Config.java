package de.christianzunker.mobilecitygate.beans;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Config {
	
	private String googleApiKey;
    private String googleApiUrl;
	private String tilesServers;
	private String piwikServer;
	private int googleTimeout;
	
	

	public int getGoogleTimeout() {
		return googleTimeout;
	}

	@Value("${googleTimeout}")
	public void setGoogleTimeout(int googleTimeout) {
		this.googleTimeout = googleTimeout;
	}

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

    public String getGoogleApiUrl() {
        return googleApiUrl;
    }

    @Value("${googleApiUrl}")
    public void setGoogleApiUrl(String googleApiUrl) {
        this.googleApiUrl = googleApiUrl;
    }
}
