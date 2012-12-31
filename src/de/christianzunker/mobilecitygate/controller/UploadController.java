package de.christianzunker.mobilecitygate.controller;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;

import de.christianzunker.mobilecitygate.beans.Client;
import de.christianzunker.mobilecitygate.dao.ClientDao;

@Controller
public class UploadController implements ServletContextAware { // NO_UCD
	
		private static final Logger logger = Logger.getLogger(UploadController.class);
		
		/*
		replaced @Autowired with "implements ServletContextAware" because of junit tests
		http://stackoverflow.com/questions/5300444/spring-3-testing-a-controller-autowired-servlet-context
		*/
		private ServletContext servletContext;
		
		
		@Autowired
		private ClientDao clientDao;
		
        //@RequestMapping(value = "/upload/category", headers="Accept=multipart/form-data", method = RequestMethod.POST)
		@RequestMapping(value = "/upload/{clientId}/poicategory", method = RequestMethod.POST)
        public @ResponseBody String createCategoryIconFile(@PathVariable("clientId") int clientId, @RequestParam("name") String[] fileNames, HttpServletRequest request) {
        		logger.debug("entering method createCategoryIconFile");
        		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        		MultipartFile file = multipartRequest.getFile("file");
                String filepath = null;
                String filename = null;
                
                Client client = clientDao.getClientById(clientId);
        	
                if (file == null) {
                	logger.debug("User Did not upload file");
                }
                else {
                	filename = cleanFilename(file.getOriginalFilename());
                	// TODO: use cleanName method: http://www.plupload.com/plupload/docs/api/index.html#class_plupload.html-cleanName
                	// TODO: or use it in javascript?
                	logger.debug("Changed File Name to: " + filename);
                }
         
                InputStream inputStream = null;
                OutputStream outputStream = null;
                logger.debug("size: " + file.getSize());
                
                // TODO: verify image is png
                // TODO: optimize image
                // TODO: rename image?
                if (file.getSize() > 0) {
                    try {
                    	inputStream = file.getInputStream();
                    	//ServletContext servletContext = request.getContextPath();
                		String contextPath = servletContext.getRealPath(File.separator);
                		filepath = contextPath + "resources" + File.separator + client.getUrl() + File.separator + "images" + File.separator + filename;
                        logger.debug("Writing file: " + filepath);
						outputStream = new FileOutputStream(filepath);
					
	                    int readBytes = 0;
	                    byte[] buffer = new byte[10000];
	                    while ((readBytes = inputStream.read(buffer, 0 , 10000))!=-1){
	         
	                        outputStream.write(buffer, 0, readBytes);
	                    }
	                    outputStream.close();
	                    inputStream.close();
                    } catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                    catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                }
                logger.debug("leaving method createCategoryIconFile");
                return filename; 
        }
		
		@RequestMapping(value = "/upload/{clientId}/mapkml", method = RequestMethod.POST)
        public @ResponseBody String createMapKMLFile(@PathVariable("clientId") int clientId, @RequestParam("name") String[] fileNames, HttpServletRequest request) {
        		logger.debug("entering method createMapKMLFile");
        		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        		MultipartFile file = multipartRequest.getFile("file");
                String filename = "";
                String filepath = "";
                
                Client client = clientDao.getClientById(clientId);
        	
                if (file == null) {
                	logger.debug("User Did not upload file");
                	return "none specified";
                }
                else {
                	filename = cleanFilename(file.getOriginalFilename());
                	// TODO: use cleanName method: http://www.plupload.com/plupload/docs/api/index.html#class_plupload.html-cleanName
                	// TODO: or use it in javascript?
                	logger.debug("Changed File Name to: " + filename);
                }
         
                InputStream inputStream = null;
                OutputStream outputStream = null;
                logger.debug("size: " + file.getSize());
                
                // TODO: verify image is png
                // TODO: optimize image
                // TODO: rename image?
                if (file.getSize() > 0) {
                    try {
                    	inputStream = file.getInputStream();
                    	//ServletContext servletContext = request.getContextPath();
                		String contextPath = servletContext.getRealPath(File.separator);
                		filepath = contextPath + "resources" + File.separator + client.getUrl() + File.separator + "kml" + File.separator + filename;
                        logger.debug("Writing file: " + filepath);
						outputStream = new FileOutputStream(filepath);
					
	                    int readBytes = 0;
	                    byte[] buffer = new byte[10000];
	                    while ((readBytes = inputStream.read(buffer, 0 , 10000))!=-1){
	         
	                        outputStream.write(buffer, 0, readBytes);
	                    }
	                    outputStream.close();
	                    inputStream.close();
                    } catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                    catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                }
                logger.debug("leaving method createMapKMLFile");
                return filename; 
        }
		
