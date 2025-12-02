/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.1.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: SIS-EXP
-- ------------------------------------------------------
-- Server version	12.1.2-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `SIS-EXP`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `SIS-EXP` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;

USE `SIS-EXP`;

--
-- Table structure for table `aseguradoras`
--

DROP TABLE IF EXISTS `aseguradoras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `aseguradoras` (
  `id` varchar(36) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `id_persona` varchar(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `id_persona` (`id_persona`),
  CONSTRAINT `1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aseguradoras`
--

LOCK TABLES `aseguradoras` WRITE;
/*!40000 ALTER TABLE `aseguradoras` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `aseguradoras` VALUES
('022b98be-3590-4f07-b9af-fc59fbe443d0','ANCON','19961cd8-811f-433d-a22b-67fb870f0e6c','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('5ce7b5d2-4868-48b1-99ef-829e6866742a','CONANCE','af13e630-628f-4d35-86cd-ce415d91dbc4','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('823e7fdf-63ef-4a0e-94e0-3de62bde04c2','ASSA','9f3061ea-647d-4b0e-ab3b-c9b213ed6173','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('cb1e9e62-cbb2-44dd-8590-40d1221adfac','MAPRE','8c32f082-1141-45b0-8254-c0497ed319d5','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('db993fc5-5ced-4b21-a17e-514cf135cb9f','INTEROCEANICA','20bcae7c-66d7-4bd5-a46b-74088a84a8bf','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('dd7cb349-1b2b-476f-9a46-be6d239ac498','SURA','a6457a5c-9695-41b7-962a-5d40b5c6faec','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('fba5823c-c315-4107-9e5f-47418ec7faa4','PARTICULAR','1fb9f5b9-9e5a-4675-9921-abc9a6a422ce','2025-12-02 00:06:02','2025-12-02 00:06:02');
/*!40000 ALTER TABLE `aseguradoras` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `expedientes`
--

DROP TABLE IF EXISTS `expedientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `expedientes` (
  `id` varchar(36) NOT NULL,
  `usuario_id` varchar(36) NOT NULL,
  `aseguradora_id` varchar(36) NOT NULL,
  `estado` enum('Pendiente','En curso','Cerrado') NOT NULL DEFAULT 'Pendiente',
  `juzgado` varchar(255) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_finalizacion` date DEFAULT NULL,
  `formato` varchar(50) DEFAULT NULL,
  `conductor` varchar(255) DEFAULT NULL,
  `numero_de_caso` varchar(50) DEFAULT NULL,
  `tipo_de_proceso` enum('TRANSITO','PENAL') NOT NULL,
  `abogado_id` varchar(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_expediente_usuario` (`usuario_id`),
  KEY `fk_expediente_aseguradora` (`aseguradora_id`),
  KEY `fk_expediente_abogado` (`abogado_id`),
  CONSTRAINT `fk_expediente_abogado` FOREIGN KEY (`abogado_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `fk_expediente_aseguradora` FOREIGN KEY (`aseguradora_id`) REFERENCES `aseguradoras` (`id`),
  CONSTRAINT `fk_expediente_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expedientes`
--

LOCK TABLES `expedientes` WRITE;
/*!40000 ALTER TABLE `expedientes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `expedientes` VALUES
('1543a684-193d-4393-a1d7-2b961bbebef3','4ee3a1ca-52cc-43be-843b-e06020096ecd','cb1e9e62-cbb2-44dd-8590-40d1221adfac','En curso','Juzgado 2','2025-12-01','2025-12-28','Digital','Conductor 2','CASO-4920','TRANSITO','0408772d-1636-4ecf-9248-6fbbef883ea8','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('54c222b3-5730-4d64-8846-55e8e1123f5f','4ee3a1ca-52cc-43be-843b-e06020096ecd','db993fc5-5ced-4b21-a17e-514cf135cb9f','Cerrado','Juzgado 7','2025-12-01','2025-12-31','Digital','Conductor 7','CASO-3906','PENAL','316996db-16db-4ed7-ad4d-c1199f70e138','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('6d010e5a-1e89-4664-9322-b5456834fd8b','4ee3a1ca-52cc-43be-843b-e06020096ecd','dd7cb349-1b2b-476f-9a46-be6d239ac498','En curso','Juzgado 3','2025-12-01','2025-12-24','Digital','Conductor 3','CASO-2524','PENAL','0408772d-1636-4ecf-9248-6fbbef883ea8','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('85a0c911-e806-4dc5-aa0d-902e0741bb67','4ee3a1ca-52cc-43be-843b-e06020096ecd','5ce7b5d2-4868-48b1-99ef-829e6866742a','Cerrado','Juzgado 5','2025-12-01','2025-12-10','Fisico','Conductor 5','CASO-3292','PENAL','0408772d-1636-4ecf-9248-6fbbef883ea8','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('9b0e7642-9096-44c2-b8e6-e4342d397c68','4ee3a1ca-52cc-43be-843b-e06020096ecd','823e7fdf-63ef-4a0e-94e0-3de62bde04c2','En curso','Juzgado 1','2025-12-01','2025-12-25','Fisico','Conductor 1','CASO-9896','TRANSITO','4ee3a1ca-52cc-43be-843b-e06020096ecd','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('a71ef95c-afe2-470d-aa50-d7fedefaf1eb','4ee3a1ca-52cc-43be-843b-e06020096ecd','fba5823c-c315-4107-9e5f-47418ec7faa4','Cerrado','Juzgado 6','2025-12-01','2025-12-13','Fisico','Conductor 6','CASO-6797','TRANSITO','316996db-16db-4ed7-ad4d-c1199f70e138','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('f3f56f6c-bb84-4c31-be9d-d0e046983c15','4ee3a1ca-52cc-43be-843b-e06020096ecd','022b98be-3590-4f07-b9af-fc59fbe443d0','Pendiente','Juzgado 4','2025-12-01','2025-12-14','Fisico','Conductor 4','CASO-6302','TRANSITO','316996db-16db-4ed7-ad4d-c1199f70e138','2025-12-02 00:06:02','2025-12-02 00:06:02');
/*!40000 ALTER TABLE `expedientes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `id` varchar(36) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `personas` VALUES
('19961cd8-811f-433d-a22b-67fb870f0e6c','Sofia Lopez','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('1fb9f5b9-9e5a-4675-9921-abc9a6a422ce','Carmen Torres','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('20bcae7c-66d7-4bd5-a46b-74088a84a8bf','Diego Flores','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('8c32f082-1141-45b0-8254-c0497ed319d5','Ana Martinez','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('9f3061ea-647d-4b0e-ab3b-c9b213ed6173','Luis Fernandez','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('a6457a5c-9695-41b7-962a-5d40b5c6faec','Pedro Sanchez','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('af13e630-628f-4d35-86cd-ce415d91dbc4','Jorge Ramirez','2025-12-02 00:06:02','2025-12-02 00:06:02');
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` varchar(36) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `usuarios` VALUES
('0408772d-1636-4ecf-9248-6fbbef883ea8','Maria Gomez','maria.gomez','$2b$14$zGTrV6sM71yY15hTm79k2O6myyLQjjginMWAYeYMfS7PMCfNhL/BG','2025-12-02 00:06:01','2025-12-02 00:06:01'),
('316996db-16db-4ed7-ad4d-c1199f70e138','Carlos Ruiz','carlos.ruiz','$2b$14$1eHtspMXU3dflEbFtqAEPuJy5Ys5kz53dHOIMiP4nLNpx8.5sYXOC','2025-12-02 00:06:02','2025-12-02 00:06:02'),
('4ee3a1ca-52cc-43be-843b-e06020096ecd','Juan Perez','juan.perez','$2b$14$DPJ2idgoJ2vjkc8QhoIj9.sATHmvIDVLhCYhs7puKFCbZVbCYUtmq','2025-12-02 00:06:00','2025-12-02 00:06:00');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Temporary table structure for view `vista_conteo_expedientes`
--

DROP TABLE IF EXISTS `vista_conteo_expedientes`;
/*!50001 DROP VIEW IF EXISTS `vista_conteo_expedientes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_conteo_expedientes` AS SELECT
 1 AS `estado`,
  1 AS `usuario_id`,
  1 AS `conteo` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_expedientes`
--

DROP TABLE IF EXISTS `vista_expedientes`;
/*!50001 DROP VIEW IF EXISTS `vista_expedientes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_expedientes` AS SELECT
 1 AS `id`,
  1 AS `usuario_id`,
  1 AS `aseguradora`,
  1 AS `asegurado`,
  1 AS `juzgado`,
  1 AS `fecha_inicio`,
  1 AS `fecha_finalizacion` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_expedientes_totales`
--

DROP TABLE IF EXISTS `vista_expedientes_totales`;
/*!50001 DROP VIEW IF EXISTS `vista_expedientes_totales`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_expedientes_totales` AS SELECT
 1 AS `aseguradora`,
  1 AS `tipo_de_proceso`,
  1 AS `abogado`,
  1 AS `fecha_inicio`,
  1 AS `asegurado` */;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `SIS-EXP`
--

USE `SIS-EXP`;

--
-- Final view structure for view `vista_conteo_expedientes`
--

/*!50001 DROP VIEW IF EXISTS `vista_conteo_expedientes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_conteo_expedientes` AS select `expedientes`.`estado` AS `estado`,`expedientes`.`usuario_id` AS `usuario_id`,count(0) AS `conteo` from `expedientes` group by `expedientes`.`usuario_id`,`expedientes`.`estado` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_expedientes`
--

/*!50001 DROP VIEW IF EXISTS `vista_expedientes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_expedientes` AS select `e`.`id` AS `id`,`e`.`usuario_id` AS `usuario_id`,`a`.`nombre` AS `aseguradora`,`p`.`nombre_completo` AS `asegurado`,`e`.`juzgado` AS `juzgado`,`e`.`fecha_inicio` AS `fecha_inicio`,`e`.`fecha_finalizacion` AS `fecha_finalizacion` from (((`expedientes` `e` join `aseguradoras` `a` on(`a`.`id` = `e`.`aseguradora_id`)) join `personas` `p` on(`a`.`id_persona` = `p`.`id`)) join `usuarios` `u` on(`e`.`abogado_id` = `u`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_expedientes_totales`
--

/*!50001 DROP VIEW IF EXISTS `vista_expedientes_totales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_expedientes_totales` AS select `a`.`nombre` AS `aseguradora`,`e`.`tipo_de_proceso` AS `tipo_de_proceso`,`u`.`nombre_completo` AS `abogado`,`e`.`fecha_inicio` AS `fecha_inicio`,`p`.`nombre_completo` AS `asegurado` from (((`expedientes` `e` join `aseguradoras` `a` on(`a`.`id` = `e`.`aseguradora_id`)) join `personas` `p` on(`a`.`id_persona` = `p`.`id`)) join `usuarios` `u` on(`e`.`abogado_id` = `u`.`id`)) */;
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
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-12-02  3:13:36
