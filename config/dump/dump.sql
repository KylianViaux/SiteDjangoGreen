-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: localhost    Database: monblog
-- ------------------------------------------------------
-- Server version	5.7.28-0ubuntu0.16.04.2

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

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add karma check',8,'add_karmacheck'),(22,'Can change karma check',8,'change_karmacheck'),(23,'Can delete karma check',8,'delete_karmacheck'),(24,'Can view karma check',8,'view_karmacheck'),(25,'Can add investor link',7,'add_investorlink'),(26,'Can change investor link',7,'change_investorlink'),(27,'Can delete investor link',7,'delete_investorlink'),(28,'Can view investor link',7,'view_investorlink'),(29,'Can add Projet',10,'add_project'),(30,'Can change Projet',10,'change_project'),(31,'Can delete Projet',10,'delete_project'),(32,'Can view Projet',10,'view_project'),(33,'Evaluer un projet',10,'evaluate_project'),(34,'Can add expert note',6,'add_expertnote'),(35,'Can change expert note',6,'change_expertnote'),(36,'Can delete expert note',6,'delete_expertnote'),(37,'Can view expert note',6,'view_expertnote'),(38,'Can add Utilisateur',9,'add_user'),(39,'Can change Utilisateur',9,'change_user'),(40,'Can delete Utilisateur',9,'delete_user'),(41,'Can view Utilisateur',9,'view_user');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_expertnote`
--

