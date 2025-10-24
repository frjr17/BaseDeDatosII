# Jeyson Rodriguez 8-951-480
import mariadb
from dotenv import load_dotenv
import os

load_dotenv()

connector = mariadb.connect(
    user="root",
    password="secret",
    host="0.0.0.0",
    port=3306,
    database="taller3_2"
)

if __name__ == "__main__":
    print("Conexión exitosa a la base de datos")

    cursor = connector.cursor()

    query = '''CREATE OR REPLACE TABLE proveedor(
        id INT AUTO_INCREMENT PRIMARY KEY,
        proveedor VARCHAR(100) NOT NULL,
        status INT,
        ciudad VARCHAR(150)
    )'''

    cursor.execute(query)
    print("Tabla 'proveedor' creada exitosamente")
    
    query = '''INSERT INTO proveedor (proveedor,status,ciudad) VALUES
        ('Proveedor A' ,1, 'Ciudad X'),
        ('Proveedor B', 0, 'Ciudad Y'),
        ('Proveedor C', 1, 'Ciudad Z')'''
    
    cursor.execute(query)
    print("Datos insertados exitosamente")

    connector.commit()
    print("\nConsola de Agregar informacion\n")
    nombre = input ("Ingresa nombre: ")
    status =int(input("Ingrese status: "))
    ciudad = input("Ingresa Ciudad: ")
    
    datos = (nombre,status,ciudad)
    query_guardar = "INSERT INTO proveedor VALUES(null,?,?,?)"
    
    cursor.execute(query_guardar,datos)
    connector.commit()

    query1 = "SELECT * FROM proveedor;"

    cursor.execute(query1)

    data = cursor.fetchall()

    data_final =[]
    for row in data:
        id = row[0]
        name = row[1]
        city = row[2]

        lista = {
            "ID":id,
            "nombre": name,
            "ciudad": city
        }

        print(lista)
        data_final.append(lista)
