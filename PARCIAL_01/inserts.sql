
USE parcial1;

-- 1) Insertar 20 tipos de usuario (INSERT IGNORE para evitar duplicados si ya existen)
INSERT INTO tipos_usuarios (tipo,descripcion) VALUES
('Cliente','Usuario cliente estándar'),
('Administrador','Usuario con privilegios de administración'),
('Vendedor','Usuario del equipo de ventas'),
('Ejecutivo','Usuario ejecutivo o gerente'),
('Otro','Otro tipo de usuario'),
('Cliente_Premium','Cliente con privilegios premium'),
('Soporte','Equipo de soporte técnico'),
('Auditor','Usuario con permisos de auditoría'),
('Analista','Analista de seguridad'),
('Operaciones','Equipo de operaciones'),
('Interno','Usuario interno de la empresa'),
('Externo','Usuario externo/contratista'),
('Pruebas','Cuenta para pruebas'),
('Supervisor','Supervisor de procesos'),
('Gerente_Regional','Gerente regional'),
('Consultor','Consultor externo'),
('Automatizacion','Cuentas de automatización/servicios'),
('Marketing','Equipo de marketing'),
('Ventas_Directas','Vendedores directos'),
('Partner','Socio comercial');

-- 2) Insertar 20 usuarios (asegurar que nombre_usuario sea único)
INSERT INTO usuarios (nombre,apellido,nombre_usuario,contrasena_hash,token,ciudad,sexo,estado_civil,tipo_empresa,direccion,id_tipo_usuario)
VALUES
('Juan','Pérez','juan.perez','hash_juan','tok_u_1','Ciudad A','masculino','soltero','privada','Calle Los Olivos 123',1),
('Ana','Gómez','ana.gomez','hash_ana','tok_u_2','Ciudad B','femenino','casado','privada','Avenida Libertad 456',2),
('Carlos','López','carlos.lopez','hash_carlos','tok_u_3','Ciudad C','masculino','casado','privada','Calle San Martín 234',3),
('Lucía','Martínez','lucia.m','hash_lucia','tok_u_4','Ciudad D','femenino','soltero','publica','Avenida Principal 980',4),
('María','Rodríguez','maria.r','hash_maria','tok_u_5','Ciudad E','femenino','casado','privada','Calle Las Flores 77',1),
('Pedro','Ramírez','pedro.r','hash_pedro','tok_u_6','Ciudad F','masculino','soltero','privada','Calle Nueva 512',2),
('Sofía','Vega','sofia.v','hash_sofia','tok_u_7','Ciudad G','femenino','union_libre','publica','Avenida del Parque 301',3),
('Miguel','Torres','miguel.t','hash_miguel','tok_u_8','Ciudad H','masculino','divorciado','privada','Calle Río Negro 48',4),
('Laura','Suárez','laura.s','hash_laura','tok_u_9','Ciudad I','femenino','viudo','privada','Boulevard Central 150',5),
('Diego','Flores','diego.f','hash_diego','tok_u_10','Ciudad J','masculino','soltero','privada','Calle 9 de Julio 210',1),
('Elena','Ríos','elena.r','hash_elena','tok_u_11','Ciudad K','femenino','casado','privada','Avenida Constitución 1420',2),
('Rafael','Guerra','rafael.g','hash_rafael','tok_u_12','Ciudad L','masculino','soltero','privada','Calle Bella Vista 85',3),
('Isabel','Mora','isabel.m','hash_isabel','tok_u_13','Ciudad M','femenino','casado','publica','Paseo de la Alameda 320',4),
('Andrés','Cuz','andres.c','hash_andres','tok_u_14','Ciudad N','masculino','soltero','privada','Calle Los Cedros 228',5),
('Patricia','Díaz','patricia.d','hash_patricia','tok_u_15','Ciudad O','femenino','casado','privada','Avenida Córdoba 1150',1),
('Fernando','Oliva','fernando.o','hash_fernando','tok_u_16','Ciudad P','masculino','soltero','privada','Calle La Paz 64',2),
('Verónica','Campos','veronica.c','hash_veronica','tok_u_17','Ciudad Q','femenino','union_libre','publica','Pasaje Los Alerces 19',3),
('Jorge','Salas','jorge.s','hash_jorge','tok_u_18','Ciudad R','masculino','casado','privada','Calle El Bosque 742',4),
('Natalia','Bravo','natalia.b','hash_natalia','tok_u_19','Ciudad S','femenino','soltero','privada','Avenida Colón 560',5),
('Óscar','Reyes','oscar.r','hash_oscar','tok_u_20','Ciudad T','masculino','divorciado','privada','Calle Santa María 403',1);

