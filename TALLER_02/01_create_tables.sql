-- 01_create_tables.sql
-- Creación de la base de datos y tablas

DROP DATABASE IF EXISTS empresa_taller02;
CREATE DATABASE empresa_taller02;

USE empresa_taller02;

-- Tabla de Perfiles
CREATE TABLE perfiles (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    nombre_perfil VARCHAR(50) NOT NULL,
    fecha_vigencia_perfil DATE NOT NULL,
    descripcion_perfil TEXT,
    encargado_perfil INT
);

-- Tabla de Usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    estado ENUM('activo', 'inactivo') NOT NULL DEFAULT 'activo',
    contrasena VARCHAR(255) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    id_perfil INT NOT NULL,
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
);

-- Nota: la siguiente alteración crea una FK circular (perfiles.encargado_perfil -> usuarios.id_usuario).
-- Se mantiene el mismo comportamiento que en el script original.
ALTER TABLE perfiles ADD FOREIGN KEY (encargado_perfil) REFERENCES usuarios(id_usuario);

-- Tabla de Login (plural)
CREATE TABLE logins (
    id_login INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_hora_login DATETIME NOT NULL,
    estado_login ENUM('exitoso', 'fallido') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla de Actividades de Fidelización
CREATE TABLE actividades_fidelizacion (
    id_actividad INT AUTO_INCREMENT PRIMARY KEY,
    id_perfil INT NOT NULL,
    fecha_actividad DATE NOT NULL,
    tipo_actividad VARCHAR(50) NOT NULL,
    descripcion_actividad TEXT,
    puntos_otorgados INT NOT NULL,
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
);

-- Tabla intermedia para la relación N:N entre usuarios y actividades
CREATE TABLE usuarios_actividades (
    id_usuario INT NOT NULL,
    id_actividad INT NOT NULL,
    PRIMARY KEY (id_usuario, id_actividad),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_actividad) REFERENCES actividades_fidelizacion(id_actividad)
);

-- Tabla intermedia para futura integración de permisos
CREATE TABLE perfil_permiso (
    id_perfil INT NOT NULL,
    id_permiso INT NOT NULL,
    PRIMARY KEY (id_perfil, id_permiso)
    -- FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
    -- FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso) -- Para futura integración
);
