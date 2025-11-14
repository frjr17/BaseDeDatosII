# Taller 04 - API Flask (SIS-EXP)

API sencilla en Flask conectada a MariaDB para gestionar expedientes, aseguradoras y usuarios. Incluye endpoints para autenticación y consulta de expedientes.

## Requisitos
- Python 3.9+
- MariaDB 10.x o MySQL compatible
- Cliente de MariaDB instalada en el sistema (Opcional)

Paquetes Python:
- `flask`
- `python-dotenv`
- `mariadb`
- `bcrypt`

## Estructura del proyecto
- `main.py`: App Flask con endpoints `/login`, `/expedientes`, `/expedientes/conteo`.
- `db/conexion.py`: Conexión a MariaDB usando variables de entorno.
- `db/datos.py`: Script para crear la BD `SIS-EXP`, tablas y datos de ejemplo.
- `db/db.sql`: SQL de referencia (puede no estar totalmente alineado con `datos.py`).

## Configuración
1) Crear y activar entorno virtual (opcional pero recomendado)
```zsh
python3 -m venv .venv
source .venv/bin/activate
```

2) Instalar dependencias
```zsh
pip install flask python-dotenv mariadb bcrypt
```

3) Crear archivo `.env` en la raíz del proyecto con tus credenciales:
```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=tu_usuario
DB_PASSWORD=tu_password
# Paso de inicialización: usa una BD existente (por ej. "mysql")
DB_NAME=mysql
```

## Inicializar base de datos y datos de ejemplo
Hay dos caminos. Recomendado: usar el script Python porque crea el esquema completo usado por la app.

- Opción A (recomendada) – Script Python:
```zsh
python db/datos.py
```
Esto creará la BD `SIS-EXP`, tablas (`usuarios`, `personas`, `aseguradoras`, `expedientes`) y cargará datos de ejemplo (usuarios y registros). Tras completarse, edita tu `.env` para que la app use la base recién creada:
```env
DB_NAME=SIS-EXP
```

- Opción B – SQL (referencia):
El archivo `db/db.sql` crea tablas básicas; puede no incluir todas las relaciones/columnas empleadas en el código. Úsalo solo si sabes ajustarlo a tu entorno.

## Ejecutar la API
La app no invoca `app.run()` directamente, así que usa Flask CLI:
```zsh
export FLASK_ENV=development
flask --app main run --reload
```
Por defecto levantará en `http://127.0.0.1:5000`.

## Endpoints
- POST `/login`
  - Body JSON: `{ "usuario": "juan.perez", "contrasena": "secret" }`
  - Respuestas: `200 OK` con datos del usuario, `404` si no existe o credenciales inválidas.

- GET `/expedientes`
  - Devuelve lista de expedientes con: `id`, `aseguradora`, `asegurado`, `juzgado`, `estado`, `FECHA`.

- GET `/expedientes/conteo`
  - Devuelve conteo por estado: `[{ "estado": "Pendiente", "conteo": 3 }, ...]`.

## Usuarios de ejemplo
El script `db/datos.py` crea usuarios con contraseña `secret`:
- `juan.perez`
- `maria.gomez`
- `carlos.ruiz`

Las contraseñas se almacenan con `bcrypt`.

## Problemas comunes
- Error al instalar `mariadb` (paquete Python): asegúrate de tener instalado el cliente/biblioteca nativa de MariaDB en tu Linux (por ejemplo, `mariadb-connector-c` o `libmariadb-dev`).
- Conexión rechazada: valida host, puerto, usuario y permisos en MariaDB.
- Esquema inconsistente: prioriza la inicialización con `db/datos.py` frente a `db/db.sql`.
