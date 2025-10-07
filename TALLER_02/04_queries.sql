-- 04_queries.sql
-- Consultas SQL que demuestran el uso de las vistas para escenarios de negocio

USE empresa_taller02;

-- 1) Mostrar desempeño de colaboradores (vista)
SELECT * FROM v_DesempenoColaboradores ORDER BY puntos_totales DESC;

-- 2) Actividades por perfil (vista)
SELECT * FROM v_actividadesPorPerfil ORDER BY porcentaje_participacion_total DESC;

-- 3) Historial de último login por usuario (vista)
SELECT * FROM v_historialLoginDetallado ORDER BY fecha_hora_login DESC;

