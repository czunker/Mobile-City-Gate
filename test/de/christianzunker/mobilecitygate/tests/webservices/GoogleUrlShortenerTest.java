package de.christianzunker.mobilecitygate.tests.webservices;

import static org.junit.Assert.*;

import org.apache.log4j.Logger;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import de.christianzunker.mobilecitygate.beans.Config;
import de.christianzunker.mobilecitygate.utils.GoogleServices;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:/etc/mobile-city-gate/mobile-city-gate-servlet.xml")
public class GoogleUrlShortenerTest {

	private static final Logger logger = Logger.getLogger(GoogleUrlShortenerTest.class);
	
	@Autowired
	private Config config;
	
	@Autowired
	private GoogleServices google;
	
	@Rule
	public ExpectedException exception = ExpectedException.none();
	
	String longUrl = "http://localhost/mobile-city-gate/kultohr/de/";
	String expectedShortUrl = "http://goo.gl/WdbC2";
	
	@Test
	public void testShortUrl() {
		logger.info("longUrl: " + longUrl);
		String shortUrl = google.getShortUrl(longUrl);
		logger.info("shortUrl: " + shortUrl);
		assertNotNull("shortUrl is null.", shortUrl);
		assertEquals(expectedShortUrl, shortUrl);
	}
	
	/*
	@Test
	public void testTimeout() {
		logger.warn("timeout: " + config.getGoogleTimeout() + "ms");
		config.setGoogleTimeout(1);
		// PROBLEM: global config bean is not updated => no timeout => no exception
		// does an extra test class solve this problem? are the beans initialized for each test or for all tests?
		// yes, it does => move test to GoogleUrlShortenerTimeoutTest
		logger.warn("timeout: " + config.getGoogleTimeout() + "ms");
		String shortUrl = google.getShortUrl(longUrl);
		logger.warn("shortUrl: " + shortUrl);
	}
	*/
	
}


