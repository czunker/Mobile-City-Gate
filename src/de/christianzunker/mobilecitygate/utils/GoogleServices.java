package de.christianzunker.mobilecitygate.utils;

import java.net.SocketTimeoutException;

import javax.ws.rs.core.MediaType;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sun.jersey.api.client.ClientHandlerException;
import com.sun.jersey.api.client.WebResource;

import de.christianzunker.mobilecitygate.beans.Config;

@Service
public class GoogleServices {

	private static final Logger logger = Logger.getLogger(GoogleServices.class);
	
	@Autowired
	private Config config;
	
	@Cacheable("urls")
	public String getShortUrl(String longUrl) {
		String shortUrl = longUrl;
		String googleApiKey = config.getGoogleApiKey();
		String googleUrl = "https://www.googleapis.com/urlshortener/v1/url?" + googleApiKey;
		try {
			com.sun.jersey.api.client.Client jsonClient = com.sun.jersey.api.client.Client.create();
			int timeout = config.getGoogleTimeout();
			if (!(timeout > 0)) {
				// config not set, connect with a default timeout of 200ms
				timeout = 200;
			}
			logger.trace("Google timeout: " + timeout + "ms");
			jsonClient.setConnectTimeout(timeout);
			WebResource webResource = jsonClient.resource(googleUrl);
			String jsonRequest = "{ \"longUrl\": \"" + longUrl + "\" }";
			logger.debug("jsonRequest: " + jsonRequest);
			String jsonResponse = webResource.accept(
			        MediaType.APPLICATION_JSON_TYPE).
			        type(MediaType.APPLICATION_JSON_TYPE).
			        post(String.class, jsonRequest);
			logger.debug("jsonResponse: " + jsonResponse);
			
			JsonParser jsonParser = new JsonParser();
			JsonObject jsonObj = (JsonObject)jsonParser.parse(jsonResponse);
			if ( jsonObj != null && jsonObj.has("id")) {
				shortUrl = jsonObj.get("id").toString();
				shortUrl = shortUrl.replace("\"", "");
			}
		}
		catch (ClientHandlerException ex) {
			Exception rootCause = (Exception) ex.getCause();
			if (rootCause.getClass().equals(SocketTimeoutException.class)) {
				logger.error("Got connection timeout!");
			}
			logger.error("Couldn't connect to Google URL Shortener!", ex);
		}
		return shortUrl;
	}
	
}
