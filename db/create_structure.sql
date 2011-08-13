/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ `web_app_db` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `web_app_db`;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `url` varchar(45) CHARACTER SET latin1 NOT NULL,
  `start_lon` double NOT NULL,
  `start_lat` double NOT NULL,
  `start_zoom` int(11) NOT NULL DEFAULT '16',
  `start_page_image` varchar(45) CHARACTER SET latin1 NOT NULL,
  `bg_image` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `homepage` varchar(500) CHARACTER SET latin1 NOT NULL,
  `social` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ind_url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_short` varchar(2) NOT NULL,
  `language_long` varchar(45) NOT NULL,
  `client_id` int(11) NOT NULL,
  `icon` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_language_client_id` (`client_id`),
  CONSTRAINT `fk_language_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` varchar(45) CHARACTER SET latin1 NOT NULL,
  `message_key` varchar(45) CHARACTER SET latin1 NOT NULL,
  `message_text` varchar(20000) CHARACTER SET latin1 NOT NULL,
  `locale` varchar(2) CHARACTER SET latin1 NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_messages_client_id` (`client_id`),
  KEY `ind_messages` (`page`,`locale`,`client_id`),
  CONSTRAINT `fk_messages_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poi_categories`
--

DROP TABLE IF EXISTS `poi_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poi_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `short_name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `icon` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `locale` varchar(2) NOT NULL DEFAULT 'de',
  PRIMARY KEY (`id`),
  KEY `fk_poi_categories_client_id` (`client_id`),
  KEY `ind_locale` (`locale`),
  CONSTRAINT `fk_poi_categories_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pois`
--

DROP TABLE IF EXISTS `pois`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pois` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `description` varchar(2000) CHARACTER SET latin1 DEFAULT NULL,
  `lon` double NOT NULL,
  `lat` double NOT NULL,
  `client_id` int(11) NOT NULL,
  `ivr_number` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `ivr_text_url` varchar(500) CHARACTER SET latin1 DEFAULT NULL,
  `locale` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_locale` (`locale`),
  KEY `fk_client_id` (`client_id`),
  CONSTRAINT `fk_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=563 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `short_name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `icon` varchar(45) NOT NULL,
  `locale` varchar(2) NOT NULL DEFAULT 'de',
  PRIMARY KEY (`id`),
  KEY `ind_locale` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rel_poi_category`
--

DROP TABLE IF EXISTS `rel_poi_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rel_poi_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poi_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_poi_id` (`poi_id`),
  KEY `fk_category_id` (`category_id`),
  KEY `ind_cat_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `poi_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `pois` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rel_poi_profile`
--

DROP TABLE IF EXISTS `rel_poi_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rel_poi_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poi_id` int(11) NOT NULL,
  `profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `poi_id` (`poi_id`),
  KEY `disability_id` (`profile_id`),
  KEY `ind_dis_id` (`profile_id`),
  CONSTRAINT `rel_poi_profile_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rel_poi_profile_ibfk_2` FOREIGN KEY (`poi_id`) REFERENCES `pois` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rel_poi_route`
--

DROP TABLE IF EXISTS `rel_poi_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rel_poi_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `route_id` int(11) NOT NULL,
  `poi_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_route_poi_route_id` (`route_id`),
  KEY `fk_route_poi_poi_id` (`poi_id`),
  KEY `ind_route_id` (`route_id`),
  CONSTRAINT `fk_route_poi_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `pois` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_route_poi_route_id` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 NOT NULL,
  `length` decimal(15,2) DEFAULT NULL,
  `kml_file` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `locale` varchar(2) NOT NULL,
  `length_unit` varchar(5) DEFAULT NULL,
  `start_lon` double NOT NULL,
  `start_lat` double NOT NULL,
  `color` varchar(45) NOT NULL,
  `end_lon` double DEFAULT NULL,
  `end_lat` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `routes_name` (`name`),
  KEY `ind_locale` (`locale`),
  KEY `fk_routes_client_id` (`client_id`),
  CONSTRAINT `fk_routes_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
