from flask import Flask
from flask import request, jsonify
from db.conexion import *
from db.conexion import getExpedientes, getExpedientesConteo, encontrarUsuario
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

    return jsonify({"message": "Login exitoso", "user": user}), 200

@app.route("/expedientes", methods=["GET"])
def list_expedientes():
    """List all expedientes"""
    info = getExpedientes()
    return jsonify(info)

@app.route("/expedientes/conteo", methods=["GET"])
def conteo_expedientes():
    """Dar conteo de expedientes por estado"""
    query_result = getExpedientesConteo()
    return jsonify(query_result)