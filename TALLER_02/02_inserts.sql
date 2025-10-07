-- 02_inserts.sql
-- Sentencias INSERT para poblar la base de datos con datos de simulación

USE empresa_taller02;

-- Insertar 10 perfiles
INSERT INTO perfiles (nombre_perfil, fecha_vigencia_perfil, descripcion_perfil, encargado_perfil)
VALUES
('Administrador', '2025-01-01', 'Perfil de administración', NULL),
('Ventas', '2025-01-01', 'Perfil de ventas', NULL),
('Soporte', '2025-01-01', 'Perfil de soporte', NULL),
('Recursos Humanos', '2025-01-01', 'Perfil de RRHH', NULL),
('Finanzas', '2025-01-01', 'Perfil de finanzas', NULL),
('Marketing', '2025-01-01', 'Perfil de marketing', NULL),
('Desarrollo', '2025-01-01', 'Perfil de desarrollo', NULL),
('Logística', '2025-01-01', 'Perfil de logística', NULL),
('Compras', '2025-01-01', 'Perfil de compras', NULL),
('Legal', '2025-01-01', 'Perfil legal', NULL);

-- Insertar 20 usuarios
INSERT INTO usuarios (nombre, apellido, estado, contrasena, cargo, salario, fecha_ingreso, id_perfil)
VALUES
('Juan', 'Perez', 'activo', 'pass1', 'Gerente', 5000, '2025-01-10', 1),
('Ana', 'Gomez', 'activo', 'pass2', 'Vendedor', 3000, '2025-02-15', 2),
('Luis', 'Martinez', 'activo', 'pass3', 'Soporte', 3200, '2025-03-20', 3),
('Maria', 'Lopez', 'activo', 'pass4', 'RRHH', 3500, '2025-04-25', 4),
('Carlos', 'Diaz', 'activo', 'pass5', 'Finanzas', 4000, '2025-05-30', 5),
('Sofia', 'Torres', 'activo', 'pass6', 'Marketing', 3300, '2025-06-05', 6),
('Pedro', 'Ramirez', 'activo', 'pass7', 'Desarrollador', 4500, '2025-07-10', 7),
('Lucia', 'Fernandez', 'activo', 'pass8', 'Logística', 3100, '2025-08-15', 8),
('Miguel', 'Sanchez', 'activo', 'pass9', 'Compras', 3400, '2025-09-20', 9),
('Laura', 'Castro', 'activo', 'pass10', 'Legal', 3600, '2025-10-25', 10),
('Jorge', 'Mendoza', 'activo', 'pass11', 'Vendedor', 3000, '2025-02-15', 2),
('Valeria', 'Rojas', 'activo', 'pass12', 'Soporte', 3200, '2025-03-20', 3),
('Diego', 'Morales', 'activo', 'pass13', 'RRHH', 3500, '2025-04-25', 4),
('Camila', 'Vega', 'activo', 'pass14', 'Finanzas', 4000, '2025-05-30', 5),
('Andres', 'Navarro', 'activo', 'pass15', 'Marketing', 3300, '2025-06-05', 6),
('Paula', 'Silva', 'activo', 'pass16', 'Desarrollador', 4500, '2025-07-10', 7),
('Ricardo', 'Ortega', 'activo', 'pass17', 'Logística', 3100, '2025-08-15', 8),
('Natalia', 'Guerrero', 'activo', 'pass18', 'Compras', 3400, '2025-09-20', 9),
('Esteban', 'Cruz', 'activo', 'pass19', 'Legal', 3600, '2025-10-25', 10),
('Isabel', 'Flores', 'activo', 'pass20', 'Gerente', 5000, '2025-01-10', 1);

