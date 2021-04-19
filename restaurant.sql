-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: restaurant
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bill_food`
--

DROP TABLE IF EXISTS `bill_food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_food` (
  `id_food` int NOT NULL,
  `id_bill` int NOT NULL,
  `num` int NOT NULL,
  PRIMARY KEY (`id_food`,`id_bill`),
  KEY `FK_bill_food2` (`id_bill`),
  CONSTRAINT `FK_bill_food` FOREIGN KEY (`id_food`) REFERENCES `food` (`id_food`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_bill_food2` FOREIGN KEY (`id_bill`) REFERENCES `bills` (`id_bill`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_food`
--

LOCK TABLES `bill_food` WRITE;
/*!40000 ALTER TABLE `bill_food` DISABLE KEYS */;
INSERT INTO `bill_food` VALUES (1,1,2),(1,21,1),(1,22,1),(1,31,3),(1,34,1),(1,43,1),(1,49,6),(1,51,1),(1,53,1),(2,20,1),(2,22,1),(2,23,6),(2,26,5),(2,41,4),(2,43,1),(2,45,4),(2,47,5),(2,48,5),(3,1,1),(3,24,1),(3,30,4),(3,34,2),(4,1,1),(4,18,1),(4,19,1),(4,24,2),(4,50,4),(5,1,2),(5,18,1),(5,19,1),(5,24,4),(5,28,3),(5,31,4),(5,52,1),(5,53,1),(6,29,6),(6,45,2),(7,19,1),(7,27,1),(7,42,5),(7,46,6),(8,20,1),(8,24,1),(8,29,1),(8,31,1),(8,53,1);
/*!40000 ALTER TABLE `bill_food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `id_bill` int NOT NULL,
  `id_table` int NOT NULL,
  `id_member` int DEFAULT NULL,
  `time_order` datetime NOT NULL,
  `time_pay` datetime DEFAULT NULL,
  `money` int NOT NULL,
  PRIMARY KEY (`id_bill`),
  KEY `FK_bill_member` (`id_member`),
  KEY `FK_table_bill` (`id_table`),
  KEY `time_order` (`time_order`),
  CONSTRAINT `FK_bill_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_table_bill` FOREIGN KEY (`id_table`) REFERENCES `tables` (`id_table`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,1,1,'2021-03-21 21:21:22','2021-03-21 22:21:22',375),(2,3,NULL,'2021-03-23 21:21:22',NULL,50),(18,2,NULL,'2021-04-15 20:36:45',NULL,126),(19,1,NULL,'2021-04-15 20:37:51',NULL,130),(20,4,NULL,'2021-04-15 20:38:58',NULL,46),(21,3,NULL,'2021-04-15 20:40:43',NULL,30),(22,2,NULL,'2021-04-15 20:41:41',NULL,58),(23,1,NULL,'2021-04-15 20:52:17',NULL,168),(24,4,NULL,'2021-04-15 21:15:34','2021-04-15 21:15:43',494),(25,2,NULL,'2021-04-15 21:16:56',NULL,0),(26,4,NULL,'2021-04-15 21:17:19','2021-04-15 21:17:23',140),(27,4,NULL,'2021-04-15 21:18:06',NULL,4),(28,3,NULL,'2021-04-15 21:18:37','2021-04-15 21:18:41',264),(29,3,NULL,'2021-04-15 21:19:16','2021-04-15 21:19:21',36),(30,3,NULL,'2021-04-15 21:19:39','2021-04-15 21:19:42',192),(31,1,NULL,'2021-04-15 21:31:42','2021-04-15 21:31:50',460),(32,3,NULL,'2021-04-15 22:41:34',NULL,0),(33,3,NULL,'2021-04-18 19:33:02',NULL,0),(34,4,NULL,'2021-04-18 19:45:49','2021-04-18 19:46:38',126),(35,2,NULL,'2021-04-18 19:55:06',NULL,0),(36,1,NULL,'2021-04-18 19:56:44',NULL,0),(37,4,NULL,'2021-04-18 19:57:37',NULL,0),(38,3,NULL,'2021-04-18 19:58:23',NULL,0),(39,4,NULL,'2021-04-18 19:58:32',NULL,0),(40,2,NULL,'2021-04-18 19:58:48','2021-04-18 19:59:23',0),(41,2,NULL,'2021-04-18 20:04:06','2021-04-18 20:04:09',112),(42,2,NULL,'2021-04-18 20:04:19','2021-04-18 20:04:23',20),(43,2,NULL,'2021-04-18 20:24:41',NULL,58),(44,1,NULL,'2021-04-18 20:34:26',NULL,0),(45,3,NULL,'2021-04-18 20:34:41','2021-04-18 20:34:46',118),(46,4,NULL,'2021-04-18 20:35:42','2021-04-18 20:35:46',24),(47,3,NULL,'2021-04-18 20:36:56','2021-04-18 20:36:58',140),(48,4,NULL,'2021-04-18 20:37:39','2021-04-18 20:37:41',140),(49,2,NULL,'2021-04-18 20:37:59','2021-04-18 20:38:02',180),(50,3,NULL,'2021-04-18 20:39:00','2021-04-18 20:39:04',152),(51,3,NULL,'2021-04-18 20:39:30','2021-04-18 20:39:32',30),(52,2,NULL,'2021-04-18 20:40:21','2021-04-18 20:40:26',88),(53,3,NULL,'2021-04-19 15:25:20','2021-04-19 15:42:30',136);
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category` char(20) NOT NULL,
  PRIMARY KEY (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('川菜'),('湘菜'),('甜品'),('粤菜');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id_discount` int NOT NULL,
  `off_price` int NOT NULL,
  `require_points` int NOT NULL,
  PRIMARY KEY (`id_discount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (1,5,150),(2,10,250),(3,20,450);
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp`
--

DROP TABLE IF EXISTS `emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp` (
  `id_emp` int NOT NULL,
  `id_server` int DEFAULT NULL,
  `name_emp` char(20) NOT NULL,
  `sex_emp` char(1) DEFAULT NULL,
  `phone_num` char(11) DEFAULT NULL,
  `position` char(20) DEFAULT NULL,
  PRIMARY KEY (`id_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp`
--

LOCK TABLES `emp` WRITE;
/*!40000 ALTER TABLE `emp` DISABLE KEYS */;
INSERT INTO `emp` VALUES (1,1,'Moly','M','13345677654','server'),(2,2,'Jess','M','13645677654','server'),(3,NULL,'张三','M','13222222222','cook');
/*!40000 ALTER TABLE `emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `id_food` int NOT NULL,
  `category` char(20) NOT NULL,
  `name_food` char(20) NOT NULL,
  `introduction` char(100) DEFAULT NULL,
  `price` int NOT NULL,
  `url` char(100) DEFAULT NULL,
  PRIMARY KEY (`id_food`),
  KEY `FK_food_category` (`category`),
  CONSTRAINT `FK_food_category` FOREIGN KEY (`category`) REFERENCES `categories` (`category`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'川菜','麻婆豆腐',NULL,30,NULL),(2,'川菜','麻辣相干',NULL,28,NULL),(3,'湘菜','小炒肉',NULL,48,NULL),(4,'粤菜','白切鸡',NULL,38,NULL),(5,'粤菜','鱼子酱沙拉',NULL,88,NULL),(6,'甜品','可口可乐',NULL,3,NULL),(7,'甜品','维维豆奶',NULL,4,NULL),(8,'甜品','老八小汉堡',NULL,18,NULL);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `food_sales`
--

DROP TABLE IF EXISTS `food_sales`;
/*!50001 DROP VIEW IF EXISTS `food_sales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `food_sales` AS SELECT 
 1 AS `name_food`,
 1 AS `sum(num)`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `food_time_sales`
--

DROP TABLE IF EXISTS `food_time_sales`;
/*!50001 DROP VIEW IF EXISTS `food_time_sales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `food_time_sales` AS SELECT 
 1 AS `sum(money)`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id_member` int NOT NULL,
  `name_member` char(20) DEFAULT NULL,
  `points` int NOT NULL,
  `sex` char(1) DEFAULT NULL,
  `phone_num` char(11) DEFAULT NULL,
  PRIMARY KEY (`id_member`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'SHAB',790,NULL,NULL),(3,NULL,30,NULL,NULL),(4,NULL,112,NULL,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_point_bill`
--

DROP TABLE IF EXISTS `member_point_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_point_bill` (
  `id_point_bill` int NOT NULL,
  `id_member` int NOT NULL,
  `time_point` datetime NOT NULL,
  `point` int NOT NULL,
  `note` char(20) DEFAULT NULL,
  PRIMARY KEY (`id_point_bill`),
  KEY `FK_member_point_bill` (`id_member`),
  CONSTRAINT `FK_member_point_bill` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_point_bill`
--

LOCK TABLES `member_point_bill` WRITE;
/*!40000 ALTER TABLE `member_point_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_point_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `sales_time`
--

DROP TABLE IF EXISTS `sales_time`;
/*!50001 DROP VIEW IF EXISTS `sales_time`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sales_time` AS SELECT 
 1 AS `sum(money)`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servers` (
  `id_server` int NOT NULL,
  `id_emp` int NOT NULL,
  PRIMARY KEY (`id_server`),
  KEY `FK_to_server` (`id_emp`),
  CONSTRAINT `FK_to_server` FOREIGN KEY (`id_emp`) REFERENCES `emp` (`id_emp`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servers`
--

LOCK TABLES `servers` WRITE;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
INSERT INTO `servers` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
  `id_table` int NOT NULL,
  `id_server` int NOT NULL,
  `num_people` int NOT NULL,
  `id_bill` int DEFAULT NULL,
  `id_member` int DEFAULT NULL,
  PRIMARY KEY (`id_table`),
  KEY `FK_server_table` (`id_server`),
  CONSTRAINT `FK_server_table` FOREIGN KEY (`id_server`) REFERENCES `servers` (`id_server`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1,1,4,NULL,NULL),(2,1,4,NULL,NULL),(3,2,2,NULL,NULL),(4,2,8,NULL,NULL);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `food_sales`
--

/*!50001 DROP VIEW IF EXISTS `food_sales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `food_sales` AS select `food`.`name_food` AS `name_food`,sum(`bill_food`.`num`) AS `sum(num)` from (`bill_food` join `food`) where (`food`.`id_food` = `bill_food`.`id_food`) group by `food`.`id_food` order by sum(`bill_food`.`num`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `food_time_sales`
--

/*!50001 DROP VIEW IF EXISTS `food_time_sales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `food_time_sales` AS select sum(`bills`.`money`) AS `sum(money)` from `bills` group by `bills`.`time_pay` order by sum(`bills`.`money`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sales_time`
--

/*!50001 DROP VIEW IF EXISTS `sales_time`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sales_time` AS select sum(`bills`.`money`) AS `sum(money)` from `bills` where (`bills`.`time_pay` between '2020.01.01' and '2021.01.01') */;
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

-- Dump completed on 2021-04-19 17:11:05
