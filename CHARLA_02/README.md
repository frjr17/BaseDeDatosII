# Sistema de Mensajería Distribuida (Publisher/Subscriber)

Este proyecto implementa un patrón de arquitectura **Publisher-Subscriber** utilizando **RabbitMQ** como broker de mensajería. El sistema demuestra la interoperabilidad entre diferentes lenguajes de programación (.NET, Go y Python) y el manejo de colas de mensajes.

## 📋 Descripción General

El flujo de datos es el siguiente:
1.  **Publisher (.NET 8)**: Una API REST que recibe peticiones HTTP POST y publica mensajes en una cola de RabbitMQ.
2.  **RabbitMQ**: El intermediario que almacena y encola los mensajes.
3.  **Subscriber (Go)**: Un servicio en segundo plano que escucha la cola y procesa los mensajes recibidos.
4.  **Load Test (Python)**: Un script para generar tráfico y probar la resistencia del sistema.

## 🚀 Requisitos Previos

*   [Docker](https://www.docker.com/) y [Docker Compose](https://docs.docker.com/compose/).
*   [Python 3.x](https://www.python.org/) (para ejecutar las pruebas de carga).

## 📂 Estructura del Proyecto

```text
.
├── compose.yml              # Orquestación de contenedores Docker
├── enable_plugins           # Plugins habilitados para RabbitMQ
├── publisher/               # API en .NET 8 (Productor)
│   ├── Dockerfile
│   └── Program.cs           # Lógica del endpoint y conexión a RabbitMQ
├── subscriber/              # Servicio en Go (Consumidor)
│   ├── Dockerfile
│   └── main.go              # Lógica de consumo de mensajes
├── rabbitmq/                # Configuración de RabbitMQ
│   ├── rabbitmq.conf
│   └── definitions.json
└── load_test/               # Scripts de prueba de carga
    ├── load_test.py         # Script en Python (AsyncIO)
    └── requirements.txt     # Dependencias de Python
```

## 🛠️ Configuración y Ejecución

### 1. Levantar los servicios

Utiliza Docker Compose para construir e iniciar todos los contenedores (RabbitMQ, Publisher y Subscriber):

```bash
docker compose up --build
```

Esto iniciará:
*   **RabbitMQ** en `localhost:5672` (UI en `localhost:15672`).
*   **Publisher API** en `localhost:8080`.
*   **Subscriber** (logs visibles en la terminal).

### 2. Acceder a la Interfaz de RabbitMQ

*   **URL**: [http://localhost:15672](http://localhost:15672)
*   **Usuario**: `frjr17`
*   **Contraseña**: `frjr17`

### 3. Ejecutar Prueba de Carga (Load Test)

El script de prueba de carga está escrito en Python y utiliza `aiohttp` para enviar peticiones asíncronas de alta concurrencia.

**Pasos:**

1.  Navega a la carpeta raíz del proyecto.
2.  Crea y activa un entorno virtual (si no lo has hecho):
    ```bash
    python3 -m venv .venv
    source .venv/bin/activate
    ```
3.  Instala las dependencias:
    ```bash
    pip install -r load_test/requirements.txt
    ```
4.  Ejecuta el test:
    ```bash
    python load_test/load_test.py
    ```

**Configuración del Test:**
El script está configurado por defecto para:
*   Enviar **20 peticiones por segundo**.
*   Duración de **60 segundos**.
*   Endpoint: `http://localhost:8080/mensaje`.

## 💻 Detalles de Implementación

### Publisher (C# / .NET 8)
*   Utiliza **Minimal APIs** de ASP.NET Core.
*   Expone un endpoint `POST /mensaje` que acepta `name`, `lastname` y `phoneNumber`.
*   Serializa los datos a JSON y los publica en la cola `frjr17-queue`.
*   **Swagger UI**: Incluye documentación interactiva generada automáticamente.
    *   Acceso: [http://localhost:8080/swagger](http://localhost:8080/swagger)
    *   Permite probar el endpoint `POST /mensaje` directamente desde el navegador sin necesidad de herramientas externas como Postman o cURL.

### Subscriber (Go)
*   Utiliza la librería `streadway/amqp`.
*   Implementa lógica de **reintento de conexión** para esperar a que RabbitMQ esté listo.
*   Consume mensajes de forma asíncrona usando Goroutines.
*   Maneja señales de sistema (`SIGINT`, `SIGTERM`) para un apagado ordenado.

### RabbitMQ
*   Configurado con persistencia de mensajes (`durable: true`).
*   Usuario y contraseña personalizados definidos en `compose.yml`.

## 📝 Notas Adicionales

*   Si deseas cambiar la tasa de mensajes del test de carga, edita la variable `TASA` en `load_test/load_test.py`.
*   Los logs del **Subscriber** mostrarán los mensajes recibidos en tiempo real en la consola de Docker.
