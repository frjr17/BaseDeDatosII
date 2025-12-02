import mariadb
from dotenv import load_dotenv
import os
import bcrypt
import uuid
from random import randint
from time import sleep
from datetime import datetime, timedelta

load_dotenv()

connector = mariadb.connect(
    user=os.getenv("DB_USER"),  # user="root",
    password=os.getenv("DB_PASSWORD"),  # password="secret"
    host=os.getenv("DB_HOST"),  # host="0.0.0.0"
    port=int(os.getenv("DB_PORT")),  # port=3306
)

if __name__ == "__main__":
    cursor = connector.cursor()
    print("Conexión exitosa a la base de datos")

    # Eliminar base de datos
    query = "DROP DATABASE IF EXISTS `SIS-EXP`;"
    cursor.execute(query)
    print("Base de datos 'SIS-EXP' eliminada exitosamente")

    # Crear base de datos
    query = "CREATE DATABASE IF NOT EXISTS `SIS-EXP`;"
    cursor.execute(query)
    print("Base de datos 'SIS-EXP' creada exitosamente")
    
    # Usar base de datos
    query = "USE `SIS-EXP`;"
    cursor.execute(query)
    print("Seleccionada la base de datos 'SIS-EXP' exitosamente")

    # Crear tablas
    query = """
    CREATE TABLE IF NOT EXISTS usuarios(
        id VARCHAR(36) NOT NULL PRIMARY KEY,
        nombre_completo VARCHAR(100) NOT NULL,
        usuario VARCHAR(50) NOT NULL UNIQUE,
        contrasena VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    """
    cursor.execute(query)
    print("Tabla 'usuarios' creada exitosamente")

    query = """
    CREATE TABLE IF NOT EXISTS personas(
        id VARCHAR(36) NOT NULL PRIMARY KEY,
        nombre_completo VARCHAR(100) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    """
    cursor.execute(query)
    print("Tabla 'personas' creada exitosamente")

    query = """
        CREATE TABLE IF NOT EXISTS aseguradoras(
            id VARCHAR(36) NOT NULL PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            id_persona VARCHAR(36) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (id_persona) REFERENCES personas(id)
        );
    """
    cursor.execute(query)
    print("Tabla 'aseguradoras' creada exitosamente")

    query = """
        CREATE TABLE IF NOT EXISTS expedientes(
            id VARCHAR(36) NOT NULL PRIMARY KEY,
            aseguradora_id VARCHAR(36) NOT NULL, 
            estado ENUM('Pendiente','En curso','Cerrado') NOT NULL DEFAULT 'Pendiente',
            juzgado VARCHAR(255) NOT NULL,
            fecha_inicio DATE,
            fecha_finalizacion DATE,
            formato VARCHAR(50),
            conductor VARCHAR(255),
            numero_de_caso VARCHAR(50),
            tipo_de_proceso ENUM('TRANSITO', 'PENAL') NOT NULL,
            abogado_id VARCHAR(36) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            CONSTRAINT `fk_expediente_aseguradora` FOREIGN KEY (aseguradora_id) REFERENCES aseguradoras(id),
            CONSTRAINT `fk_expediente_abogado` FOREIGN KEY (abogado_id) REFERENCES usuarios(id)
        );
    """
    cursor.execute(query)
    print("Tabla 'expedientes' creada exitosamente")

    query = """INSERT INTO usuarios (id,usuario, nombre_completo, contrasena) VALUES (?, ?, ?, ?)"""
    nombres_usuarios = [
        (str(uuid.uuid4()), "juan.perez", "Juan Perez", "secret"),
        (str(uuid.uuid4()), "maria.gomez", "Maria Gomez", "secret"),
        (str(uuid.uuid4()), "carlos.ruiz", "Carlos Ruiz", "secret"),
    ]

    for usuario in nombres_usuarios:
        contrasena = usuario[3]
        hashed = bcrypt.hashpw(contrasena.encode('utf-8'), bcrypt.gensalt(14))
        datos_usuario = (usuario[0], usuario[1], usuario[2], hashed.decode("utf-8"))
        cursor.execute(query, datos_usuario)
        print(f"Usuario (abogado) '{usuario[1]}' insertado exitosamente")

    nombres_aseguradoras = [
        (str(uuid.uuid4()), "ASSA"),
        (str(uuid.uuid4()), "MAPRE"),
        (str(uuid.uuid4()), "SURA"),
        (str(uuid.uuid4()), "ANCON"),
        (str(uuid.uuid4()), "CONANCE"),
        (str(uuid.uuid4()), "PARTICULAR"),
        (str(uuid.uuid4()), "INTEROCEANICA"),
    ]

    nombre_personas = [
        (str(uuid.uuid4()), "Luis Fernandez"),
        (str(uuid.uuid4()), "Ana Martinez"),
        (str(uuid.uuid4()), "Pedro Sanchez"),
        (str(uuid.uuid4()), "Sofia Lopez"),
        (str(uuid.uuid4()), "Jorge Ramirez"),
        (str(uuid.uuid4()), "Carmen Torres"),
        (str(uuid.uuid4()), "Diego Flores"),
    ]

    for i in range(len(nombres_aseguradoras)):
        id_persona = nombre_personas[i][0]
        id_aseguradora = nombres_aseguradoras[i][0]
        # Insertar en tabla personas
        query_persona = """INSERT INTO personas (id, nombre_completo) VALUES (?, ?)"""
        cursor.execute(query_persona, (id_persona, nombre_personas[i][1]))
        # Insertar en tabla aseguradoras
        query_aseguradora = (
            """INSERT INTO aseguradoras (id, nombre, id_persona) VALUES (?, ?, ?)"""
        )
        cursor.execute(
            query_aseguradora, (id_aseguradora, nombres_aseguradoras[i][1], id_persona)
        )
        print(
            f"Aseguradora '{nombres_aseguradoras[i][1]}' y persona asociada insertadas exitosamente"
        )

    for i in range(len(nombre_personas)):
        id_expediente = str(uuid.uuid4())
        aseguradora_id = nombres_aseguradoras[i][0]
        posibles_estados = ["Pendiente", "En curso", "Cerrado"]
        estado = posibles_estados[randint(0, 2)]
        
        fecha_inicio = datetime.now()
        fecha_finalizacion = fecha_inicio + timedelta(days=randint(5, 30))
        posibles_formatos = ["Digital", "Fisico"]
        formato = posibles_formatos[randint(0, 1)]
        conductor = f"Conductor {i+1}"
        numero_de_caso = f"CASO-{randint(1000, 9999)}"
        posibles_procesos = ["TRANSITO", "PENAL"]
        tipo_de_proceso = posibles_procesos[randint(0, 1)]
        abogado_id = nombres_usuarios[randint(0, len(nombres_usuarios)-1)][0]

        query_expediente = """INSERT INTO expedientes (id, aseguradora_id, estado, juzgado, fecha_inicio, fecha_finalizacion, formato, conductor, numero_de_caso, tipo_de_proceso, abogado_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"""
        cursor.execute(
            query_expediente,
            (
                id_expediente,
                aseguradora_id,
                estado,
                f"Juzgado {i+1}",
                fecha_inicio.date(),
                fecha_finalizacion.date(),
                formato,
                conductor,
                numero_de_caso,
                tipo_de_proceso,
                abogado_id
            ),
        )
        print(
            f"Expediente para '{nombre_personas[i][1]}' en juzgado {i+1} insertado exitosamente"
        )

    # Creando vista vista_expedientes
    query_view = """
    CREATE OR REPLACE VIEW vista_expedientes AS
    SELECT e.id, e.abogado_id AS usuario_id, a.nombre AS aseguradora, p.nombre_completo AS asegurado, e.juzgado, e.fecha_inicio, e.fecha_finalizacion
    FROM expedientes e 
    JOIN aseguradoras a ON a.id = e.aseguradora_id 
    JOIN personas p ON a.id_persona = p.id
    JOIN usuarios u ON e.abogado_id = u.id;
    """
    cursor.execute(query_view)
    print("Vista 'vista_expedientes' creada exitosamente")

    # Creando vista vista_conteo_expedientes
    query_view_conteo = """
    CREATE OR REPLACE VIEW vista_conteo_expedientes AS
    SELECT estado, abogado_id AS usuario_id, COUNT(*) AS conteo FROM expedientes GROUP BY abogado_id, estado;
    """
    cursor.execute(query_view_conteo)
    print("Vista 'vista_conteo_expedientes' creada exitosamente")

    # Creando vista expedientes totales
    query_view = """
    CREATE OR REPLACE VIEW vista_expedientes_totales AS
    SELECT a.nombre AS aseguradora, e.tipo_de_proceso as tipo_de_proceso, u.nombre_completo as abogado, e.fecha_inicio as fecha_inicio, p.nombre_completo as asegurado 
    FROM expedientes e 
    JOIN aseguradoras a ON a.id = e.aseguradora_id
    JOIN personas p ON a.id_persona = p.id
    JOIN usuarios u ON e.abogado_id = u.id;    
    """
    cursor.execute(query_view)
    print("Vista 'vista_expedientes_totales' creada exitosamente")

    connector.commit()
