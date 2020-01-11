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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Utilisateur',9,'add_user'),(22,'Can change Utilisateur',9,'change_user'),(23,'Can delete Utilisateur',9,'delete_user'),(24,'Can view Utilisateur',9,'view_user'),(25,'Can add image',10,'add_image'),(26,'Can change image',10,'change_image'),(27,'Can delete image',10,'delete_image'),(28,'Can view image',10,'view_image'),(29,'Can add investor link',8,'add_investorlink'),(30,'Can change investor link',8,'change_investorlink'),(31,'Can delete investor link',8,'delete_investorlink'),(32,'Can view investor link',8,'view_investorlink'),(33,'Can add Projet',7,'add_project'),(34,'Can change Projet',7,'change_project'),(35,'Can delete Projet',7,'delete_project'),(36,'Can view Projet',7,'view_project'),(37,'Evaluer un projet',7,'evaluate_project'),(38,'Can add expert note',11,'add_expertnote'),(39,'Can change expert note',11,'change_expertnote'),(40,'Can delete expert note',11,'delete_expertnote'),(41,'Can view expert note',11,'view_expertnote'),(42,'Can add est liee',6,'add_estliee'),(43,'Can change est liee',6,'change_estliee'),(44,'Can delete est liee',6,'delete_estliee'),(45,'Can view est liee',6,'view_estliee');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_estliee`
--

DROP TABLE IF EXISTS `blog_estliee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_estliee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` int(11) NOT NULL,
  `projet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_estliee_image_id_9634b4c6_fk_blog_image_id` (`image_id`),
  KEY `blog_estliee_projet_id_85eb86b3_fk_blog_project_id` (`projet_id`),
  CONSTRAINT `blog_estliee_image_id_9634b4c6_fk_blog_image_id` FOREIGN KEY (`image_id`) REFERENCES `blog_image` (`id`),
  CONSTRAINT `blog_estliee_projet_id_85eb86b3_fk_blog_project_id` FOREIGN KEY (`projet_id`) REFERENCES `blog_project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_estliee`
--

LOCK TABLES `blog_estliee` WRITE;
/*!40000 ALTER TABLE `blog_estliee` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_estliee` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_expertnote`
--

LOCK TABLES `blog_expertnote` WRITE;
/*!40000 ALTER TABLE `blog_expertnote` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_expertnote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_image`
--

DROP TABLE IF EXISTS `blog_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `copyright` smallint(5) unsigned NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_image`
--

LOCK TABLES `blog_image` WRITE;
/*!40000 ALTER TABLE `blog_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_image` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_investorlink`
--

LOCK TABLES `blog_investorlink` WRITE;
/*!40000 ALTER TABLE `blog_investorlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_investorlink` ENABLE KEYS */;
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
  `budgetActuel` int(11) NOT NULL,
  `budgetCible` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `datePublication` datetime(6) NOT NULL,
  `idCreateur_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_project_idCreateur_id_9c2de545_fk_blog_user_id` (`idCreateur_id`),
  CONSTRAINT `blog_project_idCreateur_id_9c2de545_fk_blog_user_id` FOREIGN KEY (`idCreateur_id`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_project`
--

LOCK TABLES `blog_project` WRITE;
/*!40000 ALTER TABLE `blog_project` DISABLE KEYS */;
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
  `slug` varchar(100) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(50) NOT NULL,
  `profil` longtext,
  `dateInscription` datetime(6) NOT NULL,
  `isExpert` tinyint(1) NOT NULL,
  `karma` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `blog_user_slug_591065d5` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_user`
--

LOCK TABLES `blog_user` WRITE;
/*!40000 ALTER TABLE `blog_user` DISABLE KEYS */;
INSERT INTO `blog_user` VALUES (1,NULL,1,'','',1,1,'2020-01-11 13:18:42.977218','admin','admin','pbkdf2_sha256$150000$h3SLWjkQzulp$TLqWXkfbn4DBEG1AlyfqcKVYNg9Kt9gfZMAaVD8RVnE=','admin@minda.com',NULL,'2020-01-11 13:18:42.977269',1,0),(2,'2020-01-11 13:22:57.818252',0,'','',0,1,'2020-01-11 13:22:57.722983','uti','uti','pbkdf2_sha256$150000$Ify3o7EjzbW3$JQfbW/po6BZkiDfQZz5gDOnvXC1PSARXh7sgzRPsEfA=','uti@itu.com','','2020-01-11 13:22:57.723000',0,0),(3,'2020-01-11 13:23:29.092923',0,'','',0,1,'2020-01-11 13:23:29.000351','expert','expert','pbkdf2_sha256$150000$tZ8oYGA1CLDn$caVoBQEL4AQQ9zprajHxscJl9hvleAFzMeF+eZ0VGUk=','expert@trepxe.com','','2020-01-11 13:23:29.000366',1,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(6,'blog','estliee'),(11,'blog','expertnote'),(10,'blog','image'),(8,'blog','investorlink'),(7,'blog','project'),(9,'blog','user'),(4,'contenttypes','contenttype'),(5,'sessions','session');
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
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-01-11 13:17:36.518717'),(2,'contenttypes','0002_remove_content_type_name','2020-01-11 13:17:36.574052'),(3,'auth','0001_initial','2020-01-11 13:17:36.652304'),(4,'auth','0002_alter_permission_name_max_length','2020-01-11 13:17:36.782943'),(5,'auth','0003_alter_user_email_max_length','2020-01-11 13:17:36.797408'),(6,'auth','0004_alter_user_username_opts','2020-01-11 13:17:36.813265'),(7,'auth','0005_alter_user_last_login_null','2020-01-11 13:17:36.823155'),(8,'auth','0006_require_contenttypes_0002','2020-01-11 13:17:36.825610'),(9,'auth','0007_alter_validators_add_error_messages','2020-01-11 13:17:36.832324'),(10,'auth','0008_alter_user_username_max_length','2020-01-11 13:17:36.838103'),(11,'auth','0009_alter_user_last_name_max_length','2020-01-11 13:17:36.844477'),(12,'auth','0010_alter_group_name_max_length','2020-01-11 13:17:36.851705'),(13,'auth','0011_update_proxy_permissions','2020-01-11 13:17:36.855897'),(14,'blog','0001_initial','2020-01-11 13:17:37.142407'),(15,'admin','0001_initial','2020-01-11 13:17:37.579757'),(16,'admin','0002_logentry_remove_auto_add','2020-01-11 13:17:37.672152'),(17,'admin','0003_logentry_add_action_flag_choices','2020-01-11 13:17:37.690633'),(18,'sessions','0001_initial','2020-01-11 13:17:37.709099');
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
INSERT INTO `django_session` VALUES ('uda9ifuxmif191gzhp0x345ei1l2c7x0','M2UzZDRlNTg2MDA3MzkyZjI2NjNhOWRhZjA4NGVlMzI1YTU0NzAxOTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9oYXNoIjoiM2I4NmQ5ZjYzYThmYmQwMzI5Yzc3MmE4ZjhlMmUyMzM1NDdhZjIwYSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2020-01-25 13:23:29.098605');
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

-- Dump completed on 2020-01-11 14:24:10
