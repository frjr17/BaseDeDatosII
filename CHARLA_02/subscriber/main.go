package main

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/streadway/amqp"
)

func main() { 
	var conn *amqp.Connection
	var err error
	maxRetries := 10 // Número máximo de intentos de conexión

	// Obtenemos configuración de variables de entorno o usamos valores por defecto
	host := os.Getenv("RABBITMQ_HOST")
	if host == "" { host = "rabbitmq" }
	user := os.Getenv("RABBITMQ_USER")
	if user == "" { user = "frjr17" }
	pass := os.Getenv("RABBITMQ_PASS")
	if pass == "" { pass = "frjr17" }
	queue := os.Getenv("RABBITMQ_QUEUE")
	if queue == "" { queue = "frjr17-queue" }

	// Bucle de reintento para conectar a RabbitMQ
	// Esto es útil porque el contenedor de RabbitMQ puede tardar más en iniciar que este servicio
	for i := 1; i <= maxRetries; i++ {
		conn, err = amqp.Dial(fmt.Sprintf("amqp://%s:%s@%s:5672/", user, pass, host))
		if err == nil {
			break // Conexión exitosa, salimos del bucle
		}
		log.Printf("RabbitMQ no está listo, reintentando en 5s... (intento %d/%d)", i, maxRetries)
		time.Sleep(5 * time.Second) // Esperamos 5 segundos antes de reintentar
	}
	// Si después de todos los intentos no conectamos, terminamos el programa con error
	if err != nil {
		log.Fatalf("Fallo al conectar a RabbitMQ después de %d intentos: %v", maxRetries, err)
	}
	defer conn.Close() // Aseguramos cerrar la conexión al salir

	// Abrimos un canal sobre la conexión establecida
	ch, err := conn.Channel()
	if err != nil {
		log.Fatalf("Fallo al abrir un canal: %v", err)
	}
	defer ch.Close() // Aseguramos cerrar el canal al salir

	// Registramos un consumidor para leer mensajes de la cola
	msgs, err := ch.Consume(
		queue,          // nombre de la cola
		"",             // etiqueta del consumidor (vacío = autogenerado)
		true,           // auto-ack: true significa que el mensaje se confirma automáticamente al recibirse
		false,          // exclusive: false permite otros consumidores en la cola
		false,          // no-local: false permite recibir mensajes publicados por la misma conexión
		false,          // no-wait: false espera confirmación del servidor
		nil,            // argumentos adicionales
	)
	if err != nil {
		log.Fatalf("Fallo al registrar un consumidor: %v", err)
	}

	// Configuración para manejo de señales de sistema (Graceful Shutdown)
	quit := make(chan os.Signal, 1)
	// Notificar en el canal 'quit' si recibimos SIGINT (Ctrl+C) o SIGTERM (Docker stop)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	done := make(chan bool)

	// Goroutine (hilo ligero) para procesar los mensajes en segundo plano
	go func() {
		for d := range msgs {
			// Procesamos cada mensaje recibido
			log.Printf("Recibido un mensaje: %s", d.Body)
		}

		done <- true // Señalizamos cuando el canal de mensajes se cierra
	}()

	log.Println(" [*] Esperando mensajes. Para salir presione CTRL+C")
	
	// Bloqueamos la ejecución principal esperando una señal de salida o fin de mensajes
	select {
	case <-quit:
		log.Println("Apagando suscriptor...")
	case <-done:
		log.Println("Canal cerrado.")
	}
}