-- 3) Insertar 20 registros en autenticaciones (uno o más por usuario)
INSERT INTO autenticaciones (id_usuario,nombre_usuario,contrasena_hash,agente_usuario,nombre_dispositivo,token)
VALUES
(1,'juan.perez','hash_juan','Mozilla/5.0 (Windows)','PC-Juan','auth_tok_1'),
(2,'ana.gomez','hash_ana','Mozilla/5.0 (iPhone)','iPhone-Ana','auth_tok_2'),
(3,'carlos.lopez','hash_carlos','Mozilla/5.0 (Linux)','PC-Carlos','auth_tok_3'),
(4,'lucia.m','hash_lucia','Mozilla/5.0 (Macintosh)','Mac-Lucia','auth_tok_4'),
(5,'maria.r','hash_maria','Mozilla/5.0 (Android)','Pixel-Maria','auth_tok_5'),
(6,'pedro.r','hash_pedro','Mozilla/5.0 (Windows)','PC-Pedro','auth_tok_6'),
(7,'sofia.v','hash_sofia','Mozilla/5.0 (iPad)','iPad-Sofia','auth_tok_7'),
(8,'miguel.t','hash_miguel','Mozilla/5.0 (Windows)','PC-Miguel','auth_tok_8'),
(9,'laura.s','hash_laura','Mozilla/5.0 (Android)','SG-LAURA','auth_tok_9'),
(10,'diego.f','hash_diego','Mozilla/5.0 (Linux)','PC-Diego','auth_tok_10'),
(11,'elena.r','hash_elena','Mozilla/5.0 (Macintosh)','Mac-Elena','auth_tok_11'),
(12,'rafael.g','hash_rafael','Mozilla/5.0 (Windows)','PC-Rafael','auth_tok_12'),
(13,'isabel.m','hash_isabel','Mozilla/5.0 (Android)','Phone-Isabel','auth_tok_13'),
(14,'andres.c','hash_andres','Mozilla/5.0 (iPhone)','iPhone-Andres','auth_tok_14'),
(15,'patricia.d','hash_patricia','Mozilla/5.0 (Windows)','PC-Patricia','auth_tok_15'),
(16,'fernando.o','hash_fernando','Mozilla/5.0 (Linux)','PC-Fernando','auth_tok_16'),
(17,'veronica.c','hash_veronica','Mozilla/5.0 (Android)','Phone-Veronica','auth_tok_17'),
(18,'jorge.s','hash_jorge','Mozilla/5.0 (Windows)','PC-Jorge','auth_tok_18'),
(19,'natalia.b','hash_natalia','Mozilla/5.0 (iPhone)','iPhone-Natalia','auth_tok_19'),
(20,'oscar.r','hash_oscar','Mozilla/5.0 (Windows)','PC-Oscar','auth_tok_20');

-- 4) Se omite la inserción masiva de tipos de pruebas puesto que los tipos de pruebas ya fueron insertados en tablas.sql

-- 5) Insertar 20 métodos de pago (uno por usuario como ejemplo)
INSERT INTO metodos_pago (id_usuario,tipo,marca,titular,pan_enmascarado,ultimos4,exp_mes,exp_anio,token,es_predeterminado)
VALUES
(1,'credito','VISA','Juan Pérez','**** **** **** 1111','1111',12,2025,'pm_tok_1',TRUE),
(2,'debito','MASTERCARD','Ana Gómez','**** **** **** 2222','2222',11,2024,'pm_tok_2',FALSE),
(3,'credito','VISA','Carlos López','**** **** **** 3333','3333',10,2026,'pm_tok_3',FALSE),
(4,'credito','AMEX','Lucía Martínez','**** **** **** 4444','4444',9,2025,'pm_tok_4',TRUE),
(5,'debito','VISA','María Rodríguez','**** **** **** 5555','5555',8,2027,'pm_tok_5',FALSE),
(6,'credito','MASTERCARD','Pedro Ramírez','**** **** **** 6666','6666',7,2026,'pm_tok_6',FALSE),
(7,'credito','VISA','Sofía Vega','**** **** **** 7777','7777',6,2025,'pm_tok_7',TRUE),
(8,'debito','VISA','Miguel Torres','**** **** **** 8888','8888',5,2024,'pm_tok_8',FALSE),
(9,'credito','MASTERCARD','Laura Suárez','**** **** **** 9999','9999',4,2026,'pm_tok_9',FALSE),
(10,'credito','VISA','Diego Flores','**** **** **** 0001','0001',3,2025,'pm_tok_10',TRUE),
(11,'debito','VISA','Elena Ríos','**** **** **** 1010','1010',2,2027,'pm_tok_11',FALSE),
(12,'credito','MASTERCARD','Rafael Guerra','**** **** **** 1212','1212',1,2026,'pm_tok_12',FALSE),
(13,'credito','VISA','Isabel Mora','**** **** **** 1313','1313',12,2025,'pm_tok_13',TRUE),
(14,'debito','VISA','Andrés Cruz','**** **** **** 1414','1414',11,2024,'pm_tok_14',FALSE),
(15,'credito','MASTERCARD','Patricia Díaz','**** **** **** 1515','1515',10,2026,'pm_tok_15',FALSE),
(16,'credito','VISA','Fernando Oliva','**** **** **** 1616','1616',9,2025,'pm_tok_16',TRUE),
(17,'debito','VISA','Verónica Campos','**** **** **** 1717','1717',8,2027,'pm_tok_17',FALSE),
(18,'credito','MASTERCARD','Jorge Salas','**** **** **** 1818','1818',7,2026,'pm_tok_18',FALSE),
(19,'credito','VISA','Natalia Bravo','**** **** **** 1919','1919',6,2025,'pm_tok_19',TRUE),
(20,'debito','MASTERCARD','Óscar Reyes','**** **** **** 2020','2020',5,2024,'pm_tok_20',FALSE);

