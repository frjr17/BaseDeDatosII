using RabbitMQ.Client;
using System;

// Creamos el constructor de la aplicación web (ASP.NET Core Minimal API)
var builder = WebApplication.CreateBuilder(args);

// Agregamos servicios al contenedor de inyección de dependencias
// EndpointsApiExplorer es necesario para que Swagger pueda descubrir las rutas
builder.Services.AddEndpointsApiExplorer();
// SwaggerGen genera la documentación de la API (OpenAPI)
builder.Services.AddSwaggerGen();

// Construimos la aplicación
var app = builder.Build();

// Habilitamos el middleware de Swagger para servir la especificación JSON generada
app.UseSwagger();
// Habilitamos la interfaz gráfica de Swagger (Swagger UI) para probar la API desde el navegador
app.UseSwaggerUI();

// Definimos un endpoint POST en la ruta "/mensaje"
// Este endpoint recibe parámetros (name, lastname, phoneNumber) y los envía a RabbitMQ
app.MapPost("/mensaje", async (IServiceProvider serviceProvider, string name, string lastname, string phoneNumber) =>
{
    // Obtenemos la configuración de conexión desde variables de entorno
    // Si no existen, usamos valores por defecto (útil para desarrollo local)
    var host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq";
    var user = Environment.GetEnvironmentVariable("RABBITMQ_USER") ?? "frjr17";
    var pass = Environment.GetEnvironmentVariable("RABBITMQ_PASS") ?? "frjr17";
    var queue = Environment.GetEnvironmentVariable("RABBITMQ_QUEUE") ?? "frjr17-queue"; // Nombre de la cola

    // Configuramos la fábrica de conexiones de RabbitMQ
    var factory = new ConnectionFactory()
    {
        HostName = host,
        Port = 5672, // Puerto estándar de RabbitMQ
        UserName = user,
        Password = pass
    };

    // Creamos una conexión asíncrona con el servidor RabbitMQ
    using var connection = await factory.CreateConnectionAsync();
    // Creamos un canal de comunicación dentro de esa conexión
    using var channel = await connection.CreateChannelAsync();

    // Declaramos la cola para asegurarnos de que existe antes de publicar
    // durable: true (la cola sobrevive a reinicios del broker)
    // exclusive: false (la cola puede ser usada por otras conexiones)
    // autoDelete: false (la cola no se borra cuando se desconectan los consumidores)
    await channel.QueueDeclareAsync(queue: queue, durable: true, exclusive: false, autoDelete: false, arguments: null);

    // Creamos el objeto del mensaje con los datos recibidos
    var message = new { Name = name, Lastname = lastname, PhoneNumber = phoneNumber };
    
    // Serializamos el mensaje a formato JSON (bytes UTF-8)
    var body = System.Text.Json.JsonSerializer.SerializeToUtf8Bytes(message);

    // Publicamos el mensaje en la cola
    // exchange: "" (exchange por defecto)
    // routingKey: queue (en el exchange por defecto, la routingKey es el nombre de la cola)
    await channel.BasicPublishAsync(exchange: "",
                                    routingKey: queue,
                                    body: body);

    // Retornamos una respuesta HTTP 200 OK indicando éxito
    return Results.Ok("Message sent successfully");
})
.WithName("SendMessage") // Nombre de la operación para OpenAPI
.WithOpenApi(); // Agrega metadatos de OpenAPI

// Ejecutamos la aplicación web
app.Run();