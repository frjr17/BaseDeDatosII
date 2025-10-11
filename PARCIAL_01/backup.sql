/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.0.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: parcial1
-- ------------------------------------------------------
-- Server version	12.0.2-MariaDB-ubu2404

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
-- Current Database: `parcial1`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `parcial1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;

USE `parcial1`;

--
-- Table structure for table `autenticaciones`
--

DROP TABLE IF EXISTS `autenticaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `autenticaciones` (
  `id_autenticacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(60) NOT NULL,
  `contrasena_hash` varchar(255) NOT NULL,
  `agente_usuario` varchar(200) NOT NULL,
  `nombre_dispositivo` varchar(120) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  PRIMARY KEY (`id_autenticacion`),
  UNIQUE KEY `token` (`token`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `autenticaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autenticaciones`
--

LOCK TABLES `autenticaciones` WRITE;
/*!40000 ALTER TABLE `autenticaciones` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `autenticaciones` VALUES
(1,1,'juan.perez','hash_juan','Mozilla/5.0 (Windows)','PC-Juan','auth_tok_1'),
(2,2,'ana.gomez','hash_ana','Mozilla/5.0 (iPhone)','iPhone-Ana','auth_tok_2'),
(3,3,'carlos.lopez','hash_carlos','Mozilla/5.0 (Linux)','PC-Carlos','auth_tok_3'),
(4,4,'lucia.m','hash_lucia','Mozilla/5.0 (Macintosh)','Mac-Lucia','auth_tok_4'),
(5,5,'maria.r','hash_maria','Mozilla/5.0 (Android)','Pixel-Maria','auth_tok_5'),
(6,6,'pedro.r','hash_pedro','Mozilla/5.0 (Windows)','PC-Pedro','auth_tok_6'),
(7,7,'sofia.v','hash_sofia','Mozilla/5.0 (iPad)','iPad-Sofia','auth_tok_7'),
(8,8,'miguel.t','hash_miguel','Mozilla/5.0 (Windows)','PC-Miguel','auth_tok_8'),
(9,9,'laura.s','hash_laura','Mozilla/5.0 (Android)','SG-LAURA','auth_tok_9'),
(10,10,'diego.f','hash_diego','Mozilla/5.0 (Linux)','PC-Diego','auth_tok_10'),
(11,11,'elena.r','hash_elena','Mozilla/5.0 (Macintosh)','Mac-Elena','auth_tok_11'),
(12,12,'rafael.g','hash_rafael','Mozilla/5.0 (Windows)','PC-Rafael','auth_tok_12'),
(13,13,'isabel.m','hash_isabel','Mozilla/5.0 (Android)','Phone-Isabel','auth_tok_13'),
(14,14,'andres.c','hash_andres','Mozilla/5.0 (iPhone)','iPhone-Andres','auth_tok_14'),
(15,15,'patricia.d','hash_patricia','Mozilla/5.0 (Windows)','PC-Patricia','auth_tok_15'),
(16,16,'fernando.o','hash_fernando','Mozilla/5.0 (Linux)','PC-Fernando','auth_tok_16'),
(17,17,'veronica.c','hash_veronica','Mozilla/5.0 (Android)','Phone-Veronica','auth_tok_17'),
(18,18,'jorge.s','hash_jorge','Mozilla/5.0 (Windows)','PC-Jorge','auth_tok_18'),
(19,19,'natalia.b','hash_natalia','Mozilla/5.0 (iPhone)','iPhone-Natalia','auth_tok_19'),
(20,20,'oscar.r','hash_oscar','Mozilla/5.0 (Windows)','PC-Oscar','auth_tok_20');
/*!40000 ALTER TABLE `autenticaciones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `metodos_pago`
--

DROP TABLE IF EXISTS `metodos_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodos_pago` (
  `id_metodo_pago` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `tipo` enum('debito','credito') NOT NULL DEFAULT 'credito',
  `marca` varchar(25) NOT NULL,
  `titular` varchar(120) NOT NULL,
  `pan_enmascarado` varchar(25) NOT NULL,
  `ultimos4` varchar(4) NOT NULL,
  `exp_mes` int(11) NOT NULL CHECK (`exp_mes` between 1 and 12),
  `exp_anio` int(11) NOT NULL CHECK (`exp_anio` between 2000 and 2100),
  `token` varchar(255) NOT NULL,
  `es_predeterminado` tinyint(1) NOT NULL DEFAULT 0,
  `creado_en` datetime NOT NULL DEFAULT current_timestamp(),
  `actualizado_en` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_metodo_pago`),
  UNIQUE KEY `token` (`token`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `metodos_pago_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodos_pago`
--

LOCK TABLES `metodos_pago` WRITE;
/*!40000 ALTER TABLE `metodos_pago` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `metodos_pago` VALUES
(1,1,'credito','VISA','Juan Pérez','**** **** **** 1111','1111',12,2025,'pm_tok_1',1,'2025-10-11 02:46:22',NULL),
(2,2,'debito','MASTERCARD','Ana Gómez','**** **** **** 2222','2222',11,2024,'pm_tok_2',0,'2025-10-11 02:46:22',NULL),
(3,3,'credito','VISA','Carlos López','**** **** **** 3333','3333',10,2026,'pm_tok_3',0,'2025-10-11 02:46:22',NULL),
(4,4,'credito','AMEX','Lucía Martínez','**** **** **** 4444','4444',9,2025,'pm_tok_4',1,'2025-10-11 02:46:22',NULL),
(5,5,'debito','VISA','María Rodríguez','**** **** **** 5555','5555',8,2027,'pm_tok_5',0,'2025-10-11 02:46:22',NULL),
(6,6,'credito','MASTERCARD','Pedro Ramírez','**** **** **** 6666','6666',7,2026,'pm_tok_6',0,'2025-10-11 02:46:22',NULL),
(7,7,'credito','VISA','Sofía Vega','**** **** **** 7777','7777',6,2025,'pm_tok_7',1,'2025-10-11 02:46:22',NULL),
(8,8,'debito','VISA','Miguel Torres','**** **** **** 8888','8888',5,2024,'pm_tok_8',0,'2025-10-11 02:46:22',NULL),
(9,9,'credito','MASTERCARD','Laura Suárez','**** **** **** 9999','9999',4,2026,'pm_tok_9',0,'2025-10-11 02:46:22',NULL),
(10,10,'credito','VISA','Diego Flores','**** **** **** 0001','0001',3,2025,'pm_tok_10',1,'2025-10-11 02:46:22',NULL),
(11,11,'debito','VISA','Elena Ríos','**** **** **** 1010','1010',2,2027,'pm_tok_11',0,'2025-10-11 02:46:22',NULL),
(12,12,'credito','MASTERCARD','Rafael Guerra','**** **** **** 1212','1212',1,2026,'pm_tok_12',0,'2025-10-11 02:46:22',NULL),
(13,13,'credito','VISA','Isabel Mora','**** **** **** 1313','1313',12,2025,'pm_tok_13',1,'2025-10-11 02:46:22',NULL),
(14,14,'debito','VISA','Andrés Cruz','**** **** **** 1414','1414',11,2024,'pm_tok_14',0,'2025-10-11 02:46:22',NULL),
(15,15,'credito','MASTERCARD','Patricia Díaz','**** **** **** 1515','1515',10,2026,'pm_tok_15',0,'2025-10-11 02:46:22',NULL),
(16,16,'credito','VISA','Fernando Oliva','**** **** **** 1616','1616',9,2025,'pm_tok_16',1,'2025-10-11 02:46:22',NULL),
(17,17,'debito','VISA','Verónica Campos','**** **** **** 1717','1717',8,2027,'pm_tok_17',0,'2025-10-11 02:46:22',NULL),
(18,18,'credito','MASTERCARD','Jorge Salas','**** **** **** 1818','1818',7,2026,'pm_tok_18',0,'2025-10-11 02:46:22',NULL),
(19,19,'credito','VISA','Natalia Bravo','**** **** **** 1919','1919',6,2025,'pm_tok_19',1,'2025-10-11 02:46:22',NULL),
(20,20,'debito','MASTERCARD','Óscar Reyes','**** **** **** 2020','2020',5,2024,'pm_tok_20',0,'2025-10-11 02:46:22',NULL);
/*!40000 ALTER TABLE `metodos_pago` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tipos_pruebas`
--

DROP TABLE IF EXISTS `tipos_pruebas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_pruebas` (
  `id_tipo_prueba` int(11) NOT NULL AUTO_INCREMENT,
  `referencia` varchar(50) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_ingreso` date NOT NULL DEFAULT curdate(),
  `estado` enum('activo','desactivado') NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_tipo_prueba`),
  UNIQUE KEY `referencia` (`referencia`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_pruebas`
--

LOCK TABLES `tipos_pruebas` WRITE;
/*!40000 ALTER TABLE `tipos_pruebas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tipos_pruebas` VALUES
(1,'PRB-001','Reconocimiento','Fase de recolección de información','2025-10-11','activo'),
(2,'PRB-002','Análisis de Vulnerabilidades','Identificación y evaluación de debilidades','2025-10-11','activo'),
(3,'PRB-003','Explotación','Uso de vulnerabilidades para obtener acceso','2025-10-11','activo'),
(4,'PRB-004','Escalar Privilegios o Post-Explotación','Acciones posteriores para ampliar acceso','2025-10-11','activo');
/*!40000 ALTER TABLE `tipos_pruebas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tipos_usuarios`
--

DROP TABLE IF EXISTS `tipos_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_usuarios` (
  `id_tipo_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_usuario`),
  UNIQUE KEY `tipo` (`tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_usuarios`
--

LOCK TABLES `tipos_usuarios` WRITE;
/*!40000 ALTER TABLE `tipos_usuarios` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tipos_usuarios` VALUES
(1,'Cliente','Usuario cliente estándar'),
(2,'Administrador','Usuario con privilegios de administración'),
(3,'Vendedor','Usuario del equipo de ventas'),
(4,'Ejecutivo','Usuario ejecutivo o gerente'),
(5,'Otro','Otro tipo de usuario'),
(6,'Cliente_Premium','Cliente con privilegios premium'),
(7,'Soporte','Equipo de soporte técnico'),
(8,'Auditor','Usuario con permisos de auditoría'),
(9,'Analista','Analista de seguridad'),
(10,'Operaciones','Equipo de operaciones'),
(11,'Interno','Usuario interno de la empresa'),
(12,'Externo','Usuario externo/contratista'),
(13,'Pruebas','Cuenta para pruebas'),
(14,'Supervisor','Supervisor de procesos'),
(15,'Gerente_Regional','Gerente regional'),
(16,'Consultor','Consultor externo'),
(17,'Automatizacion','Cuentas de automatización/servicios'),
(18,'Marketing','Equipo de marketing'),
(19,'Ventas_Directas','Vendedores directos'),
(20,'Partner','Socio comercial');
/*!40000 ALTER TABLE `tipos_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `nombre_usuario` varchar(60) NOT NULL,
  `contrasena_hash` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `ciudad` varchar(120) DEFAULT NULL,
  `sexo` enum('masculino','femenino','otro','prefiere_no_decir') DEFAULT NULL,
  `estado_civil` enum('soltero','casado','divorciado','viudo','union_libre','prefiere_no_decir') DEFAULT NULL,
  `tipo_empresa` enum('publica','privada') DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT current_timestamp(),
  `actualizado_en` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `token` (`token`),
  KEY `id_tipo_usuario` (`id_tipo_usuario`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipos_usuarios` (`id_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `usuarios` VALUES
(1,'Juan','Pérez','juan.perez','hash_juan','tok_u_1','Ciudad A','masculino','soltero','privada','Calle Los Olivos 123',1,'2025-10-11 02:46:22',NULL),
(2,'Ana','Gómez','ana.gomez','hash_ana','tok_u_2','Ciudad B','femenino','casado','privada','Avenida Libertad 456',2,'2025-10-11 02:46:22',NULL),
(3,'Carlos','López','carlos.lopez','hash_carlos','tok_u_3','Ciudad C','masculino','casado','privada','Calle San Martín 234',3,'2025-10-11 02:46:22',NULL),
(4,'Lucía','Martínez','lucia.m','hash_lucia','tok_u_4','Ciudad D','femenino','soltero','publica','Avenida Principal 980',4,'2025-10-11 02:46:22',NULL),
(5,'María','Rodríguez','maria.r','hash_maria','tok_u_5','Ciudad E','femenino','casado','privada','Calle Las Flores 77',1,'2025-10-11 02:46:22',NULL),
(6,'Pedro','Ramírez','pedro.r','hash_pedro','tok_u_6','Ciudad F','masculino','soltero','privada','Calle Nueva 512',2,'2025-10-11 02:46:22',NULL),
(7,'Sofía','Vega','sofia.v','hash_sofia','tok_u_7','Ciudad G','femenino','union_libre','publica','Avenida del Parque 301',3,'2025-10-11 02:46:22',NULL),
(8,'Miguel','Torres','miguel.t','hash_miguel','tok_u_8','Ciudad H','masculino','divorciado','privada','Calle Río Negro 48',4,'2025-10-11 02:46:22',NULL),
(9,'Laura','Suárez','laura.s','hash_laura','tok_u_9','Ciudad I','femenino','viudo','privada','Boulevard Central 150',5,'2025-10-11 02:46:22',NULL),
(10,'Diego','Flores','diego.f','hash_diego','tok_u_10','Ciudad J','masculino','soltero','privada','Calle 9 de Julio 210',1,'2025-10-11 02:46:22',NULL),
(11,'Elena','Ríos','elena.r','hash_elena','tok_u_11','Ciudad K','femenino','casado','privada','Avenida Constitución 1420',2,'2025-10-11 02:46:22',NULL),
(12,'Rafael','Guerra','rafael.g','hash_rafael','tok_u_12','Ciudad L','masculino','soltero','privada','Calle Bella Vista 85',3,'2025-10-11 02:46:22',NULL),
(13,'Isabel','Mora','isabel.m','hash_isabel','tok_u_13','Ciudad M','femenino','casado','publica','Paseo de la Alameda 320',4,'2025-10-11 02:46:22',NULL),
(14,'Andrés','Cuz','andres.c','hash_andres','tok_u_14','Ciudad N','masculino','soltero','privada','Calle Los Cedros 228',5,'2025-10-11 02:46:22',NULL),
(15,'Patricia','Díaz','patricia.d','hash_patricia','tok_u_15','Ciudad O','femenino','casado','privada','Avenida Córdoba 1150',1,'2025-10-11 02:46:22',NULL),
(16,'Fernando','Oliva','fernando.o','hash_fernando','tok_u_16','Ciudad P','masculino','soltero','privada','Calle La Paz 64',2,'2025-10-11 02:46:22',NULL),
(17,'Verónica','Campos','veronica.c','hash_veronica','tok_u_17','Ciudad Q','femenino','union_libre','publica','Pasaje Los Alerces 19',3,'2025-10-11 02:46:22',NULL),
(18,'Jorge','Salas','jorge.s','hash_jorge','tok_u_18','Ciudad R','masculino','casado','privada','Calle El Bosque 742',4,'2025-10-11 02:46:22',NULL),
(19,'Natalia','Bravo','natalia.b','hash_natalia','tok_u_19','Ciudad S','femenino','soltero','privada','Avenida Colón 560',5,'2025-10-11 02:46:22',NULL),
(20,'Óscar','Reyes','oscar.r','hash_oscar','tok_u_20','Ciudad T','masculino','divorciado','privada','Calle Santa María 403',1,'2025-10-11 02:46:22',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Temporary table structure for view `v_autenticaciones`
--

DROP TABLE IF EXISTS `v_autenticaciones`;
/*!50001 DROP VIEW IF EXISTS `v_autenticaciones`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_autenticaciones` AS SELECT
 1 AS `id_autenticacion`,
  1 AS `fecha_consulta`,
  1 AS `usuario_registrado`,
  1 AS `agente_usuario`,
  1 AS `nombre_dispositivo`,
  1 AS `token`,
  1 AS `id_usuario`,
  1 AS `apellido`,
  1 AS `ciudad`,
  1 AS `tipo_empresa` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mediosPago`
--

DROP TABLE IF EXISTS `v_mediosPago`;
/*!50001 DROP VIEW IF EXISTS `v_mediosPago`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_mediosPago` AS SELECT
 1 AS `id_metodo_pago`,
  1 AS `tipo_pago`,
  1 AS `marca`,
  1 AS `titular`,
  1 AS `ultimos4`,
  1 AS `es_predeterminado`,
  1 AS `id_usuario`,
  1 AS `nombre`,
  1 AS `apellido`,
  1 AS `estado_civil`,
  1 AS `direccion` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_totalesPorEmpresa`
--

DROP TABLE IF EXISTS `v_totalesPorEmpresa`;
/*!50001 DROP VIEW IF EXISTS `v_totalesPorEmpresa`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_totalesPorEmpresa` AS SELECT
 1 AS `tipo_empresa`,
  1 AS `total_usuarios` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_usuarioSistema`
--

DROP TABLE IF EXISTS `v_usuarioSistema`;
/*!50001 DROP VIEW IF EXISTS `v_usuarioSistema`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_usuarioSistema` AS SELECT
 1 AS `id_usuario`,
  1 AS `nombre`,
  1 AS `apellido`,
  1 AS `nombre_usuario`,
  1 AS `ciudad`,
  1 AS `tipo_empresa`,
  1 AS `id_tipo_usuario`,
  1 AS `nombre_tipo_usuario` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_usuariosPorEmpresa`
--

DROP TABLE IF EXISTS `v_usuariosPorEmpresa`;
/*!50001 DROP VIEW IF EXISTS `v_usuariosPorEmpresa`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_usuariosPorEmpresa` AS SELECT
 1 AS `id_usuario`,
  1 AS `nombre`,
  1 AS `apellido`,
  1 AS `tipo_empresa` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'parcial1'
--

--
-- Dumping routines for database 'parcial1'
--

--
-- Current Database: `parcial1`
--

USE `parcial1`;

--
-- Final view structure for view `v_autenticaciones`
--

/*!50001 DROP VIEW IF EXISTS `v_autenticaciones`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_autenticaciones` AS select `a`.`id_autenticacion` AS `id_autenticacion`,current_timestamp() AS `fecha_consulta`,`a`.`nombre_usuario` AS `usuario_registrado`,`a`.`agente_usuario` AS `agente_usuario`,`a`.`nombre_dispositivo` AS `nombre_dispositivo`,`a`.`token` AS `token`,`u`.`id_usuario` AS `id_usuario`,`u`.`apellido` AS `apellido`,`u`.`ciudad` AS `ciudad`,`u`.`tipo_empresa` AS `tipo_empresa` from (`autenticaciones` `a` left join `usuarios` `u` on(`a`.`id_usuario` = `u`.`id_usuario`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mediosPago`
--

/*!50001 DROP VIEW IF EXISTS `v_mediosPago`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_mediosPago` AS select `mp`.`id_metodo_pago` AS `id_metodo_pago`,`mp`.`tipo` AS `tipo_pago`,`mp`.`marca` AS `marca`,`mp`.`titular` AS `titular`,`mp`.`ultimos4` AS `ultimos4`,`mp`.`es_predeterminado` AS `es_predeterminado`,`u`.`id_usuario` AS `id_usuario`,`u`.`nombre` AS `nombre`,`u`.`apellido` AS `apellido`,`u`.`estado_civil` AS `estado_civil`,`u`.`direccion` AS `direccion` from (`metodos_pago` `mp` join `usuarios` `u` on(`mp`.`id_usuario` = `u`.`id_usuario`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_totalesPorEmpresa`
--

/*!50001 DROP VIEW IF EXISTS `v_totalesPorEmpresa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_totalesPorEmpresa` AS select `usuarios`.`tipo_empresa` AS `tipo_empresa`,count(0) AS `total_usuarios` from `usuarios` group by `usuarios`.`tipo_empresa` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_usuarioSistema`
--

/*!50001 DROP VIEW IF EXISTS `v_usuarioSistema`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_usuarioSistema` AS select `u`.`id_usuario` AS `id_usuario`,`u`.`nombre` AS `nombre`,`u`.`apellido` AS `apellido`,`u`.`nombre_usuario` AS `nombre_usuario`,`u`.`ciudad` AS `ciudad`,`u`.`tipo_empresa` AS `tipo_empresa`,`tu`.`id_tipo_usuario` AS `id_tipo_usuario`,`tu`.`tipo` AS `nombre_tipo_usuario` from (`usuarios` `u` left join `tipos_usuarios` `tu` on(`u`.`id_tipo_usuario` = `tu`.`id_tipo_usuario`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_usuariosPorEmpresa`
--

/*!50001 DROP VIEW IF EXISTS `v_usuariosPorEmpresa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_usuariosPorEmpresa` AS select `usuarios`.`id_usuario` AS `id_usuario`,`usuarios`.`nombre` AS `nombre`,`usuarios`.`apellido` AS `apellido`,`usuarios`.`tipo_empresa` AS `tipo_empresa` from `usuarios` */;
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

-- Dump completed on 2025-10-11  2:56:43