-- Actualizar encargado_perfil en perfiles (asignar usuarios como encargados)
UPDATE perfiles SET encargado_perfil = 1 WHERE id_perfil = 1;
UPDATE perfiles SET encargado_perfil = 2 WHERE id_perfil = 2;
UPDATE perfiles SET encargado_perfil = 3 WHERE id_perfil = 3;
UPDATE perfiles SET encargado_perfil = 4 WHERE id_perfil = 4;
UPDATE perfiles SET encargado_perfil = 5 WHERE id_perfil = 5;
UPDATE perfiles SET encargado_perfil = 6 WHERE id_perfil = 6;
UPDATE perfiles SET encargado_perfil = 7 WHERE id_perfil = 7;
UPDATE perfiles SET encargado_perfil = 8 WHERE id_perfil = 8;
UPDATE perfiles SET encargado_perfil = 9 WHERE id_perfil = 9;
UPDATE perfiles SET encargado_perfil = 10 WHERE id_perfil = 10;

-- Insertar registros de logins (5 por usuario) (fechas ejemplo)
INSERT INTO logins (id_usuario, fecha_hora_login, estado_login)
VALUES
(1, '2025-01-01 08:00:00', 'exitoso'), (1, '2025-01-02 09:00:00', 'exitoso'), (1, '2025-01-03 10:00:00', 'fallido'), (1, '2025-01-04 11:00:00', 'exitoso'), (1, '2025-01-05 12:00:00', 'exitoso'),
(2, '2025-01-01 08:10:00', 'exitoso'), (2, '2025-01-02 09:10:00', 'fallido'), (2, '2025-01-03 10:10:00', 'exitoso'), (2, '2025-01-04 11:10:00', 'exitoso'), (2, '2025-01-05 12:10:00', 'exitoso'),
(3, '2025-01-01 08:20:00', 'exitoso'), (3, '2025-01-02 09:20:00', 'exitoso'), (3, '2025-01-03 10:20:00', 'fallido'), (3, '2025-01-04 11:20:00', 'exitoso'), (3, '2025-01-05 12:20:00', 'exitoso'),
(4, '2025-01-01 08:30:00', 'exitoso'), (4, '2025-01-02 09:30:00', 'exitoso'), (4, '2025-01-03 10:30:00', 'fallido'), (4, '2025-01-04 11:30:00', 'exitoso'), (4, '2025-01-05 12:30:00', 'exitoso'),
(5, '2025-01-01 08:40:00', 'exitoso'), (5, '2025-01-02 09:40:00', 'fallido'), (5, '2025-01-03 10:40:00', 'exitoso'), (5, '2025-01-04 11:40:00', 'exitoso'), (5, '2025-01-05 12:40:00', 'exitoso'),
(6, '2025-01-01 08:50:00', 'exitoso'), (6, '2025-01-02 09:50:00', 'exitoso'), (6, '2025-01-03 10:50:00', 'fallido'), (6, '2025-01-04 11:50:00', 'exitoso'), (6, '2025-01-05 12:50:00', 'exitoso'),
(7, '2025-01-01 09:00:00', 'exitoso'), (7, '2025-01-02 10:00:00', 'exitoso'), (7, '2025-01-03 11:00:00', 'fallido'), (7, '2025-01-04 12:00:00', 'exitoso'), (7, '2025-01-05 13:00:00', 'exitoso'),
(8, '2025-01-01 09:10:00', 'exitoso'), (8, '2025-01-02 10:10:00', 'fallido'), (8, '2025-01-03 11:10:00', 'exitoso'), (8, '2025-01-04 12:10:00', 'exitoso'), (8, '2025-01-05 13:10:00', 'exitoso'),
(9, '2025-01-01 09:20:00', 'exitoso'), (9, '2025-01-02 10:20:00', 'exitoso'), (9, '2025-01-03 11:20:00', 'fallido'), (9, '2025-01-04 12:20:00', 'exitoso'), (9, '2025-01-05 13:20:00', 'exitoso'),
(10, '2025-01-01 09:30:00', 'exitoso'), (10, '2025-01-02 10:30:00', 'exitoso'), (10, '2025-01-03 11:30:00', 'fallido'), (10, '2025-01-04 12:30:00', 'exitoso'), (10, '2025-01-05 13:30:00', 'exitoso'),
(11, '2025-01-01 09:40:00', 'exitoso'), (11, '2025-01-02 10:40:00', 'fallido'), (11, '2025-01-03 11:40:00', 'exitoso'), (11, '2025-01-04 12:40:00', 'exitoso'), (11, '2025-01-05 13:40:00', 'exitoso'),
(12, '2025-01-01 09:50:00', 'exitoso'), (12, '2025-01-02 10:50:00', 'exitoso'), (12, '2025-01-03 11:50:00', 'fallido'), (12, '2025-01-04 12:50:00', 'exitoso'), (12, '2025-01-05 13:50:00', 'exitoso'),
(13, '2025-01-01 10:00:00', 'exitoso'), (13, '2025-01-02 11:00:00', 'exitoso'), (13, '2025-01-03 12:00:00', 'fallido'), (13, '2025-01-04 13:00:00', 'exitoso'), (13, '2025-01-05 14:00:00', 'exitoso'),
(14, '2025-01-01 10:10:00', 'exitoso'), (14, '2025-01-02 11:10:00', 'fallido'), (14, '2025-01-03 12:10:00', 'exitoso'), (14, '2025-01-04 13:10:00', 'exitoso'), (14, '2025-01-05 14:10:00', 'exitoso'),
(15, '2025-01-01 10:20:00', 'exitoso'), (15, '2025-01-02 11:20:00', 'exitoso'), (15, '2025-01-03 12:20:00', 'fallido'), (15, '2025-01-04 13:20:00', 'exitoso'), (15, '2025-01-05 14:20:00', 'exitoso'),
(16, '2025-01-01 10:30:00', 'exitoso'), (16, '2025-01-02 11:30:00', 'exitoso'), (16, '2025-01-03 12:30:00', 'fallido'), (16, '2025-01-04 13:30:00', 'exitoso'), (16, '2025-01-05 14:30:00', 'exitoso'),
(17, '2025-01-01 10:40:00', 'exitoso'), (17, '2025-01-02 11:40:00', 'fallido'), (17, '2025-01-03 12:40:00', 'exitoso'), (17, '2025-01-04 13:40:00', 'exitoso'), (17, '2025-01-05 14:40:00', 'exitoso'),
(18, '2025-01-01 10:50:00', 'exitoso'), (18, '2025-01-02 11:50:00', 'exitoso'), (18, '2025-01-03 12:50:00', 'fallido'), (18, '2025-01-04 13:50:00', 'exitoso'), (18, '2025-01-05 14:50:00', 'exitoso'),
(19, '2025-01-01 11:00:00', 'exitoso'), (19, '2025-01-02 12:00:00', 'exitoso'), (19, '2025-01-03 13:00:00', 'fallido'), (19, '2025-01-04 14:00:00', 'exitoso'), (19, '2025-01-05 15:00:00', 'exitoso'),
(20, '2025-01-01 11:10:00', 'exitoso'), (20, '2025-01-02 12:10:00', 'fallido'), (20, '2025-01-03 13:10:00', 'exitoso'), (20, '2025-01-04 14:10:00', 'exitoso'), (20, '2025-01-05 15:10:00', 'exitoso');

