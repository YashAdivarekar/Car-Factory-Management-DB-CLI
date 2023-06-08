-- MySQL dump 10.13  Distrib 8.0.31, for macos13.0 (arm64)
--
-- Host: localhost    Database: car_production
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `Car_Models`
--

DROP TABLE IF EXISTS `Car_Models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Car_Models` (
  `Model_Name` varchar(25) NOT NULL,
  `Car_Type` varchar(15) NOT NULL,
  `Count_in_Storage` int NOT NULL,
  `Plastic_Req` int DEFAULT NULL,
  `Steel_Req` int DEFAULT NULL,
  `Leather_Req` int DEFAULT NULL,
  `Cloth_Req` int DEFAULT NULL,
  PRIMARY KEY (`Model_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Car_Models`
--

LOCK TABLES `Car_Models` WRITE;
/*!40000 ALTER TABLE `Car_Models` DISABLE KEYS */;
INSERT INTO `Car_Models` VALUES ('Audi Q8','SUV',55,15,100,5,4),('BMW M4','Coupe',20,3,80,3,6),('Ford Mustang','Coupe',9,7,100,4,5),('Lamborghini Sian','coupe',0,10,90,30,10),('Mercedes-Benz A-Class','Hatchback',45,9,90,4,5),('Skoda Superb','Sedan',38,40,95,7,6);
/*!40000 ALTER TABLE `Car_Models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cars`
--

DROP TABLE IF EXISTS `cars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cars` (
  `VIN` varchar(20) NOT NULL,
  `Model_Name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`VIN`),
  KEY `Model_Name` (`Model_Name`),
  CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`Model_Name`) REFERENCES `Car_Models` (`Model_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cars`
--

LOCK TABLES `cars` WRITE;
/*!40000 ALTER TABLE `cars` DISABLE KEYS */;
INSERT INTO `cars` VALUES ('4L1SL65848Z488','Audi Q8'),('4W1SL65848Z499','Audi Q8'),('4Y1SL65848Z429','Audi Q8'),('4C1SL65848Z423','BMW M4'),('4E1SL65848Z434','BMW M4'),('4K1SL65848Z477','BMW M4'),('4L1SL65848Z428','BMW M4'),('4J1SL65848Z433','Ford Mustang'),('4X1SL65848Z478','Ford Mustang'),('4Y1SL65848Z411','Ford Mustang'),('4A1SL65848Z444','Mercedes-Benz A-Class'),('4V1SL65848Z422','Mercedes-Benz A-Class'),('4D1SL65848Z421','Skoda Superb'),('4H1SL65848Z466','Skoda Superb');
/*!40000 ALTER TABLE `cars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cars_In_Storage`
--

DROP TABLE IF EXISTS `Cars_In_Storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cars_In_Storage` (
  `VIN` varchar(20) NOT NULL,
  `Date_of_Arrival` date NOT NULL,
  `W_NO` varchar(10) DEFAULT NULL,
  `Model_Name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`VIN`),
  KEY `W_NO` (`W_NO`),
  KEY `Model_Name` (`Model_Name`),
  CONSTRAINT `cars_in_storage_ibfk_1` FOREIGN KEY (`VIN`) REFERENCES `Cars` (`VIN`),
  CONSTRAINT `cars_in_storage_ibfk_2` FOREIGN KEY (`W_NO`) REFERENCES `Worker` (`W_No`),
  CONSTRAINT `cars_in_storage_ibfk_3` FOREIGN KEY (`Model_Name`) REFERENCES `Car_Models` (`Model_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cars_In_Storage`
--

LOCK TABLES `Cars_In_Storage` WRITE;
/*!40000 ALTER TABLE `Cars_In_Storage` DISABLE KEYS */;
INSERT INTO `Cars_In_Storage` VALUES ('4A1SL65848Z444','2022-11-02','124365','Mercedes-Benz A-Class'),('4C1SL65848Z423','2022-11-27','123456','BMW M4'),('4H1SL65848Z466','2022-11-07','696969','Skoda Superb'),('4J1SL65848Z433','2022-11-08','413076','Ford Mustang'),('4K1SL65848Z477','2022-11-12','774712','BMW M4'),('4L1SL65848Z488','2022-10-21','229988','Audi Q8'),('4V1SL65848Z422','2022-11-05','229214','Mercedes-Benz A-Class'),('4W1SL65848Z499','2022-10-29','123456','Audi Q8'),('4Y1SL65848Z411','2022-10-30','234567','Ford Mustang'),('4Y1SL65848Z429','2022-10-29','123456','Audi Q8');
/*!40000 ALTER TABLE `Cars_In_Storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cars_On_Conveyer_Belts`
--

DROP TABLE IF EXISTS `Cars_On_Conveyer_Belts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cars_On_Conveyer_Belts` (
  `VIN_NO` varchar(15) NOT NULL,
  `Belt_No` int NOT NULL,
  `Progress` int NOT NULL,
  PRIMARY KEY (`VIN_NO`),
  CONSTRAINT `cars_on_conveyer_belts_ibfk_1` FOREIGN KEY (`VIN_NO`) REFERENCES `Cars` (`VIN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cars_On_Conveyer_Belts`
--

LOCK TABLES `Cars_On_Conveyer_Belts` WRITE;
/*!40000 ALTER TABLE `Cars_On_Conveyer_Belts` DISABLE KEYS */;
INSERT INTO `Cars_On_Conveyer_Belts` VALUES ('4D1SL65848Z421',3,25),('4E1SL65848Z434',3,70),('4L1SL65848Z428',2,0),('4X1SL65848Z478',1,50);
/*!40000 ALTER TABLE `Cars_On_Conveyer_Belts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colours_available`
--

DROP TABLE IF EXISTS `colours_available`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colours_available` (
  `Model_Name` varchar(25) NOT NULL,
  `Colour` varchar(25) NOT NULL,
  PRIMARY KEY (`Colour`),
  KEY `Model_Name` (`Model_Name`),
  CONSTRAINT `colours_available_ibfk_1` FOREIGN KEY (`Model_Name`) REFERENCES `Car_Models` (`Model_Name`),
  CONSTRAINT `colours_available_ibfk_2` FOREIGN KEY (`Model_Name`) REFERENCES `Car_models` (`Model_Name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colours_available`
--

LOCK TABLES `colours_available` WRITE;
/*!40000 ALTER TABLE `colours_available` DISABLE KEYS */;
INSERT INTO `colours_available` VALUES ('Audi Q8','Matte Black'),('BMW M4','British Racing Green'),('BMW M4','Sun Burn Yellow'),('Ford Mustang','Arctic Blue'),('Lamborghini Sian','Acid Green'),('Lamborghini Sian','Royal Blue'),('Mercedes-Benz A-Class','Alaskan White'),('Mercedes-Benz A-Class','Night Black'),('Skoda Superb','Dart Red'),('Skoda Superb','Diamond White'),('Skoda Superb','Paris Blue');
/*!40000 ALTER TABLE `colours_available` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Colours_of_Cars_On_Conveyer_Belts`
--

DROP TABLE IF EXISTS `Colours_of_Cars_On_Conveyer_Belts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Colours_of_Cars_On_Conveyer_Belts` (
  `VIN` varchar(15) NOT NULL,
  `Colour` varchar(25) NOT NULL,
  PRIMARY KEY (`VIN`),
  KEY `Colour` (`Colour`),
  CONSTRAINT `colours_of_cars_on_conveyer_belts_ibfk_1` FOREIGN KEY (`VIN`) REFERENCES `Cars_On_Conveyer_Belts` (`VIN_NO`),
  CONSTRAINT `colours_of_cars_on_conveyer_belts_ibfk_2` FOREIGN KEY (`Colour`) REFERENCES `Colours_Available` (`Colour`),
  CONSTRAINT `colours_of_cars_on_conveyer_belts_ibfk_3` FOREIGN KEY (`VIN`) REFERENCES `Cars_on_conveyer_belts` (`VIN_NO`) ON DELETE CASCADE,
  CONSTRAINT `colours_of_cars_on_conveyer_belts_ibfk_4` FOREIGN KEY (`VIN`) REFERENCES `Cars_on_conveyer_belts` (`VIN_NO`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Colours_of_Cars_On_Conveyer_Belts`
--

LOCK TABLES `Colours_of_Cars_On_Conveyer_Belts` WRITE;
/*!40000 ALTER TABLE `Colours_of_Cars_On_Conveyer_Belts` DISABLE KEYS */;
INSERT INTO `Colours_of_Cars_On_Conveyer_Belts` VALUES ('4E1SL65848Z434','Alaskan White'),('4D1SL65848Z421','British Racing Green'),('4X1SL65848Z478','Matte Black'),('4L1SL65848Z428','Sun Burn Yellow');
/*!40000 ALTER TABLE `Colours_of_Cars_On_Conveyer_Belts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Engine_Codes`
--

DROP TABLE IF EXISTS `Engine_Codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Engine_Codes` (
  `Model_Name` varchar(25) NOT NULL,
  `Engine_Code` varchar(15) NOT NULL,
  KEY `Model_Name` (`Model_Name`),
  CONSTRAINT `engine_codes_ibfk_1` FOREIGN KEY (`Model_Name`) REFERENCES `Car_Models` (`Model_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Engine_Codes`
--

LOCK TABLES `Engine_Codes` WRITE;
/*!40000 ALTER TABLE `Engine_Codes` DISABLE KEYS */;
INSERT INTO `Engine_Codes` VALUES ('Audi Q8','4.0L-V8'),('BMW M4','3L-S6'),('Ford Mustang','5L-SV8'),('BMW M4','2L-4C'),('Skoda Superb','1.8L-4C'),('Mercedes-Benz A-Class','2L-4C'),('Skoda Superb','2L-T5C'),('Mercedes-Benz A-Class','3L-V6'),('Skoda Superb','2.8L-V6');
/*!40000 ALTER TABLE `Engine_Codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Requires`
--

DROP TABLE IF EXISTS `Requires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Requires` (
  `VIN_NO` varchar(15) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `W_No` varchar(10) NOT NULL,
  `Model_Name` varchar(25) DEFAULT NULL,
  KEY `VIN_NO` (`VIN_NO`),
  KEY `W_No` (`W_No`),
  KEY `Model_Name` (`Model_Name`),
  KEY `Name` (`Name`),
  CONSTRAINT `requires_ibfk_1` FOREIGN KEY (`VIN_NO`) REFERENCES `Cars_On_Conveyer_Belts` (`VIN_NO`),
  CONSTRAINT `requires_ibfk_2` FOREIGN KEY (`W_No`) REFERENCES `Worker` (`W_No`),
  CONSTRAINT `requires_ibfk_3` FOREIGN KEY (`Model_Name`) REFERENCES `Car_Models` (`Model_Name`),
  CONSTRAINT `requires_ibfk_4` FOREIGN KEY (`Name`) REFERENCES `Resources` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Requires`
--

LOCK TABLES `Requires` WRITE;
/*!40000 ALTER TABLE `Requires` DISABLE KEYS */;
INSERT INTO `Requires` VALUES ('4X1SL65848Z478','Iron','123456','Audi Q8'),('4D1SL65848Z421','Paint Solvent','229214','BMW M4'),('4E1SL65848Z434','Wood','413076','Ford Mustang'),('4X1SL65848Z478','Leather','774712','Audi Q8'),('4E1SL65848Z434','Car Polish','124365','Ford Mustang');
/*!40000 ALTER TABLE `Requires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Resources`
--

DROP TABLE IF EXISTS `Resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Resources` (
  `Name` varchar(15) NOT NULL,
  `No_Suppliers` int NOT NULL,
  `Supply_Available` int NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Resources`
--

LOCK TABLES `Resources` WRITE;
/*!40000 ALTER TABLE `Resources` DISABLE KEYS */;
INSERT INTO `Resources` VALUES ('Car Polish',6,30),('Iron',3,60000),('Leather',2,150),('Paint Solvent',5,50),('Wood',1,100);
/*!40000 ALTER TABLE `Resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Robots`
--

DROP TABLE IF EXISTS `Robots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Robots` (
  `VIN_No` varchar(15) NOT NULL,
  `Work_Code` varchar(10) NOT NULL,
  `Working_Status` char(1) NOT NULL,
  KEY `VIN_No` (`VIN_No`),
  CONSTRAINT `robots_ibfk_1` FOREIGN KEY (`VIN_No`) REFERENCES `Cars_On_Conveyer_Belts` (`VIN_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Robots`
--

LOCK TABLES `Robots` WRITE;
/*!40000 ALTER TABLE `Robots` DISABLE KEYS */;
INSERT INTO `Robots` VALUES ('4D1SL65848Z421','WELD12','Y'),('4E1SL65848Z434','LIFT23','Y'),('4X1SL65848Z478','WELD12','Y'),('4E1SL65848Z434','JOIN45','N'),('4X1SL65848Z478','LIFT23','N'),('4D1SL65848Z421','LIFT23','Y');
/*!40000 ALTER TABLE `Robots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tools`
--

DROP TABLE IF EXISTS `Tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tools` (
  `Name` varchar(25) NOT NULL,
  `W_No` varchar(10) NOT NULL,
  `Working_State` varchar(10) NOT NULL,
  KEY `W_No` (`W_No`),
  CONSTRAINT `tools_ibfk_1` FOREIGN KEY (`W_No`) REFERENCES `Worker` (`W_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tools`
--

LOCK TABLES `Tools` WRITE;
/*!40000 ALTER TABLE `Tools` DISABLE KEYS */;
INSERT INTO `Tools` VALUES ('Spanner','123456','Y'),('Power Screwdriver','229214','N'),('Drill','413076','Y'),('Hammer','884856','N'),('Wrench','123456','Y'),('Power Screwdriver','774712','N'),('Wrench','229988','N'),('Hammer','696969','Y'),('Drill','234567','Y'),('Spaner','981234','Y');
/*!40000 ALTER TABLE `Tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Worker`
--

DROP TABLE IF EXISTS `Worker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Worker` (
  `W_No` varchar(10) NOT NULL,
  `Gender` char(1) NOT NULL,
  `DOB` date NOT NULL,
  `S_No` varchar(10) DEFAULT NULL,
  `Working_Status` char(1) NOT NULL,
  PRIMARY KEY (`W_No`),
  KEY `S_No` (`S_No`),
  CONSTRAINT `worker_ibfk_1` FOREIGN KEY (`S_No`) REFERENCES `Worker` (`W_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Worker`
--

LOCK TABLES `Worker` WRITE;
/*!40000 ALTER TABLE `Worker` DISABLE KEYS */;
INSERT INTO `Worker` VALUES ('123456','M','1989-03-23','413076','Y'),('124365','M','1980-08-21','229988','Y'),('229214','F','1996-02-21','696969','Y'),('229988','F','1991-06-19','981234','Y'),('234567','M','1994-05-11','124365','N'),('413076','M','1981-07-15','981234','Y'),('696969','M','1987-04-07','774712','N'),('774712','F','1996-11-03','123456','Y'),('884856','M','1986-02-11','413076','N'),('981234','F','1978-01-24',NULL,'N');
/*!40000 ALTER TABLE `Worker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Worker_Age`
--

DROP TABLE IF EXISTS `Worker_Age`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Worker_Age` (
  `W_No` varchar(10) NOT NULL,
  `Age` int NOT NULL,
  PRIMARY KEY (`W_No`),
  CONSTRAINT `worker_age_ibfk_1` FOREIGN KEY (`W_No`) REFERENCES `Worker` (`W_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Worker_Age`
--

LOCK TABLES `Worker_Age` WRITE;
/*!40000 ALTER TABLE `Worker_Age` DISABLE KEYS */;
INSERT INTO `Worker_Age` VALUES ('123456',33),('124365',42),('229214',26),('229988',31),('234567',28),('413076',41),('696969',35),('774712',26),('884856',36),('981234',44);
/*!40000 ALTER TABLE `Worker_Age` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Worker_Name`
--

DROP TABLE IF EXISTS `Worker_Name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Worker_Name` (
  `W_No` varchar(10) NOT NULL,
  `F_Name` varchar(10) NOT NULL,
  `M_Name` varchar(10) DEFAULT NULL,
  `L_Name` varchar(10) NOT NULL,
  PRIMARY KEY (`W_No`),
  CONSTRAINT `worker_name_ibfk_1` FOREIGN KEY (`W_No`) REFERENCES `Worker` (`W_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Worker_Name`
--

LOCK TABLES `Worker_Name` WRITE;
/*!40000 ALTER TABLE `Worker_Name` DISABLE KEYS */;
INSERT INTO `Worker_Name` VALUES ('123456','Adam','A','Cold'),('124365','Jason','B','Demuro'),('229214','Catherine','K','Johnson'),('229988','Cathy','A','Garcia'),('234567','Steve','C','Jobs'),('413076','Ronald','L','Brown'),('696969','Henry','D','Miler'),('774712','Kate','A','Williams'),('884856','Tommy','W','Bertin'),('981234','Emma','A','Smith');
/*!40000 ALTER TABLE `Worker_Name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Workers_Of_Cars_On_Conveyer_Belts`
--

DROP TABLE IF EXISTS `Workers_Of_Cars_On_Conveyer_Belts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Workers_Of_Cars_On_Conveyer_Belts` (
  `VIN` varchar(15) NOT NULL,
  `W_No` varchar(10) NOT NULL,
  KEY `W_No` (`W_No`),
  KEY `VIN` (`VIN`),
  CONSTRAINT `workers_of_cars_on_conveyer_belts_ibfk_1` FOREIGN KEY (`VIN`) REFERENCES `Cars_On_Conveyer_Belts` (`VIN_NO`),
  CONSTRAINT `workers_of_cars_on_conveyer_belts_ibfk_2` FOREIGN KEY (`W_No`) REFERENCES `Worker` (`W_No`),
  CONSTRAINT `workers_of_cars_on_conveyer_belts_ibfk_3` FOREIGN KEY (`VIN`) REFERENCES `Cars_on_conveyer_belts` (`VIN_NO`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Workers_Of_Cars_On_Conveyer_Belts`
--

LOCK TABLES `Workers_Of_Cars_On_Conveyer_Belts` WRITE;
/*!40000 ALTER TABLE `Workers_Of_Cars_On_Conveyer_Belts` DISABLE KEYS */;
INSERT INTO `Workers_Of_Cars_On_Conveyer_Belts` VALUES ('4X1SL65848Z478','123456'),('4D1SL65848Z421','229214'),('4E1SL65848Z434','413076'),('4X1SL65848Z478','774712'),('4E1SL65848Z434','124365'),('4L1SL65848Z428','123456');
/*!40000 ALTER TABLE `Workers_Of_Cars_On_Conveyer_Belts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-27 14:21:02
