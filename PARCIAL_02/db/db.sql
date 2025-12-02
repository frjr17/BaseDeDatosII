CREATE DATABASE IF NOT EXISTS `SIS-EXP`;

USE `SIS-EXP`;

CREATE TABLE
    IF NOT EXISTS usuarios (
        id VARCHAR(36) NOT NULL PRIMARY KEY,
        nombre_completo VARCHAR(100) NOT NULL,
        contraseña VARCHAR(255) NOT NULL,
        sesion_activa BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

CREATE TABLE
    IF NOT EXISTS aseguradoras (
        id VARCHAR(36) NOT NULL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        asegurado VARCHAR(100) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

CREATE TABLE
    IF NOT EXISTS expedientes (
        id VARCHAR(36) NOT NULL PRIMARY KEY,
        usuario_id VARCHAR(36) NOT NULL,
        aseguradora_id VARCHAR(36) NOT NULL,
        estado ENUM ('Pendiente', 'En curso', 'Cerrado') NOT NULL DEFAULT 'Pendiente',
        juzgado VARCHAR(255) NOT NULL,
        fecha_inicio DATE,
        fecha_finalizacion DATE,
        formato VARCHAR(50),
        conductor VARCHAR(255),
        numero_de_caso VARCHAR(50),
        tipo_de_proceso ENUM ('TRANSITO', 'PENAL') NOT NULL,
        abogado_id VARCHAR(36) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT `fk_expediente_usuario` FOREIGN KEY (usuario_id) REFERENCES usuarios (id),
        CONSTRAINT `fk_expediente_aseguradora` FOREIGN KEY (aseguradora_id) REFERENCES aseguradoras (id),
        CONSTRAINT `fk_expediente_abogado` FOREIGN KEY (abogado_id) REFERENCES usuarios (id)
    );

CREATE TABLE
    IF NOT EXISTS aseguradoras (
        id VARCHAR(36) NOT NULL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        id_persona VARCHAR(36) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (id_persona) REFERENCES personas (id)
    );

CREATE TABLE
    IF NOT EXISTS personas (
        id VARCHAR(36) NOT NULL PRIMARY KEY,
        nombre_completo VARCHAR(100) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );