-- 03_views.sql
-- Definición de todas las vistas solicitadas

USE empresa_taller02;

CREATE OR REPLACE VIEW v_DesempenoColaboradores AS
SELECT u.id_usuario, u.nombre, u.apellido, p.nombre_perfil,
            COUNT(a.id_actividad) AS total_actividades,
                SUM(a.puntos_otorgados) AS puntos_totales
FROM usuarios u
 JOIN perfiles p ON u.id_perfil = p.id_perfil
 JOIN usuarios_actividades ua ON u.id_usuario = ua.id_usuario
 JOIN actividades_fidelizacion a ON a.id_actividad = ua.id_actividad
GROUP BY u.id_usuario, u.nombre, u.apellido, p.nombre_perfil;

CREATE OR REPLACE VIEW v_actividadesPorPerfil AS
SELECT
    p.nombre_perfil,
    p.descripcion_perfil,
    (SELECT COUNT(*) FROM usuarios WHERE id_perfil = p.id_perfil) AS cantidad_usuarios_con_este_perfil,
    COUNT(ua.id_actividad) AS total_actividades_participadas_por_perfil,
    ROUND(AVG(a.puntos_otorgados),2) AS promedio_puntos_por_usuario_en_este_perfil,
    ROUND(
        COUNT(ua.id_actividad) / (SELECT COUNT(*) FROM usuarios_actividades) * 100, 2
    ) AS porcentaje_participacion_total
FROM perfiles p
LEFT JOIN usuarios u ON u.id_perfil = p.id_perfil
LEFT JOIN usuarios_actividades ua ON ua.id_usuario = u.id_usuario
LEFT JOIN actividades_fidelizacion a ON a.id_actividad = ua.id_actividad
GROUP BY p.id_perfil, p.nombre_perfil, p.descripcion_perfil;

CREATE OR REPLACE VIEW v_historialLoginDetallado AS
SELECT
	u.id_usuario,
    u.nombre,
    u.apellido,
    u.cargo,
    MAX(l.fecha_hora_login) AS fecha_hora_login,
    l.estado_login
FROM logins l
JOIN usuarios u ON u.id_usuario = l.id_usuario
GROUP BY u.nombre, u.apellido, u.cargo;
