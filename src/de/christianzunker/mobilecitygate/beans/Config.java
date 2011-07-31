package de.christianzunker.mobilecitygate.beans;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Config {
	
	private String googleApiKey;

	public String getGoogleApiKey() {
		return googleApiKey;
	}

	@Value("${googleApiKey}")
	public void setGoogleApiKey(String googleApiKey) {
		this.googleApiKey = googleApiKey;
	}
}