		@RequestMapping(value = "/upload/{clientId}/ivrtext", method = RequestMethod.POST)
        public @ResponseBody String createIVRTextFile(@PathVariable("clientId") int clientId, @RequestParam("name") String[] fileNames, HttpServletRequest request) {
        		logger.debug("entering method createIVRTextFile");
        		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        		MultipartFile file = multipartRequest.getFile("file");
                String filename = "";
                String filepath = "";
                
                Client client = clientDao.getClientById(clientId);
        	
                if (file == null) {
                	logger.debug("User Did not upload file");
                	return "none specified";
                }
                else {
                	filename = cleanFilename(file.getOriginalFilename());
                	// TODO: use cleanName method: http://www.plupload.com/plupload/docs/api/index.html#class_plupload.html-cleanName
                	// TODO: or use it in javascript?
                	logger.debug("Changed File Name to: " + filename);
                }
         
                InputStream inputStream = null;
                OutputStream outputStream = null;
                logger.debug("size: " + file.getSize());
                
                // TODO: verify image is png
                // TODO: optimize image
                // TODO: rename image?
                if (file.getSize() > 0) {
                    try {
                    	inputStream = file.getInputStream();
                    	//ServletContext servletContext = request.getContextPath();
                		String contextPath = servletContext.getRealPath(File.separator);
                		filepath = contextPath + "resources" + File.separator + client.getUrl() + File.separator + "ivr-html" + File.separator + filename;
                        logger.debug("Writing file: " + filepath);
						outputStream = new FileOutputStream(filepath);
					
	                    int readBytes = 0;
	                    byte[] buffer = new byte[10000];
	                    while ((readBytes = inputStream.read(buffer, 0 , 10000))!=-1){
	         
	                        outputStream.write(buffer, 0, readBytes);
	                    }
	                    outputStream.close();
	                    inputStream.close();
                    } catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                    catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                }
                logger.debug("leaving method createIVRTextFile");
                return filename; 
        }
		
		@RequestMapping(value = "/upload/icon", method = RequestMethod.POST)
        public @ResponseBody String createLanguageIconFile(@RequestParam("name") String[] fileNames, HttpServletRequest request) {
        		logger.debug("entering method createLanguageIconFile");
        		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        		MultipartFile file = multipartRequest.getFile("file");
                String filename = "";
                String filepath = "";
                
                if (file == null) {
                	logger.debug("User Did not upload file");
                	return "none specified";
                }
                else {
                	filename = cleanFilename(file.getOriginalFilename());
                	// TODO: use cleanName method: http://www.plupload.com/plupload/docs/api/index.html#class_plupload.html-cleanName
                	// TODO: or use it in javascript?
                	logger.debug("Changed File Name to: " + filename);
                }
         
                InputStream inputStream = null;
                OutputStream outputStream = null;
                logger.debug("size: " + file.getSize());
                
                // TODO: verify image is png
                // TODO: optimize image
                // TODO: rename image?
                if (file.getSize() > 0) {
                    try {
                    	inputStream = file.getInputStream();
                    	//ServletContext servletContext = request.getContextPath();
                		String contextPath = servletContext.getRealPath(File.separator);
                		filepath = contextPath + "resources" + File.separator + "global" + File.separator + "images" + File.separator + filename;
                        logger.debug("Writing file: " + filepath);
						outputStream = new FileOutputStream(filepath);
					
	                    int readBytes = 0;
	                    byte[] buffer = new byte[10000];
	                    while ((readBytes = inputStream.read(buffer, 0 , 10000))!=-1){
	         
	                        outputStream.write(buffer, 0, readBytes);
	                    }
	                    outputStream.close();
	                    inputStream.close();
                    } catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                    catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                }
                logger.debug("leaving method createLanguageIconFile");
                return filename; 
        }
		
		private String cleanFilename(String filename) {
			filename = filename.replaceAll("ö", "oe");
        	filename = filename.replaceAll("ü", "ue");
        	filename = filename.replaceAll("ä", "ae");
        	filename = filename.replaceAll("ß", "ss");
        	filename = filename.replaceAll("Ö", "Oe");
        	filename = filename.replaceAll("Ü", "Ue");
        	filename = filename.replaceAll("Ä", "Ae");
        	filename = filename.replaceAll(" ", "_");
        	return filename;
		}
        
        protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws ServletException {
        	        // to actually be able to convert Multipart instance to byte[]
        	        // we have to register a custom editor
        	        binder.registerCustomEditor(byte[].class, new ByteArrayMultipartFileEditor());
        	        // now Spring knows how to handle multipart object and convert them
        	    }

		@Override
		public void setServletContext(ServletContext arg0) {
			this.servletContext = arg0;
		}
}
