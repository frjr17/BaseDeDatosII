# Base de Datos II — Charla 1

Comparativa práctica entre Cassandra y ScyllaDB usando un mini‑benchmark de escrituras y lecturas con datos sintéticos.

## Objetivo de la charla

- Levantar Cassandra y ScyllaDB con Docker en una misma máquina.
- Crear un esquema simple con una tabla de series temporales (eventos por dispositivo).
- Ejecutar un benchmark sencillo de inserciones y lecturas.
- Medir latencias promedio y p95, y comparar cuál motor es más rápido (porcentaje de “rapidez”).
- Entender cómo el diseño de la partición/clustering afecta el rendimiento.

## Estructura del proyecto

- `docker-compose.yml`: Define 2 servicios
  - `cassandra:4.1` (expone 9042)
  - `scylladb/scylla:5.4` (expone 9043 en host → 9042 en el contenedor)
  - Volúmenes persistentes en `data/` para ambos motores
- `script.py`: Script de benchmark (crea keyspace/tabla, inserta/lee, mide latencias y compara resultados)
- `flush.py`: Borra el keyspace `demo` en ambas instancias (sirve para “empezar de cero”)
- `requirements.txt`: Dependencias Python

## Requisitos

- Docker y Docker Compose
- Python 3.9+ (recomendado 3.10+)
- Paquetes Python del archivo `requirements.txt`

Instalar dependencias (zsh):

```zsh
pip install -r requirements.txt
```

## Levantar las bases en Docker

```zsh
# Arrancar en segundo plano
docker compose up -d

# Ver estado
docker compose ps
```

Notas:
- Cassandra queda accesible en `127.0.0.1:9042`.
- ScyllaDB queda accesible en `127.0.0.1:9043` (mapea al 9042 interno del contenedor).
- El `docker-compose.yml` usa configuraciones “ligeras” para que corra en laptops (1 CPU, ~750MB para Scylla, etc.).

Si quieres verificar con `cqlsh` (opcional):

```zsh
# En Cassandra
docker exec -it cassandra cqlsh 127.0.0.1 9042 -e "DESCRIBE CLUSTER;"

# En Scylla (recuerda que en host usas 9043)
cqlsh 127.0.0.1 9043 -e "DESCRIBE CLUSTER;"  # si tienes cqlsh instalado en el host
```

## Modelo de datos

Keyspace: `demo`

Tabla: `events_by_device`

```sql
CREATE TABLE IF NOT EXISTS events_by_device (
  device_id text,
  day_bucket date,
  ts timestamp,
  value double,
  PRIMARY KEY ((device_id, day_bucket), ts)
) WITH CLUSTERING ORDER BY (ts DESC);
```

- Clave de partición: `(device_id, day_bucket)`
- Clave de clustering: `ts DESC` para leer “los últimos N eventos” eficientemente

## ¿Qué hace `script.py`?

1. Conecta a cada backend configurado en `CONTACTS`:
   - `cassandra`: 127.0.0.1:9042
   - `scylla`: 127.0.0.1:9043
2. Crea el keyspace `demo` (RF=1, SimpleStrategy) y la tabla `events_by_device` si no existen.
3. Ejecuta un benchmark en cada backend:
   - Inserta `n_insert` filas (por defecto 15000) distribuidas aleatoriamente entre 75 dispositivos y dentro de la última hora.
   - Realiza `n_read` lecturas (por defecto 7500) de “últimos 20 eventos” por dispositivo al azar para el día actual.
   - Mide latencias por operación y calcula promedio (avg) y percentil 95 (p95).
   - Imprime resultados por motor y retorna un resumen estructurado.
4. Compara ambos backends (si hay 2 o más) y muestra un resumen de “rapidez” para inserts y reads.

Consistencia: `ConsistencyLevel.ONE` tanto para inserts como para reads.

### Parámetros

Si querés cambiar la carga:

```python
bench(session, label, n_insert=15000, n_read=7500)
```

Podés editar esos valores en `script.py` o pasar parámetros si adaptás el script a CLI.

### Métricas y comparación (“porcentaje de rapidez”)

- Por cada backend se reporta:
  - Inserts: `avg_ms`, `p95_ms`, `n`
  - Reads: `avg_ms`, `p95_ms`, `n`
- Comparación entre A y B:

```
pct_faster(A, B) = (1 - (A_ms / B_ms)) * 100
```

- Valor positivo: A es más rápido que B (porcentaje de mejora en latencia promedio)
- Se imprime por separado para Inserts y Reads

## Ejecutar el benchmark

Asegurate de tener los contenedores corriendo y las dependencias instaladas:

```zsh
python3 script.py
```

Salida esperada (ejemplo simplificado):

```
[cassandra] results:
  inserts: avg=1.23 ms  p95=3.45 ms  (n=15000)
  reads:   avg=2.34 ms  p95=5.67 ms  (n=7500)

[scylla] results:
  inserts: avg=0.98 ms  p95=2.90 ms  (n=15000)
  reads:   avg=1.90 ms  p95=4.80 ms  (n=7500)

Comparison summary:
  cassandra vs scylla
  Inserts: cassandra avg=1.23 ms, scylla avg=0.98 ms -> scylla is 20.33% faster
  Reads:   cassandra avg=2.34 ms, scylla avg=1.90 ms -> scylla is 18.80% faster
```

## Limpiar datos (borrar el keyspace)

Para volver a empezar sin datos:

```zsh
python3 flush.py
```

Esto hace `DROP KEYSPACE IF EXISTS demo` en Cassandra y Scylla.

## Solución de problemas

- Contenedores no “healthy” o no levantan:
  - Ver logs: `docker compose logs -f cassandra` y `docker compose logs -f scylla`
  - Revisar colisiones de puertos 9042/9043
  - Aumentar `start_period` o `retries` del healthcheck si tu equipo es lento
- Error de conexión desde Python:
  - Verificar que `pip install -r requirements.txt` se haya ejecutado
  - Confirmar que los puertos estén accesibles y servicios arriba
- Rendimiento muy lento:
  - Recuerda que las imágenes están limitadas (1 CPU, poca RAM). Subir recursos puede mejorar números, pero el objetivo aquí es educativo/comparativo.

## Extensiones posibles

- Guardar resultados en JSON/CSV para análisis posterior.
- Exponer parámetros (n_insert/n_read) vía CLI.
- Graficar distribuciones de latencia.
- Probar distintos Consistency Levels.

---

Hecho para acompañar la Charla 1 de Base de Datos II: práctica con Cassandra y ScyllaDB, modelado por partición/tiempo y medición de latencias. ¡Que lo disfrutes! 💡