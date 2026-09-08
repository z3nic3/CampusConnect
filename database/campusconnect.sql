-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: campusconnect
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `app_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `opp_id` int DEFAULT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `applied_date` date DEFAULT NULL,
  PRIMARY KEY (`app_id`),
  KEY `student_id` (`student_id`),
  KEY `opp_id` (`opp_id`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `application_ibfk_2` FOREIGN KEY (`opp_id`) REFERENCES `opportunity` (`opp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,4,2,'ACCEPTED','2026-09-01'),(2,4,3,'REJECTED','2026-09-01'),(3,4,1,'REJECTED','2026-09-01'),(5,4,6,'PENDING','2026-09-06'),(6,4,5,'PENDING','2026-09-06'),(7,4,4,'PENDING','2026-09-06');
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `company_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `company_name` varchar(150) NOT NULL,
  `description` text,
  `industry` varchar(100) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `company_email` varchar(150) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `logo_path` varchar(255) DEFAULT NULL,
  `founded_year` int DEFAULT NULL,
  `company_size` varchar(50) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,3,'sammie','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,5,'Tata Consultancy Services','helooo','IT Industry','Kolkata','https://www.tcs.com/','tcs@company.com','9999999999',NULL,1850,'201-500','https://linkedin.com/markbrown'),(3,9,'ching lee','','','','','infosys@gmail.com','','',NULL,'',''),(5,11,'wipro','','','','','wipro@gmail.com','','',NULL,'','');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opportunity`
--

DROP TABLE IF EXISTS `opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunity` (
  `opp_id` int NOT NULL AUTO_INCREMENT,
  `company_id` int DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `skill_required` varchar(255) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `description` text,
  `posted_date` date DEFAULT NULL,
  PRIMARY KEY (`opp_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `opportunity_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunity`
--

LOCK TABLES `opportunity` WRITE;
/*!40000 ALTER TABLE `opportunity` DISABLE KEYS */;
INSERT INTO `opportunity` VALUES (1,2,'java developer','INTERNSHIP','java ,jsp,servlet','durgapur','','2026-08-30'),(2,2,'python developer','JOB','python','durgapur','need python developer','2026-08-31'),(3,2,'java developer','JOB','java ,jsp,servlet','durgapur','very good job','2026-08-31'),(4,2,'Python Developer','JOB','python','Remote','You should have ball knowledge in python ','2026-09-02'),(5,2,'BACKEND DEVELOPER','JOB','java ,jsp,servlet','Remote','u need to be serious about this job','2026-09-03'),(6,2,'Full Stack Developer','INTERNSHIP','HTML,CSS,JS','Chennai','Requires previous internship experience','2026-09-06');
/*!40000 ALTER TABLE `opportunity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_profile`
--

DROP TABLE IF EXISTS `student_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_profile` (
  `profile_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `skills` varchar(255) DEFAULT NULL,
  `education` varchar(255) DEFAULT NULL,
  `resume_path` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `bio` text,
  `github_link` varchar(255) DEFAULT NULL,
  `linkedin_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `student_profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_profile`
--

LOCK TABLES `student_profile` WRITE;
/*!40000 ALTER TABLE `student_profile` DISABLE KEYS */;
INSERT INTO `student_profile` VALUES (1,4,'java,sql','btech from aec 2028','uploads/resumes/resume_4.pdf','8016137247','durgapur','hiiiiiiiiii','https://github.com/z3nic3','https://linkedin.com/zeniceparveen');
/*!40000 ALTER TABLE `student_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'meher','meher@mail','meher','STUDENT'),(3,'sammie','sammie@mail','sammie','COMPANY'),(4,'Zenice Parveen','zeniceparveen@gmail.com','@zENICE2009','STUDENT'),(5,'mark brown','markbrown@gmail.com','@zENICE2009','COMPANY'),(6,'Admin','admin@gmail.com','admin123','ADMIN'),(9,'ching lee','infosys@gmail.com','@zENICE2009','COMPANY'),(11,'wipro','wipro@gmail.com','@zENICE2009','COMPANY');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-08 23:12:54
