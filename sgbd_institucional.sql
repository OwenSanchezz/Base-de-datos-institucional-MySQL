-- Autor: Owen Yamil Campuzano Sanchez (@owensanchezz) | Universidad ICEL, Ingeniería en Desarrollo de Software y Aplicaciones
-- Base de datos institucional: empleados, equipos, roles, bitácora y respaldos
-- Motor: MySQL 8.x

CREATE DATABASE IF NOT EXISTS sgbd_institucional
  CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE sgbd_institucional;

SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------
-- Tabla: departamentos
-- ------------------------------------------------
DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos` (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `nombre_departamento` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `ubicacion` varchar(150) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_departamento`),
  UNIQUE KEY `nombre_departamento` (`nombre_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO `departamentos` VALUES (1,'Tecnología de la Información','Edificio A, Piso 3'),(2,'Recursos Humanos','Edificio B, Piso 1'),(3,'Contabilidad','Edificio B, Piso 2'),(4,'Soporte Técnico','Edificio A, Piso 1'),(5,'Dirección General','Edificio C, Piso 5');

-- ------------------------------------------------
-- Tabla: empleados
-- ------------------------------------------------
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `apellido` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `puesto` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` varchar(150) COLLATE utf8mb4_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `id_departamento` int NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE KEY `correo` (`correo`),
  KEY `id_departamento` (`id_departamento`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO `empleados` VALUES (1,'Carlos','Ramírez Torres','Analista de Sistemas','c.ramirez@empresa.com','5551001001',1),(2,'María','López Herrera','Desarrolladora Web','m.lopez@empresa.com','5551001002',1),(3,'Jorge','Pérez Sánchez','Administrador de BD','j.perez@empresa.com','5551001003',1),(4,'Ana','Gutiérrez Díaz','Especialista en Redes','a.gutierrez@empresa.com','5551001004',1),(5,'Luis','Martínez Vega','Gerente de RRHH','l.martinez@empresa.com','5551001005',2),(6,'Patricia','Flores Mora','Reclutadora','p.flores@empresa.com','5551001006',2),(7,'Roberto','Jiménez Castro','Contador Senior','r.jimenez@empresa.com','5551001007',3),(8,'Sofía','Hernández Ruiz','Auxiliar Contable','s.hernandez@empresa.com','5551001008',3),(9,'Miguel','Torres Reyes','Técnico de Soporte N1','m.torres@empresa.com','5551001009',4),(10,'Gabriela','Morales Luna','Técnico de Soporte N2','g.morales@empresa.com','5551001010',4),(11,'Fernando','Cruz Mendoza','Técnico de Soporte N3','f.cruz@empresa.com','5551001011',4),(12,'Alejandra','Vargas Ibáñez','Directora General','a.vargas@empresa.com','5551001012',5),(13,'Ricardo','Núñez Campos','Asistente de Dirección','r.nunez@empresa.com','5551001013',5),(14,'Valeria','Ortega Pineda','Desarrolladora Móvil','v.ortega@empresa.com','5551001014',1),(15,'Daniel','Aguilar Soto','Auditor de Sistemas','d.aguilar@empresa.com','5551001015',1);

-- ------------------------------------------------
-- Tabla: equipos
-- ------------------------------------------------
DROP TABLE IF EXISTS `equipos`;
CREATE TABLE `equipos` (
  `id_equipo` int NOT NULL AUTO_INCREMENT,
  `tipo_equipo` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `marca` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `modelo` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `numero_serie` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` enum('Activo','Inactivo','En reparación') COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'Activo',
  `id_empleado` int NOT NULL,
  PRIMARY KEY (`id_equipo`),
  UNIQUE KEY `numero_serie` (`numero_serie`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `equipos_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO `equipos` VALUES (1,'Laptop','Dell','Latitude 5520','SN-DELL-001','Activo',1),(2,'Laptop','HP','EliteBook 840','SN-HP-002','Activo',2),(3,'Desktop','Lenovo','ThinkCentre M720','SN-LEN-003','Activo',3),(4,'Monitor','LG','27UK850','SN-LG-004','Activo',3),(5,'Laptop','Dell','Inspiron 15','SN-DELL-005','Activo',4),(6,'Laptop','HP','ProBook 450','SN-HP-006','Activo',5),(7,'Desktop','Acer','Aspire TC','SN-ACE-007','Inactivo',6),(8,'Laptop','Dell','Vostro 3500','SN-DELL-008','Activo',7),(9,'Desktop','HP','ProDesk 400','SN-HP-009','Activo',8),(10,'Laptop','Lenovo','ThinkPad E15','SN-LEN-010','En reparación',9),(11,'Laptop','Asus','VivoBook 15','SN-ASU-011','Activo',10),(12,'Desktop','Dell','OptiPlex 7090','SN-DELL-012','Activo',11),(13,'Laptop','Apple','MacBook Pro 14','SN-APL-013','Activo',12),(14,'Laptop','HP','Spectre x360','SN-HP-014','Activo',13),(15,'Laptop','Lenovo','IdeaPad 5','SN-LEN-015','Activo',14);

-- ------------------------------------------------
-- Tabla: usuariossistema
-- ------------------------------------------------
DROP TABLE IF EXISTS `usuariossistema`;
CREATE TABLE `usuariossistema` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `rol` enum('Administrador','Consulta','Captura','Auditor') COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_creacion` date NOT NULL DEFAULT (curdate()),
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO `usuariossistema` VALUES (1,'admin_db','Administrador','2024-01-10','Activo'),(2,'consulta_rrhh','Consulta','2024-01-15','Activo'),(3,'captura_cont','Captura','2024-02-01','Activo'),(4,'auditor_tic','Auditor','2024-02-10','Activo'),(5,'consulta_dir','Consulta','2024-03-01','Inactivo');

-- ------------------------------------------------
-- Tabla: bitacoraaccesos
-- ------------------------------------------------
DROP TABLE IF EXISTS `bitacoraaccesos`;
CREATE TABLE `bitacoraaccesos` (
  `id_acceso` int NOT NULL AUTO_INCREMENT,
  `fecha_hora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `accion_realizada` varchar(200) COLLATE utf8mb4_spanish_ci NOT NULL,
  `tabla_afectada` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_acceso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO `bitacoraaccesos` VALUES (1,'2024-04-01 08:05:00','admin_db','CREATE TABLE','Empleados'),(2,'2024-04-01 08:30:00','admin_db','INSERT','Departamentos'),(3,'2024-04-02 09:00:00','captura_cont','INSERT','Empleados'),(4,'2024-04-02 10:15:00','captura_cont','UPDATE','Empleados'),(5,'2024-04-03 11:00:00','consulta_rrhh','SELECT','Empleados'),(6,'2024-04-04 08:45:00','auditor_tic','SELECT','BitacoraAccesos'),(7,'2024-04-05 09:30:00','admin_db','GRANT','UsuariosSistema'),(8,'2024-04-06 14:00:00','captura_cont','INSERT','Equipos'),(9,'2024-04-07 16:20:00','consulta_rrhh','SELECT','Departamentos'),(10,'2024-04-08 07:55:00','admin_db','REVOKE','UsuariosSistema');

-- ------------------------------------------------
-- Tabla: respaldos
-- ------------------------------------------------
DROP TABLE IF EXISTS `respaldos`;
CREATE TABLE `respaldos` (
  `id_respaldo` int NOT NULL AUTO_INCREMENT,
  `fecha_respaldo` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_respaldo` enum('Completo','Incremental','Diferencial') COLLATE utf8mb4_spanish_ci NOT NULL,
  `responsable` varchar(150) COLLATE utf8mb4_spanish_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_spanish_ci,
  PRIMARY KEY (`id_respaldo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO `respaldos` VALUES (1,'2024-04-01 22:00:00','Completo','j.perez@empresa.com','Respaldo inicial del sistema'),(2,'2024-04-07 22:00:00','Diferencial','j.perez@empresa.com','Respaldo semanal programado'),(3,'2024-04-14 22:00:00','Diferencial','j.perez@empresa.com','Respaldo semanal programado'),(4,'2024-04-21 22:00:00','Incremental','d.aguilar@empresa.com','Respaldo por auditoría'),(5,'2024-04-30 23:59:00','Completo','j.perez@empresa.com','Cierre de mes');

SET FOREIGN_KEY_CHECKS = 1;
