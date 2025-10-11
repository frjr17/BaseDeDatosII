USE parcial1;

-- 1) Usuario del sistema: información general del usuario + id y nombre del tipo de usuario
CREATE OR REPLACE VIEW v_usuarioSistema AS
SELECT u.id_usuario,
	   u.nombre,
	   u.apellido,
	   u.nombre_usuario,
	   u.ciudad,
	   u.tipo_empresa,
	   tu.id_tipo_usuario,
	   tu.tipo AS nombre_tipo_usuario
FROM usuarios u
LEFT JOIN tipos_usuarios tu ON u.id_tipo_usuario = tu.id_tipo_usuario;

-- 2a) Listado de usuarios con campos mínimos: nombre, apellido, tipo de empresa
CREATE OR REPLACE VIEW v_usuariosPorEmpresa AS
SELECT id_usuario, nombre, apellido, tipo_empresa
FROM usuarios;

-- 2b) Totales de usuarios clasificados por tipo de empresa
CREATE OR REPLACE VIEW v_totalesPorEmpresa AS
SELECT tipo_empresa, COUNT(*) AS total_usuarios
FROM usuarios
GROUP BY tipo_empresa;

-- 3) Medios de pago: mostrar método de pago junto con información del usuario (nombre, estado civil, dirección)
CREATE OR REPLACE VIEW v_mediosPago AS
SELECT mp.id_metodo_pago,
	   mp.tipo AS tipo_pago,
	   mp.marca,
	   mp.titular,
	   mp.ultimos4,
	   mp.es_predeterminado,
	   u.id_usuario,
	   u.nombre,
	   u.apellido,
	   u.estado_civil,
	   u.direccion
FROM metodos_pago mp
JOIN usuarios u ON mp.id_usuario = u.id_usuario;

-- 4) Autenticación: mostrar información del módulo de autenticación con datos del usuario
CREATE OR REPLACE VIEW v_autenticaciones AS
SELECT a.id_autenticacion,
	   NOW() AS fecha_consulta,
	   a.nombre_usuario AS usuario_registrado,
	   a.agente_usuario,
	   a.nombre_dispositivo,
	   a.token,
	   u.id_usuario,
	   u.apellido,
	   u.ciudad,
	   u.tipo_empresa
FROM autenticaciones a
LEFT JOIN usuarios u ON a.id_usuario = u.id_usuario;


