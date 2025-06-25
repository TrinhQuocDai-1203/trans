-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: transport
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `buses`
--

DROP TABLE IF EXISTS `buses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `busType` varchar(255) NOT NULL,
  `capacity` int NOT NULL,
  `licensePlate` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buses`
--

LOCK TABLES `buses` WRITE;
/*!40000 ALTER TABLE `buses` DISABLE KEYS */;
INSERT INTO `buses` VALUES (1,'Xe giường nằm',12,'77G1-88611');
/*!40000 ALTER TABLE `buses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pickup_points`
--

DROP TABLE IF EXISTS `pickup_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pickup_points` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pickup_points`
--

LOCK TABLES `pickup_points` WRITE;
/*!40000 ALTER TABLE `pickup_points` DISABLE KEYS */;
INSERT INTO `pickup_points` VALUES (1,'Cầu Bà Di, Tuy Phước, Bình Định','Tỉnh Bình Định','','Cầu Bà Di'),(2,'Abc,123,122','Tỉnh Hưng Yên','','ABC'),(3,'UUU','Tỉnh Bắc Ninh','','UUU');
/*!40000 ALTER TABLE `pickup_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route_stops`
--

DROP TABLE IF EXISTS `route_stops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route_stops` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `estimatedTimeFromStart` int DEFAULT NULL,
  `stopName` varchar(255) NOT NULL,
  `stopOrder` int DEFAULT NULL,
  `trip_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcki4fgn1y4glbwouro8ev0c3x` (`trip_id`),
  CONSTRAINT `FKcki4fgn1y4glbwouro8ev0c3x` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route_stops`
--

LOCK TABLES `route_stops` WRITE;
/*!40000 ALTER TABLE `route_stops` DISABLE KEYS */;
/*!40000 ALTER TABLE `route_stops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seats` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `isBooked` bit(1) NOT NULL,
  `seatNumber` varchar(255) NOT NULL,
  `trip_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4vm7xuvuh00qp354d1vywnqu2` (`trip_id`),
  CONSTRAINT `FK4vm7xuvuh00qp354d1vywnqu2` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
INSERT INTO `seats` VALUES (25,_binary '','T1-S2',4);
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bookingDate` datetime(6) NOT NULL,
  `pickupLocation` varchar(255) NOT NULL,
  `price` double DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `seat_id` bigint DEFAULT NULL,
  `trip_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1f6n3pv4b80wl6gj4ra32ctxk` (`seat_id`),
  KEY `FKbcjlnu2low7r5vfimxextqab9` (`trip_id`),
  KEY `FK4eqsebpimnjen0q46ja6fl2hl` (`user_id`),
  CONSTRAINT `FK1f6n3pv4b80wl6gj4ra32ctxk` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`id`),
  CONSTRAINT `FK4eqsebpimnjen0q46ja6fl2hl` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKbcjlnu2low7r5vfimxextqab9` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (2,'2025-05-21 12:45:30.896000','UUU',100000,'PAID',25,4,4);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trips` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `arrivalTime` datetime(6) DEFAULT NULL,
  `availableSeats` int DEFAULT NULL,
  `departureLocation` varchar(255) NOT NULL,
  `departureTime` datetime(6) NOT NULL,
  `destinationLocation` varchar(255) NOT NULL,
  `pickupPoint` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `bus_id` bigint DEFAULT NULL,
  `primary_driver_id` bigint DEFAULT NULL,
  `secondary_driver_id` bigint DEFAULT NULL,
  `pickup_point_id` bigint DEFAULT NULL,
  `departure_point_id` bigint DEFAULT NULL,
  `destination_point_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2vg7b2xayoq4ogt2kbsot4juq` (`bus_id`),
  KEY `FK6sb18ndb6dc6jh49u7dlp5yp3` (`primary_driver_id`),
  KEY `FKm96d7e2d7xpb7wt42eis7vgnq` (`secondary_driver_id`),
  KEY `FKc5vmjbyraaxskq39sy5xlxcyl` (`pickup_point_id`),
  KEY `FKbg85ulk7yir47gssmoepde4wk` (`departure_point_id`),
  KEY `FK93pkx1oftwqcypyyvg2wcvt3w` (`destination_point_id`),
  CONSTRAINT `FK2vg7b2xayoq4ogt2kbsot4juq` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`),
  CONSTRAINT `FK6sb18ndb6dc6jh49u7dlp5yp3` FOREIGN KEY (`primary_driver_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK93pkx1oftwqcypyyvg2wcvt3w` FOREIGN KEY (`destination_point_id`) REFERENCES `pickup_points` (`id`),
  CONSTRAINT `FKbg85ulk7yir47gssmoepde4wk` FOREIGN KEY (`departure_point_id`) REFERENCES `pickup_points` (`id`),
  CONSTRAINT `FKc5vmjbyraaxskq39sy5xlxcyl` FOREIGN KEY (`pickup_point_id`) REFERENCES `pickup_points` (`id`),
  CONSTRAINT `FKm96d7e2d7xpb7wt42eis7vgnq` FOREIGN KEY (`secondary_driver_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trips`
--

LOCK TABLES `trips` WRITE;
/*!40000 ALTER TABLE `trips` DISABLE KEYS */;
INSERT INTO `trips` VALUES (4,'2025-05-20 05:10:00.000000',10,'UUU (Tỉnh Bắc Ninh)','2025-05-19 17:10:00.000000','Cầu Bà Di (Tỉnh Bình Định)',NULL,100000,'SCHEDULED',1,2,3,NULL,3,1),(5,'2025-05-22 01:15:00.000000',12,'UUU (Tỉnh Bắc Ninh)','2025-05-21 13:14:00.000000','Cầu Bà Di (Tỉnh Bình Định)',NULL,200000,'SCHEDULED',1,2,3,NULL,3,1);
/*!40000 ALTER TABLE `trips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fullName` varchar(255) NOT NULL,
  `numberPhone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_to7dbigycjgyt9ktt05rsdgem` (`numberPhone`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','0981793201','ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb','ADMIN'),(2,'Nguyễn Văn A','0111111111','ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb','DRIVER'),(3,'Nguyễn Văn B','0222222222','ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb','DRIVER'),(4,'0','0000000000','5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9','USER');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-21 20:43:52
