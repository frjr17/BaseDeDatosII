# Sistema de Gestión de Expedientes (SIS-EXP)

Este proyecto implementa un sistema backend para la gestión de expedientes legales, integrando una base de datos relacional MariaDB con una API RESTful desarrollada en Python con Flask.

## 📋 Tabla de Contenidos
- [Diseño de la Base de Datos](#diseño-de-la-base-de-datos)
- [Diagrama Entidad-Relación](#diagrama-entidad-relación)
- [Normalización](#normalización)
- [Integración con Python](#integración-con-python)
- [Vistas SQL](#vistas-sql)
- [API REST con Flask](#api-rest-con-flask)
- [Lecciones Aprendidas](#lecciones-aprendidas)

## Diseño de la Base de Datos

La base de datos `SIS-EXP` está diseñada para administrar tramites relacionados con usuarios (abogados), aseguradoras, personas asociadas y los expedientes de casos legales.

### Tablas Principales

1.  **usuarios**: Almacena la información de los abogados y usuarios del sistema.
    *   `id`: Identificador único (UUID).
    *   `nombre_completo`: Nombre del usuario.
    *   `usuario`: Nombre de usuario para login (único).
    *   `contrasena`: Hash de la contraseña (bcrypt).

2.  **personas**: Almacena información de personas físicas (ej. contactos de aseguradoras o asegurados).
    *   `id`: Identificador único (UUID).
    *   `nombre_completo`: Nombre de la persona.

3.  **aseguradoras**: Entidades aseguradoras involucradas en los expedientes.
    *   `id`: Identificador único (UUID).
    *   `nombre`: Nombre de la aseguradora.
    *   `id_persona`: Referencia a la tabla `personas` (Contacto/Asegurado).

4.  **expedientes**: Tabla central que registra los casos.
    *   `id`: Identificador único (UUID).
    *   `usuario_id`: Usuario creador/asignado.
    *   `aseguradora_id`: Aseguradora vinculada.
    *   `abogado_id`: Abogado a cargo.
    *   `estado`: Estado del caso ('Pendiente', 'En curso', 'Cerrado').
    *   `tipo_de_proceso`: Tipo de caso ('TRANSITO', 'PENAL').
    *   Otros campos: `juzgado`, `fecha_inicio`, `fecha_finalizacion`, `formato`, `conductor`, `numero_de_caso`.

## Diagrama Entidad-Relación

La estructura relacional se define de la siguiente manera:

*   **Un Usuario** puede tener múltiples **Expedientes** (Relación 1:N).
*   **Una Aseguradora** está vinculada a **Una Persona** (Relación 1:1 en este contexto de contacto/representante).
*   **Una Aseguradora** puede estar en múltiples **Expedientes** (Relación 1:N).
*   **Un Expediente** pertenece a un único **Usuario**, una única **Aseguradora** y es gestionado por un único **Abogado** (que también es un usuario).

Para ver el Mermaid, has [Click Aqui](https://mermaid.live/edit#pako:eNqtVFFv2jAQ_ivRPXUSoIQkheQNjWjqS6lgSNMUKXJjE7xhO7rY0gblv88OrIwmlTq1fvLd5-_y-buLD1AqyiAFhnNOKiQil55d69V6trxbrLzDKXar0chl5XHaSUklHpEVpRL1jmnVwU1jCPJuvlRSI2mYJBeIEs00F8wrkdktLYjuAU1Nr8BjLk-bh2y5WtzP3iv8nSpmq-zLejmbL5b_p6TnZFEzbNQHOpR9e8jmd9n91-yN0s7dK3og27vKIKEKSR_MGm2xTvqH2VdXeafU27Bya6tIXvJ-aMMl2fE9sbjs1NwoFET3jhg1pVbYddwIhqqgtv2k6RI1r1uwRlWyHpw8KneJq2t_1Ow-PQ2H6nA9RamXw7PdOfTM2Zn1b38dqTRusODFf_3aYSvcu7l0_NNbiWc7vJuLLy0XBlAhp5BqNGwA1nJBXAjt6OWgt0xYda4EJfjTUY6WUxP5XSnxl4bKVFtIN2TX2Ohk4Pm9ej7CJGX4WRmpIQ3iqK0B6QF-uTAZhVHox9MoSKJxEA7gN6TDMJiObieRP_YD3w8mk3F0HMC-_WwwCqe3Yez70zgJ4zBJkuMfD1CW7Q)
## Normalización

Se aplicaron las reglas de normalización hasta la Tercera Forma Normal (3FN) para garantizar la integridad de los datos y reducir la redundancia.

1.  **Primera Forma Normal (1FN)**:
    *   Todos los atributos contienen valores atómicos (no hay listas ni grupos repetidos en una celda).
    *   Cada tabla tiene una clave primaria definida (`id` UUID).

2.  **Segunda Forma Normal (2FN)**:
    *   Todas las tablas están en 1FN.
    *   No existen dependencias parciales; todos los atributos no clave dependen completamente de la clave primaria (al ser UUIDs únicos, no hay claves compuestas que generen este problema).

3.  **Tercera Forma Normal (3FN)**:
    *   Todas las tablas están en 2FN.
    *   Se eliminaron las dependencias transitivas. Por ejemplo, en lugar de guardar el nombre del contacto de la aseguradora directamente en la tabla `aseguradoras` o `expedientes`, se creó la tabla `personas` y se relacionó mediante `id_persona`. De igual forma, los detalles del abogado se obtienen mediante `abogado_id` referenciando a `usuarios`, evitando duplicar datos del abogado en el expediente.

## Integración con Python

La conexión a la base de datos se realiza utilizando el conector `mariadb` para Python.

*   **`db/conexion.py`**: Contiene las funciones para establecer la conexión y ejecutar consultas. Utiliza variables de entorno (`dotenv`) para manejar credenciales de forma segura.
    *   `getConnexion()`: Establece la conexión.
    *   `getCursor()`: Obtiene el cursor para ejecutar sentencias.
    *   Funciones CRUD como `crearExpediente`, `getExpedientes`, `encontrarUsuario`.
*   **`db/datos.py`**: Script de inicialización (Seed) que crea la estructura de la base de datos (DDL) e inserta datos de prueba (DML) utilizando librerías como `uuid` y `bcrypt` para seguridad.

## Vistas SQL

Se implementaron tres vistas para simplificar consultas complejas y reportes:

1.  **`vista_expedientes`**:
    *   Consolida información de expedientes, nombres de aseguradoras y nombres de asegurados para facilitar la visualización en el frontend sin necesidad de múltiples JOINs en cada consulta.
2.  **`vista_conteo_expedientes`**:
    *   Agrupa los expedientes por `usuario_id` y `estado` para obtener conteos rápidos (Dashboard).
3.  **`vista_expedientes_totales`**:
    *   Vista detallada que une expedientes, aseguradoras, personas y abogados para reportes completos y filtrado por múltiples criterios.

## API REST con Flask

La API (`main.py`) expone los siguientes endpoints para interactuar con el sistema:

### Autenticación
*   `POST /login`: Autentica usuarios verificando credenciales contra hashes bcrypt.

### Expedientes
*   `POST /expedientes`: **Crear nuevos registros**. Recibe un JSON con los datos del expediente (conductor, aseguradora, caso, etc.) y lo inserta en la base de datos.
*   `GET /expedientes`: **Consultar información**. Lista los expedientes asociados a un usuario.
*   `GET /expedientes/fecha/<fecha>`: Filtra expedientes donde una fecha dada cae dentro del rango de inicio y fin del caso.
*   `GET /expedientes/conteo`: Devuelve estadísticas de expedientes por estado.
*   `GET /expedientes/totales`: Búsqueda avanzada filtrada por aseguradora, tipo de proceso o abogado.

## Lecciones Aprendidas

1.  **Seguridad en Credenciales**: El uso de `python-dotenv` es fundamental para no exponer contraseñas de base de datos en el código fuente, manteniendo las buenas prácticas de seguridad.
2.  **Abstracción de Base de Datos**: Separar la lógica de conexión y consultas en `conexion.py` permite que el código de la API (`main.py`) sea más limpio y fácil de mantener.
3.  **Uso de Vistas**: Implementar vistas en SQL reduce significativamente la complejidad del código Python, delegando la lógica de unión de datos al motor de base de datos, que es más eficiente.
4.  **Integridad de Datos con UUID**: El uso de UUIDs como claves primarias facilita la generación de IDs únicos desde la aplicación antes de la inserción, evitando problemas de concurrencia y facilitando la migración de datos.
5.  **Validación de Datos**: Es crucial validar la existencia de claves foráneas (como `aseguradora` o `abogado`) antes de intentar insertar un registro para evitar errores de integridad referencial y proveer mensajes de error claros al cliente.
