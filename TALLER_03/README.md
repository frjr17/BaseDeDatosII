## TALLER_03 — API de Proveedores (rápido)

Proyecto de práctica: API REST para operar sobre la tabla `proveedor` (CRUD) usada en clase.

### Qué contiene
- Código Python con Flask (`main.py`) que expone endpoints para crear/leer/editar/eliminar proveedores.
- Conector a MariaDB en `db/conexion.py`.

### Requisitos
- Python 3.10+ (o compatible)
- MariaDB/MySQL accesible (puede usarse localmente o un contenedor)
- Instalar dependencias:

```bash
python -m pip install -r requirements.txt
```

### Variables de entorno (usar `.env` o exportarlas)
- DB_USER
- DB_PASSWORD
- DB_HOST
- DB_PORT
- DB_NAME

Puedes copiar `.env.example` a `.env` y completarlo.

### Esquema mínimo (tabla `proveedor`)
Ejemplo SQL para MariaDB/MySQL:

```sql
CREATE TABLE proveedor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ciudad VARCHAR(100) NOT NULL,
  proveedor VARCHAR(255) NOT NULL,
  `status` INT NOT NULL
);

-- Datos de ejemplo
INSERT INTO proveedor (ciudad, proveedor, `status`) VALUES
('Lima','ACME S.A.',1),
('Arequipa','Distribuciones SRL',1);
```

### Ejecutar la API

1. Exporta variables de entorno o crea `.env` (ver `.env.example`).
2. Ejecuta:

```bash
# desde la raíz del proyecto
python main.py
```

La app escucha por defecto en http://0.0.0.0:5000

### Endpoints (CRUD)

Base: http://localhost:5000

- GET /proveedores
  - Lista todos los proveedores.
  - Respuesta: JSON array de objetos.

- GET /proveedores/<id>
  - Obtiene proveedor por id.
  - 404 si no existe.

- POST /proveedores
  - Crear proveedor. Body JSON: {"ciudad": "...", "proveedor": "...", "status": 1}
  - Respuesta: {"id": <nuevo_id>} (201)

- PUT /proveedores/<id>
  - Actualiza campos (se aceptan campos parciales). Body JSON: cualquiera de {"ciudad","proveedor","status"}
  - Respuesta: {"updated": <nrows>} o 404 si no existe.

- DELETE /proveedores/<id>
  - Elimina proveedor por id. Respuesta: {"deleted": <nrows>} o 404.

### Comandos rápidos (curl) 

1) Listar todos

```bash
curl -sS http://localhost:5000/proveedores | jq '.' > prueba_listado.json
```

2) Crear (INSERT)

```bash
curl -sS -X POST http://localhost:5000/proveedores \
  -H 'Content-Type: application/json' \
  -d '{"ciudad":"Cusco","proveedor":"Prueba SRL","status":1}' | jq '.' > prueba_crear.json
```

3) Consultar por id (SELECT)

```bash
# sustituir 3 por el id devuelto por el POST anterior
curl -sS http://localhost:5000/proveedores/3 | jq '.' > prueba_get_3.json
```

4) Actualizar (UPDATE)

```bash
curl -sS -X PUT http://localhost:5000/proveedores/3 \
  -H 'Content-Type: application/json' \
  -d '{"ciudad":"Cusco Updated","status":0}' | jq '.' > prueba_update_3.json
```

5) Eliminar (DELETE)

```bash
curl -sS -X DELETE http://localhost:5000/proveedores/3 | jq '.' > prueba_delete_3.json
```
