-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: combuy
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `combuy`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `combuy` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;

USE `combuy`;

--
-- Table structure for table `bannerimg`
--

DROP TABLE IF EXISTS `bannerimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bannerimg` (
  `img_id` int(11) NOT NULL AUTO_INCREMENT,
  `dir` varchar(100) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  PRIMARY KEY (`img_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bannerimg`
--

LOCK TABLES `bannerimg` WRITE;
/*!40000 ALTER TABLE `bannerimg` DISABLE KEYS */;
/*!40000 ALTER TABLE `bannerimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `brand_id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) NOT NULL,
  `content` varchar(50) DEFAULT NULL,
  `img` varchar(100) NOT NULL,
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'APPLE','apple .inc','/images/brand/Apple.png'),(2,'Acer',NULL,'/images/brand/Acer.png'),(3,'ASUS',NULL,'/images/brand/Asus.png'),(4,'Microsoft',NULL,'/images/brand/Microsoft.png'),(5,'Lenovo',NULL,'/images/brand/Lenovo.png'),(6,'DELL',NULL,'/images/brand/Dell.png'),(7,'HP',NULL,'/images/brand/Hp.png'),(8,'LG',NULL,'/images/brand/Lg.png'),(9,'MSI',NULL,'/images/brand/Msi.png'),(999,'other',NULL,'');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card` (
  `card_id` int(11) NOT NULL AUTO_INCREMENT,
  `card_num` varchar(17) NOT NULL,
  `expiry_date` varchar(5) NOT NULL,
  `security_code` varchar(4) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`card_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `card_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (1,'1111222233335558','0523','987',6),(2,'2222333344445555','0524','312',6),(4,'0123654655121234','0324','561',6),(5,'5201321521513215','0524','321',42);
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `content` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'筆電',NULL),(2,'滑鼠',NULL),(3,'鍵盤',NULL),(4,'耳機',NULL),(5,'喇叭',NULL),(6,'麥克風',NULL),(999,'其他',NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect`
--

DROP TABLE IF EXISTS `collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collect` (
  `user_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL,
  `spec_id` int(11) NOT NULL,
  `update_time` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`prod_id`,`spec_id`) USING BTREE,
  KEY `prod_id` (`prod_id`),
  KEY `user_id` (`user_id`),
  KEY `spec_id` (`spec_id`),
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `collect_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`),
  CONSTRAINT `collect_ibfk_3` FOREIGN KEY (`spec_id`) REFERENCES `sellspec` (`spec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect`
--

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;
INSERT INTO `collect` VALUES (6,2,5,'2023-09-18 00:03:28'),(6,9,1,'2023-09-18 00:01:43'),(6,11,0,'2023-09-18 00:03:34'),(6,17,3,'2023-09-18 04:03:01'),(6,19,7,'2023-09-18 07:42:49'),(7,6,4,'2023-09-18 04:08:57'),(7,11,3,'2023-09-18 04:08:56'),(7,13,0,'2023-09-18 04:09:00'),(7,13,3,'2023-09-18 04:08:25'),(7,18,5,'2023-09-18 04:09:27'),(7,19,7,'2023-09-18 04:07:59'),(7,20,6,'2023-09-18 04:08:01'),(7,21,5,'2023-09-18 04:08:04'),(7,22,0,'2023-09-18 04:08:33');
/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_product`
--

DROP TABLE IF EXISTS `order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_product` (
  `order_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL,
  `spec_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `comment` varchar(300) DEFAULT NULL,
  `comment_grade` tinyint(4) DEFAULT NULL,
  `comment_time` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`,`prod_id`,`spec_id`) USING BTREE,
  KEY `prod_id` (`prod_id`),
  KEY `format_id` (`spec_id`),
  CONSTRAINT `order_product_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_product_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`),
  CONSTRAINT `order_product_ibfk_3` FOREIGN KEY (`spec_id`) REFERENCES `sellspec` (`spec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_product`
--

LOCK TABLES `order_product` WRITE;
/*!40000 ALTER TABLE `order_product` DISABLE KEYS */;
INSERT INTO `order_product` VALUES (1,11,3,42900,1,'讚...',3,'2023-09-18 04:02:31'),(2,4,0,2290,1,NULL,NULL,NULL),(2,5,0,2290,1,NULL,NULL,NULL),(2,6,4,109900,1,NULL,NULL,NULL),(3,4,0,2290,1,NULL,NULL,NULL),(3,5,0,2290,1,NULL,NULL,NULL),(3,6,4,109900,1,NULL,NULL,NULL),(4,11,3,42900,4,'不錯',4,'2023-09-18 04:07:47'),(5,4,0,2290,1,'好...',5,'2023-09-18 07:54:57');
/*!40000 ALTER TABLE `order_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `recipient` varchar(100) NOT NULL,
  `recipient_address` varchar(300) NOT NULL,
  `recipient_phone` varchar(50) NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT 1 COMMENT '訂單取消 0\r\n訂單成立 1\r\n訂單完成 2',
  `pay` tinyint(4) NOT NULL DEFAULT 0 COMMENT '尚未付款 0\r\n付款完成 1',
  `pay_method` tinyint(4) NOT NULL COMMENT '銀行或郵局轉帳 0\r\n信用卡(一次付清)　 1',
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,6,'2023-09-17 23:46:28','買家001號','臺中市中區黎明路二段658號','0912345678',2,1,0),(2,6,'2023-09-18 03:58:53','吳毅成','臺中市中區黎明路二段658號','0912345678',0,0,0),(3,6,'2023-09-18 04:01:27','吳毅成','臺中市中區黎明路二段658號','0912345678',1,0,1),(4,7,'2023-09-18 04:06:28','楊弍','臺中市中區黎明路二段658號','0912345678',2,1,0),(5,6,'2023-09-18 07:53:29','吳毅成','臺中市中區黎明路二段658號','0912345678',2,1,1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `prod_name` varchar(50) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `creat_time` datetime NOT NULL DEFAULT current_timestamp(),
  `update_time` datetime NOT NULL DEFAULT current_timestamp(),
  `transport` tinyint(4) NOT NULL DEFAULT 2 COMMENT '郵寄寄送 0\r\n宅配/快遞　 1\r\n全部 2',
  `payment` tinyint(4) NOT NULL DEFAULT 2 COMMENT '銀行或郵局轉帳 0\r\n信用卡(一次付清)　 1\r\n全部 2',
  PRIMARY KEY (`prod_id`),
  KEY `user_id` (`user_id`),
  KEY `brand_id` (`brand_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`),
  CONSTRAINT `product_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,2,'Macbook Pro 13',1,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(2,2,'MacBook Air 13',1,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(3,2,'MacBook Air 15',1,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(4,2,'巧控滑鼠',1,2,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(5,2,'巧控鍵盤',1,3,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(6,2,'Macbook Pro 14',1,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(7,3,'ASUS ROG Zephyrus G14',3,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(8,3,'ASUS TUF Gaming A15',3,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(9,3,'ASUS TUF Gaming A16',3,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(10,3,'ASUS TUF Gaming F15',3,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(11,3,'ASUS VivobookPro 15',3,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(12,4,'acer Aspire5',2,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(13,4,'acer Predator Helios Neo 16',2,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(14,3,'ASUS Marshmallow Mouse MD100',3,2,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(15,3,'ASUS Marshmallow 無線鍵盤 KW100',3,3,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(16,3,'華碩 ROG Falchion Ace 機械式電競鍵盤',3,3,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(17,4,'Lenovo IdeaPad Gaming 3',5,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(18,4,'Microsoft Surface Laptop4 ',4,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(19,4,'DELL Inspiron Gaming',6,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(20,4,'DELL Alienware m16',6,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(21,4,'DELL Alienware x14 R2',6,1,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(22,4,'Lenovo 15.6吋 T210 休閒筆電側背包',5,999,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2),(23,3,'華碩 ROG Fusion II 300 電競耳麥',3,4,'2023-09-17 16:48:07','2023-09-17 16:48:07',2,2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_tag`
--

DROP TABLE IF EXISTS `product_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_tag` (
  `prod_id` int(11) NOT NULL,
  `tag` int(11) NOT NULL,
  PRIMARY KEY (`prod_id`,`tag`),
  KEY `tag` (`tag`),
  CONSTRAINT `product_tag_ibfk_1` FOREIGN KEY (`tag`) REFERENCES `tag` (`tag`),
  CONSTRAINT `product_tag_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_tag`
--

LOCK TABLES `product_tag` WRITE;
/*!40000 ALTER TABLE `product_tag` DISABLE KEYS */;
INSERT INTO `product_tag` VALUES (1,6),(2,6),(7,3),(7,5),(8,3),(9,3),(10,3),(11,2),(11,5),(11,6),(12,5),(13,3),(17,3),(18,2),(18,5),(19,3),(20,3),(21,5);
/*!40000 ALTER TABLE `product_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productimg`
--

DROP TABLE IF EXISTS `productimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productimg` (
  `img_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` int(11) NOT NULL,
  `spec_id` int(11) NOT NULL,
  `dir` varchar(100) NOT NULL DEFAULT '/images/products/',
  `filename` varchar(100) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '產品圖 0\r\n介紹圖 1',
  `originalname` varchar(255) NOT NULL,
  `stored_name` varchar(255) NOT NULL,
  `upload_date` datetime NOT NULL DEFAULT current_timestamp(),
  `file_size` int(11) NOT NULL DEFAULT 0,
  `img_src` varchar(255) NOT NULL,
  `mime_type` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`img_id`),
  KEY `prod_id` (`prod_id`),
  CONSTRAINT `productimg_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productimg`
--

LOCK TABLES `productimg` WRITE;
/*!40000 ALTER TABLE `productimg` DISABLE KEYS */;
INSERT INTO `productimg` VALUES (1,1,0,'/images/products/','prod_175244_1685342760.png',0,'prod_175244_1685342760.png','prod_175244_1685342760.png','2023-09-17 17:00:35',0,'../images/products/prod_175244_1685342760.png',' '),(2,1,0,'/images/products/','175244-1.jpg',1,'175244-1.jpg','175244-1.jpg','2023-09-17 17:00:35',0,'../images/products/175244-1.jpg',' '),(3,1,1,'/images/products/','prod_175245_1685342751.png',0,'prod_175245_1685342751.png','prod_175245_1685342751.png','2023-09-17 17:00:35',0,'../images/products/prod_175245_1685342751.png',' '),(4,1,1,'/images/products/','175244-1.jpg',1,'175244-1.jpg','175244-1.jpg','2023-09-17 17:00:35',0,'../images/products/175244-1.jpg',' '),(5,1,2,'/images/products/','prod_175246_1685342730.png',0,'prod_175246_1685342730.png','prod_175246_1685342730.png','2023-09-17 17:00:35',0,'../images/products/prod_175246_1685342730.png',' '),(6,1,2,'/images/products/','175244-1.jpg',1,'175244-1.jpg','175244-1.jpg','2023-09-17 17:00:35',0,'../images/products/175244-1.jpg',' '),(7,1,3,'/images/products/','prod_175247_1685342738.png',0,'prod_175247_1685342738.png','prod_175247_1685342738.png','2023-09-17 17:00:35',0,'../images/products/prod_175247_1685342738.png',' '),(8,1,3,'/images/products/','175244-1.jpg',1,'175244-1.jpg','175244-1.jpg','2023-09-17 17:00:35',0,'../images/products/175244-1.jpg',' '),(9,2,0,'/images/products/','prod_156830_1685344803.png',0,'prod_156830_1685344803.png','prod_156830_1685344803.png','2023-09-17 17:00:35',0,'../images/products/prod_156830_1685344803.png',' '),(10,2,0,'/images/products/','156836_1.jpg',1,'156836_1.jpg','156836_1.jpg','2023-09-17 17:00:35',0,'../images/products/156836_1.jpg',' '),(11,2,1,'/images/products/','prod_156833_1685344703.png',0,'prod_156833_1685344703.png','prod_156833_1685344703.png','2023-09-17 17:00:35',0,'../images/products/prod_156833_1685344703.png',' '),(12,2,1,'/images/products/','156836_1.jpg',1,'156836_1.jpg','156836_1.jpg','2023-09-17 17:00:35',0,'../images/products/156836_1.jpg',' '),(13,2,2,'/images/products/','prod_156832_1685344775.png',0,'prod_156832_1685344775.png','prod_156832_1685344775.png','2023-09-17 17:00:35',0,'../images/products/prod_156832_1685344775.png',' '),(14,2,2,'/images/products/','156836_1.jpg',1,'156836_1.jpg','156836_1.jpg','2023-09-17 17:00:35',0,'../images/products/156836_1.jpg',' '),(15,1,4,'/images/products/','prod_175246_1685342730.png',0,'prod_175246_1685342730.png','prod_175246_1685342730.png','2023-09-17 17:00:35',0,'../images/products/prod_175246_1685342730.png',' '),(16,1,4,'/images/products/','175244-1.jpg',1,'175244-1.jpg','175244-1.jpg','2023-09-17 17:00:35',0,'../images/products/175244-1.jpg',' '),(17,1,5,'/images/products/','prod_175247_1685342738.png',0,'prod_175247_1685342738.png','prod_175247_1685342738.png','2023-09-17 17:00:35',0,'../images/products/prod_175247_1685342738.png',' '),(18,1,5,'/images/products/','175244-1.jpg',1,'175244-1.jpg','175244-1.jpg','2023-09-17 17:00:35',0,'../images/products/175244-1.jpg',' '),(19,2,3,'/images/products/','prod_156830_1685344803.png',0,'prod_156830_1685344803.png','prod_156830_1685344803.png','2023-09-17 17:00:35',0,'../images/products/prod_156830_1685344803.png',' '),(20,2,3,'/images/products/','156836_1.jpg',1,'156836_1.jpg','156836_1.jpg','2023-09-17 17:00:35',0,'../images/products/156836_1.jpg',' '),(21,2,4,'/images/products/','prod_156833_1685344703.png',0,'prod_156833_1685344703.png','prod_156833_1685344703.png','2023-09-17 17:00:35',0,'../images/products/prod_156833_1685344703.png',' '),(22,2,4,'/images/products/','156836_1.jpg',1,'156836_1.jpg','156836_1.jpg','2023-09-17 17:00:35',0,'../images/products/156836_1.jpg',' '),(23,2,5,'/images/products/','prod_156832_1685344775.png',0,'prod_156832_1685344775.png','prod_156832_1685344775.png','2023-09-17 17:00:35',0,'../images/products/prod_156832_1685344775.png',' '),(24,2,5,'/images/products/','156836_1.jpg',1,'156836_1.jpg','156836_1.jpg','2023-09-17 17:00:35',0,'../images/products/156836_1.jpg',' '),(25,2,6,'/images/products/','prod_190212_1694072574.png',0,'prod_190212_1694072574.png','prod_190212_1694072574.png','2023-09-17 17:00:35',0,'../images/products/prod_190212_1694072574.png',' '),(26,2,6,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(27,2,7,'/images/products/','prod_190218_1694072270.png',0,'prod_190218_1694072270.png','prod_190218_1694072270.png','2023-09-17 17:00:35',0,'../images/products/prod_190218_1694072270.png',' '),(28,2,7,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(29,2,8,'/images/products/','prod_190216_1694072358.png',0,'prod_190216_1694072358.png','prod_190216_1694072358.png','2023-09-17 17:00:35',0,'../images/products/prod_190216_1694072358.png',' '),(30,2,8,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(31,2,9,'/images/products/','prod_190214_1694072440.png',0,'prod_190214_1694072440.png','prod_190214_1694072440.png','2023-09-17 17:00:35',0,'../images/products/prod_190214_1694072440.png',' '),(32,2,10,'/images/products/','prod_190212_1694072574.png',0,'prod_190212_1694072574.png','prod_190212_1694072574.png','2023-09-17 17:00:35',0,'../images/products/prod_190212_1694072574.png',' '),(33,2,10,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(34,2,11,'/images/products/','prod_190218_1694072270.png',0,'prod_190218_1694072270.png','prod_190218_1694072270.png','2023-09-17 17:00:35',0,'../images/products/prod_190218_1694072270.png',' '),(35,2,11,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(36,2,12,'/images/products/','prod_190216_1694072358.png',0,'prod_190216_1694072358.png','prod_190216_1694072358.png','2023-09-17 17:00:35',0,'../images/products/prod_190216_1694072358.png',' '),(37,2,12,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(38,2,9,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(39,2,13,'/images/products/','prod_190214_1694072440.png',0,'prod_190214_1694072440.png','prod_190214_1694072440.png','2023-09-17 17:00:35',0,'../images/products/prod_190214_1694072440.png',' '),(40,2,13,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(41,3,0,'/images/products/','prod_190252_1693985322.png',0,'prod_190252_1693985322.png','prod_190252_1693985322.png','2023-09-17 17:00:35',0,'../images/products/prod_190252_1693985322.png',' '),(42,3,0,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(43,3,1,'/images/products/','prod_190259_1693985081.png',0,'prod_190259_1693985081.png','prod_190259_1693985081.png','2023-09-17 17:00:35',0,'../images/products/prod_190259_1693985081.png',' '),(44,3,1,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(45,3,2,'/images/products/','prod_190257_1693985140.png',0,'prod_190257_1693985140.png','prod_190257_1693985140.png','2023-09-17 17:00:35',0,'../images/products/prod_190257_1693985140.png',' '),(46,3,2,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(47,3,3,'/images/products/','prod_190254_1693985173.png',0,'prod_190254_1693985173.png','prod_190254_1693985173.png','2023-09-17 17:00:35',0,'../images/products/prod_190254_1693985173.png',' '),(48,3,3,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(49,3,4,'/images/products/','prod_190252_1693985322.png',0,'prod_190252_1693985322.png','prod_190252_1693985322.png','2023-09-17 17:00:35',0,'../images/products/prod_190252_1693985322.png',' '),(50,3,4,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(51,3,5,'/images/products/','prod_190259_1693985081.png',0,'prod_190259_1693985081.png','prod_190259_1693985081.png','2023-09-17 17:00:35',0,'../images/products/prod_190259_1693985081.png',' '),(52,3,5,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(53,3,6,'/images/products/','prod_190257_1693985140.png',0,'prod_190257_1693985140.png','prod_190257_1693985140.png','2023-09-17 17:00:35',0,'../images/products/prod_190257_1693985140.png',' '),(54,3,6,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(55,3,7,'/images/products/','prod_190254_1693985173.png',0,'prod_190254_1693985173.png','prod_190254_1693985173.png','2023-09-17 17:00:35',0,'../images/products/prod_190254_1693985173.png',' '),(56,3,7,'/images/products/','190262-1.png',1,'190262-1.png','190262-1.png','2023-09-17 17:00:35',0,'../images/products/190262-1.png',' '),(57,4,0,'/images/products/','MK2E3.jpg',0,'MK2E3.jpg','MK2E3.jpg','2023-09-17 17:00:35',0,'../images/products/MK2E3.jpg',' '),(58,4,1,'/images/products/','MMMQ3.jpg',0,'MMMQ3.jpg','MMMQ3.jpg','2023-09-17 17:00:35',0,'../images/products/MMMQ3.jpg',' '),(59,5,0,'/images/products/','MK2A3TA.jpg',0,'MK2A3TA.jpg','MK2A3TA.jpg','2023-09-17 17:00:35',0,'../images/products/MK2A3TA.jpg',' '),(60,6,0,'/images/products/','prod_190239_1694066020.png',0,'prod_190239_1694066020.png','prod_190239_1694066020.png','2023-09-17 17:00:35',0,'../images/products/prod_190239_1694066020.png',' '),(61,6,0,'/images/products/','190273-1.png',1,'190273-1.png','190273-1.png','2023-09-17 17:00:35',0,'../images/products/190273-1.png',' '),(62,6,1,'/images/products/','prod_190241_1694066011.png',0,'prod_190241_1694066011.png','prod_190241_1694066011.png','2023-09-17 17:00:35',0,'../images/products/prod_190241_1694066011.png',' '),(63,6,1,'/images/products/','190273-1.png',1,'190273-1.png','190273-1.png','2023-09-17 17:00:35',0,'../images/products/190273-1.png',' '),(64,6,2,'/images/products/','prod_190239_1694066020.png',0,'prod_190239_1694066020.png','prod_190239_1694066020.png','2023-09-17 17:00:35',0,'../images/products/prod_190239_1694066020.png',' '),(65,6,2,'/images/products/','190273-1.png',1,'190273-1.png','190273-1.png','2023-09-17 17:00:35',0,'../images/products/190273-1.png',' '),(66,6,3,'/images/products/','prod_190241_1694066011.png',0,'prod_190241_1694066011.png','prod_190241_1694066011.png','2023-09-17 17:00:35',0,'../images/products/prod_190241_1694066011.png',' '),(67,6,3,'/images/products/','190273-1.png',1,'190273-1.png','190273-1.png','2023-09-17 17:00:35',0,'../images/products/190273-1.png',' '),(68,6,4,'/images/products/','prod_190239_1694066020.png',0,'prod_190239_1694066020.png','prod_190239_1694066020.png','2023-09-17 17:00:35',0,'../images/products/prod_190239_1694066020.png',' '),(69,6,4,'/images/products/','190273-1.png',1,'190273-1.png','190273-1.png','2023-09-17 17:00:35',0,'../images/products/190273-1.png',' '),(70,6,5,'/images/products/','prod_190241_1694066011.png',0,'prod_190241_1694066011.png','prod_190241_1694066011.png','2023-09-17 17:00:35',0,'../images/products/prod_190241_1694066011.png',' '),(71,6,5,'/images/products/','190273-1.png',1,'190273-1.png','190273-1.png','2023-09-17 17:00:35',0,'../images/products/190273-1.png',' '),(72,7,0,'/images/products/','prod_182773_1685510143.jpg',0,'prod_182773_1685510143.jpg','prod_182773_1685510143.jpg','2023-09-17 17:00:35',0,'../images/products/prod_182773_1685510143.jpg',' '),(73,7,0,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(74,7,0,'/images/products/','182774-1.jpg',1,'182774-1.jpg','182774-1.jpg','2023-09-17 17:00:35',0,'../images/products/182774-1.jpg',' '),(75,7,0,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(76,7,1,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(77,7,1,'/images/products/','182774-1.jpg',1,'182774-1.jpg','182774-1.jpg','2023-09-17 17:00:35',0,'../images/products/182774-1.jpg',' '),(78,7,1,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(79,7,1,'/images/products/','prod_182774_1685437277.jpg',0,'prod_182774_1685437277.jpg','prod_182774_1685437277.jpg','2023-09-17 17:00:35',0,'../images/products/prod_182774_1685437277.jpg',' '),(80,8,0,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(81,8,0,'/images/products/','190351-1.jpg',1,'190351-1.jpg','190351-1.jpg','2023-09-17 17:00:35',0,'../images/products/190351-1.jpg',' '),(82,8,0,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(83,8,0,'/images/products/','prod_190351_1692238068.jpg',0,'prod_190351_1692238068.jpg','prod_190351_1692238068.jpg','2023-09-17 17:00:35',0,'../images/products/prod_190351_1692238068.jpg',' '),(84,8,1,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(85,8,1,'/images/products/','190351-1.jpg',1,'190351-1.jpg','190351-1.jpg','2023-09-17 17:00:35',0,'../images/products/190351-1.jpg',' '),(86,8,1,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(87,8,1,'/images/products/','prod_189120_1688955655.jpg',0,'prod_189120_1688955655.jpg','prod_189120_1688955655.jpg','2023-09-17 17:00:35',0,'../images/products/prod_189120_1688955655.jpg',' '),(88,8,2,'/images/products/','prod_185723_1686980593.jpg',0,'prod_185723_1686980593.jpg','prod_185723_1686980593.jpg','2023-09-17 17:00:35',0,'../images/products/prod_185723_1686980593.jpg',' '),(89,8,2,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(90,8,2,'/images/products/','190351-1.jpg',1,'190351-1.jpg','190351-1.jpg','2023-09-17 17:00:35',0,'../images/products/190351-1.jpg',' '),(91,8,2,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(92,8,3,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(93,8,3,'/images/products/','190351-1.jpg',1,'190351-1.jpg','190351-1.jpg','2023-09-17 17:00:35',0,'../images/products/190351-1.jpg',' '),(94,8,3,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(95,8,3,'/images/products/','prod_186512_1686973941.jpg',0,'prod_186512_1686973941.jpg','prod_186512_1686973941.jpg','2023-09-17 17:00:35',0,'../images/products/prod_186512_1686973941.jpg',' '),(96,9,0,'/images/products/','prod_186518_1686973784.jpg',0,'prod_186518_1686973784.jpg','prod_186518_1686973784.jpg','2023-09-17 17:00:35',0,'../images/products/prod_186518_1686973784.jpg',' '),(97,9,0,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(98,9,0,'/images/products/','186518-1.jpg',1,'186518-1.jpg','186518-1.jpg','2023-09-17 17:00:35',0,'../images/products/186518-1.jpg',' '),(99,9,0,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(100,9,1,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(101,9,1,'/images/products/','186518-1.jpg',1,'186518-1.jpg','186518-1.jpg','2023-09-17 17:00:35',0,'../images/products/186518-1.jpg',' '),(102,9,1,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(103,9,1,'/images/products/','prod_186519_1686973638.jpg',0,'prod_186519_1686973638.jpg','prod_186519_1686973638.jpg','2023-09-17 17:00:35',0,'../images/products/prod_186519_1686973638.jpg',' '),(104,10,0,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(105,10,0,'/images/products/','185783-1.jpg',1,'185783-1.jpg','185783-1.jpg','2023-09-17 17:00:35',0,'../images/products/185783-1.jpg',' '),(106,10,0,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(107,10,0,'/images/products/','prod_185783_1686979954.jpg',0,'prod_185783_1686979954.jpg','prod_185783_1686979954.jpg','2023-09-17 17:00:35',0,'../images/products/prod_185783_1686979954.jpg',' '),(108,10,1,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(109,10,1,'/images/products/','185783-1.jpg',1,'185783-1.jpg','185783-1.jpg','2023-09-17 17:00:35',0,'../images/products/185783-1.jpg',' '),(110,10,1,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(111,10,1,'/images/products/','prod_185782_1686980050.jpg',0,'prod_185782_1686980050.jpg','prod_185782_1686980050.jpg','2023-09-17 17:00:35',0,'../images/products/prod_185782_1686980050.jpg',' '),(112,7,2,'/images/products/','prod_186517_1683784741.jpg',0,'prod_186517_1683784741.jpg','prod_186517_1683784741.jpg','2023-09-17 17:00:35',0,'../images/products/prod_186517_1683784741.jpg',' '),(113,7,2,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(114,7,2,'/images/products/','182774-1.jpg',1,'182774-1.jpg','182774-1.jpg','2023-09-17 17:00:35',0,'../images/products/182774-1.jpg',' '),(115,7,2,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(116,7,3,'/images/products/','prod_186516_1683785345.jpg',0,'prod_186516_1683785345.jpg','prod_186516_1683785345.jpg','2023-09-17 17:00:35',0,'../images/products/prod_186516_1683785345.jpg',' '),(117,7,3,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(118,7,3,'/images/products/','182774-1.jpg',1,'182774-1.jpg','182774-1.jpg','2023-09-17 17:00:35',0,'../images/products/182774-1.jpg',' '),(119,7,3,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(120,7,4,'/images/products/','prod_186500_1683786478.jpg',0,'prod_186500_1683786478.jpg','prod_186500_1683786478.jpg','2023-09-17 17:00:35',0,'../images/products/prod_186500_1683786478.jpg',' '),(121,7,4,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(122,7,4,'/images/products/','182774-1.jpg',1,'182774-1.jpg','182774-1.jpg','2023-09-17 17:00:35',0,'../images/products/182774-1.jpg',' '),(123,7,4,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(124,11,0,'/images/products/','prod_190641_1694593060.jpg',0,'prod_190641_1694593060.jpg','prod_190641_1694593060.jpg','2023-09-17 17:00:35',0,'../images/products/prod_190641_1694593060.jpg',' '),(125,11,0,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(126,11,0,'/images/products/','190641-1.jpg',1,'190641-1.jpg','190641-1.jpg','2023-09-17 17:00:35',0,'../images/products/190641-1.jpg',' '),(127,11,0,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(128,11,1,'/images/products/','prod_187738_1690275724.jpg',0,'prod_187738_1690275724.jpg','prod_187738_1690275724.jpg','2023-09-17 17:00:35',0,'../images/products/prod_187738_1690275724.jpg',' '),(129,11,1,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(130,11,1,'/images/products/','190641-1.jpg',1,'190641-1.jpg','190641-1.jpg','2023-09-17 17:00:35',0,'../images/products/190641-1.jpg',' '),(131,11,1,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(132,11,3,'/images/products/','prod_183200_1690187827.jpg',0,'prod_183200_1690187827.jpg','prod_183200_1690187827.jpg','2023-09-17 17:00:35',0,'../images/products/prod_183200_1690187827.jpg',' '),(133,11,3,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(134,11,3,'/images/products/','190641-1.jpg',1,'190641-1.jpg','190641-1.jpg','2023-09-17 17:00:35',0,'../images/products/190641-1.jpg',' '),(135,11,3,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(136,11,2,'/images/products/','prod_185235_1690252548.jpg',0,'prod_185235_1690252548.jpg','prod_185235_1690252548.jpg','2023-09-17 17:00:35',0,'../images/products/prod_185235_1690252548.jpg',' '),(137,11,2,'/images/products/','ROG_1.jpg',1,'ROG_1.jpg','ROG_1.jpg','2023-09-17 17:00:35',0,'../images/products/ROG_1.jpg',' '),(138,11,2,'/images/products/','190641-1.jpg',1,'190641-1.jpg','190641-1.jpg','2023-09-17 17:00:35',0,'../images/products/190641-1.jpg',' '),(139,11,2,'/images/products/','asus_vip.jpg',1,'asus_vip.jpg','asus_vip.jpg','2023-09-17 17:00:35',0,'../images/products/asus_vip.jpg',' '),(140,12,0,'/images/products/','prod_188005_1687241802.jpg',0,'prod_188005_1687241802.jpg','prod_188005_1687241802.jpg','2023-09-17 17:00:35',0,'../images/products/prod_188005_1687241802.jpg',' '),(141,12,1,'/images/products/','prod_187189_1685437515.jpg',0,'prod_187189_1685437515.jpg','prod_187189_1685437515.jpg','2023-09-17 17:00:35',0,'../images/products/prod_187189_1685437515.jpg',' '),(142,12,1,'/images/products/','187188-1.jpg',1,'187188-1.jpg','187188-1.jpg','2023-09-17 17:00:35',0,'../images/products/187188-1.jpg',' '),(143,12,2,'/images/products/','prod_187188_1685437748.jpg',0,'prod_187188_1685437748.jpg','prod_187188_1685437748.jpg','2023-09-17 17:00:35',0,'../images/products/prod_187188_1685437748.jpg',' '),(144,12,2,'/images/products/','187188-1.jpg',1,'187188-1.jpg','187188-1.jpg','2023-09-17 17:00:35',0,'../images/products/187188-1.jpg',' '),(145,12,3,'/images/products/','prod_186423_1684985256.jpg',0,'prod_186423_1684985256.jpg','prod_186423_1684985256.jpg','2023-09-17 17:00:35',0,'../images/products/prod_186423_1684985256.jpg',' '),(146,12,3,'/images/products/','186423-1.jpg',1,'186423-1.jpg','186423-1.jpg','2023-09-17 17:00:35',0,'../images/products/186423-1.jpg',' '),(147,12,4,'/images/products/','prod_185706_1687242083.jpg',0,'prod_185706_1687242083.jpg','prod_185706_1687242083.jpg','2023-09-17 17:00:35',0,'../images/products/prod_185706_1687242083.jpg',' '),(148,12,5,'/images/products/','prod_175476_1687250960.jpg',0,'prod_175476_1687250960.jpg','prod_175476_1687250960.jpg','2023-09-17 17:00:35',0,'../images/products/prod_175476_1687250960.jpg',' '),(149,12,5,'/images/products/','186423-1.jpg',1,'186423-1.jpg','186423-1.jpg','2023-09-17 17:00:35',0,'../images/products/186423-1.jpg',' '),(150,12,6,'/images/products/','prod_173698_1687226989.jpg',0,'prod_173698_1687226989.jpg','prod_173698_1687226989.jpg','2023-09-17 17:00:35',0,'../images/products/prod_173698_1687226989.jpg',' '),(151,12,6,'/images/products/','186423-1.jpg',1,'186423-1.jpg','186423-1.jpg','2023-09-17 17:00:35',0,'../images/products/186423-1.jpg',' '),(152,13,0,'/images/products/','prod_190353_1694144394.jpg',0,'prod_190353_1694144394.jpg','prod_190353_1694144394.jpg','2023-09-17 17:00:35',0,'../images/products/prod_190353_1694144394.jpg',' '),(153,13,0,'/images/products/','190353-1.jpg',1,'190353-1.jpg','190353-1.jpg','2023-09-17 17:00:35',0,'../images/products/190353-1.jpg',' '),(154,13,1,'/images/products/','prod_189159_1688957054.jpg',0,'prod_189159_1688957054.jpg','prod_189159_1688957054.jpg','2023-09-17 17:00:35',0,'../images/products/prod_189159_1688957054.jpg',' '),(155,13,2,'/images/products/','prod_185609_1683170204.jpg',0,'prod_185609_1683170204.jpg','prod_185609_1683170204.jpg','2023-09-17 17:00:35',0,'../images/products/prod_185609_1683170204.jpg',' '),(156,13,2,'/images/products/','190353-1.jpg',1,'190353-1.jpg','190353-1.jpg','2023-09-17 17:00:35',0,'../images/products/190353-1.jpg',' '),(157,13,3,'/images/products/','prod_185608_1685438686.jpg',0,'prod_185608_1685438686.jpg','prod_185608_1685438686.jpg','2023-09-17 17:00:35',0,'../images/products/prod_185608_1685438686.jpg',' '),(158,13,3,'/images/products/','190353-1.jpg',1,'190353-1.jpg','190353-1.jpg','2023-09-17 17:00:35',0,'../images/products/190353-1.jpg',' '),(159,14,0,'/images/products/','prod_188899_1688364106.png',0,'prod_188899_1688364106.png','prod_188899_1688364106.png','2023-09-17 17:00:35',0,'../images/products/prod_188899_1688364106.png',' '),(160,14,0,'/images/products/','2(84).png',1,'2(84).png','2(84).png','2023-09-17 17:00:35',0,'../images/products/2(84).png',' '),(161,14,1,'/images/products/','prod_188900_1688364121.png',0,'prod_188900_1688364121.png','prod_188900_1688364121.png','2023-09-17 17:00:35',0,'../images/products/prod_188900_1688364121.png',' '),(162,14,1,'/images/products/','2(84).png',1,'2(84).png','2(84).png','2023-09-17 17:00:35',0,'../images/products/2(84).png',' '),(163,14,2,'/images/products/','prod_188898_1688364070.png',0,'prod_188898_1688364070.png','prod_188898_1688364070.png','2023-09-17 17:00:35',0,'../images/products/prod_188898_1688364070.png',' '),(164,14,2,'/images/products/','2(84).png',1,'2(84).png','2(84).png','2023-09-17 17:00:35',0,'../images/products/2(84).png',' '),(165,15,0,'/images/products/','prod_188895_1688362865.png',0,'prod_188895_1688362865.png','prod_188895_1688362865.png','2023-09-17 17:00:35',0,'../images/products/prod_188895_1688362865.png',' '),(166,15,0,'/images/products/','1(85).png',1,'1(85).png','1(85).png','2023-09-17 17:00:35',0,'../images/products/1(85).png',' '),(167,15,0,'/images/products/','2(81).png',1,'2(81).png','2(81).png','2023-09-17 17:00:35',0,'../images/products/2(81).png',' '),(168,15,0,'/images/products/','3(65).png',1,'3(65).png','3(65).png','2023-09-17 17:00:35',0,'../images/products/3(65).png',' '),(169,15,1,'/images/products/','prod_188896_1688362873.png',0,'prod_188896_1688362873.png','prod_188896_1688362873.png','2023-09-17 17:00:35',0,'../images/products/prod_188896_1688362873.png',' '),(170,15,1,'/images/products/','1(85).png',1,'1(85).png','1(85).png','2023-09-17 17:00:35',0,'../images/products/1(85).png',' '),(171,15,1,'/images/products/','2(81).png',1,'2(81).png','2(81).png','2023-09-17 17:00:35',0,'../images/products/2(81).png',' '),(172,15,1,'/images/products/','3(65).png',1,'3(65).png','3(65).png','2023-09-17 17:00:35',0,'../images/products/3(65).png',' '),(173,16,1,'/images/products/','prod_188677_1688023538.png',0,'prod_188677_1688023538.png','prod_188677_1688023538.png','2023-09-17 17:00:35',0,'../images/products/prod_188677_1688023538.png',' '),(174,16,1,'/images/products/','1(73).png',1,'1(73).png','1(73).png','2023-09-17 17:00:35',0,'../images/products/1(73).png',' '),(175,16,1,'/images/products/','2(69).png',1,'2(69).png','2(69).png','2023-09-17 17:00:35',0,'../images/products/2(69).png',' '),(176,16,1,'/images/products/','3(53).png',1,'3(53).png','3(53).png','2023-09-17 17:00:35',0,'../images/products/3(53).png',' '),(177,16,2,'/images/products/','prod_188654_1688023509.png',0,'prod_188654_1688023509.png','prod_188654_1688023509.png','2023-09-17 17:00:35',0,'../images/products/prod_188654_1688023509.png',' '),(178,16,2,'/images/products/','1(73).png',1,'1(73).png','1(73).png','2023-09-17 17:00:35',0,'../images/products/1(73).png',' '),(179,16,2,'/images/products/','2(69).png',1,'2(69).png','2(69).png','2023-09-17 17:00:35',0,'../images/products/2(69).png',' '),(180,16,2,'/images/products/','3(53).png',1,'3(53).png','3(53).png','2023-09-17 17:00:35',0,'../images/products/3(53).png',' '),(181,16,3,'/images/products/','prod_188675_1688023529.png',0,'prod_188675_1688023529.png','prod_188675_1688023529.png','2023-09-17 17:00:35',0,'../images/products/prod_188675_1688023529.png',' '),(182,16,3,'/images/products/','1(73).png',1,'1(73).png','1(73).png','2023-09-17 17:00:35',0,'../images/products/1(73).png',' '),(183,16,3,'/images/products/','2(69).png',1,'2(69).png','2(69).png','2023-09-17 17:00:35',0,'../images/products/2(69).png',' '),(184,16,3,'/images/products/','3(53).png',1,'3(53).png','3(53).png','2023-09-17 17:00:35',0,'../images/products/3(53).png',' '),(185,17,0,'/images/products/','187129-1.jpg',1,'187129-1.jpg','187129-1.jpg','2023-09-17 17:00:35',0,'../images/products/187129-1.jpg',' '),(186,17,0,'/images/products/','prod_191174_1694416227.jpg',0,'prod_191174_1694416227.jpg','prod_191174_1694416227.jpg','2023-09-17 17:00:35',0,'../images/products/prod_191174_1694416227.jpg',' '),(187,17,1,'/images/products/','187129-1.jpg',1,'187129-1.jpg','187129-1.jpg','2023-09-17 17:00:35',0,'../images/products/187129-1.jpg',' '),(188,17,1,'/images/products/','prod_187129_1685954978.jpg',0,'prod_187129_1685954978.jpg','prod_187129_1685954978.jpg','2023-09-17 17:00:35',0,'../images/products/prod_187129_1685954978.jpg',' '),(189,17,2,'/images/products/','187129-1.jpg',1,'187129-1.jpg','187129-1.jpg','2023-09-17 17:00:35',0,'../images/products/187129-1.jpg',' '),(190,17,2,'/images/products/','prod_186126_1683264783.jpg',0,'prod_186126_1683264783.jpg','prod_186126_1683264783.jpg','2023-09-17 17:00:35',0,'../images/products/prod_186126_1683264783.jpg',' '),(191,17,3,'/images/products/','187129-1.jpg',1,'187129-1.jpg','187129-1.jpg','2023-09-17 17:00:35',0,'../images/products/187129-1.jpg',' '),(192,17,3,'/images/products/','prod_186219_1694415989.png',0,'prod_186219_1694415989.png','prod_186219_1694415989.png','2023-09-17 17:00:35',0,'../images/products/prod_186219_1694415989.png',' '),(193,17,4,'/images/products/','prod_179097_1683255138.jpg',0,'prod_179097_1683255138.jpg','prod_186219_1694415989.png','2023-09-17 17:00:35',0,'../images/products/prod_179097_1683255138.jpg',' '),(194,17,4,'/images/products/','179090-1.jpg',1,'179090-1.jpg','179090-1.jpg','2023-09-17 17:00:35',0,'../images/products/179090-1.jpg',' '),(195,17,5,'/images/products/','prod_183961_1685433517.jpg',0,'prod_183961_1685433517.jpg','prod_183961_1685433517.jpg','2023-09-17 17:00:35',0,'../images/products/prod_183961_1685433517.jpg',' '),(196,17,5,'/images/products/','179090-1.jpg',1,'179090-1.jpg','179090-1.jpg','2023-09-17 17:00:35',0,'../images/products/179090-1.jpg',' '),(197,18,5,'/images/products/','prod_181381_1678946732.jpg',0,'prod_181381_1678946732.jpg','prod_181381_1678946732.jpg','2023-09-17 17:00:35',5,'../images/products/prod_181381_1678946732.jpg',' '),(198,18,5,'/images/products/','181381-1.jpg',1,'181381-1.jpg','181381-1.jpg','2023-09-17 17:00:35',0,'../images/products/181381-1.jpg',' '),(199,19,7,'/images/products/','prod_189282_1689580971.jpg',0,'prod_189282_1689580971.jpg','prod_189282_1689580971.jpg','2023-09-17 17:00:35',0,'../images/products/prod_189282_1689580971.jpg',' '),(200,19,7,'/images/products/','189282-1.jpg',1,'189282-1.jpg','189282-1.jpg','2023-09-17 17:00:35',0,'../images/products/189282-1.jpg',' '),(201,20,6,'/images/products/','prod_189219_1689566539.jpg',0,'prod_189219_1689566539.jpg','prod_189219_1689566539.jpg','2023-09-17 17:00:35',0,'../images/products/prod_189219_1689566539.jpg',' '),(202,20,6,'/images/products/','189219-1.jpg',1,'189219-1.jpg','189219-1.jpg','2023-09-17 17:00:35',0,'../images/products/189219-1.jpg',' '),(204,20,8,'/images/products/','189219-1.jpg',1,'189219-1.jpg','189219-1.jpg','2023-09-17 17:00:35',0,'../images/products/189219-1.jpg',' '),(205,21,3,'/images/products/','prod_189215_1689579800.jpg',0,'prod_189215_1689579800.jpg','prod_189215_1689579800.jpg','2023-09-17 17:00:35',0,'../images/products/prod_189215_1689579800.jpg',' '),(206,20,8,'/images/products/','prod_189218_1689579990.jpg',0,'prod_189218_1689579990.jpg','prod_189218_1689579990.jpg','2023-09-17 17:00:35',0,'../images/products/prod_189218_1689579990.jpg',' '),(207,21,3,'/images/products/','189213-1.jpg',1,'189213-1.jpg','189213-1.jpg','2023-09-17 17:00:35',0,'../images/products/189213-1.jpg',' '),(208,21,5,'/images/products/','prod_189214_1689579657.jpg',0,'prod_189214_1689579657.jpg','prod_189214_1689579657.jpg','2023-09-17 17:00:35',0,'../images/products/prod_189214_1689579657.jpg',' '),(209,21,5,'/images/products/','189213-1.jpg',1,'189213-1.jpg','189213-1.jpg','2023-09-17 17:00:35',0,'../images/products/189213-1.jpg',' '),(210,21,7,'/images/products/','prod_189213_1689578967.jpg',0,'prod_189213_1689578967.jpg','prod_189213_1689578967.jpg','2023-09-17 17:00:35',0,'../images/products/prod_189213_1689578967.jpg',' '),(211,21,7,'/images/products/','189213-1.jpg',1,'189213-1.jpg','189213-1.jpg','2023-09-17 17:00:35',0,'../images/products/189213-1.jpg',' '),(212,22,0,'/images/products/','prod_178654_1665709311.jpg',0,'prod_178654_1665709311.jpg','prod_178654_1665709311.jpg','2023-09-17 17:00:35',0,'../images/products/prod_178654_1665709311.jpg',' '),(213,23,0,'/images/products/','prod_188695_1690190748.png',0,'prod_188695_1690190748.png','prod_188695_1690190748.png','2023-09-17 17:00:35',0,'../images/products/prod_188695_1690190748.png',' '),(214,23,0,'/images/products/','188695-1.jpg',1,'188695-1.jpg','188695-1.jpg','2023-09-17 17:00:35',0,'../images/products/188695-1.jpg',' ');
/*!40000 ALTER TABLE `productimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sellspec`
--

DROP TABLE IF EXISTS `sellspec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sellspec` (
  `prod_id` int(11) NOT NULL,
  `spec_id` int(11) NOT NULL,
  `spec_name` varchar(100) NOT NULL,
  `contnet` varchar(500) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `publish` int(11) NOT NULL DEFAULT 0 COMMENT '不公開 0\r\n公開 1',
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  `update_time` datetime NOT NULL DEFAULT current_timestamp(),
  `info_content` varchar(2500) DEFAULT NULL,
  `cpu` varchar(150) DEFAULT NULL,
  `gpu` varchar(150) DEFAULT NULL,
  `ram` varchar(100) DEFAULT NULL,
  `os` varchar(100) DEFAULT NULL,
  `screen` varchar(150) DEFAULT NULL,
  `battery` varchar(100) DEFAULT NULL,
  `warranty` varchar(150) DEFAULT NULL,
  `size` varchar(100) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`prod_id`,`spec_id`),
  KEY `spec_id` (`spec_id`),
  CONSTRAINT `sellspec_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellspec`
--

LOCK TABLES `sellspec` WRITE;
/*!40000 ALTER TABLE `sellspec` DISABLE KEYS */;
INSERT INTO `sellspec` VALUES (1,0,'(M2,太空灰) 8GB/256G',NULL,39900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','• M2 晶片具備新一代 CPU、GPU 與新世代的機器學習效能表現\r\n• 8 核心 CPU 配備 4 個效能核心與 4 個節能核心\r\n• 10 核心 GPU\r\n• 16 核心神經網路引擎\r\n• 100GB/s 記憶體頻寬\r\n• 8GB 統一記憶體\r\n• 256GB SSD 儲存裝置\r\n• 全景圖影像合成的速度提升，最高可達43%\r\n• 遊戲效能提升，最高可達 39%\r\n• 主動式散熱系統，維持出色效能\r\n• 電池續航力最長可達 20 小時，滿足一天所需\r\n• 13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富\r\n• FaceTime HD 相機具備先進的影像訊號處理器，讓你在視訊通話中出色亮眼\r\n• 錄音室等級三麥克風陣列，收音更清晰\r\n• 快速的 Wi-Fi 6 無線連線能力\r\n• 兩個 Thunderbolt 埠，可供充電與連接配件\r\n• 背光巧控鍵盤具備觸控列和可供安全解鎖與付款的 Touch ID\r\n• 超快速的 SSD 儲存裝置，能讓你瞬間開啟 app 和檔案\r\n• macOS Monterey 讓聯繫、分享和創作的方式再也不同，輕鬆在所有 Apple 裝置互通','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','8GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n1.56 公分 (0.61 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.38 公斤 (3.0 磅)'),(1,1,'(M2,銀色) 8GB/256G',NULL,39900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','• M2 晶片具備新一代 CPU、GPU 與新世代的機器學習效能表現\r\n• 8 核心 CPU 配備 4 個效能核心與 4 個節能核心\r\n• 10 核心 GPU\r\n• 16 核心神經網路引擎\r\n• 100GB/s 記憶體頻寬\r\n• 8GB 統一記憶體\r\n• 256GB SSD 儲存裝置\r\n• 全景圖影像合成的速度提升，最高可達43%\r\n• 遊戲效能提升，最高可達 39%\r\n• 主動式散熱系統，維持出色效能\r\n• 電池續航力最長可達 20 小時，滿足一天所需\r\n• 13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富\r\n• FaceTime HD 相機具備先進的影像訊號處理器，讓你在視訊通話中出色亮眼\r\n• 錄音室等級三麥克風陣列，收音更清晰\r\n• 快速的 Wi-Fi 6 無線連線能力\r\n• 兩個 Thunderbolt 埠，可供充電與連接配件\r\n• 背光巧控鍵盤具備觸控列和可供安全解鎖與付款的 Touch ID\r\n• 超快速的 SSD 儲存裝置，能讓你瞬間開啟 app 和檔案\r\n• macOS Monterey 讓聯繫、分享和創作的方式再也不同，輕鬆在所有 Apple 裝置互通','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','8GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n1.56 公分 (0.61 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.38 公斤 (3.0 磅)'),(1,2,'(M2,太空灰) 8GB/512G',NULL,45900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','• Apple M2 晶片\r\n• M2 晶片具備新一代 CPU、GPU 與新世代的機器學習效能表現\r\n• 8 核心 CPU 配備 4 個效能核心與 4 個節能核心\r\n• 10 核心 GPU\r\n• 16 核心神經網路引擎\r\n• 100GB/s 記憶體頻寬\r\n• 8GB 統一記憶體\r\n• 512GB SSD 儲存裝置\r\n• 全景圖影像合成的速度提升，最高可達43%\r\n• 遊戲效能提升，最高可達 39%\r\n• 主動式散熱系統，維持出色效能\r\n• 電池續航力最長可達 20 小時，滿足一天所需\r\n• 13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富\r\n• FaceTime HD 相機具備先進的影像訊號處理器，讓你在視訊通話中出色亮眼\r\n• 錄音室等級三麥克風陣列，收音更清晰\r\n• 快速的 Wi-Fi 6 無線連線能力\r\n• 兩個 Thunderbolt 埠，可供充電與連接配件\r\n• 背光巧控鍵盤具備觸控列和可供安全解鎖與付款的 Touch ID\r\n• 超快速的 SSD 儲存裝置，能讓你瞬間開啟 app 和檔案\r\n• macOS Monterey 讓聯繫、分享和創作的方式再也不同，輕鬆在所有 Apple 裝置互通','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','8GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n1.56 公分 (0.61 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.38 公斤 (3.0 磅)'),(1,3,'(M2,銀色) 8GB/512G',NULL,45900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','• Apple M2 晶片\r\n• M2 晶片具備新一代 CPU、GPU 與新世代的機器學習效能表現\r\n• 8 核心 CPU 配備 4 個效能核心與 4 個節能核心\r\n• 10 核心 GPU\r\n• 16 核心神經網路引擎\r\n• 100GB/s 記憶體頻寬\r\n• 8GB 統一記憶體\r\n• 512GB SSD 儲存裝置\r\n• 全景圖影像合成的速度提升，最高可達43%\r\n• 遊戲效能提升，最高可達 39%\r\n• 主動式散熱系統，維持出色效能\r\n• 電池續航力最長可達 20 小時，滿足一天所需\r\n• 13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富\r\n• FaceTime HD 相機具備先進的影像訊號處理器，讓你在視訊通話中出色亮眼\r\n• 錄音室等級三麥克風陣列，收音更清晰\r\n• 快速的 Wi-Fi 6 無線連線能力\r\n• 兩個 Thunderbolt 埠，可供充電與連接配件\r\n• 背光巧控鍵盤具備觸控列和可供安全解鎖與付款的 Touch ID\r\n• 超快速的 SSD 儲存裝置，能讓你瞬間開啟 app 和檔案\r\n• macOS Monterey 讓聯繫、分享和創作的方式再也不同，輕鬆在所有 Apple 裝置互通','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','8GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n1.56 公分 (0.61 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.38 公斤 (3.0 磅)'),(1,4,'(M2,太空灰) 16GB/512G',NULL,51900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','• Apple M2 晶片\r\n• M2 晶片具備新一代 CPU、GPU 與新世代的機器學習效能表現\r\n• 8 核心 CPU 配備 4 個效能核心與 4 個節能核心\r\n• 10 核心 GPU\r\n• 16 核心神經網路引擎\r\n• 100GB/s 記憶體頻寬\r\n• 16GB 統一記憶體\r\n• 512GB SSD 儲存裝置\r\n• 全景圖影像合成的速度提升，最高可達43%\r\n• 遊戲效能提升，最高可達 39%\r\n• 主動式散熱系統，維持出色效能\r\n• 電池續航力最長可達 20 小時，滿足一天所需\r\n• 13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富\r\n• FaceTime HD 相機具備先進的影像訊號處理器，讓你在視訊通話中出色亮眼\r\n• 錄音室等級三麥克風陣列，收音更清晰\r\n• 快速的 Wi-Fi 6 無線連線能力\r\n• 兩個 Thunderbolt 埠，可供充電與連接配件\r\n• 背光巧控鍵盤具備觸控列和可供安全解鎖與付款的 Touch ID\r\n• 超快速的 SSD 儲存裝置，能讓你瞬間開啟 app 和檔案\r\n• macOS Monterey 讓聯繫、分享和創作的方式再也不同，輕鬆在所有 Apple 裝置互通','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','16GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n1.56 公分 (0.61 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.38 公斤 (3.0 磅)'),(1,5,'(M2,銀色) 16GB/512G',NULL,51900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','• Apple M2 晶片\r\n• M2 晶片具備新一代 CPU、GPU 與新世代的機器學習效能表現\r\n• 8 核心 CPU 配備 4 個效能核心與 4 個節能核心\r\n• 10 核心 GPU\r\n• 16 核心神經網路引擎\r\n• 100GB/s 記憶體頻寬\r\n• 16GB 統一記憶體\r\n• 512GB SSD 儲存裝置\r\n• 全景圖影像合成的速度提升，最高可達43%\r\n• 遊戲效能提升，最高可達 39%\r\n• 主動式散熱系統，維持出色效能\r\n• 電池續航力最長可達 20 小時，滿足一天所需\r\n• 13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富\r\n• FaceTime HD 相機具備先進的影像訊號處理器，讓你在視訊通話中出色亮眼\r\n• 錄音室等級三麥克風陣列，收音更清晰\r\n• 快速的 Wi-Fi 6 無線連線能力\r\n• 兩個 Thunderbolt 埠，可供充電與連接配件\r\n• 背光巧控鍵盤具備觸控列和可供安全解鎖與付款的 Touch ID\r\n• 超快速的 SSD 儲存裝置，能讓你瞬間開啟 app 和檔案\r\n• macOS Monterey 讓聯繫、分享和創作的方式再也不同，輕鬆在所有 Apple 裝置互通','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','16GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 500 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n1.56 公分 (0.61 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.38 公斤 (3.0 磅)'),(2,0,'(M1,太空灰) 8GB/256GB',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M1 晶片配備 8 核心 CPU、7 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置¹\r\n具備原彩顯示的 Retina 顯示器\r\n巧控鍵盤\r\nTouch ID\r\n力度觸控板\r\n兩個 Thunderbolt / USB 4 埠','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','7 核心 GPU','8GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 400 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n0.41 至 1.61 公分 (0.16 至 0.63 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.29 公斤 (2.8 磅)'),(2,1,'(M1,金) 8G/256G',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M1 晶片配備 8 核心 CPU、7 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置¹\r\n具備原彩顯示的 Retina 顯示器\r\n巧控鍵盤\r\nTouch ID\r\n力度觸控板\r\n兩個 Thunderbolt / USB 4 埠','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','7 核心 GPU','8GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 400 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n0.41 至 1.61 公分 (0.16 至 0.63 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.29 公斤 (2.8 磅)'),(2,2,'(M1,銀色) 8G/256G',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M1 晶片配備 8 核心 CPU、7 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置¹\r\n具備原彩顯示的 Retina 顯示器\r\n巧控鍵盤\r\nTouch ID\r\n力度觸控板\r\n兩個 Thunderbolt / USB 4 埠','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','7 核心 GPU','8GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 400 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n0.41 至 1.61 公分 (0.16 至 0.63 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.29 公斤 (2.8 磅)'),(2,3,'(M1,太空灰) 16GB/512GB',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M1 晶片配備 8 核心 CPU、7 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n512GB SSD 儲存裝置¹\r\n具備原彩顯示的 Retina 顯示器\r\n巧控鍵盤\r\nTouch ID\r\n力度觸控板\r\n兩個 Thunderbolt / USB 4 埠','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','7 核心 GPU','16GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 400 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n0.41 至 1.61 公分 (0.16 至 0.63 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.29 公斤 (2.8 磅)'),(2,4,'(M1,金) 16GB/512GB',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M1 晶片配備 8 核心 CPU、7 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n512GB SSD 儲存裝置¹\r\n具備原彩顯示的 Retina 顯示器\r\n巧控鍵盤\r\nTouch ID\r\n力度觸控板\r\n兩個 Thunderbolt / USB 4 埠','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','7 核心 GPU','16GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 400 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n0.41 至 1.61 公分 (0.16 至 0.63 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.29 公斤 (2.8 磅)'),(2,5,'(M1,銀色) 16GB/512GB',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M1 晶片配備 8 核心 CPU、7 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n512GB SSD 儲存裝置¹\r\n具備原彩顯示的 Retina 顯示器\r\n巧控鍵盤\r\nTouch ID\r\n力度觸控板\r\n兩個 Thunderbolt / USB 4 埠','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','7 核心 GPU','16GB 統一記憶體','macOS ','13.3 吋 Retina 顯示器具備 400 尼特亮度與 P3 廣色域，影像鮮明，細節豐富','電池續航力最長可達 20 小時，滿足一天所需',NULL,'高度\r\n0.41 至 1.61 公分 (0.16 至 0.63 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.24 公分 (8.36 吋)','1.29 公斤 (2.8 磅)'),(2,6,'(M2,午夜色)8G/256G',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、8 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置\r\n具備原彩顯示的 13.6 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n30W USB-C 電源轉接器','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','8 核心 GPU','8GB 統一記憶體','macOS ','具備原彩顯示的 13.6 吋 Liquid Retina 顯示器\r\n','整合式 52.6 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.13 公分 (0.44 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.50 公分 (8.46 吋)','1.24 公斤 (2.7 磅)'),(2,7,'(M2,星光色)8G/256G',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、8 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置\r\n具備原彩顯示的 13.6 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n30W USB-C 電源轉接器','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','8 核心 GPU','8GB 統一記憶體','macOS ','具備原彩顯示的 13.6 吋 Liquid Retina 顯示器\r\n','整合式 52.6 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.13 公分 (0.44 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.50 公分 (8.46 吋)','1.24 公斤 (2.7 磅)'),(2,8,'(M2,銀色)8G/256G',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、8 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置\r\n具備原彩顯示的 13.6 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n30W USB-C 電源轉接器','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','8 核心 GPU','8GB 統一記憶體','macOS ','具備原彩顯示的 13.6 吋 Liquid Retina 顯示器\r\n','整合式 52.6 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.13 公分 (0.44 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.50 公分 (8.46 吋)','1.24 公斤 (2.7 磅)'),(2,9,'(M2,太空灰)8G/256G',NULL,30900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、8 核心 GPU 與 16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置\r\n具備原彩顯示的 13.6 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n30W USB-C 電源轉接器','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','8 核心 GPU','8GB 統一記憶體','macOS ','具備原彩顯示的 13.6 吋 Liquid Retina 顯示器\r\n','整合式 52.6 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.13 公分 (0.44 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.50 公分 (8.46 吋)','1.24 公斤 (2.7 磅)'),(2,10,'(M2,午夜色)16G/512G',NULL,47900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、8 核心 GPU 與 16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n具備原彩顯示的 13.6 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n30W USB-C 電源轉接器\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)\r\n','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','8 核心 GPU','16GB 統一記憶體','macOS ','具備原彩顯示的 13.6 吋 Liquid Retina 顯示器\r\n','整合式 52.6 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.13 公分 (0.44 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.50 公分 (8.46 吋)','1.24 公斤 (2.7 磅)'),(2,11,'(M2,星光色)16G/512G',NULL,47900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、8 核心 GPU 與 16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n具備原彩顯示的 13.6 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n30W USB-C 電源轉接器\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)\r\n','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','8 核心 GPU','16GB 統一記憶體','macOS ','具備原彩顯示的 13.6 吋 Liquid Retina 顯示器\r\n','整合式 52.6 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.13 公分 (0.44 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.50 公分 (8.46 吋)','1.24 公斤 (2.7 磅)'),(2,12,'(M2,銀色)16G/512G',NULL,47900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、8 核心 GPU 與 16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n具備原彩顯示的 13.6 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n30W USB-C 電源轉接器\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)\r\n','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','8 核心 GPU','16GB 統一記憶體','macOS ','具備原彩顯示的 13.6 吋 Liquid Retina 顯示器\r\n','整合式 52.6 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.13 公分 (0.44 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.50 公分 (8.46 吋)','1.24 公斤 (2.7 磅)'),(2,13,'(M2,太空灰)16G/512G',NULL,47900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、8 核心 GPU 與 16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n具備原彩顯示的 13.6 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n30W USB-C 電源轉接器\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)\r\n','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','8 核心 GPU','16GB 統一記憶體','macOS ','具備原彩顯示的 13.6 吋 Liquid Retina 顯示器\r\n','整合式 52.6 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.13 公分 (0.44 吋)\r\n寬度\r\n30.41 公分 (11.97 吋)\r\n縱深\r\n21.50 公分 (8.46 吋)','1.24 公斤 (2.7 磅)'),(3,0,'(M2,午夜色)8G/256G',NULL,42900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、10 核心 GPU、16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置\r\n具備原彩顯示的 15.3 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n35W 雙 USB-C 埠小型電源轉接器\r\n','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','8GB 統一記憶體','macOS ','具備原彩顯示的 15.3 吋 Liquid Retina 顯示器','整合式 66.5 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.15 公分 (0.45 吋)\r\n寬度\r\n34.04 公分 (13.40 吋)\r\n縱深\r\n23.76 公分 (9.35 吋)','1.51 公斤 (3.3 磅)'),(3,1,'(M2,星光色)8G/256G',NULL,42900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、10 核心 GPU、16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置\r\n具備原彩顯示的 15.3 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n35W 雙 USB-C 埠小型電源轉接器\r\n','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','8GB 統一記憶體','macOS ','具備原彩顯示的 15.3 吋 Liquid Retina 顯示器','整合式 66.5 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.15 公分 (0.45 吋)\r\n寬度\r\n34.04 公分 (13.40 吋)\r\n縱深\r\n23.76 公分 (9.35 吋)','1.51 公斤 (3.3 磅)'),(3,2,'(M2,銀色)8G/256G',NULL,42900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、10 核心 GPU、16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置\r\n具備原彩顯示的 15.3 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n35W 雙 USB-C 埠小型電源轉接器\r\n','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','8GB 統一記憶體','macOS ','具備原彩顯示的 15.3 吋 Liquid Retina 顯示器','整合式 66.5 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.15 公分 (0.45 吋)\r\n寬度\r\n34.04 公分 (13.40 吋)\r\n縱深\r\n23.76 公分 (9.35 吋)','1.51 公斤 (3.3 磅)'),(3,3,'(M2,太空灰)8G/256G',NULL,42900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、10 核心 GPU、16 核心神經網路引擎\r\n8GB 統一記憶體\r\n256GB SSD 儲存裝置\r\n具備原彩顯示的 15.3 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n35W 雙 USB-C 埠小型電源轉接器\r\n','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','8GB 統一記憶體','macOS ','具備原彩顯示的 15.3 吋 Liquid Retina 顯示器','整合式 66.5 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.15 公分 (0.45 吋)\r\n寬度\r\n34.04 公分 (13.40 吋)\r\n縱深\r\n23.76 公分 (9.35 吋)','1.51 公斤 (3.3 磅)'),(3,4,'(M2,午夜色)16G/512G',NULL,54900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、10 核心 GPU、16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n具備原彩顯示的 15.3 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n35W 雙 USB-C 埠小型電源轉接器','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','16GB 統一記憶體','macOS ','具備原彩顯示的 15.3 吋 Liquid Retina 顯示器','整合式 66.5 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.15 公分 (0.45 吋)\r\n寬度\r\n34.04 公分 (13.40 吋)\r\n縱深\r\n23.76 公分 (9.35 吋)','1.51 公斤 (3.3 磅)'),(3,5,'(M2,星光色)16G/512G',NULL,54900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、10 核心 GPU、16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n具備原彩顯示的 15.3 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n35W 雙 USB-C 埠小型電源轉接器','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','16 GB 統一記憶體','macOS ','具備原彩顯示的 15.3 吋 Liquid Retina 顯示器','整合式 66.5 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.15 公分 (0.45 吋)\r\n寬度\r\n34.04 公分 (13.40 吋)\r\n縱深\r\n23.76 公分 (9.35 吋)','1.51 公斤 (3.3 磅)'),(3,6,'(M2,銀色)16G/512G',NULL,54900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、10 核心 GPU、16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n具備原彩顯示的 15.3 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n35W 雙 USB-C 埠小型電源轉接器','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','16 GB 統一記憶體','macOS ','具備原彩顯示的 15.3 吋 Liquid Retina 顯示器','整合式 66.5 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.15 公分 (0.45 吋)\r\n寬度\r\n34.04 公分 (13.40 吋)\r\n縱深\r\n23.76 公分 (9.35 吋)','1.51 公斤 (3.3 磅)'),(3,7,'(M2,太空灰)16G/512G',NULL,54900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 晶片配備 8 核心 CPU、10 核心 GPU、16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n具備原彩顯示的 15.3 吋 Liquid Retina 顯示器³\r\n1080p FaceTime HD 相機\r\nMagSafe 3 充電埠\r\n兩個 Thunderbolt / USB 4 埠\r\n35W 雙 USB-C 埠小型電源轉接器','8 核心 CPU 配備 4 個效能核心與 4 個節能核心','10 核心 GPU','16 GB 統一記憶體','macOS ','具備原彩顯示的 15.3 吋 Liquid Retina 顯示器','整合式 66.5 瓦特小時鋰聚合物電池',NULL,'高度\r\n1.15 公分 (0.45 吋)\r\n寬度\r\n34.04 公分 (13.40 吋)\r\n縱深\r\n23.76 公分 (9.35 吋)','1.51 公斤 (3.3 磅)'),(4,0,'白色多點觸控表面',NULL,2290,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','巧控滑鼠採用無線及可充電式設計，且底部設計再更精進，能順暢地在桌面上滑動。多點觸控表面可讓你使用簡單手勢操作，例如滑動切換網頁和捲動瀏覽文件等。\r\n\r\n配備充電式電池，每次充電可為巧控滑鼠提供約一個月或更長時間的電力。巧控滑鼠開箱即可使用，還可自動與你的 Mac 配對，並隨附一條編織的 USB-C 對 Lightning 連接線，用來連接到 Mac 上的 USB-C 埠，方便進行配對與充電。','','','','','','','','',''),(4,1,'黑色多點觸控表面',NULL,2290,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','巧控滑鼠採用無線及可充電式設計，且底部設計再更精進，能順暢地在桌面上滑動。多點觸控表面可讓你使用簡單手勢操作，例如滑動切換網頁和捲動瀏覽文件等。\r\n\r\n配備充電式電池，每次充電可為巧控滑鼠提供約一個月或更長時間的電力。巧控滑鼠開箱即可使用，還可自動與你的 Mac 配對，並隨附一條編織的 USB-C 對 Lightning 連接線，用來連接到 Mac 上的 USB-C 埠，方便進行配對與充電。','','','','','','','','',''),(5,0,'中文 (注音)',NULL,2290,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','巧控鍵盤提供格外舒適且精準的打字體驗。採用無線及可充電式設計，內建電池的長效表現令人讚歎，每次充電後能為鍵盤提供約一個月或更長時間的電力¹。還能與你的 Mac 自動配對，讓你立即開始工作。它並隨附一條編織的 USB-C 對 Lightning 連接線，用來連接到 Mac 上的 USB-C 埠，方便進行配對與充電。','','','','','','','','',''),(6,0,'(M2,太空灰)16G/512G',NULL,64900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 Pro 配備 10 核心 CPU、16 核心 GPU、16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n67W USB-C 電源轉接器\r\n14 吋 Liquid Retina XDR 顯示器²\r\n三個 Thunderbolt 4 埠、HDMI 埠、SDXC 卡插槽、耳機插孔、MagSafe 3 埠\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)','M2 Pro 晶片\r\n12 核心 CPU 配備 8 個效能核心與 4 個節能核心','16 核心 GPU','16GB 統一記憶體','macOS ','14 吋 Liquid Retina XDR 顯示器','整合式 70 瓦特小時鋰聚合物電池','','高度\r\n1.55 公分 (0.61 吋)\r\n寬度\r\n31.26 公分 (12.31 吋)\r\n縱深\r\n22.12 公分 (8.71 吋)\r\n','1.60 公斤 (3.54 磅)'),(6,1,'(M2,銀色)16G/512G',NULL,64900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 Pro 配備 10 核心 CPU、16 核心 GPU、16 核心神經網路引擎\r\n16GB 統一記憶體\r\n512GB SSD 儲存裝置\r\n67W USB-C 電源轉接器\r\n14 吋 Liquid Retina XDR 顯示器²\r\n三個 Thunderbolt 4 埠、HDMI 埠、SDXC 卡插槽、耳機插孔、MagSafe 3 埠\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)','M2 Pro 晶片\r\n12 核心 CPU 配備 8 個效能核心與 4 個節能核心','16 核心 GPU','16GB 統一記憶體','macOS ','14 吋 Liquid Retina XDR 顯示器','整合式 70 瓦特小時鋰聚合物電池','','高度\r\n1.55 公分 (0.61 吋)\r\n寬度\r\n31.26 公分 (12.31 吋)\r\n縱深\r\n22.12 公分 (8.71 吋)\r\n','1.60 公斤 (3.54 磅)'),(6,2,'(M2 MAX,太空灰)32G/1TB',NULL,79900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 Max 配備 12 核心 CPU、30 核心 GPU、16 核心神經網路引擎\r\n32GB 統一記憶體\r\n1TB SSD 儲存裝置\r\n96W USB-C 電源轉接器\r\n14 吋 Liquid Retina XDR 顯示器²\r\n三個 Thunderbolt 4 埠、HDMI 埠、SDXC 卡插槽、耳機插孔、MagSafe 3 埠\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)','M2 Max 晶片\r\n12 核心 CPU 配備 8 個效能核心與 4 個節能核心','30 核心 GPU','32 GB 統一記憶體','macOS ','14 吋 Liquid Retina XDR 顯示器','整合式 70 瓦特小時鋰聚合物電池','','高度\r\n1.55 公分 (0.61 吋)\r\n寬度\r\n31.26 公分 (12.31 吋)\r\n縱深\r\n22.12 公分 (8.71 吋)\r\n','1.63 公斤 (3.59 磅)'),(6,3,'(M2 MAX,銀色)32G/1TB',NULL,79900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 Max 配備 12 核心 CPU、30 核心 GPU、16 核心神經網路引擎\r\n32GB 統一記憶體\r\n1TB SSD 儲存裝置\r\n96W USB-C 電源轉接器\r\n14 吋 Liquid Retina XDR 顯示器²\r\n三個 Thunderbolt 4 埠、HDMI 埠、SDXC 卡插槽、耳機插孔、MagSafe 3 埠\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)\r\n加入換購方案','M2 Pro 晶片\r\n12 核心 CPU 配備 8 個效能核心與 4 個節能核心','30 核心 GPU','32 GB 統一記憶體','macOS ','14 吋 Liquid Retina XDR 顯示器','整合式 70 瓦特小時鋰聚合物電池','','高度\r\n1.55 公分 (0.61 吋)\r\n寬度\r\n31.26 公分 (12.31 吋)\r\n縱深\r\n22.12 公分 (8.71 吋)\r\n','1.63 公斤 (3.59 磅)'),(6,4,'(M2 MAX,太空灰)32G/2TB',NULL,109900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 Max 配備 12 核心 CPU、30 核心 GPU、16 核心神經網路引擎\r\n32GB 統一記憶體\r\n2TB SSD 儲存裝置\r\n96W USB-C 電源轉接器\r\n14 吋 Liquid Retina XDR 顯示器²\r\n三個 Thunderbolt 4 埠、HDMI 埠、SDXC 卡插槽、耳機插孔、MagSafe 3 埠\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)','M2 Max 晶片\r\n12 核心 CPU 配備 8 個效能核心與 4 個節能核心','30 核心 GPU','32 GB 統一記憶體','macOS ','14 吋 Liquid Retina XDR 顯示器','整合式 70 瓦特小時鋰聚合物電池','','高度\r\n1.55 公分 (0.61 吋)\r\n寬度\r\n31.26 公分 (12.31 吋)\r\n縱深\r\n22.12 公分 (8.71 吋)\r\n','1.63 公斤 (3.59 磅)'),(6,5,'(M2 MAX,銀色)32G/2TB',NULL,10900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','Apple M2 Max 配備 12 核心 CPU、30 核心 GPU、16 核心神經網路引擎\r\n32GB 統一記憶體\r\n2TB SSD 儲存裝置\r\n96W USB-C 電源轉接器\r\n14 吋 Liquid Retina XDR 顯示器²\r\n三個 Thunderbolt 4 埠、HDMI 埠、SDXC 卡插槽、耳機插孔、MagSafe 3 埠\r\n含 Touch ID 的背光巧控鍵盤 - 中文 (注音)\r\n加入換購方案','M2 Pro 晶片\r\n12 核心 CPU 配備 8 個效能核心與 4 個節能核心','30 核心 GPU','32 GB 統一記憶體','macOS ','14 吋 Liquid Retina XDR 顯示器','整合式 70 瓦特小時鋰聚合物電池','','高度\r\n1.55 公分 (0.61 吋)\r\n寬度\r\n31.26 公分 (12.31 吋)\r\n縱深\r\n22.12 公分 (8.71 吋)\r\n','1.63 公斤 (3.59 磅)'),(7,0,'日蝕灰 ( GA402RJ )',NULL,60900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen9 6900HS 8核心/16緒 3.3GHz超頻4.9GHz/ L2快取 4MB+L3快取 16MB\r\n顯示卡：AMD Radeon™ RX6700S GDDR6 8GB(具備MUX獨顯直連)\r\n記憶體：16G(8G*2)(8GB on board) DDR5 4800/ 總共1個插槽，共使用1個，最高支援32G\r\n固態硬碟：1TB M.2 NVMe™ PCIe 4.0 SSD\r\n螢幕：14\'(薄邊框)/ ROG Nebula Display/ WQXGA (2560 x 1600) 16:10 /120Hz 3ms/IPS-level / DCI-P3 100% / Pantone 認證 / Dolby Vision\r\n光碟機：NO\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6E(802.11ax)+Bluetooth 5.2 (Dual band) 2*2\r\n視訊：720P HD IR Camera for Windows Hello\r\n其他規格：\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery\r\n2x USB 3.2 Gen 2 Type-A\r\n1x card reader (microSD) (UHS-II)\r\n1x HDMI 2.0b\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：31.2 x 22.7 x 1.95 ~ 1.95 cm\r\n重量：1.72 Kg\r\n電池：76WHrs, 4S1P, 4-cell Li-ion\r\n變壓器： 180W AC Adapter/ 100-240V AC通用\r\n保固：二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen9 6900HS 8核心/16緒 3.3GHz超頻4.9GHz/ L2快取 4MB+L3快取 16MB','AMD Radeon™ RX6700S GDDR6 8GB(具備MUX獨顯直連)','16G(8G*2)(8GB on board) DDR5 4800/ 總共1個插槽，共使用1個，最高支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','14\'(薄邊框)/ ROG Nebula Display/ WQXGA (2560 x 1600) 16:10 /120Hz 3ms/IPS-level / DCI-P3 100% / Pantone 認證 / Dolby Vision','電池續航力最長可達 20 小時，滿足一天所需','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','31.2 x 22.7 x 1.95 ~ 1.95 cm','1.72 Kg'),(7,1,'月光白 ( GA402RJ )',NULL,60900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen9 6900HS 8核心/16緒 3.3GHz超頻4.9GHz/ L2快取 4MB+L3快取 16MB\r\n顯示卡：AMD Radeon™ RX6700S GDDR6 8GB(具備MUX獨顯直連)\r\n記憶體：16G(8G*2)(8GB on board) DDR5 4800/ 總共1個插槽，共使用1個，最高支援32G\r\n固態硬碟：1TB M.2 NVMe™ PCIe 4.0 SSD\r\n螢幕：14\'(薄邊框)/ ROG Nebula Display/ WQXGA (2560 x 1600) 16:10 /120Hz 3ms/IPS-level / DCI-P3 100% / Pantone 認證 / Dolby Vision\r\n光碟機：NO\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6E(802.11ax)+Bluetooth 5.2 (Dual band) 2*2\r\n視訊：720P HD IR Camera for Windows Hello\r\n其他規格：\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery\r\n2x USB 3.2 Gen 2 Type-A\r\n1x card reader (microSD) (UHS-II)\r\n1x HDMI 2.0b\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：31.2 x 22.7 x 1.95 ~ 1.95 cm\r\n重量：1.72 Kg\r\n電池：76WHrs, 4S1P, 4-cell Li-ion\r\n變壓器： 180W AC Adapter/ 100-240V AC通用\r\n保固：二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen9 6900HS 8核心/16緒 3.3GHz超頻4.9GHz/ L2快取 4MB+L3快取 16MB','AMD Radeon™ RX6700S GDDR6 8GB(具備MUX獨顯直連)','16G(8G*2)(8GB on board) DDR5 4800/ 總共1個插槽，共使用1個，最高支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','14\'(薄邊框)/ ROG Nebula Display/ WQXGA (2560 x 1600) 16:10 /120Hz 3ms/IPS-level / DCI-P3 100% / Pantone 認證 / Dolby Vision','電池續航力最長可達 20 小時，滿足一天所需','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','31.2 x 22.7 x 1.95 ~ 1.95 cm','1.72 Kg'),(7,2,'月光白 ( GA402XV)',NULL,65999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)\r\n顯示卡：NVIDIA® GeForce RTX™ 4060 8GB GDDR6(具備MUX獨顯直連)\r\n2300MHz* at 125W (2250MHz Boost Clock+50MHz OC, 100W+25W Dynamic Boost)\r\n記憶體：16GB DDR5 on board / 總共1個插槽，已經使用1個，最高支援32G\r\n硬碟：1TB PCIe® 4.0 NVMe™ M.2 SSD / 總共2個插槽，已經使用1個\r\n螢幕：14 \"(薄邊框)/QHD+ 16:10 (2560 x 1600, WQXGA)/165Hz/3ms/IPS-level/Anti-glare/DCI-P3 100%/Pantone 認證/Dolby Vision/G-Sync\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6E(802.11ax) (Triple band) 2*2 + Bluetooth® 5.2\r\nI/O:\r\n1x Type C USB 4 support DisplayPort™ / power delivery\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™\r\n2x USB 3.2 Gen 2 Type-A\r\n1x card reader (microSD) (UHS-II)\r\n1x HDMI 2.1 FRL\r\n尺寸：31.2 x 22.7 x 1.95 ~ 2.05 cm\r\n重量：1.72 Kg\r\n電池：76WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / LCD無亮點保固 / 電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)','NVIDIA® GeForce RTX™ 4060 8GB GDDR6(具備MUX獨顯直連)\r\n2300MHz* at 125W (2250MHz Boost Clock+50MHz OC, 100W+25W Dynamic Boost)','16GB DDR5 on board / 總共1個插槽，已經使用1個，最高支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','14\'(薄邊框)/ ROG Nebula Display/ WQXGA (2560 x 1600) 16:10 /120Hz 3ms/IPS-level / DCI-P3 100% / Pantone 認證 / Dolby Vision','電池續航力最長可達 20 小時，滿足一天所需','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','31.2 x 22.7 x 1.95 ~ 2.05 cm','1.72 Kg'),(7,3,'日蝕灰 ( GA402XV )',NULL,65999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)\r\n顯示卡：NVIDIA® GeForce RTX™ 4060 8GB GDDR6(具備MUX獨顯直連)\r\n2300MHz* at 125W (2250MHz Boost Clock+50MHz OC, 100W+25W Dynamic Boost)\r\n記憶體：16GB DDR5 on board / 總共1個插槽，已經使用1個，最高支援32G\r\n硬碟：1TB PCIe® 4.0 NVMe™ M.2 SSD / 總共2個插槽，已經使用1個\r\n螢幕：14 \"(薄邊框)/QHD+ 16:10 (2560 x 1600, WQXGA)/165Hz/3ms/IPS-level/Anti-glare/DCI-P3 100%/Pantone 認證/Dolby Vision/G-Sync\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6E(802.11ax) (Triple band) 2*2 + Bluetooth® 5.2\r\nI/O:\r\n1x Type C USB 4 support DisplayPort™ / power delivery\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™\r\n2x USB 3.2 Gen 2 Type-A\r\n1x card reader (microSD) (UHS-II)\r\n1x HDMI 2.1 FRL\r\n尺寸：31.2 x 22.7 x 1.95 ~ 2.05 cm\r\n重量：1.72 Kg\r\n電池：76WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / LCD無亮點保固 / 電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)','NVIDIA® GeForce RTX™ 4060 8GB GDDR6(具備MUX獨顯直連)\r\n2300MHz* at 125W (2250MHz Boost Clock+50MHz OC, 100W+25W Dynamic Boost)','16GB DDR5 on board / 總共1個插槽，已經使用1個，最高支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','14\'(薄邊框)/ ROG Nebula Display/ WQXGA (2560 x 1600) 16:10 /120Hz 3ms/IPS-level / DCI-P3 100% / Pantone 認證 / Dolby Vision','電池續航力最長可達 20 小時，滿足一天所需','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','31.2 x 22.7 x 1.95 ~ 2.05 cm','1.72 Kg'),(7,4,'日蝕灰 ( GA402XZ )',NULL,81999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)\r\n顯示卡：NVIDIA® GeForce RTX™ 4080 12GB GDDR6(具備MUX獨顯直連)\r\n記憶體：16GB DDR5 on board\r\n硬碟：1TB PCIe® 4.0 NVMe™ M.2 Performance SSD\r\n螢幕：14 \"(薄邊框)/QHD+ 16:10 (2560 x 1600, WQXGA)/165Hz/3ms/IPS-level/Anti-glare/DCI-P3 100%/Pantone 認證/Dolby Vision/G-Sync\r\n光碟機：NO\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6E(802.11ax) (Triple band) 2*2 + Bluetooth® 5.2\r\nI/O:\r\n1x Type C USB 4 support DisplayPort™ / power delivery\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™\r\n2x USB 3.2 Gen 2 Type-A\r\n1x card reader (microSD) (UHS-II)\r\n1x HDMI 2.1 FRL\r\n尺寸：31.2 x 22.7 x 1.95 ~ 2.05 cm\r\n重量：1.72 Kg\r\n電池：76WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / LCD無亮點保固 / 電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)','NVIDIA® GeForce RTX™ 4080 12GB GDDR6(具備MUX獨顯直連)','16GB DDR5 on board','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','14\'(薄邊框)/ ROG Nebula Display/ WQXGA (2560 x 1600) 16:10 /120Hz 3ms/IPS-level / DCI-P3 100% / Pantone 認證 / Dolby Vision','電池續航力最長可達 20 小時，滿足一天所需','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','31.2 x 22.7 x 1.95 ~ 2.05 cm','1.72 Kg'),(8,0,'御鐵灰 ( FA507NU )',NULL,34999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 7 7735H (8-core/16-thread, 16MB L3 cache, up to 4.7 GHz max boost)\r\n顯示卡：\'NVIDIA® GeForce RTX™ 4050 6GB GDDR6(具備MUX獨顯直連)\r\n2420MHz* at 140W (2370MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)\r\n記憶體：8GB DDR5-4800 / 共2個插槽，已經使用1個，最大支援32G\r\nSSD硬碟：512GB PCIe® 4.0 NVMe™ M.2 SSD / 共2個插槽，已使用1個\r\n傳統硬碟：無法擴充\r\n螢幕：15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/G-Sync\r\n光碟機： 無\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth® 5.2\r\n鍵盤：Backlit Chiclet Keyboard 1-Zone RGB\r\n網路攝影機：720P HD camera\r\nIO PORT :\r\n1x RJ45 LAN port\r\n1x Type C USB 4 support DisplayPort™ / G-SYNC\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery / G-SYNC\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：35.4 x 25.1 x 2.24 ~ 2.49 cm\r\n重量：2.20 Kg\r\n電池：90WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 7 7735H (8-core/16-thread, 16MB L3 cache, up to 4.7 GHz max boost)','NVIDIA® GeForce RTX™ 4050 6GB GDDR6(具備MUX獨顯直連)\r\n2420MHz* at 140W (2370MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)','8GB DDR5-4800 / 共2個插槽，已經使用1個，最大支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/G-Sync','90WHrs, 4S1P, 4-cell Li-ion','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.4 x 25.1 x 2.24 ~ 2.49 cm','2.20 Kg'),(8,1,'軍規電競 16G升級版 御鐵灰 ( FA507NU )',NULL,43999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 7 7735H (8-core/16-thread, 16MB L3 cache, up to 4.7 GHz max boost)\r\n顯示卡：\'NVIDIA® GeForce RTX™ 4060 8GB GDDR6(具備MUX獨顯直連)\r\n2420MHz* at 140W (2370MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)\r\n記憶體：16GB DDR5-4800 / 共2個插槽，已經使用2個，最大支援32G\r\nSSD硬碟：512GB PCIe® 4.0 NVMe™ M.2 SSD / 共2個插槽，已使用1個\r\n傳統硬碟：無法擴充\r\n螢幕：15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/G-Sync\r\n光碟機： 無\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth® 5.2\r\n鍵盤：Backlit Chiclet Keyboard 1-Zone RGB\r\n網路攝影機：720P HD camera\r\nIO PORT :\r\n1x RJ45 LAN port\r\n1x Type C USB 4 support DisplayPort™ / G-SYNC\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery / G-SYNC\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：35.4 x 25.1 x 2.24 ~ 2.49 cm\r\n重量：2.20 Kg\r\n電池：90WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 7 7735H (8-core/16-thread, 16MB L3 cache, up to 4.7 GHz max boost)','NVIDIA® GeForce RTX™ 4060 8GB GDDR6(具備MUX獨顯直連)\r\n2420MHz* at 140W (2370MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)','16GB DDR5-4800 / 共2個插槽，已經使用2個，最大支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/G-Sync','90WHrs, 4S1P, 4-cell Li-ion','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.4 x 25.1 x 2.24 ~ 2.49 cm','2.20 Kg'),(8,2,'軍規電競 御鐵灰 ( FA507NV )',NULL,43999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 7 7735H (8-core/16-thread, 16MB L3 cache, up to 4.7 GHz max boost)\r\n顯示卡：\'NVIDIA® GeForce RTX™ 4060 8GB GDDR6(具備MUX獨顯直連)\r\n2420MHz* at 140W (2370MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)\r\n記憶體：8GB DDR5-4800 / 共2個插槽，已經使用1個，最大支援32G\r\nSSD硬碟：512GB PCIe® 4.0 NVMe™ M.2 SSD / 共2個插槽，已使用1個\r\n傳統硬碟：無法擴充\r\n螢幕：15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/G-Sync\r\n光碟機： 無\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth® 5.2\r\n鍵盤：Backlit Chiclet Keyboard 1-Zone RGB\r\n網路攝影機：720P HD camera\r\nIO PORT :\r\n1x RJ45 LAN port\r\n1x Type C USB 4 support DisplayPort™ / G-SYNC\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery / G-SYNC\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：35.4 x 25.1 x 2.24 ~ 2.49 cm\r\n重量：2.20 Kg\r\n電池：90WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 7 7735H (8-core/16-thread, 16MB L3 cache, up to 4.7 GHz max boost)','NVIDIA® GeForce RTX™ 4060 8GB GDDR6(具備MUX獨顯直連)\r\n2420MHz* at 140W (2370MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)','8GB DDR5-4800 / 共2個插槽，已經使用1個，最大支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/G-Sync','90WHrs, 4S1P, 4-cell Li-ion','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.4 x 25.1 x 2.24 ~ 2.49 cm','2.20 Kg'),(8,3,'軍規電競 御鐵灰 ( FA507XI )',NULL,54999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)\r\n顯示卡：NVIDIA® GeForce RTX™ 4070 8GB GDDR6 (具備MUX獨顯直連)\r\n2225MHz* at140W (2175MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)\r\n記憶體：16GB DDR5-4800 / 總共2個插槽，已經使用2個，最高支援32GB\r\n硬碟：512GB PCIe® 4.0 NVMe™ M.2 SSD / 總共2個插槽，已經使用1個\r\n螢幕：15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/G-Sync\r\n光碟機：NO\r\n作業系統：Windows11 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth® 5.2\r\nI/O:\r\n1x RJ45 LAN port\r\n1x Type C USB 4 support DisplayPort™\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：35.4 x 25.1 x 2.24 ~ 2.49 cm\r\n重量：2.20 Kg\r\n電池：90WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / LCD無亮點保固 / 電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)','NVIDIA® GeForce RTX™ 4070 8GB GDDR6 (具備MUX獨顯直連)\r\n2225MHz* at140W (2175MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)','16GB DDR5-4800 / 總共2個插槽，已經使用2個，最高支援32GB','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/G-Sync','90WHrs, 4S1P, 4-cell Li-ion','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.4 x 25.1 x 2.24 ~ 2.49 cm','2.20 Kg'),(9,0,'軍規電競 暴風沙 ( FA617XS )',NULL,51999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)\r\n顯示卡：AMD Radeon™ RX 7600S 8GB GDDR6(具備MUX獨顯直連) up to 95W(SmartShift)\r\n記憶體：16GB DDR5-4800 / 總共2個插槽，已經使用2個，最高支援32G\r\n硬碟：512GB PCIe® 4.0 NVMe™ M.2 SSD / 總共2個插槽，已經使用1個\r\n螢幕：16 \"(薄邊框)/QHD+ 16:10 (2560 x 1600, WQXGA)/240Hz/3ms/IPS-level/Anti-glare/DCI-P3 100%/FreeSync Premium\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth® 5.2\r\nI/O:\r\n1x RJ45 LAN port\r\n1x Type C USB 4 support DisplayPort™\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：35.5 x 25.2 x 2.21 ~ 2.68 cm\r\n重量：2.20 Kg\r\n電池：90WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / LCD無亮點保固 / 電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 9 7940H (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost)','AMD Radeon™ RX 7600S 8GB GDDR6(具備MUX獨顯直連) up to 95W(SmartShift)','16GB DDR5-4800 / 總共2個插槽，已經使用2個，最高支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','16 \"(薄邊框)/QHD+ 16:10 (2560 x 1600, WQXGA)/240Hz/3ms/IPS-level/Anti-glare/DCI-P3 100%/FreeSync Premium','90WHrs, 4S1P, 4-cell Li-ion','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.5 x 25.2 x 2.21 ~ 2.68 cm','2.20 Kg'),(9,1,'軍規電競 暴風沙 ( FA617NS )',NULL,43900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen™ 7 7735H (8-core/16-thread, 16MB L3 cache, up to 4.7 GHz max boost)\r\n顯示卡：AMD Radeon™ RX 7600S 8GB GDDR6(具備MUX獨顯直連) up to 95W(SmartShift)\r\n記憶體：16GB DDR5-4800 / 總共2個插槽，已經使用2個，最高支援32G\r\n硬碟：512GB PCIe® 4.0 NVMe™ M.2 SSD / 總共2個插槽，已經使用1個\r\n螢幕：16 \"(薄邊框)/FHD+ 16:10 (1920 x 1200, WUXGA)/165Hz/7ms/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/FreeSync\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth® 5.2\r\nI/O:\r\n1x RJ45 LAN port\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：35.5 x 25.2 x 2.21 ~ 2.68 cm\r\n重量：2.20 Kg\r\n電池：90WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / LCD無亮點保固 / 電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen™ 7 7735H (8-core/16-thread, 16MB L3 cache, up to 4.7 GHz max boost)','AMD Radeon™ RX 7600S 8GB GDDR6(具備MUX獨顯直連) up to 95W(SmartShift)','16GB DDR5-4800 / 總共2個插槽，已經使用2個，最高支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','16 \"(薄邊框)/QHD+ 16:10 (2560 x 1600, WQXGA)/240Hz/3ms/IPS-level/Anti-glare/DCI-P3 100%/FreeSync Premium','90WHrs, 4S1P, 4-cell Li-ion','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.5 x 25.2 x 2.21 ~ 2.68 cm','2.20 Kg'),(10,0,'軍規電競 機甲灰 ( FX507ZC4 )',NULL,36999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-12500H 12核心/16緒 3.3GHz 超頻 4.50GHz / 18M Cache\r\n顯示卡：NVIDIA® GeForce RTX™ 3050 4GB GDDR6(具備MUX獨顯直連)\r\n1790MHz* at 95W (1740MHz Boost Clock+50MHz OC, 80W+15W Dynamic Boost)\r\n記憶體：16GB DDR4-3200 / 共2個插槽，已經使用1個，最大支援32G\r\nSSD硬碟：512G M.2 NVMe PCIe 3.0 SSD / 共1個插槽，已經使用1個\r\n傳統硬碟：不可擴充\r\n螢幕：15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/Adaptive-Sync\r\n光碟機： 無\r\n作業系統：Windows 11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth® 5.2\r\n鍵盤：單區RGB多彩鍵盤\r\n網路攝影機：720 HD 網路攝影機\r\nIO PORT :\r\n1x RJ45 LAN port\r\n1x Thunderbolt™ 4 support DisplayPort™\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / G-SYNC\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：35.4 x 25.1 x 2.24 ~ 2.49 cm\r\n重量：2.20 Kg\r\n電池：90WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 200W AC Adapter, Output: 20V DC, 10A, 200W, Input: 100-240V AC, 50/60Hz universal\r\n保固：二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i5-12500H 12核心/16緒 3.3GHz 超頻 4.50GHz / 18M Cache','NVIDIA® GeForce RTX™ 3050 4GB GDDR6(具備MUX獨顯直連)\r\n1790MHz* at 95W (1740MHz Boost Clock+50MHz OC, 80W+15W Dynamic Boost)','16GB DDR4-3200 / 共2個插槽，已經使用1個，最大支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/Adaptive-Sync','90WHrs, 4S1P, 4-cell Li-ion','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.4 x 25.1 x 2.24 ~ 2.49 cm','2.20 Kg'),(10,1,'軍規電競 御鐵灰 ( FX507ZU4 )',NULL,35999,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i7-12700H 14核心/20緒 2.3GHz 超頻 4.70GHz / 24M Cache\r\n顯示卡：NVIDIA® GeForce RTX™ 4050 6GB GDDR6(具備MUX獨顯直連)\r\nROG Boost: 2420MHz* at 140W (2370MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)\r\n記憶體：8GB DDR4-3200 / 共2個插槽，已經使用1個，最大支援32G\r\nSSD硬碟：512GB PCIe® 4.0 NVMe™ M.2 SSD / 總共2個插槽，已經使用1個\r\n傳統硬碟：不可擴充\r\n螢幕：15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/Adaptive-Sync\r\n光碟機： 無\r\n作業系統：Windows 11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth® 5.2\r\n鍵盤：單區RGB多彩鍵盤\r\n網路攝影機：720 HD 網路攝影機\r\nIO PORT :\r\n1x RJ45 LAN port\r\n1x Thunderbolt™ 4 support DisplayPort™\r\n1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery / G-SYNC\r\n2x USB 3.2 Gen 1 Type-A\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm Combo Audio Jack\r\n尺寸：35.4 x 25.1 x 2.24 ~ 2.49 cm\r\n重量：2.20 Kg\r\n電池：90WHrs, 4S1P, 4-cell Li-ion\r\n變壓器：ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal\r\n保固：二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i7-12700H 14核心/20緒 2.3GHz 超頻 4.70GHz / 24M Cache','NVIDIA® GeForce RTX™ 4050 6GB GDDR6(具備MUX獨顯直連)\r\nROG Boost: 2420MHz* at 140W (2370MHz Boost Clock+50MHz OC, 115W+25W Dynamic Boost)','16GB DDR4-3200 / 共2個插槽，已經使用1個，最大支援32G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6 \"(薄邊框)/FHD (1920 x 1080) 16:9/144Hz/IPS-level/Anti-glare/NTSC 72%/SRGB 100%/Adaptive-Sync','90WHrs, 4S1P, 4-cell Li-ion','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.4 x 25.1 x 2.24 ~ 2.49 cm','2.20 Kg'),(11,0,'華碩OLED創作者 午夜藍 ( K6502ZC )',NULL,35900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-12500H 12核心/16緒 1.3GHz 超頻 4.5GHz / 18M Cache\r\n顯示卡：NVIDIA® GeForce® RTX™ 3050 Laptop GPU 4G DDR6\r\n記憶體：16GB DDR4 on board / 共1個插槽，已經使用1個\r\nSSD硬碟：512GB M.2 NVMe™ PCIe® 3.0 Performance SSD / 共2個插槽，已經使用1個\r\n傳統硬碟：無，不可擴充\r\n螢幕：15.6吋 2.8k (2880 x 1620) OLED 16:9 aspect ratio 120Hz refresh rate\r\n光碟機：NO\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n網路規格：Wi-Fi 6E(802.11ax)\"\r\n無線規格：Bluetooth 5\r\n攝影機：1080p FHD 攝影機 含視訊鏡頭遮罩\r\nFingerPrint\r\nI/O：\r\n1x USB 3.2 Gen 2 Type-C support power delivery\r\n2x USB 3.2 Gen 1 Type-A\r\n1x Thunderbolt™ 4 supports display / power delivery\r\n1x HDMI 2.1 TMDS\r\n1x 3.5mm Combo Audio Jack\r\n1x RJ45 Gigabit Ethernet\r\n1x DC-in\r\nSD 4.0 card reader\r\n尺寸：35.63 x 23.53 x 1.99 ~ 2.00 cm\r\n重量：1.8kg\r\n電池：70WHrs，3S1P，3 芯鋰離子電池\r\n變壓器：ø4.5，150W AC 變壓器，輸出：20V DC，7.5A，150W，輸入：100~240V AC，50/60Hz 通用\r\n保固：二年國際保固/首年完美保固/LCD無亮點保固/電池保固一年。 服務專線：0800-093-456\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i5-12500H 12核心/16緒 1.3GHz 超頻 4.5GHz / 18M Cache','NVIDIA® GeForce® RTX™ 3050 Laptop GPU 4G DDR6','16GB DDR4 on board / 共1個插槽，已經使用1個','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6吋 2.8k (2880 x 1620) OLED 16:9 aspect ratio 120Hz refresh rate','70WHrs，3S1P，3 芯鋰離子電池','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.63 x 23.53 x 1.99 ~ 2.00 cm','1.8kg'),(11,1,'華碩13代創異創作者 午夜藍 ( K6502VU )',NULL,48900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel® Core™ i5-13500H 處理器 2.6 GHz (12核心/16緒 3.5GHz 超頻 4.7GHz / 18M Cache)\r\n顯示卡：NVIDIA® GeForce RTX™ 4050 Laptop GPU 6GB GDDR6\r\n顯示卡功耗：1605 - 2370 MHz\r\n記憶體：16GB(8G*2) DDR5-4800 / 共2個插槽，已使用2個，最高支援16G\r\nSSD硬碟：512GB M.2 NVMe™ PCIe® 4.0 SSD / 共2個插槽，已使用1個\r\n傳統硬碟：No\r\n螢幕尺寸：15.6\" 2.8K (2880 x 1620) OLED 16:9 aspect ratio\r\n作業系統：Windows11 PRO 64bit\r\n光碟機：No\r\n網路規格：Wi-Fi 6E(802.11ax) (雙頻) 1*1\r\n藍芽規格：Bluetooth® 5.0\r\n視訊鏡頭：1080p FHD 攝影機 含視訊鏡頭遮罩\r\n鍵盤規格：背光巧克力鍵盤, 1.4mm 鍵程, 觸控板\r\n指紋辨識：No\r\nNFC : No\r\n喇叭/音效技術：SonicMaster, 內建喇叭, 內建陣列麥克風, 支援 Cortana\r\nI/O規格：\r\n1x USB 3.2 Gen 2 Type-C 支援顯示/供電\r\n2x USB 3.2 Gen 1 Type-A\r\n1x Thunderbolt™ 4 支援顯示/供電\r\n1x HDMI 2.1 FRL\r\n1x 3.5mm 複合式音源線插孔\r\n1x RJ45 GB 乙太網路\r\n1 x DC 輸入\r\nSD 4.0 讀卡機\r\n尺寸：35.63 x 23.53 x 1.99 ~ 2.00 cm\r\n重量：1.80 kg (3.97 lbs)\r\n變壓器：ø4.5，150W AC 變壓器，輸出：20V DC，7.5A，150W，輸入：100~240V AC，50/60Hz 通用\r\n電池：70WHrs，3S1P，3 芯鋰離子電池\r\n保固：二年台灣地區保固/一年國際旅約保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel® Core™ i5-13500H 處理器 2.6 GHz (12核心/16緒 3.5GHz 超頻 4.7GHz / 18M Cache)','NVIDIA® GeForce RTX™ 4050 Laptop GPU 6GB GDDR6','16GB(8G*2) DDR5-4800 / 共2個插槽，已使用2個，最高支援16G','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6\" 2.8K (2880 x 1620) OLED 16:9 aspect ratio','70WHrs，3S1P，3 芯鋰離子電池','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.63 x 23.53 x 1.99 ~ 2.00 cm','1.80 kg (3.97 lbs)'),(11,2,'華碩OLED創作者 酷玩銀 ( K6502ZC )',NULL,44900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i7-12700H 14核心/20緒 2.3GHz 超頻 4.70GHz / 24M Cache\r\n顯示卡：NVIDIA® GeForce® RTX™ 3050 Laptop GPU 4G DDR6\r\n記憶體：16GB DDR4 on board / 共1個插槽，已經使用0個\r\nSSD硬碟：512GB M.2 NVMe™ PCIe® 3.0 Performance SSD / 共2個插槽，已經使用1個\r\n傳統硬碟：無，不可擴充\r\n螢幕：15.6吋/2.8K (2880 x 1800) OLED 16:9 aspect ratio/ 600nits HDR peak brightness /100% DCI-P3 color gamut/120Hz refresh rate\r\n光碟機：NO\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(Gig+)(802.11ax) + Bluetooth 5.0 (Dual band) 2*2\r\n攝影機：1080p FHD 攝影機 含視訊鏡頭遮罩\r\nFingerPrint\r\nI/O：\r\n1x USB 3.2 Gen 2 Type-C support power delivery\r\n2x USB 3.2 Gen 1 Type-A\r\n1x Thunderbolt™ 4 supports display / power delivery\r\n1x HDMI 2.1 TMDS\r\n1x 3.5mm Combo Audio Jack\r\n1x RJ45 Gigabit Ethernet\r\n1x DC-in\r\nSD 4.0 card reader\r\n尺寸：35.63 x 23.53 x 1.99 ~ 2.00 cm\r\n重量：1.8kg\r\n電池：70WHrs，3S1P，3 芯鋰離子電池\r\n變壓器：ø4.5，150W AC 變壓器，輸出：20V DC，7.5A，150W，輸入：100~240V AC，50/60Hz 通用\r\n保固：二年國際保固/首年完美保固/LCD無亮點保固/電池保固一年。 服務專線：0800-093-456\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i7-12700H 14核心/20緒 2.3GHz 超頻 4.70GHz / 24M Cache','NVIDIA® GeForce® RTX™ 3050 Laptop GPU 4G DDR6','16GB DDR4 on board / 共1個插槽，已經使用0個','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6吋/2.8K (2880 x 1800) OLED 16:9 aspect ratio/ 600nits HDR peak brightness /100% DCI-P3 color gamut/120Hz refresh rate','70WHrs，3S1P，3 芯鋰離子電池','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.63 x 23.53 x 1.99 ~ 2.00 cm','1.8kg'),(11,3,'華碩OLED創作者 酷玩銀 ( K6502ZE )',NULL,42900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel® Core™ i5-12500H Processor 2.5 GHz (18M Cache, up to 4.5 GHz, 4P+8E cores)\r\n顯示卡：NVIDIA® GeForce® RTX™ 3050Ti Laptop GPU 4G DDR6\r\n記憶體：16GB DDR4 on board / 共1個插槽，已經使用0個\r\nSSD硬碟：512GB M.2 NVMe™ PCIe® 3.0 Performance SSD / 共2個插槽，已經使用1個\r\n傳統硬碟：無，不可擴充\r\n螢幕：15.6吋/2.8K (2880 x 1800) OLED 16:9 aspect ratio/ 600nits HDR peak brightness /100% DCI-P3 color gamut/120Hz refresh rate\r\n光碟機：NO\r\n作業系統：Windows11 64Bits 英/泰/簡中/印尼/越南/繁中\r\n無線規格：Wi-Fi 6(Gig+)(802.11ax) + Bluetooth 5.0 (Dual band) 2*2\r\n攝影機：1080p FHD 攝影機 含視訊鏡頭遮罩\r\nFingerPrint\r\nI/O：\r\n1x USB 3.2 Gen 2 Type-C 支援 power delivery\r\n2x USB 3.2 Gen 1 Type-A\r\n1x Thunderbolt™ 4 支援顯示/供電\r\n1x HDMI 2.1 TMDS\r\n1x 3.5mm 複合式音源線插孔\r\n1x RJ45 GB 乙太網路\r\n1 x DC 輸入\r\nSD 4.0 讀卡機\r\n鍵盤：背光巧克力鍵盤, 1.4mm 鍵程, 觸控板\r\n觸碰版：\r\n尺寸：35.63 x 23.53 x 1.99 ~ 2.00 cm\r\n重量：1.8kg\r\n電池：70WHrs，3S1P，3 芯鋰離子電池\r\n變壓器：ø4.5，150W AC 變壓器，輸出：20V DC，7.5A，150W，輸入：100~240V AC，50/60Hz 通用\r\n保固：二年國際保固/首年完美保固/LCD無亮點保固/電池保固一年。 服務專線：0800-093-456\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel® Core™ i5-12500H Processor 2.5 GHz (18M Cache, up to 4.5 GHz, 4P+8E cores)','NVIDIA® GeForce® RTX™ 3050Ti Laptop GPU 4G DDR6','16GB DDR4 on board / 共1個插槽，已經使用0個','Windows11 64Bits 英/泰/簡中/印尼/越南/繁中','15.6吋/2.8K (2880 x 1800) OLED 16:9 aspect ratio/ 600nits HDR peak brightness /100% DCI-P3 color gamut/120Hz refresh rate','70WHrs，3S1P，3 芯鋰離子電池','二年國際保固 / 首年完美保固 / LCD無亮點保固/電池保固一年','35.63 x 23.53 x 1.99 ~ 2.00 cm','1.8kg'),(12,0,'宏碁13代強效 金屬灰 ( A517-58M-53V9 )',NULL,33900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel® Core™ i5-1335U 10核心/12緒 1.3GHz 超頻 4.6GHz / 12M Cache\r\n顯示卡：Intel® Iris® Xe Graphics\r\n記憶體：16GB LPDDR5(Onboard)\r\nSSD硬碟：512GB PCIe Gen4 SSD / 共1個插槽，已使用1個\r\n傳統硬碟：No\r\n螢幕尺寸：17.3\" IPS/霧面/LED背光/FHD (1920x1080), 色域 NTSC 45% , 亮度 250 nits\r\n作業系統：Windows 11 Home\r\n光碟機：無,請另購外接式光碟機\r\n網路規格：Wi-Fi 6E 802.11 a/b/g/n/ac/ax 2.4 GHz/5 GHz/6 GHz三頻段 2x2 MU-MIMO\r\n藍芽規格：Bluetooth® 5.1\r\n視訊鏡頭：FHD (1920 x 1080)with Temporal Noise Reduction(TNR)\r\n鍵盤規格：無背光\r\nI/O規格：\r\n1x Type-C (USB4® 40Gbps, DisplayPort, Thunderbolt 4, DC-in 20 V; 65 W)\r\n2x Type-A USB 3.2 Gen 1\r\n1x HDMI 2.1\r\n1x 3.5mm 複合式音源線插孔\r\n尺寸：402.1 (W) x 256.5 (D) x 17.99 (H) mm\r\n重量：2.09 kg\r\n變壓器：65W\r\n電池：50Wh Li-ion battery\r\n保固：二年台灣地區保固/一年國際旅約保固/電池保固一年\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel® Core™ i5-1335U 10核心/12緒 1.3GHz 超頻 4.6GHz / 12M Cache','Intel® Iris® Xe Graphics','16GB LPDDR5(Onboard)','Windows 11 Home','17.3\" IPS/霧面/LED背光/FHD (1920x1080), 色域 NTSC 45% , 亮度 250 nits','50Wh Li-ion battery','二年台灣地區保固/一年國際旅約保固/電池保固一年','402.1 (W) x 256.5 (D) x 17.99 (H) mm','2.09 kg'),(12,1,'宏碁13代強效 金屬灰 ( A515-58P-30EZ )',NULL,29900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel® Core™ i3-1305U 5核心/6緒 1.6GHz 超頻 4.5GHz / 10M Cache\r\n顯示卡：Intel® UHD Graphics\r\n記憶體：8GB LPDDR5(Onboard)\r\nSSD硬碟：512GB PCIe Gen4 SSD / 共1個插槽，已使用1個\r\n傳統硬碟：無\r\n螢幕：15.6吋 1920 x 1080 FHD/霧面/LED背光/NTSC 45%/220 nits\r\n光碟機： NO\r\n作業系統：Windows 11\r\n無線規格：Wi-Fi 6 802.11a/b/g/n/ac+ax Dual Band (2.4 GHz and 5 GHz)2x2 MU-MIMO\r\n藍芽規格：Bluetooth 5.1\r\n鍵盤背光：無\r\n視訊鏡頭：HD (1280 x 720) with Temporal Noise Reduction(TNR)\r\nIO規格：\r\n1 X HDMI 2.1\r\n2 X USB Type-A USB 3.2 Gen 1\r\n1 X COMBO audio jack\r\n尺寸：362.9 (W) x 237.5 (D) x /17.99 (H) mm\r\n重量：1.78 Kg\r\n變壓器：65W\r\n電池：50Wh Li-ion battery\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主\r\n備註：不含包包及滑鼠','Intel® Core™ i3-1305U 5核心/6緒 1.6GHz 超頻 4.5GHz / 10M Cache','Intel® UHD Graphics','8GB LPDDR5(Onboard)','Windows 11','15.6吋 1920 x 1080 FHD/霧面/LED背光/NTSC 45%/220 nits','50Wh Li-ion battery','二年台灣地區保固/一年國際旅約保固/電池保固一年','362.9 (W) x 237.5 (D) x /17.99 (H) mm','1.78 Kg'),(12,2,'宏碁13代強效 金屬灰 ( A515-58P-599T )',NULL,29900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel® Core™ i5-1335U 10核心/12緒 1.3GHz 超頻 4.6GHz / 12M Cache\r\n顯示卡：Intel® Iris® Xe Graphics\r\n記憶體：8GB LPDDR5(Onboard)\r\nSSD硬碟：512GB PCIe Gen4 SSD / 共1個插槽，已使用1個\r\n傳統硬碟：無\r\n螢幕：15.6吋 1920 x 1080 FHD/霧面/LED背光/NTSC 45%/220 nits\r\n光碟機： NO\r\n作業系統：Windows 11\r\n無線規格：Wi-Fi 6 802.11a/b/g/n/ac+ax Dual Band (2.4 GHz and 5 GHz)2x2 MU-MIMO\r\n藍芽規格：Bluetooth 5.1\r\n鍵盤背光：無\r\n視訊鏡頭：HD (1280 x 720) with Temporal Noise Reduction(TNR)\r\nIO規格：\r\n1 X HDMI 2.1\r\n2 X USB Type-A USB 3.2 Gen 1\r\n1 X COMBO audio jack\r\n尺寸：362.9 (W) x 237.5 (D) x /17.99 (H) mm\r\n重量：1.78 Kg\r\n變壓器：65W\r\n電池：50Wh Li-ion battery\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主\r\n備註：不含包包及滑鼠','Intel® Core™ i5-1335U 10核心/12緒 1.3GHz 超頻 4.6GHz / 12M Cache','Intel® Iris® Xe Graphics','8GB LPDDR5(Onboard)','Windows 11','15.6吋 1920 x 1080 FHD/霧面/LED背光/NTSC 45%/220 nits','50Wh Li-ion battery','二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修','362.9 (W) x 237.5 (D) x /17.99 (H) mm','1.78 Kg'),(12,3,'宏碁13代強效 金屬灰 ( A514-56M-55H0 )',NULL,28900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','商品規格\r\n處理器：Intel® Core™ i5-1335U 10核心/12緒 1.3GHz 超頻 4.6GHz / 12M Cache\r\n顯示卡：IIntel® Iris® Xe Graphics\r\n記憶體：16GB LPDDR5 Onboard\r\nSSD硬碟：512GB PCIe NVMe SSD / 共1個插槽，已使用1個\r\n傳統硬碟：無\r\n螢幕：14吋 16:10 1920 x 1200 FHD+/IPS/霧面/LED背光/NTSC 45%/250 nits\r\n光碟機： NO\r\n作業系統：Windows 11\r\n無線規格：Wi-Fi 6E 802.11 a/b/g/n/ac/ax 2.4 GHz/5 GHz/6 GHz三頻段 2x2 MU-MIMO、Bluetooth 5.1\r\n視訊鏡頭：FHD (1920 x 1080) with Temporal Noise Reduction(TNR)\r\nIO規格：\r\n1 X HDMI 2.1\r\n1 X Type-C (USB4® 40Gbps)(DisplayPort)(Thunderbolt 4)(DC-in 19 V; 65 W)支援影像傳輸\r\n2 X USB 3.2 Gen 1\r\n1 X COMBO audio jack\r\n尺寸：318.2 (W) x 225.5 (D) x 17.8 (H) mm\r\n重量：1.48 Kg\r\n變壓器：65W\r\n電池：50Wh Li-ion battery\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主\r\n備註：不含包包及滑鼠','Intel® Core™ i5-1335U 10核心/12緒 1.3GHz 超頻 4.6GHz / 12M Cache','IIntel® Iris® Xe Graphics','16GB LPDDR5 Onboard','Windows 11','14吋 16:10 1920 x 1200 FHD+/IPS/霧面/LED背光/NTSC 45%/250 nits','50Wh Li-ion battery','二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修','318.2 (W) x 225.5 (D) x 17.8 (H) mm','1.48 Kg'),(12,4,'宏碁13代強效 金屬灰 ( A515-58M-50Z1  )',NULL,33900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','商品規格\r\n處理器：Intel® Core™ i5-1335U 10核心/12緒 1.3GHz 超頻 4.6GHz / 12M Cache\r\n顯示卡：IIntel® Iris® Xe Graphics\r\n記憶體：16GB LPDDR5 Onboard\r\nSSD硬碟：512GB PCIe NVMe SSD / 共1個插槽，已使用1個\r\n傳統硬碟：無\r\n螢幕：15.6吋 1920 x 1080 FHD/IPS/霧面/LED背光/NTSC 45%/250 nits\r\n光碟機： NO\r\n作業系統：Windows 11\r\n無線規格：WiFi-6 802.11a/b/g/n/ac/ax 2x2 MU-MIMO、Bluetooth 5.1\r\n視訊鏡頭：FHD (1920 x 1080) with Temporal Noise Reduction(TNR)\r\nIO規格：\r\n1 X HDMI 2.1\r\n1 X TypeC(USB 3.2 Gen 2)(DisplayPort)(Thunderbolt 4)(DC-in 19 V; 65 W)支援影像傳輸\r\n2 X USB 3.2 Gen 1\r\n1 X COMBO audio jack\r\n尺寸：362.9 (W) x 237.8 (D) x /17.9 (H) mm\r\n重量：1.77 Kg\r\n變壓器：65W\r\n電池：50Wh Li-ion battery\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主\r\n備註：不含包包及滑鼠','Intel® Core™ i5-1335U 10核心/12緒 1.3GHz 超頻 4.6GHz / 12M Cache','Intel® Iris® Xe Graphics','16GB LPDDR5(Onboard)','Windows 11 Home','15.6吋 1920 x 1080 FHD/IPS/霧面/LED背光/NTSC 45%/250 nits','50Wh Li-ion battery','二年台灣地區保固/一年國際旅約保固/電池保固一年','362.9 (W) x 237.8 (D) x /17.9 (H) mm','1.77 Kg'),(12,5,'宏碁高效能 磨砂金 ( A515-57-56MZ  )',NULL,29900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-1235U 10核心/12緒 1.3GHz 超頻 4.4GHz / 12M Cache\r\n顯示卡：Intel Iris Xe\r\n記憶體：8GB DDR4 3200 / 總共2個插槽，已經使用1個，最大支援32G\r\nSSD硬碟：512GB PCIe NVMe SSD / 總共2個插槽，已經使用1個\r\n傳統硬碟：無\r\n螢幕：15.6吋 1920x1080 FHD/霧面/LED背光\r\n光碟機：NO\r\n作業系統：Windows 11 Home\r\n無線規格：802.11a/b/g/n/ac 2x2 MU-MIMO\r\n藍芽規格：Bluetooth® 5.2\r\n鍵盤規格：巧克力鍵盤\r\n網路攝影機：VGA WebCam\r\nI/O 介面：\r\n1 x Type-C USB 3.2 Gen 2 (DisplayPort)(Thunderbolt 4)(DC-in 20 V; 65 W)\r\n3 x TypeA USB3.0\r\n1 x HDMI\r\n1 x AC 電源孔\r\n1 x RJ45 Gigabit Ethernet\r\n1 x Microphone-in/Headphone-out jack\r\n尺寸：362.9 (W) x 237.8 (D) x 17.9 (H) mm\r\n重量： 1.8kg 含電池重量\r\n電池：50Wh Li-ion battery\r\n變壓器：65W AC Adapter\r\n保固：二年台灣地區完全保固/一年國際旅約保固/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i5-1235U 10核心/12緒 1.3GHz 超頻 4.4GHz / 12M Cache','Intel® Iris® Xe Graphics','8GB DDR4 3200 / 總共2個插槽，已經使用1個，最大支援32G','Windows 11 Home','15.6吋 1920x1080 FHD/霧面/LED背光','65W AC Adapter','二年台灣地區完全保固/一年國際旅約保固/第一年58分鐘快速完修','362.9 (W) x 237.8 (D) x 17.9 (H) mm','1.8kg 含電池重量'),(12,6,'宏碁高效能 金屬灰 ( A515-57-52NZ  )',NULL,29900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-1235U 10核心/12緒 1.3GHz 超頻 4.4GHz / 12M Cache\r\n顯示卡：Intel Iris Xe\r\n記憶體：8GB DDR4-3200 / 共2個插槽，已使用1個，最大支援32G\r\nSSD硬碟：512GB PCIe NVMe SSD / 共2個插槽，已使用1個\r\n傳統硬碟：無\r\n螢幕：15.6吋 1920 x 1080 FHD/IPS/霧面/LED背光/NTSC 45%\r\n光碟機： NO\r\n作業系統：Windows 11\r\n無線規格：WiFi-6 802.11a/b/g/n/ac/ax 2x2 MU-MIMO、Bluetooth 5.2\r\n視訊鏡頭：HD (1280 x 720)\r\nIO規格：\r\n1 X HDMI 2.0\r\n1 X RJ45 Gigabit Ethernet\r\n1 X TypeC(USB 3.2 Gen 2)(DisplayPort)(Thunderbolt 4)(DC-in 20 V; 65 W)支援影像傳輸\r\n3 X USB3.0 TypeA\r\n1 X COMBO audio jack\r\n尺寸：362.9 (W) x 237.8 (D) x /17.9 (H) mm\r\n重量：1.76 Kg\r\n變壓器：65W\r\n電池：50Wh\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主\r\n備註：不含包包及滑鼠','Intel Core i5-1235U 10核心/12緒 1.3GHz 超頻 4.4GHz / 12M Cache','Intel Iris Xe','8GB DDR4-3200 / 共2個插槽，已使用1個，最大支援32G','Windows 11 Home','15.6吋 1920 x 1080 FHD/IPS/霧面/LED背光/NTSC 45%','50W','二年台灣地區完全保固/一年國際旅約保固/第一年58分鐘快速完修','362.9 (W) x 237.8 (D) x /17.9 (H) mm','1.76 Kg'),(13,0,'宏碁13代掠奪者冷競特攻電競 ( PHN16-71-57LQ  )',NULL,46900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-13500HX 14 核心/20緒 2.5GHz 超頻 4.7GHz/24 MB L3 快取)\r\n顯示卡：NVIDIA GeForce RTX 4050 6GB GDDR6 (MGP 140W 滿血版, 支援獨顯直連、動態顯示切換、G-sync)\r\n記憶體：16GB DDR5-4800 / 共2個插槽，已使用1個，最高支援32G\r\nSSD硬碟：512GB PCIe NVMe SED SSD/ 共2個插槽，已使用1個\r\n傳統硬碟：無\r\n螢幕尺寸：16 吋 WUXGA 16:10 IPS 螢幕 (1920 x 1200, 165Hz, 霧面, LED 背光, sRGB 100%, 亮度 400 nits)\r\n作業系統：Windows 11 Home\r\n光碟機：無\r\n網路規格：Killer Wi-Fi 6 AX 1650i (2.4 GHz / 5 GHz 雙頻段, 802.11 a/b/g/n+acR2+ax, 2x2 MU-MIMO)\r\n藍芽規格：Bluetooth 5.1\r\n視訊鏡頭：HD (1280 x 720) with Temporal Noise Reduction (TNR)\r\n鍵盤規格：4 區 RGB 背光鍵盤\r\n指紋辨識：無\r\nNFC：無\r\n喇叭/音效技術：Acer TrueHarmony, DTS Audio, Acer Purified.Voice, 內建喇叭與麥克風\r\nI/O規格：\r\n2x Type-C (USB 3.2 Gen 2 / DP / Thunderbolt™ 4)\r\n3x Type-A 3(USB 3.2 Gen 2*2+USB 3.2 Gen 1*1 )\r\n1x HDMI 2.1\r\n1x RJ-45 Killer™ Ethernet E2600\r\n可外接螢幕數量：3\r\n尺寸：360.1 (寬) x 279.9 (深) x 26.55/28.25 (高) mm\r\n重量：2.6 公斤\r\n變壓器：230W\r\n電池：90Wh 鋰離子電池\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修','NVIDIA GeForce RTX 4050 6GB GDDR6 (MGP 140W 滿血版, 支援獨顯直連、動態顯示切換、G-sync)','Intel Iris Xe','16GB DDR5-4800 / 共2個插槽，已使用1個，最高支援32G','Windows 11 Home','16 吋 WUXGA 16:10 IPS 螢幕 (1920 x 1200, 165Hz, 霧面, LED 背光, sRGB 100%, 亮度 400 nits)','90Wh 鋰離子電池','二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修','360.1 (寬) x 279.9 (深) x 26.55/28.25 (高) mm','2.6 公斤'),(13,1,'宏碁13代掠奪者冷競特攻電競 ( PHN16-71-91QX  )',NULL,65900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel® Core™ i9-13900HX 核心處理器 5.4 GHz (36MB Cache, up to 5.4 GHz, 8 P-cores and 16 E- cores)\r\n顯示卡：NVIDIA® GeForce RTX™ 4060 8G-GDDR6\r\nMGP 140W滿血版 (支援獨顯直連、動態顯示切換、G-sync)\r\n記憶體：16GB DDR5 4800MHz/ 共2個插槽，已經使用1個，最高支援32G\r\nSSD硬碟：1TB PCIe NVMe SED SSD/ 共2個插槽，已經使用1個\r\n傳統硬碟： 無\r\n螢幕：16\" 16:10/IPS/165Hz/霧面/LED背光 WQXGA 2560 x 1600 sRGB100% 500 nits\r\n光碟機： 無\r\n作業系統：Windows 11 家用版\r\n無線規格：Killer™ Wi-Fi 6 AX 1650i 2.4 GHz/5 GHz 雙頻段 802.11 a/b/g/n+acR2+ax 2x2 MU-MIMO\r\n藍芽規格：Bluetooth® 5.1\r\n攝影機：HD (1280 x 720) with Temporal Noise Reduction(TNR)\r\nI/O 介面：\r\n2x USB Type-C(USB 3.2 Gen 2)(DisplayPort)(Thunderbolt 4)(DC-in 20 V; 65 W)\r\n3x USB Type-A(USB 3.2 Gen 2*2+USB 3.2 Gen 1*1 )\r\n1x HDMI 2.1\r\n1x microSD Card reader\r\n1x Microphone-in/Headphone-out jack\r\n尺寸：360.1 (W) x 279.9 (D) x 26.55/28.25 (H) mm\r\n重量：2.6 kg\r\n變壓器：330 W\r\n電池：90Wh Li-ion battery\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel® Core™ i9-13900HX 核心處理器 5.4 GHz (36MB Cache, up to 5.4 GHz, 8 P-cores and 16 E- cores)','NVIDIA® GeForce RTX™ 4060 8G-GDDR6','16GB DDR5 4800MHz/ 共2個插槽，已經使用1個，最高支援32G','Windows 11 家用版','16\" 16:10/IPS/165Hz/霧面/LED背光 WQXGA 2560 x 1600 sRGB100% 500 nits','90Wh Li-ion battery','二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修','360.1 (W) x 279.9 (D) x 26.55/28.25 (H) mm','2.6 公斤'),(13,2,'宏碁13代掠奪者冷競特攻電競 ( PHN16-71-79C7 )',NULL,62900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i7-13700H, 14核心/20緒 2.1GHz 超頻5.0GHz / 24M Cache\r\n顯示卡：NVIDIA® GeForce RTX™ 4060 8G-GDDR6 MGP 140W滿血版 (支援獨顯直連、動態顯示切換、G-sync)\r\n記憶體：16GB DDR5 4800MHz/ 共2個插槽，已經使用1個，最高支援32G\r\nSSD硬碟：512GB PCIe NVMe SED SSD/ 共2個插槽，已經使用1個\r\n傳統硬碟： 無\r\n螢幕：16\" WQXGA 2560 x 1600/16:10/IPS/165Hz/霧面/LED背光/sRGB100%/500 nits\r\n光碟機： 無\r\n作業系統：Windows 11 家用版\r\n無線規格：Killer™ Wi-Fi 6 AX 1650i 2.4 GHz/5 GHz 雙頻段 802.11 a/b/g/n+acR2+ax 2x2 MU-MIMO\r\n藍芽規格：Bluetooth® 5.1\r\n攝影機：HD (1280 x 720) with Temporal Noise Reduction(TNR)\r\nI/O 介面：\r\n2x USB Type-C(USB 3.2 Gen 2)(DisplayPort)(Thunderbolt 4)(DC-in 20 V; 65 W)\r\n3x USB Type-A(USB 3.2 Gen 2*2+USB 3.2 Gen 1*1 )\r\n1x HDMI 2.1\r\n1x microSD Card reader\r\n1x Microphone-in/Headphone-out jack\r\n尺寸：360.1 (W) x 279.9 (D) x 26.55/28.25 (H) mm\r\n重量：2.6 kg\r\n變壓器：330 W\r\n電池：90Wh Li-ion battery\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i7-13700H, 14核心/20緒 2.1GHz 超頻5.0GHz / 24M Cache','NVIDIA® GeForce RTX™ 4060 8G-GDDR6 MGP 140W滿血版 (支援獨顯直連、動態顯示切換、G-sync)','16GB DDR5 4800MHz/ 共2個插槽，已經使用1個，最高支援32G','Windows 11 家用版','16\" WQXGA 2560 x 1600/16:10/IPS/165Hz/霧面/LED背光/sRGB100%/500 nits','90Wh Li-ion battery','二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修','360.1 (W) x 279.9 (D) x 26.55/28.25 (H) mm','2.6 公斤'),(13,3,'宏碁13代掠奪者冷競特攻電競 ( PHN16-71-7121 )',NULL,59900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i7-13700H, 14核心/20緒 2.1GHz 超頻5.0GHz / 24M Cache\r\n顯示卡：NVIDIA® GeForce RTX™ 4050 6G-GDDR6 MGP 140W滿血版 (支援獨顯直連、動態顯示切換、G-sync)\r\n記憶體：16GB DDR5 4800MHz/ 共2個插槽，已經使用1個，最高支援32G\r\nSSD硬碟：512GB PCIe NVMe SED SSD/ 共2個插槽，已經使用1個\r\n傳統硬碟： 無\r\n螢幕：16\" WUXGA 1920 x 1200/16:10/IPS/165Hz/霧面/LED背光/sRGB100%/400 nits\r\n光碟機： 無\r\n作業系統：Windows 11 家用版\r\n無線規格：Killer™ Wi-Fi 6 AX 1650i 2.4 GHz/5 GHz 雙頻段 802.11 a/b/g/n+acR2+ax 2x2 MU-MIMO\r\n藍芽規格：Bluetooth® 5.1\r\n攝影機：HD (1280 x 720) with Temporal Noise Reduction(TNR)\r\nI/O 介面：\r\n2x (USB 3.2 Gen 2)(DisplayPort)(Thunderbolt 4)(DC-in 20 V; 65 W)\r\n2x USB 3.2 Gen 2\r\n1x USB 3.2 Gen 1\r\n1x HDMI 2.1\r\n1x microSD Card reader\r\n1x Microphone-in/Headphone-out jack\r\n尺寸：360.1 (W) x 279.9 (D) x 26.55/28.25 (H) mm\r\n重量：2.6 kg\r\n變壓器：230 W\r\n電池：90Wh Li-ion battery\r\n保固：二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i7-13700H, 14核心/20緒 2.1GHz 超頻5.0GHz / 24M Cache','NVIDIA® GeForce RTX™ 4050 6G-GDDR6 MGP 140W滿血版 (支援獨顯直連、動態顯示切換、G-sync)','16GB DDR5 4800MHz/ 共2個插槽，已經使用1個，最高支援32G','Windows 11 家用版','16\" WQXGA 2560 x 1600/16:10/IPS/165Hz/霧面/LED背光/sRGB100%/500 nits','90Wh Li-ion battery','二年台灣地區完全保固/一年國際旅約保固/電池保固一年/第一年58分鐘快速完修','360.1 (W) x 279.9 (D) x 26.55/28.25 (H) mm','2.6 kg'),(14,0,'星河紫隨附初心綠上蓋 90XB07A0-BMU010',NULL,1090,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','','','','','','','','','',''),(14,1,'靜謐藍隨附天空藍上蓋 90XB07A0-BMU000',NULL,1090,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','','','','','','','','','',''),(14,2,'燕麥奶隨附抹茶綠上蓋 90XB07A0-BMU0A0',NULL,1090,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','','','','','','','','','',''),(15,0,'燕麥棕 90XB0880-BKB0R0',NULL,1290,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','','','','','','','','','',''),(15,1,'抹茶綠 90XB0880-BKB0S0',NULL,1290,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','','','','','','','','','',''),(16,1,'青軸/PBT/USB TYPE-C/RGB/中文 90MP0348-BKTA11',NULL,1290,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','ROG Falchion Ace 65% 輕巧電競鍵盤具備ROG NX 機械軸，ROG 鍵軸穩定器、吸音泡綿、互動式觸控板、雙 Type-C 連接埠、三種鍵盤傾斜角度，以及保護蓋\r\n\r\n緊湊設計：精巧的 68 鍵配置方式巧妙地整合箭頭與方向鍵\r\nROG NX 機械軸： 具備 7000 萬次點擊壽命、高速觸發力以及特殊調校的觸發行程，提供絕佳的觸鍵手感與回饋\r\n絕佳打字體驗：獨特設計的ROG鍵軸穩定器，確保流暢鍵擊及長鍵的穩定性，鍵盤還配有ROG PBT 二色成型鍵帽及內搭載吸音泡棉\r\n互動式觸控板：直觀設計，讓您輕鬆調整個人設定並自訂控制功能\r\n雙 USB-C®：雙接口設計實現更整潔的桌面配置，也讓您能夠在兩台PC之間快速切換\r\n人體工學設計：鍵盤三種傾斜角度，提供絕佳舒適度及支配力 \r\n便攜且具保護力：革命性創新鍵盤保護套，移動時為鍵盤提供保護力\r\n台灣僅提供白色款','','','','','','','','',''),(16,2,'茶軸/PBT/USB TYPE-C/RGB/中文 90MP0348-BKTA11',NULL,1290,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','ROG Falchion Ace 65% 輕巧電競鍵盤具備ROG NX 機械軸，ROG 鍵軸穩定器、吸音泡綿、互動式觸控板、雙 Type-C 連接埠、三種鍵盤傾斜角度，以及保護蓋\r\n\r\n緊湊設計：精巧的 68 鍵配置方式巧妙地整合箭頭與方向鍵\r\nROG NX 機械軸： 具備 7000 萬次點擊壽命、高速觸發力以及特殊調校的觸發行程，提供絕佳的觸鍵手感與回饋\r\n絕佳打字體驗：獨特設計的ROG鍵軸穩定器，確保流暢鍵擊及長鍵的穩定性，鍵盤還配有ROG PBT 二色成型鍵帽及內搭載吸音泡棉\r\n互動式觸控板：直觀設計，讓您輕鬆調整個人設定並自訂控制功能\r\n雙 USB-C®：雙接口設計實現更整潔的桌面配置，也讓您能夠在兩台PC之間快速切換\r\n人體工學設計：鍵盤三種傾斜角度，提供絕佳舒適度及支配力 \r\n便攜且具保護力：革命性創新鍵盤保護套，移動時為鍵盤提供保護力\r\n台灣僅提供白色款','','','','','','','','',''),(16,3,'紅軸/PBT/USB TYPE-C/RGB/中文 90MP0348-BKTA11',NULL,1290,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','ROG Falchion Ace 65% 輕巧電競鍵盤具備ROG NX 機械軸，ROG 鍵軸穩定器、吸音泡綿、互動式觸控板、雙 Type-C 連接埠、三種鍵盤傾斜角度，以及保護蓋\r\n\r\n緊湊設計：精巧的 68 鍵配置方式巧妙地整合箭頭與方向鍵\r\nROG NX 機械軸： 具備 7000 萬次點擊壽命、高速觸發力以及特殊調校的觸發行程，提供絕佳的觸鍵手感與回饋\r\n絕佳打字體驗：獨特設計的ROG鍵軸穩定器，確保流暢鍵擊及長鍵的穩定性，鍵盤還配有ROG PBT 二色成型鍵帽及內搭載吸音泡棉\r\n互動式觸控板：直觀設計，讓您輕鬆調整個人設定並自訂控制功能\r\n雙 USB-C®：雙接口設計實現更整潔的桌面配置，也讓您能夠在兩台PC之間快速切換\r\n人體工學設計：鍵盤三種傾斜角度，提供絕佳舒適度及支配力 \r\n便攜且具保護力：革命性創新鍵盤保護套，移動時為鍵盤提供保護力\r\n台灣僅提供白色款','','','','','','','','',''),(17,0,'聯想征戰沙場電競 16G升級版 極致黑 ( 82SB00F6TW  )',NULL,40900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen 7 6800H 8核心/16緒 3.2GHz 超頻 4.7GHz / L2 4MB，L3 16MB\r\n顯示卡：NVIDIA GeForce® RTX3050 4GB\r\n顯示卡功耗：60W\r\n記憶體：16GB(8G*2)DDR5-4800 / 共2個插槽，已經使用2個，最高支援16G\r\nSSD硬碟：512GB_SSD_M.2_2242_G4_TLC / 共1個插槽，已經使用1個\r\n傳統硬碟：無\r\n螢幕尺寸：15.6吋, FHD 1920 x 1080 窄邊框防眩光 165Hz,100% sRGB\r\n作業系統：Windows 11\r\n光碟機： NO\r\n網路規格：Wi-Fi 6 11ax, 2x2\r\n藍芽規格：Bluetooth v5.2\r\n視訊鏡頭：720P_HD CAMERA_W/ARRAY_MIC\r\n鍵盤規格：BKLT_WH_KB_STO_GY_TC\r\n指紋辨識：No\r\nNFC：No\r\n喇叭/音效技術：Stereo speakers, 2W x2, Nahimic Audio\r\nI/O規格：\r\n2x USB 3.2 Gen 1\r\n1x USB-C 3.2 Gen 2 (support data transfer, Power Delivery 3.0, and DisplayPort 1.4)\r\n1x HDMI 2.0\r\n1x Ethernet (RJ-45)\r\n1x Headphone / microphone combo jack (3.5mm)\r\n1x Power connector\r\n尺寸：359.6 x 266.4 x 21.8 mm\r\n重量：2.315 kg\r\n變壓器：170W adapter\r\n電池：45Wh\r\n保固：二年售後保固\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen 7 6800H 8核心/16緒 3.2GHz 超頻 4.7GHz / L2 4MB，L3 16MB','NVIDIA GeForce® RTX3050 4GB','16GB(8G*2)DDR5-4800 / 共2個插槽，已經使用2個，最高支援16G','Windows 11 Home','15.6吋, FHD 1920 x 1080 窄邊框防眩光 165Hz,100% sRGB','45Wh','二年售後保固','359.6 x 266.4 x 21.8 mm','2.315 kg'),(17,1,'聯想征戰沙場電競 極致黑 ( 82SB00F6TW  )',NULL,40900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：AMD Ryzen 7 6800H 8核心/16緒 3.2GHz 超頻 4.7GHz / L2 4MB，L3 16MB\r\n顯示卡：NVIDIA GeForce® RTX3050 4GB\r\n顯示卡功耗：60W\r\n記憶體：8G DDR5-4800 / 共2個插槽，已經使用1個，最高支援16G\r\nSSD硬碟：512GB_SSD_M.2_2242_G4_TLC / 共1個插槽，已經使用1個\r\n傳統硬碟：無\r\n螢幕尺寸：15.6吋, FHD 1920 x 1080 窄邊框防眩光 165Hz,100% sRGB\r\n作業系統：Windows 11\r\n光碟機： NO\r\n網路規格：Wi-Fi 6 11ax, 2x2\r\n藍芽規格：Bluetooth v5.2\r\n視訊鏡頭：720P_HD CAMERA_W/ARRAY_MIC\r\n鍵盤規格：BKLT_WH_KB_STO_GY_TC\r\n指紋辨識：No\r\nNFC：No\r\n喇叭/音效技術：Stereo speakers, 2W x2, Nahimic Audio\r\nI/O規格：\r\n2x USB 3.2 Gen 1\r\n1x USB-C 3.2 Gen 2 (support data transfer, Power Delivery 3.0, and DisplayPort 1.4)\r\n1x HDMI 2.0\r\n1x Ethernet (RJ-45)\r\n1x Headphone / microphone combo jack (3.5mm)\r\n1x Power connector\r\n尺寸：359.6 x 266.4 x 21.8 mm\r\n重量：2.315 kg\r\n變壓器：170W adapter\r\n電池：45Wh\r\n保固：二年售後保固\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','AMD Ryzen 7 6800H 8核心/16緒 3.2GHz 超頻 4.7GHz / L2 4MB，L3 16MB','NVIDIA GeForce® RTX3050 4GB','8G DDR5-4800 / 共2個插槽，已經使用1個，最高支援16G','Windows 11 Home','15.6吋, FHD 1920 x 1080 窄邊框防眩光 165Hz,100% sRGB','45Wh','二年售後保固','359.6 x 266.4 x 21.8 mm','2.315 kg'),(17,2,'聯想征戰沙場電競 白 ( 82S900WWTW  )',NULL,44990,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-12450H, 8C (4P + 4E) / 12T, P-core 2.0 / 4.4GHz, E-core 1.5 / 3.3GHz, 12MB\r\n顯示卡：NVIDIA GeForce RTX 3060 6GB GDDR6, Boost Clock 1642MH, TGP 105W\r\n記憶體：8G DDR4-3200 / 共2個插槽，已經使用1個\r\nSSD硬碟：512GB SSD M.2 2242 PCIe 4.0x4 NVMe / 共1個插槽，已經使用1個\r\n傳統硬碟：無\r\n螢幕：15.6吋, 1920 x 1080 窄邊框防眩光 120Hz, 45% NTSC, 螢幕明亮度250nits\r\n光碟機： NO\r\n作業系統：Windows 11\r\n無線規格：Wi-Fi 6 11ax, 2x2 + BT5.1\r\n鍵盤規格：藍色背光鍵盤\r\n攝影機：HD 720P 網路攝影機\r\nI/O 介面：\r\n2x USB 3.2 Gen 1\r\n1x HDMI 2.0\r\n1x Ethernet (RJ-45)\r\n1x Headphone / microphone combo jack (3.5mm)\r\n1x Power connector\r\n尺寸 (WxDxH)：359.6 x 266.4 x 21.8 mm\r\n電池：60Wh\r\n重量：2.3 kg\r\n變壓器：230 W\r\n保固：二年售後保固\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i5-12450H, 8C (4P + 4E) / 12T, P-core 2.0 / 4.4GHz, E-core 1.5 / 3.3GHz, 12MB','NVIDIA GeForce RTX 3060 6GB GDDR6, Boost Clock ','8G DDR4-3200 / 共2個插槽，已經使用1個','Windows 11 Home','15.6吋, 1920 x 1080 窄邊框防眩光 120Hz, 45% NTSC, 螢幕明亮度250nits','60Wh','二年售後保固','359.6 x 266.4 x 21.8 mm','2.3 kg'),(17,3,'聯想征戰沙場電競 16G升級版 白 ( 82S900WWTW  )',NULL,44990,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-12450H, 8C (4P + 4E) / 12T, P-core 2.0 / 4.4GHz, E-core 1.5 / 3.3GHz, 12MB\r\n顯示卡：NVIDIA GeForce RTX 3060 6GB GDDR6, Boost Clock 1642MH, TGP 105W\r\n記憶體：16GB(8G*2) DDR4-3200 / 共2個插槽，已經使用2個\r\nSSD硬碟：512GB SSD M.2 2242 PCIe 4.0x4 NVMe / 共1個插槽，已經使用1個\r\n傳統硬碟：無\r\n螢幕：15.6吋, 1920 x 1080 窄邊框防眩光 120Hz, 45% NTSC, 螢幕明亮度250nits\r\n光碟機： NO\r\n作業系統：Windows 11\r\n無線規格：Wi-Fi 6 11ax, 2x2 + BT5.1\r\n鍵盤規格：藍色背光鍵盤\r\n攝影機：HD 720P 網路攝影機\r\nI/O 介面：\r\n2x USB 3.2 Gen 1\r\n1x HDMI 2.0\r\n1x Ethernet (RJ-45)\r\n1x Headphone / microphone combo jack (3.5mm)\r\n1x Power connector\r\n尺寸 (WxDxH)：359.6 x 266.4 x 21.8 mm\r\n電池：60Wh\r\n重量：2.3 kg\r\n變壓器：230 W\r\n保固：二年售後保固\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i5-12450H, 8C (4P + 4E) / 12T, P-core 2.0 / 4.4GHz, E-core 1.5 / 3.3GHz, 12MB','NVIDIA GeForce RTX 3060 6GB GDDR6, Boost Clock ','16GB(8G*2) DDR4-3200 / 共2個插槽，已經使用2個','Windows 11 Home','15.6吋, 1920 x 1080 窄邊框防眩光 120Hz, 45% NTSC, 螢幕明亮度250nits','60Wh','二年售後保固','359.6 x 266.4 x 21.8 mm','2.3 kg'),(17,4,'聯想征戰沙場電競 魔力黑 ( 82K10172TW )',NULL,29900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器： Intel Core i5-11320H (4C / 8T, 3.2 / 4.5GHz, 8MB)\r\n顯示卡：NVIDIA GeForce RTX 3050 4GB\r\n記憶體：8GB SO-DIMM DDR4-3200 / 共2個插槽，已經使用1個，最高支援16G\r\nSSD硬碟：512GB SSD M.2 2242 PCIe 3.0x4 NVMe / 共1個插槽，已經使用1個\r\n傳統硬碟：無\r\n螢幕尺寸： 15.6\" FHD (1920x1080) IPS 250nits Anti-glare, 120Hz, 45% NTSC, DC dimmer\r\n作業系統：Windows 11 Home 64\r\n光碟機： NO\r\n網路規格：Wi-Fi 6 11ax, 2x2\r\n藍芽規格：Bluetooth v5.0\r\n視訊鏡頭：720P_HD CAMERA_W/ARRAY_MIC\r\n鍵盤規格：鍵盤黑色繁體中文，4-Zone RGB背光鍵盤\r\n指紋辨識：No\r\nNFC：No\r\n喇叭/音效技術：Stereo speakers, 2W x2, Nahimic Audio\r\nI/O規格：\r\n1x USB-C 3.2 Gen 1 (support data transfer only)\r\n1x HDMI 2.\r\n1x power connecto\r\n1x headphone / microphone combo jack (3.5mm)\r\n1x Ethernet (RJ-45)\r\n2x USB 3.2 Gen\r\n尺寸： 359.6 x 251.9 x 24.2 mm\r\n重量： 2.25 kg\r\n變壓器：170W Slim Tip\r\n電池：Integrated 45Wh\r\n保固：二年售後保固\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i5-11320H (4C / 8T, 3.2 / 4.5GHz, 8MB)','NVIDIA GeForce RTX 3050 4GB','8GB SO-DIMM DDR4-3200 / 共2個插槽，已經使用1個，最高支援16G','Windows 11 Home 64','15.6\" FHD (1920x1080) IPS 250nits Anti-glare, 120Hz, 45% NTSC, DC dimmer','Integrated 45Wh','二年售後保固','359.6 x 251.9 x 24.2 mm','2.25 kg'),(17,5,'聯想征戰沙場電競 魔力黑 ( 82K10172TW )',NULL,29900,5000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-11320H 4核心/8緒 2.5GHz 超頻 4.50GHz / 8M Cache\r\n顯示卡：GeForce® RTX3050 4GB\r\n記憶體：16G DDR4-3200 / 共2個插槽，已經使用2個\r\nSSD硬碟：512GB_SSD_M.2_2242_NVME_TLC / 共1個插槽，已經使用1個\r\nSSD硬碟：可再加裝 M.2 2280 PCIe SSD / 共1個插槽，已經使用0個\r\n傳統硬碟：無，可加裝2.5吋硬碟\r\n螢幕：15.6吋, 1920 x 1080 窄邊框防眩光 120Hz, 45% NTSC, 螢幕明亮度250nits\r\n光碟機： NO\r\n作業系統：Windows 11\r\n無線規格：Wi-Fi 6 11ax, 2x2 + BT5.0\r\n鍵盤規格：4-Zone RGB Backlit\r\n攝影機：HD 720P 網路攝影機\r\nI/O 介面：\r\n2x USB 3.2 Gen 1\r\n1x USB-C 3.2 Gen 1 (support data transfer only)\r\n1x HDMI 2.0\r\n1x Ethernet (RJ-45)\r\n1x Headphone / microphone combo jack (3.5mm)\r\n1x Power connector\r\n尺寸 (WxDxH)：359.6 x 251.9 x 24.2 mm\r\n電池：45Wh\r\n重量：2.25 kg\r\n變壓器：170W\r\n保固：二年售後保固\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i5-11320H (4C / 8T, 3.2 / 4.5GHz, 8MB)','NVIDIA GeForce RTX 3050 4GB','16G DDR4-3200 / 共2個插槽，已經使用2個','Windows 11 Home 64','15.6\" FHD (1920x1080) IPS 250nits Anti-glare, 120Hz, 45% NTSC, DC dimmer','Integrated 45Wh','二年售後保固','359.6 x 251.9 x 24.2 mm','2.25 kg'),(18,5,'白金 ( 5BT-00053 )',NULL,49900,2000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：Intel Core i5-1135G7 4核心/8緒 2.4GHz 超頻 4.2GHz / 8M Cache\r\n顯示卡：Intel® Iris® Xe\r\n記憶體：8GB LPDDR4x\r\nSSD硬碟：512G PCIe SSD\r\n傳統硬碟 : 無\r\n螢幕：13.5 吋 3:2 PixelSense® 螢幕 2256x1504 (201 PPI) 10點觸控\r\n光碟機 : 無\r\n作業系統：Windows 10\r\n無線規格：Wi-Fi 6 相容於 802.11ax、Bluetooth® 無線 5.0 技術\r\n攝影機：Windows Hello 臉部驗證相機 (前方)、720p HD f2.0 相機 (前方)\r\nI/O 介面：\r\n1 x USB-C\r\n1 x USB-A\r\n1 x 3.5 mm耳機插孔\r\n1 x Surface Connect 埠\r\n尺寸 (WxDxH)：12.1 吋 x 8.8 吋 x 0.57 吋 (308 公釐 x 223 公釐 x 14.5 公釐)\r\n重量：2.79 磅 (1,265 公克)\r\n保固：１年售後保固\r\n備註：以上規格僅供參考，如有任何問題，請依原廠公告為主','Intel Core i5-1135G7 4核心/8緒 2.4GHz 超頻 4.2GHz / 8M Cache','Intel® Iris® Xe','8GB LPDDR4x','Windows 10','13.5 吋 3:2 PixelSense® 螢幕 2256x1504 (201 PPI) 10點觸控','Integrated 45Wh','1年售後保固','12.1 吋 x 8.8 吋 x 0.57 吋 (308 公釐 x 223 公釐 x 14.5 公釐)','2.79 磅 (1,265 公克)'),(19,7,'戴爾13代機械硬核電競 量子黑 ( G15-5530-R1768BTW )',NULL,49900,0,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：第13代 Intel® Core™ i7-13650HX (24 MB 快取記憶體, 14 核, 最高睿頻 4.90 GHz)\r\n顯示卡：NVIDIA® GeForce® RTX™ 4050, 6 GB GDDR6\r\n記憶體：16GB (8GBx2) DDR5 4800MHz   (2 Slot/ up to 32G)\r\nSSD硬碟：M.2 2230 512GB NVMe Gen 4 Class 35 (擴充第二顆M.2，需要加購螺絲墊片與散热片)\r\n螢幕尺寸：15.6吋 FHD (1920x1080) 165Hz, 3ms, sRGB-100%, ComfortViewPlus, NVIDIA G-SYNC+DDS 顯示器\r\n光碟機：No\r\n作業系統：Windows® 11  家用版 64位元 三國語言版(繁體中文、簡體中文、英文)\r\n網路規格：Intel Wi-Fi 6 AX201, 2x2 802.11ax 1\r\n視訊鏡頭：720p (30 fps) HD RGB 攝影機，單一內建麥克風\r\n音效與喇叭：立體聲喇叭，搭載 Realtek ALC3254，2 x 2.5 W\r\n鍵盤規格：繁體中文 Qwerty 背光 鍵盤 含 數字鍵台 (無 G-Key)\r\nI/O規格：\r\n1x 耳機 (耳機和麥克風組合) 連接埠\r\n1x RJ45 乙太網路連接埠\r\n3x USB 3.2 Gen 1 連接埠\r\n1x HDMI 2.1 連接埠\r\n1x USB-C 3.2 Gen 2 連接埠，具備 DisplayPort™\r\n軟體：Mcafee 12M、Microsoft® Office 試用版\r\n尺寸：高度：25.4 x 368.9 x 289.9 (mm)\r\n重量：2.81 kg\r\n變壓器：330W\r\n電池：鋰離子(86 瓦時)電池 含Alienware 電池防護技術\r\n保固：2年 頂級支援 1-2 營業日 到府服務 含 HW-SW 支援\r\n備註：以上資料僅供參考，如有任何問題，請依原廠公告為主。','第13代 Intel® Core™ i7-13650HX (24 MB 快取記憶體, 14 核, 最高睿頻 4.90 GHz)','NVIDIA® GeForce® RTX™ 4050, 6 GB GDDR6','16GB (8GBx2) DDR5 4800MHz   (2 Slot/ up to 32G)','Windows® 11  家用版 64位元 三國語言版(繁體中文、簡體中文、英文)','15.6吋 FHD (1920x1080) 165Hz, 3ms, sRGB-100%, ComfortViewPlus, NVIDIA G-SYNC+DDS 顯示器','鋰離子(86 瓦時)電池 含Alienware 電池防護技術','1年售後保固','高度：25.4 x 368.9 x 289.9 (mm)','2.81 kg'),(20,6,'戴爾13代外星人電競 月影色 ( ALWM16-R1908QBTW )',NULL,134990,2000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：第13代 Intel® Core™i9-13900HX，24核心/32緒 1.65GHz /超頻 5.4GHz/36MB快取\r\n顯示卡：NVIDIA® GeForce RTX™ 4060 8GB GDDR6\r\n記憶體：32GB（16G×2）DDR5 4800MHz（2個DDR5 SO DIMMs）\r\nSSD硬碟：1TB PCIe NVMe M.2 SSD（2個PCIe NVMe M.2 SSD）\r\n螢幕尺寸：16吋QHD+（2560×1600）165Hz、3ms、ComfortView Plus、NVIDIA G-SYNC和AMD FreeSync+動態顯示切換、100% sRGB色域\r\n作業系統：Windows® 11 Home（64位元）\r\n網路規格：Intel® Wi-Fi 6E AX211，具備\r\n藍芽規格：Bluetooth v5.2\r\n視訊鏡頭：Alienware FHD（1920 x 1080 解析度），帶雙陣列麥克風和 Windows Hello IR 支持\r\nAlienFX 燈光詳情：可程式化，最多支援 1680萬種不同顏色\r\n鍵盤規格：英文鍵盤 ，Alienware MX 系列 1-Zone AlienFX 鍵盤\r\n觸控板詳情：多點觸控手勢觸控板，具備整合捲動功能\r\nI/O規格：\r\n2x Type-C 端口（Thunderbolt™ 4.0、USB 4 Gen 2、DisplayPort 1.4 和 15W 供電 (3A/5V) 功能）\r\n1x USB Type-A 3.2 Gen 1\r\n1x HDMI 2.1 輸出連接埠\r\n1x Mini DisplayPort 1.4\r\n1x 電源/DC 輸入連接埠\r\n1x RJ-45 乙太網路連接埠\r\n1x USB 3.2 Gen 1 Type-A 連接埠 (具備 PowerShare 功能)\r\n1x 通用耳機插孔\r\n1x SD 卡插槽\r\n軟體：Mcafee 12M、Microsoft® Office 試用版\r\n尺寸：高度：25.4 x 368.9 x 289.9 (mm)\r\n重量：3.25公斤\r\n變壓器：330W\r\n電池：鋰離子(86 瓦時)電池 含Alienware 電池防護技術\r\n保固：2年 頂級支援 1-2 營業日 到府服務 含 HW-SW 支援\r\n備註：以上資料僅供參考，如有任何問題，請依原廠公告為主。','第13代 Intel® Core™i9-13900HX，24核心/32緒 1.65GHz /超頻 5.4GHz/36MB快取','NVIDIA® GeForce RTX™ 4060 8GB GDDR6','32GB（16G×2）DDR5 4800MHz（2個DDR5 SO DIMMs）','Windows® 11 Home（64位元）','16吋QHD+（2560×1600）165Hz、3ms、ComfortView Plus、NVIDIA G-SYNC和AMD FreeSync+動態顯示切換、100% sRGB色域','鋰離子(86 瓦時)電池 含Alienware 電池防護技術','1年售後保固','高度：25.4 x 368.9 x 289.9 (mm)','3.25公斤'),(20,8,'戴爾13代外星人電競 月影色 ( ALWM16-R1788QBTW )',NULL,84990,2000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：第13代 Intel® Core™i7-13700HX，16核心/24緒 1.55GHz /超頻 5.0GHz/30MB快取\r\n顯示卡：NVIDIA® GeForce RTX™ 4060 8GB GDDR6\r\n記憶體：16GB（8G×2）DDR5 4800MHz（2個DDR5 SO DIMMs）\r\nSSD硬碟：512GB PCIe NVMe M.2 SSD（2個PCIe NVMe M.2 SSD）\r\n螢幕尺寸：16吋QHD+（2560×1600）165Hz、3ms、ComfortView Plus、NVIDIA G-SYNC和AMD FreeSync+動態顯示切換、100% sRGB色域\r\n作業系統：Windows® 11 Home（64位元）\r\n網路規格：Intel® Wi-Fi 6E AX211，具備\r\n藍芽規格：Bluetooth v5.2\r\n視訊鏡頭：Alienware FHD（1920 x 1080 解析度），帶雙陣列麥克風和 Windows Hello IR 支持\r\nAlienFX 燈光詳情：可程式化，最多支援 1680萬種不同顏色\r\n鍵盤規格：英文鍵盤 ，Alienware M 系列 1-Zone AlienFX 鍵盤\r\n觸控板詳情：多點觸控手勢觸控板，具備整合捲動功能\r\nI/O規格：\r\n2x Type-C 端口（Thunderbolt™ 4.0、USB 4 Gen 2、DisplayPort 1.4 和 15W 供電 (3A/5V) 功能）\r\n1x USB Type-A 3.2 Gen 1\r\n1x HDMI 2.1 輸出連接埠\r\n1x Mini DisplayPort 1.4\r\n1x 電源/DC 輸入連接埠\r\n1x RJ-45 乙太網路連接埠\r\n1x USB 3.2 Gen 1 Type-A 連接埠 (具備 PowerShare 功能)\r\n1x 通用耳機插孔\r\n1x SD 卡插槽\r\n軟體：Mcafee 12M、Microsoft® Office 試用版\r\n尺寸：高度：25.4 x 368.9 x 289.9 (mm)\r\n重量：3.25公斤\r\n變壓器：330W\r\n電池：鋰離子(86 瓦時)電池 含Alienware 電池防護技術\r\n\r\n\r\n保固：2年 頂級支援 1-2 營業日 到府服務 含 HW-SW 支援\r\n備註：以上資料僅供參考，如有任何問題，請依原廠公告為主。','第13代 Intel® Core™i7-13700HX，16核心/24緒 1.55GHz /超頻 5.0GHz/30MB快取','NVIDIA® GeForce RTX™ 4060 8GB GDDR6','16GB（8G×2）DDR5 4800MHz（2個DDR5 SO DIMMs）','Windows® 11 Home（64位元）','16吋QHD+（2560×1600）165Hz、3ms、ComfortView Plus、NVIDIA G-SYNC和AMD FreeSync+動態顯示切換、100% sRGB色域','鋰離子(86 瓦時)電池 含Alienware 電池防護技術','1年售後保固','高度：25.4 x 368.9 x 289.9 (mm)','3.25公斤'),(21,3,'戴爾13代外星人電競 星辰銀 ( ALWX14-R1888QBTW )',NULL,104900,2000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：第13代 Intel® Core™ i7 13620H（10核心/16緒/超頻4.9GHz/24MB快取）\r\n顯示卡：NVIDIA® GeForce RTX™ 4060 8GB GDDR6\r\n記憶體：32GB LP-DDR5 4800 MT/s(無法擴充)\r\nSSD硬碟：1TB PCIe NVMe M.2 SSD\r\n螢幕尺寸：14.0吋 QHD+（2560 x 1600），165Hz，3ms，100% DCI-P3色域，ComfortView Plus，NVIDIA G-SYNC + Advanced Optimus\r\n作業系統：Windows® 11 Home（64位元）\r\n網路規格：Intel® Wi-Fi 6E AX211，具備\r\n藍芽規格：Bluetooth v5.2\r\n視訊鏡頭：Alienware FHD（1920 x 1080 解析度），帶雙陣列麥克風和 Windows Hello IR 支持\r\nAlienFX 燈光詳情：可程式化，最多支援 16.8 百萬種不同顏色\r\n鍵盤規格：英文鍵盤 ，Alienware X 系列 1-Zone AlienFX 鍵盤 ，1.2mm 鍵程\r\n觸控板詳情：多點觸控手勢觸控板，具備整合捲動功能\r\nI/O規格：\r\n1x USB 3.2 第 2 代 Type-C® 連接埠，具備電源供應與 DisplayPort™\r\n1x 通用耳機插孔連接埠\r\n1x HDMI 2.1 連接埠\r\n1x USB 3.2 Gen 1 Type-A 連接埠 (具備 PowerShare 功能)\r\n2x Thunderbolt™ 4 連接埠​，具備電源供應與 DisplayPort™ (Type-C 連接埠​)\r\n1x microSD 卡插槽\r\n軟體：Mcafee 12M、Microsoft® Office 試用版\r\n尺寸：高度：14.5 x260.41 x321.08\r\n重量：1.91公斤 (4.224磅)\r\n變壓器：130W Type-C 小型機箱 配接卡\r\n電池：鋰離子(80 瓦時)電池 含Alienware 電池防護技術\r\n\r\n\r\n保固：2年 頂級支援 1-2 營業日 到府服務 含 HW-SW 支援\r\n備註：以上資料僅供參考，如有任何問題，請依原廠公告為主。','第13代 Intel® Core™ i7 13620H（10核心/16緒/超頻4.9GHz/24MB快取）','NVIDIA® GeForce RTX™ 4060 8GB GDDR6','32GB LP-DDR5 4800 MT/s(無法擴充)','Windows® 11 Home（64位元）','14.0吋 QHD+（2560 x 1600），165Hz，3ms，100% DCI-P3色域，ComfortView Plus，NVIDIA G-SYNC + Advanced Optimus','鋰離子(80 瓦時)電池 含Alienware 電池防護技術','1年售後保固','高度：14.5 x260.41 x321.08','1.91公斤 (4.224磅)'),(21,5,'戴爾13代外星人電競 星辰銀 ( ALWX14-R1788QBTW )',NULL,87900,2000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：第13代 Intel® Core™ i7 13620H（10核心/16緒/超頻4.9GHz/24MB快取）\r\n顯示卡：NVIDIA® GeForce RTX™ 4060 8GB GDDR6\r\n記憶體：16GB LP-DDR5 4800 MT/s(無法擴充)\r\nSSD硬碟：512GB PCIe NVMe M.2 SSD（固態碟）\r\n螢幕尺寸：14.0吋 QHD+（2560 x 1600），165Hz，3ms，100% DCI-P3色域，ComfortView Plus，NVIDIA G-SYNC + Advanced Optimus\r\n作業系統：Windows® 11 Home（64位元）\r\n網路規格：Intel® Wi-Fi 6E AX211，具備\r\n藍芽規格：Bluetooth v5.2\r\n視訊鏡頭：Alienware FHD（1920 x 1080 解析度），帶雙陣列麥克風和 Windows Hello IR 支持\r\nAlienFX 燈光詳情：可程式化，最多支援 16.8 百萬種不同顏色\r\n鍵盤規格：英文鍵盤 ，Alienware X 系列 1-Zone AlienFX 鍵盤 ，1.2mm 鍵程\r\n觸控板詳情：多點觸控手勢觸控板，具備整合捲動功能\r\nI/O規格：\r\n1x USB 3.2 第 2 代 Type-C® 連接埠，具備電源供應與 DisplayPort™\r\n1x 通用耳機插孔連接埠\r\n1x HDMI 2.1 連接埠\r\n1x USB 3.2 Gen 1 Type-A 連接埠 (具備 PowerShare 功能)\r\n2x Thunderbolt™ 4 連接埠​，具備電源供應與 DisplayPort™ (Type-C 連接埠​)\r\n1x microSD 卡插槽\r\n軟體：Mcafee 12M、Microsoft® Office 試用版\r\n尺寸：高度：14.5 x260.41 x321.08\r\n重量：1.91公斤 (4.224磅)\r\n變壓器：130W Type-C 小型機箱 配接卡\r\n電池：鋰離子(80 瓦時)電池 含Alienware 電池防護技術\r\n保固：2年 頂級支援 1-2 營業日 到府服務 含 HW-SW 支援\r\n備註：以上資料僅供參考，如有任何問題，請依原廠公告為主。','第13代 Intel® Core™ i7 13620H（10核心/16緒/超頻4.9GHz/24MB快取）','NVIDIA® GeForce RTX™ 4060 8GB GDDR6','16GB LP-DDR5 4800 MT/s(無法擴充)','Windows® 11 Home（64位元）','14.0吋 QHD+（2560 x 1600），165Hz，3ms，100% DCI-P3色域，ComfortView Plus，NVIDIA G-SYNC + Advanced Optimus','鋰離子(80 瓦時)電池 含Alienware 電池防護技術','2年 頂級支援 1-2 營業日 到府服務 含 HW-SW 支援','高度：14.5 x260.41 x321.08','1.91公斤 (4.224磅)'),(21,7,'戴爾13代外星人電競 星辰銀 ( ALWX14-R1768QBTW )',NULL,84900,1000,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','處理器：第13代 Intel® Core™ i7 13620H（10核心/16緒/超頻4.9GHz/24MB快取）\r\n顯示卡：NVIDIA® GeForce RTX™ 4050 6GB GDDR6\r\n記憶體：16GB LP-DDR5 4800 MT/s (無法擴充)\r\nSSD硬碟：512GB PCIe NVMe M.2 SSD（固態碟）\r\n螢幕尺寸：14.0吋 QHD+（2560 x 1600），165Hz，3ms，100% DCI-P3色域，ComfortView Plus，NVIDIA G-SYNC + Advanced Optimus\r\n作業系統：Windows® 11 Home（64位元）\r\n網路規格：Intel® Wi-Fi 6E AX211，具備\r\n藍芽規格：Bluetooth v5.2\r\n視訊鏡頭：Alienware FHD（1920 x 1080 解析度），帶雙陣列麥克風和 Windows Hello IR 支持\r\nAlienFX 燈光詳情：可程式化，最多支援 16.8 百萬種不同顏色\r\n鍵盤規格：英文鍵盤 ，Alienware X 系列 1-Zone AlienFX 鍵盤 ，1.2mm 鍵程\r\n觸控板詳情：多點觸控手勢觸控板，具備整合捲動功能\r\nI/O規格：\r\n1x USB 3.2 第 2 代 Type-C® 連接埠，具備電源供應與 DisplayPort™\r\n1x 通用耳機插孔連接埠\r\n1x HDMI 2.1 連接埠\r\n1x USB 3.2 Gen 1 Type-A 連接埠 (具備 PowerShare 功能)\r\n2x Thunderbolt™ 4 連接埠​，具備電源供應與 DisplayPort™ (Type-C 連接埠​)\r\n1x microSD 卡插槽\r\n尺寸：高度：14.5 x260.41 x321.08\r\n重量：1.91公斤 (4.224磅)\r\n變壓器：130W Type-C 小型機箱 配接卡\r\n電池：鋰離子(80 瓦時)電池 含Alienware 電池防護技術\r\n保固：2年 頂級支援 1-2 營業日 到府服務 含 HW-SW 支援\r\n備註：以上資料僅供參考，如有任何問題，請依原廠公告為主。','第13代 Intel® Core™ i7 13620H（10核心/16緒/超頻4.9GHz/24MB快取）','NVIDIA® GeForce RTX™ 4050 6GB GDDR6','16GB LP-DDR5 4800 MT/s (無法擴充)','Windows® 11 Home（64位元）','14.0吋 QHD+（2560 x 1600），165Hz，3ms，100% DCI-P3色域，ComfortView Plus，NVIDIA G-SYNC + Advanced Optimus','鋰離子(80 瓦時)電池 含Alienware 電池防護技術','2年 頂級支援 1-2 營業日 到府服務 含 HW-SW 支援','高度：14.5 x260.41 x321.08','1.91公斤 (4.224磅)'),(22,0,'',NULL,990,500,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','','','','','','','','','',''),(23,0,'',NULL,2990,770,1,'2023-09-17 16:53:41','2023-09-17 16:53:41','1、搭載 Hi-Res ESS Quad-DAC 的 RGB 電競耳機，具備環狀 RGB 燈效以及 USB-C 連接頭，可支援PC、遊戲主機和手機，引領業界的 HI-RES ESS Quad-DAC，為你帶來完美細膩的逼真音效 \r\n2、USB-C 接頭支援多平台，包括 PC、Mac、行動電話及 PS4 \r\n3、可自訂的多色環狀 RGB 燈效，讓你展現個人風格 \r\n4、獨家 ASUS Essence 驅動單體、氣密腔體以及 Audio Signal Diversion 技術，提「聲」歷其境的音效體驗 5、符合人體工學的 D 型 ROG Hybrid 耳罩，提升配戴舒適感 6、使用 USB-C 轉 USB 2.0 轉接頭','','','','','','','','','');
/*!40000 ALTER TABLE `sellspec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopcart`
--

DROP TABLE IF EXISTS `shopcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shopcart` (
  `user_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL,
  `spec_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`prod_id`,`spec_id`) USING BTREE,
  KEY `prod_id` (`prod_id`),
  KEY `spec_id` (`spec_id`),
  CONSTRAINT `shopcart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `shopcart_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `product` (`prod_id`),
  CONSTRAINT `shopcart_ibfk_3` FOREIGN KEY (`spec_id`) REFERENCES `sellspec` (`spec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopcart`
--

LOCK TABLES `shopcart` WRITE;
/*!40000 ALTER TABLE `shopcart` DISABLE KEYS */;
INSERT INTO `shopcart` VALUES (6,4,0),(7,11,3);
/*!40000 ALTER TABLE `shopcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tag` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(50) NOT NULL,
  PRIMARY KEY (`tag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'CP值'),(2,'文書機'),(3,'電競機'),(4,'繪圖效能機'),(5,'極度輕薄'),(6,'開學季學生主打');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `rights` tinyint(4) NOT NULL DEFAULT 2 COMMENT '管理員 0\r\n賣家 1\r\n買家 2\r\n',
  `acc` varchar(20) NOT NULL,
  `pwd` varchar(1000) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `birth` date NOT NULL,
  `address` varchar(300) DEFAULT NULL,
  `photo` varchar(300) DEFAULT NULL,
  `change_pwd_time` date NOT NULL DEFAULT current_timestamp(),
  `creat_time` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  KEY `right` (`rights`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,0,'admin','$2b$10$PiWmGE8pvsjfIVT6EKMkG.1o5rYH8Kjr3jU6aqtE2coQlZTb1VgXy','管理員1號','0912345678','admin01@email.com','2000-01-01','台中市南屯區黎明路二段658號',NULL,'2023-08-24','2023-08-24'),(2,1,'seller01','$2b$10$WKiCfj0XWaKXIk1tzkgLCe2RsED.HX4qBISH9cZRHj9yscXX2eScG','賣家1號','0912345678','seller01@email.com','2000-01-01','台中市南屯區黎明路二段658號',NULL,'2023-08-24','2023-08-24'),(3,1,'seller02','$2b$10$xb3a/HSMVro24rigOU7gRumbFkGNm1AjYZybqzmwWq6YPebzpcx9u','賣家2號','0912345678','seller02@email.com','2000-01-01','台中市南屯區黎明路二段658號',NULL,'2023-08-24','2023-08-24'),(4,1,'seller03','$2b$10$I0S5zCuU7BpDzVrHw6UmnO7bAQuT5F9nq0N41FM6oDPdipkqob5Rm','賣家3號','0912345678','seller03@email.com','2000-01-01','台中市南屯區黎明路二段658號',NULL,'2023-08-24','2023-08-24'),(5,1,'seller04','$2b$10$VGuiO4kiyQGvB1q1R1pnPOkamWccoskzY7Nllxa8WKwujdvtfML7K','賣家4號','0912345678','seller04@email.com','2000-01-01','台中市南屯區黎明路二段658號',NULL,'2023-08-24','2023-08-24'),(6,2,'buyer01','$2b$10$lIfLO0xAj2vRPegkpvt7jO3lNArwo8jTl/jt/0I2Xc2rrZLi5o4zq','吳毅成','0912345678','buyer01@email.com','2000-01-15','臺中市南屯區黎明路二段658號','/images/user/image_6_1694980643574.png','2023-09-03','2023-08-24'),(7,2,'buyer02','$2b$10$XZOwlduXlfQPw3vXXuDczO7AFA6c/7zyynp2gML5/syOHoHYWV2gC','楊弍','0912345678','buyer02@email.com','1980-01-01','臺中市南屯區黎明路二段658號','/images/user/image_7_1694981162711.gif','2023-08-24','2023-08-24'),(8,2,'buyer03','$2b$10$5x/uAEkltwc2bgO1qc2wIudU0KwwuImi8Em2Y7sgEIEvHB5hziKLe','買家3號','0912345678','buyer03@email.com','2000-01-01','台中市南屯區黎明路二段658號',NULL,'2023-08-24','2023-08-24'),(9,2,'buyer04','$2b$10$u/mx7VRJ2XPGkTnvIjsjIelB.VFy34k./UZlX2wufyHDsHbStR3yq','買家4號','0912345678','buyer04@email.com','2000-01-01','台中市南屯區黎明路二段658號',NULL,'2023-08-24','2023-08-24'),(10,2,'buyer05','$2b$10$YD6jXZdDUvN1opHU5LzGkuw/vjc1j9JsQCBPh/lT1DSx.sxLR997C','買家5號','0912345678','buyer05@gmail.com','2000-01-01','台中市南屯區黎明路二段658號',NULL,'2023-08-24','2023-08-24'),(18,2,'Aa010102','$2b$10$hvosbHJys4XZ.weVdIPkT.kBhnbmmnQMlGVh3Z0xwIqKfg4DansQi','aaa','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(19,2,'Aa010103','$2b$10$wq15RNi3PS5BQ8Nf9pTTg.odW42/o.UR7NKeEKXE1qZpbUQzCCGv.','aaa','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(20,2,'Aa010104','$2b$10$brnxY9S6kvqRZ5SE/I6cfuvUr/lNvmiFEote0QIQZj1MeLxQm5172','aaa','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(21,2,'Aa010105','$2b$10$FOK9OWLvggfH/NVD8uTbx.vOrVU8rNYoH894mrWdEtWV.Ww0ZP.zG','aaa','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(22,2,'Aa010106','$2b$10$vPADhJpEL2UcFcM7XwtT6eZzkb3ZWVFgVFV9t09obGkHjn2Hk1pyW','aaa','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(23,2,'Aa010107','$2b$10$p8RZojH3EuBBsH55OBaStuN5mCfx9v71FIyVF00sCFKFa1EDtKw0C','aaa','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(24,2,'Aa010108','$2b$10$HNqCrvTbgLeOxTY0aE9EOOKcrcguFRsONzQxBcgPKLL3VqScl419S','a','0912345678','a@gmail.com','2000-02-02',NULL,NULL,'2023-08-30','2023-08-30'),(25,2,'Aa010109','$2b$10$DGr5rCgczPlYl3ZcBtJHAeNyiDw8aB0r8XqTa0TUANQ0/OXl2Ary6','a','0912345678','a@gmail.com','2000-02-02',NULL,NULL,'2023-08-30','2023-08-30'),(26,2,'Ab010101','$2b$10$Vvjg8KH/malRtGwfI6Tzu.shNM9VlCPRO5W5g5ITzBe76WCmDGPvy','aaa','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(27,1,'Ab010102','$2b$10$vcK6d.W9jA5lx.XVG7y2iOTeqCpvKXVFXmgJnyum/eb2l.OqhOuxa','Ab010102','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(28,2,'Ab010103','$2b$10$7DTKYpi2gsw2b/l2D3o2LucjewnPf1zxS5fChrb9LCPezTn5oqLwW','Ab010103','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(30,2,'Ab010105','$2b$10$0fTzedslNWdBj0UBZvLgKe.qOxI95cQH20yoj57ZQUUpvebWFKm42','Ab010105','0912345678','a@gmail.com','2000-01-01',NULL,NULL,'2023-08-30','2023-08-30'),(41,2,'Bb010101','$2b$10$cLRMoDajQU/udKS1GlqAI.rKXcJHRHRt5OUhIghNja2ttinHOR4xS','Bb010101','0912345678','asda@gmail.com','1977-07-06',NULL,NULL,'2023-09-04','2023-09-04'),(42,2,'Bbb010101','$2b$10$4J8BCn3Gq9Ul5x1ptG8rmOvA0/WkSPyw5xnFgC7U7Vb68y3xj31ue','Bbb010101','0912345680','asd@gmail.com','1987-09-28','彰化縣彰化市彰美路1段1號','/images/user/image_42_1694145175005.png','2023-09-04','2023-09-04');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vw_all_order_product_count`
--

DROP TABLE IF EXISTS `vw_all_order_product_count`;
/*!50001 DROP VIEW IF EXISTS `vw_all_order_product_count`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_all_order_product_count` AS SELECT
 1 AS `order_id`,
  1 AS `prod_id`,
  1 AS `spec_id`,
  1 AS `counts` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_comment`
--

DROP TABLE IF EXISTS `vw_comment`;
/*!50001 DROP VIEW IF EXISTS `vw_comment`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_comment` AS SELECT
 1 AS `prod_id`,
  1 AS `spec_id`,
  1 AS `user_id`,
  1 AS `order_id`,
  1 AS `prod_name`,
  1 AS `spec_name`,
  1 AS `name`,
  1 AS `state`,
  1 AS `comment`,
  1 AS `comment_grade`,
  1 AS `comment_time`,
  1 AS `img_src` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_order_detail`
--

DROP TABLE IF EXISTS `vw_order_detail`;
/*!50001 DROP VIEW IF EXISTS `vw_order_detail`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_order_detail` AS SELECT
 1 AS `order_id`,
  1 AS `user_id`,
  1 AS `prod_id`,
  1 AS `spec_id`,
  1 AS `prod_name`,
  1 AS `spec_name`,
  1 AS `price`,
  1 AS `count`,
  1 AS `subtotla`,
  1 AS `img_src` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_order_info`
--

DROP TABLE IF EXISTS `vw_order_info`;
/*!50001 DROP VIEW IF EXISTS `vw_order_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_order_info` AS SELECT
 1 AS `user_id`,
  1 AS `order_id`,
  1 AS `recipient`,
  1 AS `recipient_address`,
  1 AS `recipient_phone`,
  1 AS `state`,
  1 AS `pay`,
  1 AS `pay_method`,
  1 AS `total`,
  1 AS `order_date` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_product_comment_grade`
--

DROP TABLE IF EXISTS `vw_product_comment_grade`;
/*!50001 DROP VIEW IF EXISTS `vw_product_comment_grade`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_product_comment_grade` AS SELECT
 1 AS `prod_id`,
  1 AS `spec_id`,
  1 AS `comment_grade` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_products_detail`
--

DROP TABLE IF EXISTS `vw_products_detail`;
/*!50001 DROP VIEW IF EXISTS `vw_products_detail`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_products_detail` AS SELECT
 1 AS `prod_id`,
  1 AS `spec_id`,
  1 AS `prod_name`,
  1 AS `spec_name`,
  1 AS `brand`,
  1 AS `category`,
  1 AS `publish`,
  1 AS `cpu`,
  1 AS `gpu`,
  1 AS `ram`,
  1 AS `os`,
  1 AS `screen`,
  1 AS `battery`,
  1 AS `size`,
  1 AS `weight`,
  1 AS `warranty`,
  1 AS `info_content` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_products_info`
--

DROP TABLE IF EXISTS `vw_products_info`;
/*!50001 DROP VIEW IF EXISTS `vw_products_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_products_info` AS SELECT
 1 AS `prod_id`,
  1 AS `spec_id`,
  1 AS `seller_id`,
  1 AS `brand_id`,
  1 AS `category_id`,
  1 AS `prod_name`,
  1 AS `spec_name`,
  1 AS `seller_name`,
  1 AS `brand`,
  1 AS `category`,
  1 AS `publish`,
  1 AS `price`,
  1 AS `stock`,
  1 AS `sales`,
  1 AS `inventory`,
  1 AS `comment_grade`,
  1 AS `create_time`,
  1 AS `update_time`,
  1 AS `img_src` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'combuy'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_cards` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_cards`(IN p_user_id INT)
BEGIN
    SELECT
        user.user_id,
        user.name,
        card.card_num,
        card.expiry_date,
        card.security_code
    FROM
        card
    LEFT JOIN `user` ON user.user_id = card.user_id
    WHERE
        card.user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_collect` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_collect`(IN `p_user_id` INT)
BEGIN
    SELECT
        user_id,
        collect.prod_id,
        collect.spec_id,
        vw_products_info.prod_name,
        vw_products_info.spec_name,
        vw_products_info.price,
        vw_products_info.publish,
        vw_products_info.img_src,
        collect.update_time
    FROM
        collect
    LEFT JOIN vw_products_info ON collect.prod_id = vw_products_info.prod_id AND collect.spec_id = vw_products_info.spec_id
    WHERE user_id = p_user_id
        ORDER BY collect.update_time DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_order`(IN `p_user_id` INT, IN `p_order_id` INT)
BEGIN
    SELECT
        orders.user_id,
        orders.order_id,
        order_product.prod_id,
        order_product.spec_id,
        vw_products_info.prod_name,
        vw_products_info.spec_name,
        order_product.count,
        order_product.price,
        (
            order_product.count * order_product.price
        ) AS amount,
        vw_products_info.img_src
    FROM
        order_product
    LEFT JOIN vw_products_info ON order_product.prod_id = vw_products_info.prod_id AND order_product.spec_id = vw_products_info.spec_id
    LEFT JOIN orders ON order_product.order_id = orders.order_id
    WHERE
        orders.state != 0 AND user_id = p_user_id AND orders.order_id = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_orderList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_orderList`(IN p_user_id INT)
BEGIN
    SELECT
        orders.order_id,
        user.user_id,
        user.name AS buyer,
        SUM(TEMPTABLE.amount) AS total,
        orders.recipient,
        orders.recipient_address,
        orders.recipient_phone,
        orders.state,
        orders.pay,
        orders.pay_method,
        orders.order_date
    FROM
        orders
    LEFT JOIN(
        SELECT
            orders.user_id,
            orders.order_id,
            order_product.prod_id,
            order_product.spec_id,
            (
                order_product.count * order_product.price
            ) AS amount
        FROM
            order_product
        LEFT JOIN orders ON order_product.order_id = orders.order_id
    ) AS TEMPTABLE
ON
    orders.order_id = TEMPTABLE.order_id
LEFT JOIN USER ON user.user_id = orders.user_id
WHERE
    orders.user_id = p_user_id
GROUP BY
    orders.order_id ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_shopcart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_shopcart`(IN p_user_id INT)
BEGIN
    SELECT
        user_id,
        shopcart.prod_id,
        shopcart.spec_id,
        vw_products_info.prod_name,
        vw_products_info.spec_name,
        vw_products_info.price,
        vw_products_info.publish,
        vw_products_info.img_src
    FROM
        shopcart
    LEFT JOIN vw_products_info ON shopcart.prod_id = vw_products_info.prod_id AND shopcart.spec_id = vw_products_info.spec_id
    WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `combuy`
--

USE `combuy`;

--
-- Final view structure for view `vw_all_order_product_count`
--

/*!50001 DROP VIEW IF EXISTS `vw_all_order_product_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_all_order_product_count` AS select `orders`.`order_id` AS `order_id`,`order_product`.`prod_id` AS `prod_id`,`order_product`.`spec_id` AS `spec_id`,`order_product`.`count` AS `counts` from (`orders` left join `order_product` on(`orders`.`order_id` = `order_product`.`order_id`)) where `orders`.`state` <> 0 and `order_product`.`count` is not null order by `orders`.`order_id`,`order_product`.`prod_id`,`order_product`.`spec_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_comment`
--

/*!50001 DROP VIEW IF EXISTS `vw_comment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_comment` AS select `order_product`.`prod_id` AS `prod_id`,`order_product`.`spec_id` AS `spec_id`,`user`.`user_id` AS `user_id`,`orders`.`order_id` AS `order_id`,`vw_products_info`.`prod_name` AS `prod_name`,`vw_products_info`.`spec_name` AS `spec_name`,`user`.`name` AS `name`,`orders`.`state` AS `state`,ifnull(`order_product`.`comment`,'') AS `comment`,ifnull(`order_product`.`comment_grade`,0) AS `comment_grade`,`order_product`.`comment_time` AS `comment_time`,`vw_products_info`.`img_src` AS `img_src` from (((`order_product` left join `orders` on(`order_product`.`order_id` = `orders`.`order_id`)) left join `user` on(`orders`.`user_id` = `user`.`user_id`)) left join `vw_products_info` on(`order_product`.`prod_id` = `vw_products_info`.`prod_id` and `order_product`.`spec_id` = `vw_products_info`.`spec_id`)) where `orders`.`state` <> 0 order by `order_product`.`comment_time` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_order_detail`
--

/*!50001 DROP VIEW IF EXISTS `vw_order_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_order_detail` AS select `order_product`.`order_id` AS `order_id`,`orders`.`user_id` AS `user_id`,`order_product`.`prod_id` AS `prod_id`,`order_product`.`spec_id` AS `spec_id`,`vw_products_info`.`prod_name` AS `prod_name`,`vw_products_info`.`spec_name` AS `spec_name`,`order_product`.`price` AS `price`,`order_product`.`count` AS `count`,`order_product`.`price` * `order_product`.`count` AS `subtotla`,`vw_products_info`.`img_src` AS `img_src` from ((`order_product` left join `vw_products_info` on(`order_product`.`prod_id` = `vw_products_info`.`prod_id` and `order_product`.`spec_id` = `vw_products_info`.`spec_id`)) left join `orders` on(`order_product`.`order_id` = `orders`.`order_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_order_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_order_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_order_info` AS select `vw_order_detail`.`user_id` AS `user_id`,`vw_order_detail`.`order_id` AS `order_id`,`orders`.`recipient` AS `recipient`,`orders`.`recipient_address` AS `recipient_address`,`orders`.`recipient_phone` AS `recipient_phone`,`orders`.`state` AS `state`,`orders`.`pay` AS `pay`,`orders`.`pay_method` AS `pay_method`,sum(`vw_order_detail`.`subtotla`) AS `total`,`orders`.`order_date` AS `order_date` from (`vw_order_detail` left join `orders` on(`vw_order_detail`.`order_id` = `orders`.`order_id`)) group by `vw_order_detail`.`order_id` order by `orders`.`order_date` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_product_comment_grade`
--

/*!50001 DROP VIEW IF EXISTS `vw_product_comment_grade`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_product_comment_grade` AS select `product`.`prod_id` AS `prod_id`,`sellspec`.`spec_id` AS `spec_id`,round(avg(`order_product`.`comment_grade`),1) AS `comment_grade` from (((`sellspec` left join `product` on(`sellspec`.`prod_id` = `product`.`prod_id`)) left join `order_product` on(`sellspec`.`spec_id` = `order_product`.`spec_id` and `sellspec`.`prod_id` = `order_product`.`prod_id`)) left join `orders` on(`order_product`.`order_id` = `orders`.`order_id`)) where `orders`.`state` <> 0 and `order_product`.`comment_grade` is not null group by `sellspec`.`prod_id`,`sellspec`.`spec_id` order by `sellspec`.`prod_id`,`sellspec`.`spec_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_products_detail`
--

/*!50001 DROP VIEW IF EXISTS `vw_products_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_products_detail` AS select `product`.`prod_id` AS `prod_id`,`sellspec`.`spec_id` AS `spec_id`,`product`.`prod_name` AS `prod_name`,`sellspec`.`spec_name` AS `spec_name`,`brand`.`brand` AS `brand`,`category`.`category` AS `category`,`sellspec`.`publish` AS `publish`,`sellspec`.`cpu` AS `cpu`,`sellspec`.`gpu` AS `gpu`,`sellspec`.`ram` AS `ram`,`sellspec`.`os` AS `os`,`sellspec`.`screen` AS `screen`,`sellspec`.`battery` AS `battery`,`sellspec`.`size` AS `size`,`sellspec`.`weight` AS `weight`,`sellspec`.`warranty` AS `warranty`,`sellspec`.`info_content` AS `info_content` from ((((`product` left join `sellspec` on(`product`.`prod_id` = `sellspec`.`prod_id`)) left join `brand` on(`product`.`brand_id` = `brand`.`brand_id`)) left join `category` on(`category`.`category_id` = `product`.`category_id`)) left join (select `productimg`.`prod_id` AS `prod_id`,`productimg`.`type` AS `TYPE`,`productimg`.`dir` AS `dir`,`productimg`.`filename` AS `filename` from `productimg`) `productimg` on(`sellspec`.`prod_id` = `productimg`.`prod_id` and `productimg`.`TYPE` = 1)) group by `sellspec`.`prod_id`,`sellspec`.`spec_id` order by `sellspec`.`prod_id`,`sellspec`.`spec_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_products_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_products_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_products_info` AS select `product`.`prod_id` AS `prod_id`,`sellspec`.`spec_id` AS `spec_id`,`product`.`user_id` AS `seller_id`,`product`.`brand_id` AS `brand_id`,`product`.`category_id` AS `category_id`,`product`.`prod_name` AS `prod_name`,`sellspec`.`spec_name` AS `spec_name`,`user`.`name` AS `seller_name`,`brand`.`brand` AS `brand`,`category`.`category` AS `category`,`sellspec`.`publish` AS `publish`,`sellspec`.`price` AS `price`,`sellspec`.`stock` AS `stock`,ifnull(`vw_all_order_product_count`.`counts`,0) AS `sales`,`sellspec`.`stock` - ifnull(`vw_all_order_product_count`.`counts`,0) AS `inventory`,ifnull(`vw_product_comment_grade`.`comment_grade`,0) AS `comment_grade`,`sellspec`.`create_time` AS `create_time`,`sellspec`.`update_time` AS `update_time`,ifnull(concat(`productimg`.`dir`,`productimg`.`filename`),'/images/products/defaultImage.jpg') AS `img_src` from (((((((`product` left join `sellspec` on(`product`.`prod_id` = `sellspec`.`prod_id`)) left join `user` on(`user`.`user_id` = `product`.`user_id`)) left join `brand` on(`product`.`brand_id` = `brand`.`brand_id`)) left join `category` on(`category`.`category_id` = `product`.`category_id`)) left join `vw_all_order_product_count` on(`sellspec`.`prod_id` = `vw_all_order_product_count`.`prod_id` and `sellspec`.`spec_id` = `vw_all_order_product_count`.`spec_id`)) left join (select `productimg`.`prod_id` AS `prod_id`,`productimg`.`spec_id` AS `spec_id`,`productimg`.`type` AS `TYPE`,`productimg`.`dir` AS `dir`,`productimg`.`filename` AS `filename` from `productimg`) `productimg` on(`sellspec`.`prod_id` = `productimg`.`prod_id` and `sellspec`.`spec_id` = `productimg`.`spec_id` and `productimg`.`TYPE` = 0)) left join `vw_product_comment_grade` on(`sellspec`.`prod_id` = `vw_product_comment_grade`.`prod_id` and `sellspec`.`spec_id` = `vw_product_comment_grade`.`spec_id`)) group by `sellspec`.`prod_id`,`sellspec`.`spec_id` order by `sellspec`.`prod_id`,`sellspec`.`spec_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-18  8:02:53