-- Insertar actividades de fidelización y mapeos usuarios_actividades
INSERT INTO actividades_fidelizacion (id_actividad, id_perfil, fecha_actividad, tipo_actividad, descripcion_actividad, puntos_otorgados)
VALUES
(1, 1, '2025-01-10', 'Curso de Liderazgo', 'Participación en curso de liderazgo', 60),
(2, 2, '2025-01-20', 'Premio al Mejor Vendedor', 'Reconocimiento por ventas destacadas', 90),
(3, 3, '2025-02-10', 'Taller de Soporte Técnico', 'Asistencia a taller de soporte', 60),
(4, 4, '2025-02-20', 'Reconocimiento RRHH', 'Reconocimiento por gestión de personal', 90),
(5, 5, '2025-03-10', 'Seminario de Finanzas', 'Participación en seminario financiero', 60),
(6, 6, '2025-03-20', 'Premio Marketing', 'Reconocimiento por campaña exitosa', 90),
(7, 7, '2025-04-10', 'Hackathon Interno', 'Participación en hackathon de desarrollo', 60),
(8, 8, '2025-04-20', 'Premio Logística', 'Reconocimiento por optimización logística', 90),
(9, 9, '2025-05-10', 'Curso de Compras', 'Asistencia a curso de compras estratégicas', 60),
(10, 10, '2025-05-20', 'Reconocimiento Legal', 'Reconocimiento por asesoría legal', 90),
(11, 2, '2025-06-10', 'Taller de Ventas', 'Participación en taller de ventas', 60),
(12, 3, '2025-06-20', 'Premio Soporte', 'Reconocimiento por atención al cliente', 90),
(13, 4, '2025-07-10', 'Curso de RRHH', 'Asistencia a curso de recursos humanos', 60),
(14, 5, '2025-07-20', 'Premio Finanzas', 'Reconocimiento por gestión financiera', 90),
(15, 6, '2025-08-10', 'Seminario de Marketing', 'Participación en seminario de marketing', 60),
(16, 7, '2025-08-20', 'Premio Desarrollo', 'Reconocimiento por innovación tecnológica', 90),
(17, 8, '2025-09-10', 'Taller de Logística', 'Asistencia a taller de logística', 60),
(18, 9, '2025-09-20', 'Premio Compras', 'Reconocimiento por negociación exitosa', 90),
(19, 10, '2025-10-10', 'Curso Legal', 'Participación en curso de derecho empresarial', 60),
(20, 1, '2025-10-20', 'Premio Gerente', 'Reconocimiento por liderazgo', 90),
(21, 2, '2025-11-10', 'Seminario de Ventas', 'Participación en seminario de ventas', 60),
(22, 3, '2025-11-20', 'Premio Soporte', 'Reconocimiento por solución de incidencias', 90),
(23, 4, '2025-12-10', 'Curso de RRHH', 'Asistencia a curso avanzado de RRHH', 60),
(24, 5, '2025-12-20', 'Premio Finanzas', 'Reconocimiento por auditoría exitosa', 90);