DROP TABLE IF EXISTS `blog_expertnote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_expertnote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `noteBudget` int(11) NOT NULL,
  `noteFaisabilite` int(11) NOT NULL,
  `noteUtilite` int(11) NOT NULL,
  `noteGlobale` int(11) NOT NULL,
  `commentaire` varchar(255) NOT NULL,
  `idExpert_id` int(11) DEFAULT NULL,
  `idProject_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_expertnote_idExpert_id_cb8b46c8_fk_blog_user_id` (`idExpert_id`),
  KEY `blog_expertnote_idProject_id_ba7ebaec_fk_blog_project_id` (`idProject_id`),
  CONSTRAINT `blog_expertnote_idExpert_id_cb8b46c8_fk_blog_user_id` FOREIGN KEY (`idExpert_id`) REFERENCES `blog_user` (`id`),
  CONSTRAINT `blog_expertnote_idProject_id_ba7ebaec_fk_blog_project_id` FOREIGN KEY (`idProject_id`) REFERENCES `blog_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_expertnote`
--

LOCK TABLES `blog_expertnote` WRITE;
/*!40000 ALTER TABLE `blog_expertnote` DISABLE KEYS */;
INSERT INTO `blog_expertnote` VALUES (1,0,0,0,0,'Projet irréalisable dans de telles conditions',4,3),(2,0,0,2,0,'Le projet est intéressant mais infaisable avec un tel budget',5,3),(3,7,8,9,8,'Projet très intéressant',6,2),(4,7,10,10,9,'Validé ',7,2);
/*!40000 ALTER TABLE `blog_expertnote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_investorlink`
--

DROP TABLE IF EXISTS `blog_investorlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_investorlink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contribution` int(11) NOT NULL,
  `derniereTransaction` int(11) NOT NULL,
  `dateTransaction` datetime(6) NOT NULL,
  `idInvestisseur_id` int(11) DEFAULT NULL,
  `idProject_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_investorlink_idInvestisseur_id_8b862354_fk_blog_user_id` (`idInvestisseur_id`),
  KEY `blog_investorlink_idProject_id_bfe1f9c7_fk_blog_project_id` (`idProject_id`),
  CONSTRAINT `blog_investorlink_idInvestisseur_id_8b862354_fk_blog_user_id` FOREIGN KEY (`idInvestisseur_id`) REFERENCES `blog_user` (`id`),
  CONSTRAINT `blog_investorlink_idProject_id_bfe1f9c7_fk_blog_project_id` FOREIGN KEY (`idProject_id`) REFERENCES `blog_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_investorlink`
--

LOCK TABLES `blog_investorlink` WRITE;
/*!40000 ALTER TABLE `blog_investorlink` DISABLE KEYS */;
INSERT INTO `blog_investorlink` VALUES (1,50,50,'2020-01-21 09:40:27.077591',5,2),(2,25,25,'2020-01-21 09:41:40.636477',6,2),(3,10,10,'2020-01-21 09:42:31.705662',7,2),(4,100,50,'2020-01-21 09:42:44.906203',2,2),(5,35,10,'2020-01-21 09:43:13.253755',1,2);
/*!40000 ALTER TABLE `blog_investorlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_karmacheck`
--

DROP TABLE IF EXISTS `blog_karmacheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_karmacheck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluation` int(11) NOT NULL,
  `oldEvaluation` int(11) NOT NULL,
  `ExpertEvaluateur_id` int(11) DEFAULT NULL,
  `ExpertEvalue_id` int(11) DEFAULT NULL,
  `idProject_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_karmacheck_ExpertEvaluateur_id_1c97e568_fk_blog_user_id` (`ExpertEvaluateur_id`),
  KEY `blog_karmacheck_ExpertEvalue_id_88bd4360_fk_blog_user_id` (`ExpertEvalue_id`),
  KEY `blog_karmacheck_idProject_id_8b9ff3a6_fk_blog_project_id` (`idProject_id`),
  CONSTRAINT `blog_karmacheck_ExpertEvaluateur_id_1c97e568_fk_blog_user_id` FOREIGN KEY (`ExpertEvaluateur_id`) REFERENCES `blog_user` (`id`),
  CONSTRAINT `blog_karmacheck_ExpertEvalue_id_88bd4360_fk_blog_user_id` FOREIGN KEY (`ExpertEvalue_id`) REFERENCES `blog_user` (`id`),
  CONSTRAINT `blog_karmacheck_idProject_id_8b9ff3a6_fk_blog_project_id` FOREIGN KEY (`idProject_id`) REFERENCES `blog_project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_karmacheck`
--

LOCK TABLES `blog_karmacheck` WRITE;
/*!40000 ALTER TABLE `blog_karmacheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_karmacheck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_project`
--

DROP TABLE IF EXISTS `blog_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `difficulte` int(11) NOT NULL,
  `budgetActuel` int(11) NOT NULL,
  `budgetCible` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `datePublication` datetime(6) NOT NULL,
  `project_Main_Image` varchar(100) DEFAULT NULL,
  `idCreateur_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_project_idCreateur_id_9c2de545_fk_blog_user_id` (`idCreateur_id`),
  CONSTRAINT `blog_project_idCreateur_id_9c2de545_fk_blog_user_id` FOREIGN KEY (`idCreateur_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_project`
--

LOCK TABLES `blog_project` WRITE;
/*!40000 ALTER TABLE `blog_project` DISABLE KEYS */;
INSERT INTO `blog_project` VALUES (1,'Projet mystère',1,0,5000,'Projet pour m\'enrichir (partie I)','2020-01-21 08:59:08.086817','',1),(2,'Plantons des arbres',5,220,5000,'Planter des arbres partout dans le monde','2020-01-21 09:13:04.430371','images/projet2.png',2),(3,'Barrage',2,0,500,'Création d\'un barrage pour bloquer l\'eau de la rivière','2020-01-21 09:21:57.502771','',8),(4,'Foodtruck ecologique',2,0,10000,'Le foodtruck écologique pour Atlantide ','2020-01-21 09:29:21.325423','images/projet3.jpeg',3),(5,'El famoso ',1,0,10,'No description available','2020-01-21 09:48:18.360930','images/troll_nmXpA8M.jpeg',9);
/*!40000 ALTER TABLE `blog_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_user`
--

DROP TABLE IF EXISTS `blog_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(50) NOT NULL,
  `profil` longtext,
  `dateInscription` datetime(6) NOT NULL,
  `isExpert` tinyint(1) NOT NULL,
  `karma` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_user`
--

LOCK TABLES `blog_user` WRITE;
/*!40000 ALTER TABLE `blog_user` DISABLE KEYS */;
INSERT INTO `blog_user` VALUES (1,'2020-01-21 09:43:07.945326',1,'','',1,1,'2020-01-21 08:48:29.832579','admin','pbkdf2_sha256$150000$SIjzYa65CR2L$x7YCasfX7fSjDnBlU6ioyEoUmS/Ni8vFLdMxwEnpO54=','admin@minda.com','I\'m the law!','2020-01-21 08:48:29.832645',1,10000),(2,'2020-01-21 09:42:39.976745',0,'','',0,1,'2020-01-21 09:03:13.140249','uti','pbkdf2_sha256$150000$uJlwWFK3dUmU$sPe1GOy9Sof+ld8FYm2aPV8Vf6IbLFiKhov5IapbJqE=','uti@uti.com','Je suis un simple utilisateur','2020-01-21 09:03:13.140290',0,0),(3,'2020-01-21 09:35:47.947334',0,'','',0,1,'2020-01-21 09:03:55.936127','expert1','pbkdf2_sha256$150000$BzlEvQgHCNXA$FCN2/hz1L6Lu9u/pq2LGJot0gB6EnhsIJTSr3PMGaU4=','expert1@expert1.com','Compte expert de niveau 1','2020-01-21 09:03:55.936140',1,110),(4,'2020-01-21 09:36:27.986242',0,'','',0,1,'2020-01-21 09:04:19.370292','expert2','pbkdf2_sha256$150000$15azpPgzRe2H$blR1Z+9PwNz59Wb2cieBAHaF/OFHKPJG+oMLYotE/5c=','expert2@expert2.com','Compte expert de niveau 2','2020-01-21 09:04:19.370306',1,250),(5,'2020-01-21 09:45:54.685971',0,'','',0,1,'2020-01-21 09:04:43.285974','expert3','pbkdf2_sha256$150000$y5S2DhL5Eyvg$ljvYGtoCCTspH7iJhjMuW4q4BK0D3J0m00gYDuX6DtU=','expert3@expert3.com','Compte expert de niveau 3','2020-01-21 09:04:43.285987',1,350),(6,'2020-01-21 09:40:50.956556',0,'','',0,1,'2020-01-21 09:05:47.038776','expert5','pbkdf2_sha256$150000$8ecllgHi5Jm7$0KNFf9WB1xc+Fz7L7TdnZ1wu1YPUJH0GD0TcxX40/cE=','expert5@expert5.com','Compte expert de niveau 5','2020-01-21 09:05:47.038789',1,550),(7,'2020-01-21 09:41:54.908667',0,'','',0,1,'2020-01-21 09:06:30.011256','expert10','pbkdf2_sha256$150000$ygAd20nuuOYT$jBGRDmGAHBL1PJDl6o1V590b0SO9ead44xE2TJp1+S4=','expert10@expert10.com','Compte expert de niveau 10','2020-01-21 09:06:30.011269',1,1050),(8,'2020-01-21 09:20:25.426832',0,'','',0,1,'2020-01-21 09:07:49.742370','user','pbkdf2_sha256$150000$ZKIgMjs3f6ap$Utknqlaba8Xnx45LU/ngYyPYgyXRd045MlRr5j5jJ9g=','user@user.com','Compte utilisateur simple','2020-01-21 09:07:49.742385',0,0),(9,'2020-01-21 09:47:20.211101',0,'','',0,1,'2020-01-21 09:47:14.349013','troll','pbkdf2_sha256$150000$15W2XDsUSUc5$XmeAg1Bom/KMZD7iY03qnEEDQdPkal3QevOhrRb/aTQ=','troll@troll.com','','2020-01-21 09:47:14.349026',0,0);
/*!40000 ALTER TABLE `blog_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_user_groups`
--

DROP TABLE IF EXISTS `blog_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_user_groups_user_id_group_id_9046f296_uniq` (`user_id`,`group_id`),
  KEY `blog_user_groups_group_id_29990e74_fk_auth_group_id` (`group_id`),
  CONSTRAINT `blog_user_groups_group_id_29990e74_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `blog_user_groups_user_id_4e1acb48_fk_blog_user_id` FOREIGN KEY (`user_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_user_groups`
--

LOCK TABLES `blog_user_groups` WRITE;
/*!40000 ALTER TABLE `blog_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_user_user_permissions`
--

DROP TABLE IF EXISTS `blog_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_user_user_permissions_user_id_permission_id_1d3c1311_uniq` (`user_id`,`permission_id`),
  KEY `blog_user_user_permi_permission_id_95ca6010_fk_auth_perm` (`permission_id`),
  CONSTRAINT `blog_user_user_permi_permission_id_95ca6010_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `blog_user_user_permissions_user_id_379a1502_fk_blog_user_id` FOREIGN KEY (`user_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_user_user_permissions`
--

LOCK TABLES `blog_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `blog_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_blog_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_blog_user_id` FOREIGN KEY (`user_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(6,'blog','expertnote'),(7,'blog','investorlink'),(8,'blog','karmacheck'),(10,'blog','project'),(9,'blog','user'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-01-21 08:44:21.020552'),(2,'contenttypes','0002_remove_content_type_name','2020-01-21 08:44:21.091051'),(3,'auth','0001_initial','2020-01-21 08:44:21.184000'),(4,'auth','0002_alter_permission_name_max_length','2020-01-21 08:44:21.341348'),(5,'auth','0003_alter_user_email_max_length','2020-01-21 08:44:21.356489'),(6,'auth','0004_alter_user_username_opts','2020-01-21 08:44:21.371655'),(7,'auth','0005_alter_user_last_login_null','2020-01-21 08:44:21.381434'),(8,'auth','0006_require_contenttypes_0002','2020-01-21 08:44:21.383949'),(9,'auth','0007_alter_validators_add_error_messages','2020-01-21 08:44:21.391832'),(10,'auth','0008_alter_user_username_max_length','2020-01-21 08:44:21.397824'),(11,'auth','0009_alter_user_last_name_max_length','2020-01-21 08:44:21.402834'),(12,'auth','0010_alter_group_name_max_length','2020-01-21 08:44:21.411657'),(13,'auth','0011_update_proxy_permissions','2020-01-21 08:44:21.430336'),(14,'blog','0001_initial','2020-01-21 08:44:21.686892'),(15,'admin','0001_initial','2020-01-21 08:44:22.249886'),(16,'admin','0002_logentry_remove_auto_add','2020-01-21 08:44:22.360151'),(17,'admin','0003_logentry_add_action_flag_choices','2020-01-21 08:44:22.380574'),(18,'sessions','0001_initial','2020-01-21 08:44:22.403278');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-21 10:51:18
