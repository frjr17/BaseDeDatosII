CREATE DATABASE IF NOT EXISTS parcial1;
USE parcial1;

-- Tipos de usuarios
CREATE TABLE tipos_usuarios (
    id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

-- Tabla de Usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre_usuario VARCHAR(60) NOT NULL UNIQUE,
    contrasena_hash VARCHAR(255) NOT NULL,
    token VARCHAR(255) UNIQUE,
    ciudad VARCHAR(120),
    sexo ENUM('masculino','femenino','otro','prefiere_no_decir'),
    estado_civil ENUM('soltero','casado','divorciado','viudo','union_libre','prefiere_no_decir'),
    tipo_empresa ENUM('publica','privada'),
    direccion VARCHAR(255),
    id_tipo_usuario INT NOT NULL,
    creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_tipo_usuario) REFERENCES tipos_usuarios(id_tipo_usuario)      
);

-- Módulo de autenticación (sesiones / accesos)
CREATE TABLE autenticaciones (
    id_autenticacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre_usuario VARCHAR(60) NOT NULL,
    contrasena_hash VARCHAR(255) NOT NULL,
    agente_usuario VARCHAR(200) NOT NULL,
    nombre_dispositivo VARCHAR(120),
    token VARCHAR(255) NOT NULL UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Catálogo de tipos de pruebas
CREATE TABLE tipos_pruebas (
    id_tipo_prueba INT AUTO_INCREMENT PRIMARY KEY,
    referencia VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(120) NOT NULL,
    descripcion TEXT,
    fecha_ingreso DATE NOT NULL DEFAULT (CURRENT_DATE),
    estado ENUM('activo','desactivado') NOT NULL DEFAULT 'activo'
);

-- Registros iniciales (sin "Informe")
INSERT INTO tipos_pruebas (referencia, nombre, descripcion, estado)
VALUES
    ('PRB-001', 'Reconocimiento', 'Fase de recolección de información', 'activo'),
    ('PRB-002', 'Análisis de Vulnerabilidades', 'Identificación y evaluación de debilidades', 'activo'),
    ('PRB-003', 'Explotación', 'Uso de vulnerabilidades para obtener acceso', 'activo'),
    ('PRB-004', 'Escalar Privilegios o Post-Explotación', 'Acciones posteriores para ampliar acceso', 'activo');

-- Módulo de pago
CREATE TABLE metodos_pago (
    id_metodo_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo ENUM('debito','credito') NOT NULL DEFAULT 'credito',
    marca VARCHAR(50) NOT NULL,
    titular VARCHAR(120) NOT NULL,
    pan_enmascarado VARCHAR(25) NOT NULL,        -- **** **** **** 1234
    ultimos4 CHAR(4) NOT NULL,
    exp_mes INT NOT NULL CHECK (exp_mes BETWEEN 1 AND 12),
    exp_anio INT NOT NULL CHECK (exp_anio BETWEEN 2000 AND 2100),
    token VARCHAR(255) NOT NULL UNIQUE, 
    es_predeterminado BOOLEAN NOT NULL DEFAULT FALSE,
    creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);
