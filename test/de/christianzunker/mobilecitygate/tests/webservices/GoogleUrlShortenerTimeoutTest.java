package de.christianzunker.mobilecitygate.tests.webservices;

import static org.junit.Assert.assertEquals;

import org.apache.log4j.Logger;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sun.jersey.api.client.ClientHandlerException;

import de.christianzunker.mobilecitygate.beans.Config;
import de.christianzunker.mobilecitygate.utils.GoogleServices;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:/etc/mobile-city-gate/mobile-city-gate-servlet.xml")
public class GoogleUrlShortenerTimeoutTest {

	private static final Logger logger = Logger.getLogger(GoogleUrlShortenerTimeoutTest.class);
	
	@Autowired
	private Config config;
	
	@Autowired
	private GoogleServices google;
	
	@Rule
	public ExpectedException exception = ExpectedException.none();
	
	String longUrl = "http://localhost/mobile-city-gate/kultohr/de/";
	String expectedShortUrl = "http://localhost/mobile-city-gate/kultohr/de/";
	
	@Test
	public void testTimeout() {
		logger.info("timeout: " + config.getGoogleTimeout() + "ms");
		config.setGoogleTimeout(1);
		/*
		 * this test has to be in a seperate class because of the config bean
		 * when combining multiple tests in one class, the instance of GoogleService gets autowired to one config bean
		 * this bean can't be changed for this instance, see also problem description in GoogleUrlShortenerTest
		 * 
		 * possibile other solution?
		 * http://blog.springsource.org/2011/06/21/spring-3-1-m2-testing-with-configuration-classes-and-profiles/  
		 */
		logger.info("timeout: " + config.getGoogleTimeout() + "ms");
		String shortUrl = google.getShortUrl(longUrl);
		logger.info("shortUrl: " + shortUrl);
		assertEquals(expectedShortUrl, shortUrl);
	}
	
}


