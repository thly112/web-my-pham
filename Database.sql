-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: cosmeticstore
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `accountId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `mail` varchar(30) DEFAULT NULL,
  `roleId` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `code` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`accountId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'user','1','admin@example.com',1,1,'123456'),(2,'admin','1','user1@example.com',2,1,'789012'),(3,'seller','1','user2@example.com',3,1,'345678'),(4,'shipper','1','user3@example.com',4,1,'901234'),(5,'admin2','1','user4@example.com',2,1,'567890'),(6,'seller2','1','user5@example.com',3,1,'123456');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cartId` int NOT NULL AUTO_INCREMENT,
  `customerId` int DEFAULT NULL,
  `totalPrice` float DEFAULT NULL,
  PRIMARY KEY (`cartId`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1,100000),(2,2,200000),(3,3,300000),(4,4,400000),(5,5,500000),(6,6,600000),(7,7,700000),(8,8,800000),(9,9,900000),(10,10,1000000),(11,11,1100000),(12,12,1200000),(13,13,1300000),(14,14,1400000),(15,15,1500000),(16,16,1600000),(17,17,1700000),(18,18,1800000),(19,19,1900000),(20,20,2000000);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `cartId` int NOT NULL,
  `productId` int NOT NULL,
  `quantity` int NOT NULL,
  `totalPrice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cartId`,`productId`),
  KEY `fk_product` (`productId`),
  CONSTRAINT `fk_cart` FOREIGN KEY (`cartId`) REFERENCES `cart` (`cartId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (2,2,2,100000.00),(3,3,3,150000.00),(4,4,4,200000.00),(5,5,5,250000.00),(6,6,6,300000.00),(7,7,7,350000.00),(8,8,8,400000.00),(9,2,1,50000.00),(10,3,2,100000.00),(11,4,3,150000.00),(12,5,4,200000.00),(13,6,5,250000.00),(14,7,6,300000.00),(15,8,7,350000.00),(16,9,8,400000.00),(17,1,1,50000.00),(18,2,2,100000.00),(19,3,3,150000.00),(20,4,4,200000.00);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(100) DEFAULT NULL,
  `imageURL` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Mỹ phẩm trang điểm','https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=14905c08-2eca-4d9d-9efa-8491009f8a50&w=450&q=70'),(2,'Mỹ phẩm chăm sóc da','https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=772b8b8b-a1cb-47d6-9dd5-8093619f3f81&w=450&q=70'),(3,'Mỹ phẩm chăm sóc tóc','https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=9c8196fd-d25e-4f81-a06d-529d668a4c5e&w=450&q=70'),(4,'Mỹ phẩm chăm sóc cơ thể','https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=7f531254-21fa-4de5-8777-1abc5b0527bd&w=450&q=70'),(5,'Mỹ phẩm nam','https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=7c17707e-0b02-47f1-b746-f1989c783716&w=450&q=70'),(6,'Mỹ phẩm trẻ em','https://media-cdn.oriflame.com/productImage?externalMediaId=product-management-media%2F35775%2F35775.png%3Fversion%3D1643398202&w=231&bc=%23f5f5f5&ib=%23f5f5f5&h=231&q=90'),(7,'Mỹ phẩm hữu cơ','https://media-cdn.oriflame.com/productImage?externalMediaId=product-management-media%2F29690%2F29690.png%3Fversion%3D1594228110&w=231&bc=%23f5f5f5&ib=%23f5f5f5&h=231&q=90'),(8,'Phụ kiện','https://media-asia-cdn.oriflame.com/contentImage?externalMediaId=cf78bea7-06c0-49c7-9b0b-e267fd419836&w=450&q=70');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerId` int NOT NULL AUTO_INCREMENT,
  `customerName` varchar(100) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `reputation` int DEFAULT '0',
  `rewardPoints` int DEFAULT '0',
  `accountId` int DEFAULT NULL,
  PRIMARY KEY (`customerId`),
  KEY `accountId` (`accountId`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `account` (`accountId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Nguyễn Văn An','1990-01-01','Nam','Số 10, đường Nguyễn Trãi, thành phố Mỹ Tho, tỉnh Tiền Giang','0987654321','nguyenvanan@gmail.com','Khách hàng mới',0,0,1),(2,'Trần Thị My','1991-02-02','Nữ','Số 20, đường Lê Lợi, quận 7, TP.HCM','0998765432','tranthimy@gmail.com','Khách hàng thân thiết',5,100,1),(3,'Lê Quang Chung','1992-03-03','Nam','Số 30, đường Hùng Vương, quận Bình Tân, thành phố Hồ Chí Minh','0909765432','lequangchung@gmail.com','Khách hàng VIP',10,200,1),(4,'Đỗ Thị Diệu','1993-04-04','Nữ','Số 40, đường Trần Phú, thành phố Bến Tre, tỉnh Bến Tre','0911765432','dothidieu@gmail.com','Khách hàng mới',0,0,1),(5,'Huỳnh Văn Én','1994-05-05','Nam','Số 50, đường Nguyễn Huệ, thành phố Mỹ Tho, tỉnh Tiền Giang','0922765432','huynhvanen@gmail.com','Khách hàng thân thiết',5,100,1),(6,'Phan Thị Trúc','1995-06-06','Nữ','Số 60, đường Ba Tháng Hai, quận Ninh Kiều, thành phố Cần Thơ','0933765432','phanthitruc@gmail.com','Khách hàng VIP',10,200,1),(7,'Nguyễn Thị Ngân','1996-07-07','Nữ','Số 70, đường Lê Văn Duyệt, thành phố Mỹ Tho, tỉnh Tiền Giang','0944765432','nguyenthingan@gmail.com','Khách hàng mới',0,0,1),(8,'Trương Văn Hải','1997-08-08','Nam','Số 80, đường Lý Thường Kiệt, huyện Cao Lãnh, tỉnh Đồng Tháp','0955765432','truongvanhai@gmail.com','Khách hàng thân thiết',5,100,1),(9,'Lý Thị Ngọc','1998-09-09','Nữ','Số 90, đường Nguyễn Văn Trỗi, huyện Phụng Hiệp, tỉnh Hậu Giang','0966765432','lythingoc@gmail.com','Khách hàng VIP',10,200,1),(10,'Trần Văn Bình','1999-10-10','Nam','Số 100, đường Quang Trung, quận 10, TP.HCM','0977765432','tranvanbinh@gmail.com','Khách hàng mới',0,0,1),(11,'Nguyễn Thị Thu','2000-11-11','Nữ','Số 110, đường Cách Mạng Tháng Tám, quận 1, TP.HCM','0988765432','nguyenthithu@gmail.com','Khách hàng thân thiết',5,100,1),(12,'Lê Văn Tâm','2001-12-12','Nam','Số 120, đường Lê Duẩn, thành phố Nha Trang, tỉnh Khánh Hòa','0999765432','levantam@gmail.com','Khách hàng VIP',10,200,1),(13,'Phạm Thị Hương','2002-01-01','Nữ','Số 130, đường Ngô Gia Tự, thành phố Hồ Chí Minh','0901765432','phamthihuong@gmail.com','Khách hàng mới',0,0,1),(14,'Hoàng Văn Hòa','2003-02-02','Nam','Số 140, đường Lê Thánh Tông, quận Cẩm Lệ, thành phố Đà Nẵng','0912765432','hoangvanhoa@gmail.com','Khách hàng thân thiết',5,100,1),(15,'Mai Thị Quỳnh','2004-03-03','Nữ','Số 150, đường Nguyễn Chí Thanh, quận Bắc Từ Liêm, Hà Nội','0923765432','maithiquynh@gmail.com','Khách hàng VIP',10,200,1),(16,'Ngô Văn Hiển','2005-04-04','Nam','Số 160, đường Trần Hưng Đạo, thành phố Vinh, tỉnh Nghệ An','0934765432','ngovanhien@gmail.com','Khách hàng mới',0,0,1),(17,'Dương Thị Hoài','2006-05-05','Nữ','Số 170, đường Nguyễn Trãi, quận Thanh Xuân, Hà Nội','0945765432','duongthihoai@gmail.com','Khách hàng thân thiết',5,100,1),(18,'Võ Văn Tài','2007-06-06','Nam','Số 180, đường Lý Tự Trọng, thành phố Vũng Tàu, tỉnh Bà Rịa - Vũng Tàu','0956765432','vovantai@gmail.com','Khách hàng VIP',10,200,1),(19,'Hồ Thị Thảo','2008-07-07','Nữ','Số 190, đường Nguyễn Đình Chính, quận Gò Vấp, TP.HCM','0967765432','hothithao@gmail.com','Khách hàng mới',0,0,1),(20,'Đoàn Văn Lâm','2009-08-08','Nam','Số 200, đường Đống Đa, thành phố Huế, tỉnh Thừa Thiên Huế','0978765432','doanvanlam@gmail.com','Khách hàng thân thiết',5,100,1);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employeeId` int NOT NULL AUTO_INCREMENT,
  `employeeName` varchar(100) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `mail` varchar(30) DEFAULT NULL,
  `job` varchar(100) DEFAULT NULL,
  `accountId` int DEFAULT NULL,
  `activityArea` varchar(100) DEFAULT NULL,
  `imageURL` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`employeeId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Nguyễn Văn A','1990-01-01','Nam','Số 10, đường Nguyễn Trãi, quận Tân Bình, thành phố Hồ Chí Minh','0987654321','nguyenvana@gmail.com','Seller',3,'Sales','https://example.com/images/employees/nguyenvanan.jpg'),(2,'Phạm Thị B','1991-08-02','Nữ','Số 20, đường Lê Lợi, huyện Mỏ Cày Nam, tỉnh Bến Tre','0998765234','phamthib@gmail.com','Seller',3,'Sales','https://example.com/images/employees/tranthibu.jpg'),(3,'Trần Quang C','1992-03-03','Nam','Số 30, đường Hùng Vương, huyện Mỹ Xuyên, tỉnh Sóc Trăng','0909765124','tranquangc@gmail.com','Seller',3,'Logistics','https://example.com/images/employees/lequangc.jpg'),(4,'Đỗ Thị D','1993-04-04','Nữ','Số 40, đường Trần Phú, huyện Tân Châu, tỉnh An Giang','0911765453','dothid@gmail.com','Seller',3,'Marketing','https://example.com/images/employees/dothidu.jpg'),(5,'Lý Văn E','1994-12-05','Nam','Số 50, đường Nguyễn Huệ, huyện Kiên Lương, tỉnh Kiên Giang','0922765725','lyvane@gmail.com','Shipper',4,'Administration','https://example.com/images/employees/huynhvane.jpg'),(6,'Phan Thị Fc','1995-04-06','Nữ','Số 60, đường Ba Tháng Hai, huyện Hồng Ngự, tỉnh Đồng Tháp','0933765824','phanthif@gmail.com','Shipper',4,'Finance','https://example.com/images/employees/phanthi.jpg'),(7,'Lý Văn Eq','1994-12-05','Nam','Số 50, đường Nguyễn Huệ, huyện Kiên Lương, tỉnh Kiên Giang','0922765725','lyvane@gmail.com','Shipper',4,'Administration','https://example.com/images/employees/huynhvane.jpg'),(8,'Phan Thị Fe','1995-04-06','Nữ','Số 60, đường Ba Tháng Hai, huyện Hồng Ngự, tỉnh Đồng Tháp','0933765824','phanthif@gmail.com','Shipper',4,'Finance','https://example.com/images/employees/phanthi.jpg'),(9,'Lý Văn EC','1994-12-05','Nam','Số 50, đường Nguyễn Huệ, huyện Kiên Lương, tỉnh Kiên Giang','0922765725','lyvane@gmail.com','Shipper',4,'Administration','https://example.com/images/employees/huynhvane.jpg'),(10,'Phan Thị FE','1995-04-06','Nữ','Số 60, đường Ba Tháng Hai, huyện Hồng Ngự, tỉnh Đồng Tháp','0933765824','phanthif@gmail.com','Shipper',4,'Finance','https://example.com/images/employees/phanthi.jpg');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `importing_goods`
--

DROP TABLE IF EXISTS `importing_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `importing_goods` (
  `productId` int NOT NULL,
  `supplierId` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `importingDate` date DEFAULT NULL,
  `cost` float DEFAULT NULL,
  PRIMARY KEY (`productId`,`supplierId`),
  KEY `supplierId` (`supplierId`),
  CONSTRAINT `importing_goods_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `importing_goods_ibfk_2` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`supplierId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `importing_goods`
--

LOCK TABLES `importing_goods` WRITE;
/*!40000 ALTER TABLE `importing_goods` DISABLE KEYS */;
INSERT INTO `importing_goods` VALUES (1,2,50,'2023-12-07',100000),(1,3,45,'2023-11-16',150000),(1,5,60,'2023-11-26',180000),(2,3,75,'2023-12-05',200000),(2,4,25,'2023-11-25',90000),(2,7,10,'2023-11-15',60000),(3,2,70,'2023-11-14',210000),(3,6,30,'2023-12-04',50000),(4,5,20,'2023-12-03',75000),(4,8,50,'2023-11-23',200000),(4,9,25,'2023-11-13',95000),(5,1,80,'2023-11-22',240000),(5,4,100,'2023-12-02',300000),(5,6,15,'2023-11-12',45000),(6,4,50,'2023-11-11',180000),(6,7,15,'2023-11-21',45000),(6,8,45,'2023-12-01',150000),(7,1,25,'2023-11-30',80000),(7,2,55,'2023-11-20',160000),(7,8,40,'2023-11-10',120000),(8,1,30,'2023-11-09',90000),(8,7,60,'2023-11-29',250000),(8,9,20,'2023-11-19',100000),(9,2,15,'2023-11-28',40000),(9,5,30,'2023-11-18',80000),(10,1,65,'2023-11-17',300000),(10,3,40,'2023-11-27',120000);
/*!40000 ALTER TABLE `importing_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `productId` int NOT NULL,
  `orderId` int NOT NULL,
  `quantity` int NOT NULL,
  `totalPrice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`productId`,`orderId`),
  KEY `fk_order` (`orderId`),
  CONSTRAINT `fk_order` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,1,50000.00),(1,13,2,100000.00),(2,2,2,100000.00),(2,6,1,50000.00),(2,19,1,30000.00),(3,3,3,150000.00),(3,12,4,160000.00),(4,4,4,200000.00),(4,18,2,120000.00),(5,5,5,250000.00),(5,15,2,200000.00),(6,10,2,120000.00),(7,8,3,150000.00),(7,16,1,70000.00),(8,9,2,100000.00),(8,14,3,300000.00),(9,7,3,300000.00),(9,17,3,180000.00),(10,11,1,450000.00),(10,20,4,400000.00);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `orderValue` float DEFAULT NULL,
  `orderDate` datetime DEFAULT NULL,
  `cartId` int DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `paymentStatus` varchar(100) DEFAULT NULL,
  `orderStatus` varchar(100) DEFAULT NULL,
  `paymentMethod` varchar(100) DEFAULT NULL,
  `deliveryMethod` varchar(100) DEFAULT NULL,
  `employeeId` int DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `cartId` (`cartId`),
  KEY `customerId` (`customerId`),
  KEY `employeeId` (`employeeId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `cart` (`cartId`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`employeeId`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,5500000,'2023-01-29 09:10:00',10,10,'Paid','Chưa giao cho shipper','Credit card','Giao hàng tận nơi',7),(2,6000000,'2023-01-28 13:45:00',11,11,'Unpaid','Save','Cash on Delivery','Giao hàng tận nơi',NULL),(3,8000000,'2023-01-24 10:50:00',15,15,'Unpaid','Save','Cash on Delivery','Giao hàng tận nơi',NULL),(4,8500000,'2023-01-23 07:15:00',16,16,'Unpaid','Save','Momo','Giao hàng tận nơi',NULL),(5,9000000,'2023-01-22 23:40:00',17,17,'Paid','Chưa giao cho shipper','Bank transfer','Giao hàng tận nơi',5),(6,6500000,'2023-02-27 18:20:00',12,12,'Paid','Đã giao cho shipper','MoMo','Giao hàng tận nơi',9),(7,7000000,'2023-02-26 21:30:00',13,13,'Unpaid','Save','Bank transfer','Giao hàng tận nơi',NULL),(8,13000000,'2023-02-14 16:15:00',5,5,'Paid','Chưa giao cho shipper','Bank transfer','Giao hàng tận nơi',4),(9,13500000,'2023-02-13 12:00:00',6,6,'Unpaid','Save','Credit card','Giao hàng tận nơi',NULL),(10,14000000,'2023-02-12 09:25:00',7,7,'Paid','Đã giao khách hàng','Cash on delivery','Giao hàng tận nơi',6),(11,7500000,'2023-03-25 14:05:00',14,14,'Paid','Đã giao khách hàng','Credit card','Giao hàng tận nơi',2),(12,8000000,'2023-03-24 10:50:00',15,15,'Unpaid','Save','Cash on Delivery','Giao hàng tận nơi',NULL),(13,11500000,'2023-03-17 08:10:00',2,2,'Unpaid','Save','Credit card','Giao hàng tận nơi',NULL),(14,12000000,'2023-03-16 02:35:00',3,3,'Paid','Đã giao khách hàng','Cash on delivery','Giao hàng tận nơi',2),(15,12500000,'2023-03-15 19:50:00',4,4,'Unpaid','Save','Momo','Giao hàng tận nơi',NULL),(16,8500000,'2023-04-23 07:15:00',16,16,'Unpaid','Save','Momo','Giao hàng tận nơi',NULL),(17,9000000,'2023-04-22 23:40:00',17,17,'Paid','Chưa giao cho shipper','Bank transfer','Giao hàng tận nơi',5),(18,13000000,'2023-04-14 16:15:00',5,5,'Paid','Chưa giao cho shipper','Bank transfer','Giao hàng tận nơi',4),(19,13500000,'2023-04-13 12:00:00',6,6,'Unpaid','Save','Credit card','Giao hàng tận nơi',NULL),(20,14000000,'2023-04-12 09:25:00',7,7,'Paid','Đã giao khách hàng','Cash on delivery','Giao hàng tận nơi',6),(21,9500000,'2023-05-21 17:25:00',18,18,'Unpaid','Save','Credit card','Giao hàng tận nơi',NULL),(22,10000000,'2023-05-20 20:35:00',19,19,'Paid','Đã giao khách hàng','Cash on delivery','Giao hàng tận nơi',7),(23,10500000,'2023-06-19 15:00:00',20,20,'Unpaid','Save','MoMo','Giao hàng tận nơi',NULL),(24,11000000,'2023-06-18 11:45:00',1,1,'Paid','Chưa giao cho shipper','Bank transfer','Giao hàng tận nơi',9),(25,11500000,'2023-07-17 08:10:00',2,2,'Unpaid','Save','Credit card','Giao hàng tận nơi',NULL),(26,12000000,'2023-07-16 02:35:00',3,3,'Paid','Đã giao khách hàng','Cash on delivery','Giao hàng tận nơi',2),(27,12500000,'2023-08-15 19:50:00',4,4,'Unpaid','Save','Momo','Giao hàng tận nơi',NULL),(28,13000000,'2023-08-14 16:15:00',5,5,'Paid','Chưa giao cho shipper','Bank transfer','Giao hàng tận nơi',4),(29,13500000,'2023-09-13 12:00:00',6,6,'Unpaid','Save','Credit card','Giao hàng tận nơi',NULL),(30,14000000,'2023-09-12 09:25:00',7,7,'Paid','Đã giao khách hàng','Cash on delivery','Giao hàng tận nơi',6),(31,14500000,'2023-10-11 05:50:00',8,8,'Unpaid','Save','MoMo','Giao hàng tận nơi',NULL),(32,15000000,'2023-10-10 22:15:00',9,9,'Paid','Chưa giao cho shipper','Bank transfer','Giao hàng tận nơi',8),(33,5500000,'2023-12-29 09:10:00',10,10,'Paid','Chưa giao cho shipper','Credit card','Giao hàng tận nơi',7),(34,14500000,'2023-11-11 05:50:00',8,8,'Unpaid','Save','MoMo','Giao hàng tận nơi',NULL),(35,6000000,'2023-12-28 13:45:00',11,11,'Unpaid','Save','Cash on Delivery','Giao hàng tận nơi',NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(100) DEFAULT NULL,
  `description` text,
  `stock` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `categoryId` int DEFAULT NULL,
  `imageURL` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`productId`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Kem nền Maybelline Superstay 24H','Kem nền dạng lỏng, độ che phủ cao, lâu trôi trong 24h',100,1000,250000,1,'https://image.hsv-tech.io/1387x0/bbx/maybelline_superstay_24h_full_coverage_foundation_112_c835b7d5a58c413db58a9dca04c2d682.png'),(2,'Son lì MAC Retro Matte Lipstick','Son lì dạng thỏi, lâu trôi, lên màu chuẩn',50,500,300000,2,'https://product.hstatic.net/200000066044/product/mac02.707-son-thoi-li-mac-retro-matte-lipstick-3g_a9dfe87e75be459d943472718ded3982.jpg'),(3,'Mặt nạ giấy Innisfree It is Real Squeeze Mask','Mặt nạ giấy dạng miếng, cấp ẩm, làm sáng da',200,2000,150000,1,'https://cf.shopee.vn/file/2f620f00bdc91053d85819205dde739b'),(4,'Sữa rửa mặt Cetaphil Gentle Skin Cleanser','Sữa rửa mặt dịu nhẹ, không gây kích ứng da',1000,10000,200000,1,'https://product.hstatic.net/1000360941/product/sua-rua-mat-da-nhay-cam-centaphil_446a407e24c141faa68bb6b63a883980_master.jpg'),(5,'Dầu gội đầu Dove Deeply Nourishing Shampoo','Dầu gội đầu dưỡng ẩm, giúp tóc mềm mượt',500,5000,250000,3,'https://cdn-images.kiotviet.vn/shopthaovy/047e62d35c1c4bfca5a29b75e6713126.jpeg'),(6,'Sữa tắm The Body Shop Shea Butter Body Wash','Sữa tắm dưỡng ẩm, giúp da mềm mượt',1000,10000,300000,4,'https://www.thebodyshop.com.vn/img/resize/565?url=%2Fpub/media%2Fcatalog%2Fproduct%2Fc%2Fo%2Fcondition-shea-250ml-1.jpg'),(7,'Kem chống nắng La Roche-Posay Anthelios Shaka Fluid SPF50+','Kem chống nắng dạng lỏng, chống thấm nước, bảo vệ da khỏi tia UV',200,2000,500000,1,'https://nhathuoc365.vn/images/products/2020/03/27/original/kem-chong-nang-anthelios-shaka-fluid-spf50-la-roche-posay-50-ml-1585308214.jpg'),(8,'Nước hoa Dior Sauvage Eau de Parfum','Nước hoa nam, hương gỗ thơm nồng, nam tính',100,1000,600000,5,'https://classic.vn/wp-content/uploads/2022/02/dior-sauvage-eau-de-parfume.webp'),(9,'Sữa tắm gội cho bé Johnsons Baby Cotton Touch','Sữa tắm gội cho bé dịu nhẹ, không gây kích ứng da',500,5000,200000,6,'https://down-vn.img.susercontent.com/file/9681231fddf0d737a2a4fc126ff2f876'),(10,'Kem chống nắng Bioré UV Aqua Rich Watery Essence SPF50+ PA++++','Kem chống nắng dạng gel, thấm nhanh, không gây nhờn rít',200,2000,450000,1,'https://mint07.com/wp-content/uploads/2015/07/biore-watery-essence.jpeg'),(11,'Mascara Maybelline Lash Sensational','Mascara tạo mi dày, cong vút, không vón cục',150,1500,180000,1,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1xCYZHkDTXffI3ZMgzths6GWRgkE5WSg14q57MM1Bi3T5RyysmnA63APAR4Ym7klQGIA&usqp=CAU'),(12,'Kem chống nắng Neutrogena Ultra Sheer Dry-Touch SPF 100+','Kem chống nắng dạng kem, không gây bết dính, chống tia UVB/UVA',120,1200,300000,1,'https://hanguc247.com/wp-content/uploads/2022/11/kem-ch%E1%BB%91ng-n%E1%BA%AFng-neutrogena-ultra-sheer-1.jpg'),(13,'Son dưỡng môi Burt\'s Bees Beeswax Lip Balm','Son dưỡng môi tự nhiên, giữ ẩm cho đôi môi mềm mại',200,2000,80000,1,'https://cdn.vuahanghieu.com/unsafe/0x900/left/top/smart/filters:quality(90)/https://admin.vuahanghieu.com/upload/product/2022/03/son-duong-moi-burt-s-bees-beeswax-lip-balm-with-vitamin-e-peppermint-4-25g-622b18e3cef9c-11032022163947.jpg'),(14,'Nước tẩy trang Micellar Water Garnier','Nước tẩy trang dạng micellar, làm sạch nhẹ nhàng',250,2500,120000,2,'https://adminbeauty.hvnet.vn/Upload/Files/a1-02112018044051.jpg'),(15,'Tẩy trang mắt Lancome Bi-Facil Double-Action Eye Makeup Remover','Tẩy trang mắt kép lớp, loại bỏ mọi vết trang điểm',100,1000,250000,2,'https://chiaki.vn/upload/product/2023/08/dung-dich-tay-trang-mat-moi-lancome-bi-facil-double-action-eye-makeup-remover-64d49cfb5968d-10082023151659.jpg'),(16,'Gel tắm gội nam Dove Men+Care Clean Comfort','Gel tắm gội 2 trong 1, làm sạch da và tóc nam giới',300,3000,180000,3,'https://bizweb.dktcdn.net/100/344/652/products/13g.jpg?v=1669038678457'),(17,'Kem chống nám Olay White Radiance','Kem chống nám dưỡng trắng da, giảm tình trạng tăng sắc tố',150,1500,350000,4,'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/products/P21180_1_l.webp'),(18,'Nước hoa nữ Chanel Chance Eau Tendre','Nước hoa nữ, hương hoa quả nhẹ nhàng, tinh tế',80,800,900000,5,'https://bizweb.dktcdn.net/100/429/123/products/nuoc-hoa-nu-chinh-hang-chanel-chance-eau-tendre-edt.jpg?v=1647667387937'),(19,'Kem chống nám Sakura White Pinkish Radiance','Kem chống nám dưỡng trắng da, chứa chiết xuất từ hoa anh đào',180,1800,280000,4,'https://shopmuanhanh.com/admincp/sanpham/HinhAnh/kem-duong-trang-da-garnier-sakura-white-spf21-thai-lan-20200302235944309.png'),(20,'Son môi YSL Rouge Pur Couture','Son lì màu sắc tươi tắn, bền màu suốt thời gian',120,1200,450000,1,'https://mint07.com/wp-content/uploads/2020/11/son-ysl-rouge-pur-couture.jpg'),(21,'Kem dưỡng ẩm Neutrogena Hydro Boost Water Gel','Kem dưỡng ẩm làm mềm mại và tái tạo làn da',250,2500,200000,2,'https://cdn.nhathuoclongchau.com.vn/unsafe/https://cms-prod.s3-sgn09.fptcloud.com/00501475_kem_duong_am_neutrogena_hydro_boost_water_gel_50g_7703_630e_large_90af6742b2.jpg'),(22,'Má hồng Milani Baked Blush','Má hồng nung, tạo điểm nhấn, lâu trôi',100,1000,160000,1,'https://cf.shopee.vn/file/7e9a1e0c747f0855e0aae463cb7a4c62'),(23,'Sữa rửa mặt Neutrogena Deep Clean Facial Cleanser','Sữa rửa mặt sâu lỗ chân lông, làm sạch dầu và bã nhờn',180,1800,150000,2,'https://product.hstatic.net/200000061028/product/3021178_1_8e4645df38314362876b6857f0cb88fa_1024x1024.jpg'),(24,'Kem chống nắng Shiseido Perfect UV Protector SPF50+ PA++++','Kem chống nắng chống tia UV, làm dịu và dưỡng ẩm da',150,1500,420000,1,'https://www.shiseido.com.vn/dw/image/v2/BCSK_PRD/on/demandware.static/-/Sites-itemmaster_shiseido/default/dw5c93bc5f/images/SAPAC/20SS/15678.jpg?sw=1400&sh=1400&sm=fit'),(25,'Tẩy tế bào chết toàn thân The Body Shop Spa of the World','Tẩy tế bào chết cả body, giúp da trở nên mềm mại',120,1200,250000,4,'https://img.sosanhgia.com/images/500x0/a818b0e8643c4278b4c8090ada7830c0/tay-te-bao-chet-the-body-shop-spa-of-the-world-french-grape-seed-scrub-350ml.jpeg'),(26,'Son lót Innisfree No Sebum Blur Primer','Son lót kiểm soát dầu, làm mờ lỗ chân lông',200,2000,120000,1,'https://www.innisfree.vn/m/static/upload/product/product/247_ID0101_1.jpg'),(27,'Son môi ColourPop Ultra Matte Lip','Son lì màu sắc tươi tắn, siêu bền màu',100,1000,100000,1,'https://product.hstatic.net/200000041750/product/son-kem-li-colourpop-ultra-matte-lips-love-bug_82e619fd15174be59fc4bdc215994df7_master.jpg'),(28,'Kem chống nám Hada Labo Shirojyun Premium Whitening Essence','Kem dưỡng trắng chống nám, tái tạo làn da từ bên trong',180,1800,300000,4,'https://bizweb.dktcdn.net/100/257/549/products/kem-duong-trang-da-cao-cap-hada-labo-shirojyun-premium-medicated-deep-whitening-cream-nhat-ban-04.jpg?v=1587727888477'),(29,'Nước hoa nam Calvin Klein Eternity for Men','Nước hoa nam, hương thơm tinh tế, nam tính',80,800,700000,5,'https://hangtieudungmy.com.vn/image/cache/catalog/nuoc-hoa-nam-ck-eternity-for-men-800x800.jpg'),(30,'Sữa rửa mặt La Roche-Posay Effaclar Purifying Foaming Gel','Sữa rửa mặt chứa nước khoáng, làm sạch sâu cho da dầu mụn',120,1200,250000,2,'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/products/P09671_1_l.webp');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `ratingId` int NOT NULL AUTO_INCREMENT,
  `productId` int DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `review` text,
  `reviewDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ratingId`),
  KEY `productId` (`productId`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (1,1,1,5,'Great product!','2022-12-31 17:00:00'),(2,1,2,4,'Good service.','2023-01-01 17:00:00'),(3,1,3,3,'Average experience.','2023-01-02 17:00:00'),(4,1,4,5,'Amazing!','2023-01-03 17:00:00'),(5,1,5,4,'Satisfied.','2023-01-04 17:00:00'),(6,1,6,2,'Disappointed.','2023-01-05 17:00:00'),(7,1,7,5,'Highly recommended!','2023-01-06 17:00:00'),(8,1,8,4,'Quick delivery.','2023-01-07 17:00:00'),(9,1,9,3,'Needs improvement.','2023-01-08 17:00:00'),(10,1,10,5,'Excellent!','2023-01-09 17:00:00'),(11,2,1,4,'Satisfied.','2023-01-04 17:00:00'),(12,2,2,2,'Disappointed.','2023-01-05 17:00:00'),(13,2,12,5,'Highly recommended!','2023-01-06 17:00:00'),(14,10,1,4,'Quick delivery.','2023-01-07 17:00:00'),(15,10,2,3,'Needs improvement.','2023-01-08 17:00:00'),(16,10,12,5,'Excellent!','2023-01-09 17:00:00');
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplierId` int NOT NULL AUTO_INCREMENT,
  `supplierName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`supplierId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Mỹ phẩm ABC'),(2,'Công ty TNHH SX-TM Mỹ phẩm XYZ'),(3,'Công ty CP Mỹ phẩm Hàn Quốc K-Beauty'),(4,'Công ty TNHH MTV Mỹ phẩm Pháp L\"Oreal'),(5,'Công ty Cổ phần Mỹ phẩm Nhật Bản Shiseido'),(6,'Công ty TNHH MTV Mỹ phẩm Mỹ Maybelline'),(7,'Công ty Cổ phần Mỹ phẩm Thái Lan Mistine'),(8,'Nhà phân phối Mỹ phẩm A Cosmetics'),(9,'Công ty TNHH Xuất nhập khẩu Mỹ phẩm B Beauty'),(10,'Công ty Cổ phần Mỹ phẩm Việt Nam Queenie');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-02 21:31:46
