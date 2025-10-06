-- =========================================
-- DB: arcade_racer_db_simple
-- Juego de carreras arcade (modelo minimal)
-- Tablas: players, cars, tracks, races, race_results
-- =========================================
DROP DATABASE IF EXISTS arcade_racer_db_simple;
CREATE DATABASE arcade_racer_db_simple;
USE arcade_racer_db_simple;

CREATE TABLE players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL
);

-- Autos disponibles
CREATE TABLE cars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(80) NOT NULL,
    top_speed_kmh INT NOT NULL
);

-- Pistas
CREATE TABLE tracks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(60)
);

-- Carreras (cada carrera se corre en una pista)
CREATE TABLE races (
    id INT AUTO_INCREMENT PRIMARY KEY,
    track_id INT NOT NULL,
    started_at DATETIME NOT NULL,
  FOREIGN KEY (track_id) REFERENCES tracks(id)
);

-- Resultados de la carrera:
-- Quién corrió (player), con qué auto (car), en qué carrera (race),
-- su posición final y su tiempo total en segundos.
CREATE TABLE race_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT NOT NULL,
    player_id INT NOT NULL,
    car_id INT NOT NULL,
    finish_position INT NOT NULL,
    total_time_sec INT NOT NULL,
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (player_id) REFERENCES players(id),
    FOREIGN KEY (car_id) REFERENCES cars(id)
);

-- =========================================
-- INSERT (datos de ejemplo)
-- =========================================
INSERT INTO players (nickname) VALUES
 ('NeoTurbo'), ('SkyDrift'), ('LunaRacer');

INSERT INTO cars (model, top_speed_kmh) VALUES
('Seat León', 210),
('Renault Clio', 200),
('Peugeot 208', 195);

INSERT INTO tracks (name, country) VALUES
 ('Circuito Atardecer', 'Estados Unidos'),
 ('Paso Alpino', 'Suiza');

INSERT INTO races (track_id, started_at) VALUES
 (1, '2025-10-06 10:00:00'),
 (2, '2025-10-06 11:00:00');

-- Resultados de la carrera 1 (Sunset Circuit)
INSERT INTO race_results (race_id, player_id, car_id, finish_position, total_time_sec) VALUES
 (1, 1, 3, 1, 312),   -- NeoTurbo con Vortex X
 (1, 2, 1, 2, 320),   -- SkyDrift con Comet GT
 (1, 3, 2, 3, 333);   -- LunaRacer con Falcon RS

-- Resultados de la carrera 2 (Alpine Pass)
INSERT INTO race_results (race_id, player_id, car_id, finish_position, total_time_sec) VALUES
 (2, 2, 3, 1, 355),
 (2, 3, 1, 2, 362),
 (2, 1, 2, 3, 366);

-- =========================================
-- SELECT / WHERE / JOIN (ejemplos)
-- =========================================

-- 1) Podio (Top-3) de una carrera con nombres de pista y modelos de auto
SELECT rr.finish_position, p.nickname, c.model, rr.total_time_sec, t.name AS track
FROM race_results rr
JOIN races r   ON r.id = rr.race_id
JOIN tracks t  ON t.id = r.track_id
JOIN players p ON p.id = rr.player_id
JOIN cars c    ON c.id = rr.car_id
WHERE rr.race_id = 1
ORDER BY rr.finish_position;

-- 2) Mejor tiempo de cada jugador en todo el historial
SELECT p.nickname, MIN(rr.total_time_sec) AS best_time_sec
FROM players p
JOIN race_results rr ON rr.player_id = p.id
GROUP BY p.id, p.nickname
ORDER BY best_time_sec;

-- 3) Todas las carreras corridas en 'Alpine Pass' con su ganador
SELECT r.id AS race_id, t.name AS track, p.nickname AS winner, c.model AS winner_car
FROM races r
JOIN tracks t ON t.id = r.track_id
JOIN race_results rr ON rr.race_id = r.id
JOIN players p ON p.id = rr.player_id
JOIN cars c ON c.id = rr.car_id
WHERE t.name = 'Alpine Pass' AND rr.finish_position = 1
ORDER BY r.id;

-- 4) Participaciones de un jugador específico (usando WHERE)
SELECT p.nickname, r.id AS race_id, t.name AS track, c.model, rr.finish_position, rr.total_time_sec
FROM race_results rr
JOIN players p ON p.id = rr.player_id
JOIN races r   ON r.id = rr.race_id
JOIN tracks t  ON t.id = r.track_id
JOIN cars c    ON c.id = rr.car_id
WHERE p.nickname = 'NeoTurbo'
ORDER BY r.id;
