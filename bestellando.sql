-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: bestellando
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

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
-- Table structure for table `bestellung`
--

DROP TABLE IF EXISTS `bestellung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestellung` (
  `Bestellung_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Bestellung_Tisch_ID` int(11) DEFAULT NULL,
  `Bestellung_Kelner_ID` int(11) DEFAULT NULL,
  `Datum` date DEFAULT NULL,
  PRIMARY KEY (`Bestellung_ID`),
  KEY `Bestellung_Tisch_ID` (`Bestellung_Tisch_ID`),
  KEY `Bestellung_Kelner_ID` (`Bestellung_Kelner_ID`),
  CONSTRAINT `bestellung_ibfk_1` FOREIGN KEY (`Bestellung_Tisch_ID`) REFERENCES `tische` (`Tisch_ID`),
  CONSTRAINT `bestellung_ibfk_2` FOREIGN KEY (`Bestellung_Kelner_ID`) REFERENCES `kellner` (`Kellner_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestellung`
--

LOCK TABLES `bestellung` WRITE;
/*!40000 ALTER TABLE `bestellung` DISABLE KEYS */;
INSERT INTO `bestellung` VALUES (1,1,1,'2023-07-05'),(2,1,1,'2023-07-05'),(3,3,4,'2023-07-05'),(4,4,2,'2023-07-05'),(5,4,2,'2023-07-05'),(6,4,2,'2023-07-05'),(7,1,1,'2023-07-05'),(8,2,4,'2023-07-06'),(9,1,1,'2023-07-06'),(10,1,1,'2023-07-06'),(11,1,1,'2023-07-06'),(12,1,1,'2023-07-06'),(13,1,1,'2023-07-06'),(14,4,3,'2023-07-06'),(15,1,1,'2023-07-06'),(16,1,1,'2023-07-06'),(17,1,1,'2023-07-06');
/*!40000 ALTER TABLE `bestellung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bestellung_deteile`
--

DROP TABLE IF EXISTS `bestellung_deteile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestellung_deteile` (
  `Geri_ID` int(11) DEFAULT NULL,
  `Best_ID` int(11) DEFAULT NULL,
  `Gerichte_Anzahl` int(11) DEFAULT NULL,
  KEY `Geri_ID` (`Geri_ID`),
  KEY `Best_ID` (`Best_ID`),
  CONSTRAINT `bestellung_deteile_ibfk_1` FOREIGN KEY (`Geri_ID`) REFERENCES `gerichte` (`Gericht_ID`),
  CONSTRAINT `bestellung_deteile_ibfk_2` FOREIGN KEY (`Best_ID`) REFERENCES `bestellung` (`Bestellung_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestellung_deteile`
--

LOCK TABLES `bestellung_deteile` WRITE;
/*!40000 ALTER TABLE `bestellung_deteile` DISABLE KEYS */;
INSERT INTO `bestellung_deteile` VALUES (7,7,4),(13,7,4),(1,9,7),(2,9,7),(1,10,7),(2,10,7),(1,11,7),(2,11,7),(1,12,7),(2,12,7),(1,13,7),(2,13,7),(7,14,10),(8,14,7),(1,15,10),(2,15,11),(1,16,10),(2,16,11),(3,17,2),(4,17,4),(5,17,5),(6,17,6),(7,17,6),(8,17,6),(12,17,16),(13,17,10);
/*!40000 ALTER TABLE `bestellung_deteile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gerichte`
--

DROP TABLE IF EXISTS `gerichte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gerichte` (
  `Gericht_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Gericht_Name` varchar(50) DEFAULT NULL,
  `Gericht_Preis` decimal(8,2) DEFAULT NULL,
  `KategorieNr` int(11) DEFAULT NULL,
  PRIMARY KEY (`Gericht_ID`),
  KEY `KategorieNr` (`KategorieNr`),
  CONSTRAINT `gerichte_ibfk_1` FOREIGN KEY (`KategorieNr`) REFERENCES `kategorie` (`Kategorie_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gerichte`
--

LOCK TABLES `gerichte` WRITE;
/*!40000 ALTER TABLE `gerichte` DISABLE KEYS */;
INSERT INTO `gerichte` VALUES (1,'Tomatensuppe',4.50,1),(2,'Kartoffelsuppe',5.00,1),(3,'SCHAFSKAESE mit Butter und Brot',12.50,2),(4,'KROATISCHER SCHINKEN',15.50,2),(5,'Gurkensalat',3.50,3),(6,'Caesar Salat',7.50,3),(7,'Wiener Schnitzel',12.50,4),(8,'Rinderfilet mit Pfeffersauce',18.00,4),(9,'Pommes Frites',2.50,5),(10,'Kartoffelgratin',4.00,5),(11,'Schokoladenkuchen',5.50,6),(12,'Vanilleeis mit hei?en Kirschen',6.50,6),(13,'Cola',2.00,7),(14,'Apfelsaftschorle',2.50,7),(15,'Zwiebelsuppe',4.00,8),(16,'Schwabische Maultaschen',8.50,8);
/*!40000 ALTER TABLE `gerichte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategorie`
--

DROP TABLE IF EXISTS `kategorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategorie` (
  `Kategorie_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Bezeichnung` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Kategorie_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategorie`
--

LOCK TABLES `kategorie` WRITE;
/*!40000 ALTER TABLE `kategorie` DISABLE KEYS */;
INSERT INTO `kategorie` VALUES (1,'Suppen'),(2,'Kalte Vorspeisen'),(3,'Salate'),(4,'Hauptgerichte'),(5,'Beilagen'),(6,'Desserts'),(7,'Getr?nke'),(8,'Spezialit?ten');
/*!40000 ALTER TABLE `kategorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kellner`
--

DROP TABLE IF EXISTS `kellner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kellner` (
  `Kellner_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Kellner_Vorname` varchar(30) DEFAULT NULL,
  `Kellner_Nachname` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Kellner_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kellner`
--

LOCK TABLES `kellner` WRITE;
/*!40000 ALTER TABLE `kellner` DISABLE KEYS */;
INSERT INTO `kellner` VALUES (1,'Max','Minelli'),(2,'Anna','Schmidt'),(3,'Tom','Fischer'),(4,'Ilona','Wagner');
/*!40000 ALTER TABLE `kellner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tische`
--

DROP TABLE IF EXISTS `tische`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tische` (
  `Tisch_ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Tisch_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tische`
--

LOCK TABLES `tische` WRITE;
/*!40000 ALTER TABLE `tische` DISABLE KEYS */;
INSERT INTO `tische` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `tische` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-07  8:46:43
