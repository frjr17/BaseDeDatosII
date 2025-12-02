from flask import Flask
from flask import request, jsonify
from db.conexion import *
from db.conexion import getExpedientes, getExpedientesConteo, encontrarUsuario, crearExpediente, getExpedientesTotales
import bcrypt
app = Flask(__name__)


@app.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    print(data)
    if not data:
        return jsonify({"error": "Falta usuario y contraseña"}), 400

    usuario = data.get("usuario")
    contrasena = data.get("contrasena")

    if not usuario or not contrasena:
        return jsonify({"error": "Falta usuario y contraseña"}), 400

    user = encontrarUsuario(usuario)
    if not user:
        return jsonify({"error": "Usuario no encontrado"}), 404
  

    is_valid = bcrypt.checkpw(contrasena.encode('utf-8'),user["contrasena"].encode('utf-8'))
    if not is_valid:
        return jsonify({"error": "Usuario o contrasena incorrecta"}), 404

    return jsonify({"message": "Login exitoso", "user": {
        "id": user["id"],
        "nombre_completo": user["nombre_completo"],
        "usuario": user["usuario"],
    }}), 200

@app.route("/expedientes", methods=["POST"])
def create_expediente():
    """Create a new expediente"""
    data = request.get_json()
    required_fields = [
        "conductor", "aseguradora", "numero_de_caso", "tipo_de_proceso", 
        "abogado", "fecha_inicio", "fecha_finalizacion", "juzgado", "formato"
    ]
    
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"Falta el campo {field}"}), 400
            
    result = crearExpediente(data)
    if "error" in result:
        return jsonify(result), 400
    return jsonify(result), 201

@app.route("/expedientes", methods=["GET"])
def list_expedientes():
    """List all expedientes"""
    usuario_id = request.args.get("usuario_id")
    if not usuario_id:
        return jsonify({"error": "Falta el parametro usuario_id"}), 400
        
    info = getExpedientes(usuario_id)
    return jsonify(info)

@app.route("/expedientes/fecha/<fecha>", methods=["GET"])
def list_expedientes_por_fecha(fecha):
    """List expedientes by date, restringido por usuario"""
    usuario_id = request.args.get("usuario_id")
    if not usuario_id:
        return jsonify({"error": "Falta el parametro usuario_id"}), 400

    info = getExpedientesPorFecha(fecha, usuario_id)
    return jsonify(info)

@app.route("/expedientes/conteo", methods=["GET"])
def conteo_expedientes():
    """Dar conteo de expedientes por estado"""
    usuario_id = request.args.get("usuario_id")
    if not usuario_id:
        return jsonify({"error": "Falta el parametro usuario_id"}), 400
        
    query_result = getExpedientesConteo(usuario_id)
    return jsonify(query_result)

@app.route("/expedientes/totales", methods=["GET"])
def list_expedientes_totales():
    """List all expedientes totales"""
    aseguradora = request.args.get("aseguradora")
    tipo_de_proceso = request.args.get("tipo_de_proceso")
    abogado = request.args.get("abogado")
    
    info = getExpedientesTotales(aseguradora, tipo_de_proceso, abogado)
    return jsonify(info)

