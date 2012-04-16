package de.christianzunker.mobilecitygate.utils;

import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.authentication.encoding.PasswordEncoder;

public class EncodePassword { // NO_UCD

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		PasswordEncoder encoder = new Md5PasswordEncoder();
	    String hashedPass = encoder.encodePassword("test123", null);
	    System.out.println(hashedPass);
	}

}