INSERT INTO usuarios_actividades (id_usuario, id_actividad) VALUES
(1, 1), (2, 2),
(3, 1), (4, 1), (5, 1), (6, 1), (7, 1),
(8, 2), (9, 2), (10, 2), (11, 2), (12, 2),
(3, 3), (4, 4),
(5, 3), (6, 3), (7, 3), (8, 3), (9, 3),
(10, 4), (11, 4), (12, 4), (13, 4), (14, 4),
(5, 5), (6, 6),
(7, 5), (8, 5), (9, 5), (10, 5), (11, 5),
(12, 6), (13, 6), (14, 6), (15, 6), (16, 6),
(7, 7), (8, 8),
(9, 7), (10, 7), (11, 7), (12, 7), (13, 7),
(14, 8), (15, 8), (16, 8), (17, 8), (18, 8),
(9, 9), (10, 10),
(11, 9), (12, 9), (13, 9), (14, 9), (15, 9),
(16, 10), (17, 10), (18, 10), (19, 10), (20, 10),
(11, 11), (12, 12),
(13, 11), (14, 11), (15, 11), (16, 11), (17, 11),
(18, 12), (19, 12), (20, 12), (1, 12), (2, 12),
(13, 13), (14, 14),
(15, 13), (16, 13), (17, 13), (18, 13), (19, 13),
(20, 14), (1, 14), (2, 14), (3, 14), (4, 14),
(15, 15), (16, 16),
(17, 15), (18, 15), (19, 15), (20, 15), (1, 15),
(2, 16), (3, 16), (4, 16), (5, 16), (6, 16),
(17, 17), (18, 18),
(19, 17), (20, 17), (1, 17), (2, 17), (3, 17),
(4, 18), (5, 18), (6, 18), (7, 18), (8, 18),
(19, 19), (20, 20),
(1, 19), (2, 19), (3, 19), (4, 19), (5, 19),
(6, 20), (7, 20), (8, 20), (9, 20), (10, 20),
(2, 21), (3, 22),
(4, 21), (5, 21), (6, 21), (7, 21), (8, 21),
(9, 22), (10, 22), (11, 22), (12, 22), (13, 22),
(4, 23), (5, 24),
(6, 23), (7, 23), (8, 23), (9, 23), (10, 23),
(11, 24), (12, 24), (13, 24), (14, 24), (15, 24);
