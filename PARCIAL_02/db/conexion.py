import mariadb
import os
from dotenv import load_dotenv
from datetime import datetime
import uuid

load_dotenv()

def getConnexion():
    connector = mariadb.connect(
        user=os.getenv("DB_USER"), # user="root",
        password=os.getenv("DB_PASSWORD"), # password="secret"
        host=os.getenv("DB_HOST"), # host="0.0.0.0"
        port=int(os.getenv("DB_PORT")), # port=3306
        database=os.getenv("DB_NAME")
    )
    return connector

def getCursor():
    cursor = getConnexion().cursor()
    return cursor

def getEntidad(nombre):
    # Abrir una conexión y devolver filas como lista de diccionarios (nombre-columna -> valor)
    conn = getConnexion()
    cursor = conn.cursor()
    query = "SELECT * FROM {}".format(nombre)

    print("Query: ", query)

    cursor.execute(query)
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = [dict(zip(columns, row)) for row in rows]

    cursor.close()
    conn.close()
    return result

def getExpedientes(usuario_id):
    cursor = getCursor()
    query = """SELECT * FROM vista_expedientes WHERE usuario_id = ?;"""
    cursor.execute(query, (usuario_id,))
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = [dict(zip(columns, row)) for row in rows]
    return result

def getExpedientesPorFecha(fecha,usuario_id):
    # Convertir DD-MM-YYYY a YYYY-MM-DD
    try:
        fecha_obj = datetime.strptime(fecha, '%d-%m-%Y')
        fecha_sql = fecha_obj.strftime('%Y-%m-%d')
    except ValueError:
        # Manejar formato de fecha inválido si es necesario, o dejar que falle/pase
        fecha_sql = fecha

    cursor = getCursor()
    query = """SELECT * FROM vista_expedientes WHERE ? BETWEEN fecha_inicio AND fecha_finalizacion AND usuario_id = ?;"""
    cursor.execute(query, (fecha_sql,usuario_id))
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = [dict(zip(columns, row)) for row in rows]
    return result

def getExpedientesConteo(usuario_id):
    cursor = getCursor()
    query = """SELECT conteo, estado FROM vista_conteo_expedientes WHERE usuario_id = ?;"""
    cursor.execute(query, (usuario_id,))
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = [dict(zip(columns, row)) for row in rows]
    return result

def getExpedientesTotales(aseguradora=None, tipo_de_proceso=None, abogado=None):
    cursor = getCursor()
    query = "SELECT * FROM vista_expedientes_totales WHERE 1=1"
    params = []
    
    if aseguradora:
        query += " AND aseguradora = ?"
        params.append(aseguradora)
    
    if tipo_de_proceso:
        query += " AND tipo_de_proceso = ?"
        params.append(tipo_de_proceso)
        
    if abogado:
        query += " AND abogado = ?"
        params.append(abogado)
        
    cursor.execute(query, tuple(params))
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = [dict(zip(columns, row)) for row in rows]
    return result

def encontrarUsuario(usuario):
    cursor = getCursor()
    query = "SELECT id, nombre_completo, usuario, contrasena, created_at FROM usuarios WHERE usuario = ? "
    cursor.execute(query, (usuario,))
    row = cursor.fetchone()
    if row:
        columns = [desc[0] for desc in cursor.description]
        return dict(zip(columns, row))
    return None

def getAseguradoraId(nombre):
    cursor = getCursor()
    query = "SELECT id FROM aseguradoras WHERE nombre = ?"
    cursor.execute(query, (nombre,))
    row = cursor.fetchone()
    if row:
        return row[0]
    return None

def getAnyUsuarioId():
    cursor = getCursor()
    query = "SELECT id FROM usuarios LIMIT 1"
    cursor.execute(query)
    row = cursor.fetchone()
    if row:
        return row[0]
    return None

def crearExpediente(data):
    conn = getConnexion()
    cursor = conn.cursor()
    
    # Generar ID
    id_expediente = str(uuid.uuid4())
    
    # Obtener aseguradora ID
    aseguradora_nombre = data.get('aseguradora')
    aseguradora_id = getAseguradoraId(aseguradora_nombre)
    if not aseguradora_id:
        return {"error": f"Aseguradora '{aseguradora_nombre}' no encontrada"}

    # Obtener abogado ID
    abogado_usuario = data.get('abogado')
    usuario_abogado = encontrarUsuario(abogado_usuario)
    if not usuario_abogado:
        return {"error": f"Abogado (usuario) '{abogado_usuario}' no encontrado"}
    abogado_id = usuario_abogado['id']

    query = """
        INSERT INTO expedientes (
            id, aseguradora_id, estado, juzgado, 
            fecha_inicio, fecha_finalizacion, formato, conductor, 
            numero_de_caso, tipo_de_proceso, abogado_id
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """
    
    try:
        cursor.execute(query, (
            id_expediente,
            aseguradora_id,
            'Pendiente', # Estado por defecto
            data.get('juzgado'),
            data.get('fecha_inicio'),
            data.get('fecha_finalizacion'),
            data.get('formato'),
            data.get('conductor'),
            data.get('numero_de_caso'),
            data.get('tipo_de_proceso'),
            abogado_id
        ))
        conn.commit()
        conn.close()
        return {"message": "Expediente creado exitosamente", "id": id_expediente}
    except Exception as e:
        conn.close()
        return {"error": str(e)}

if __name__ == "__main__":
    print("Conexión exitosa a la base de datos")
   