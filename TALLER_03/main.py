from flask import Flask
from flask import request, jsonify
from db.conexion import *

app = Flask(__name__)


@app.route("/proveedores", methods=["GET"])
def list_proveedores():
    """List all proveedores"""
    info = getEntidad("proveedor")
    return jsonify(info)


@app.route("/proveedores/<int:proveedor_id>", methods=["GET"])
def get_proveedor(proveedor_id):
    """Get a proveedor by id"""
    info = getProveedorById(proveedor_id)
    if not info:
        return jsonify({"error": "Proveedor not found"}), 404
    return jsonify(info)


@app.route("/proveedores", methods=["POST"])
def create_proveedor():
    """Crear un proveedor. Espera JSON con ciudad, proveedor, status"""
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing JSON body"}), 400

    ciudad = data.get("ciudad")
    proveedor = data.get("proveedor")
    status = data.get("status")

    if ciudad is None or proveedor is None or status is None:
        return jsonify({"error": "Missing required fields: ciudad, proveedor, status"}), 400

    try:
        status = int(status)
    except (ValueError, TypeError):
        return jsonify({"error": "Field 'status' must be an integer"}), 400

    new_id = createProveedor(ciudad=ciudad, proveedor=proveedor, status=status)
    return jsonify({"id": new_id}), 201


@app.route("/proveedores/<int:proveedor_id>", methods=["PUT"])
def update_proveedor(proveedor_id):
    """Actualizar un proveedor existente. Acepta campos parciales: ciudad, proveedor, status"""
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing JSON body"}), 400

    ciudad = data.get("ciudad")
    proveedor = data.get("proveedor")
    status = data.get("status")

    if status is not None:
        try:
            status = int(status)
        except (ValueError, TypeError):
            return jsonify({"error": "Field 'status' must be an integer"}), 400

    affected = updateProveedor(
        proveedor_id,
        ciudad=ciudad,
        proveedor=proveedor,
        status=status,
    )

    if affected == 0:
        return jsonify({"message": "No rows updated (not found or no changes)"}), 404
    return jsonify({"updated": affected})


@app.route("/proveedores/<int:proveedor_id>", methods=["DELETE"])
def delete_proveedor(proveedor_id):
    """Eliminar un proveedor por id"""
    affected = deleteProveedor(proveedor_id)
    if affected == 0:
        return jsonify({"message": "Proveedor not found"}), 404
    return jsonify({"deleted": affected})


@app.route("/", methods=["GET"])
def home():
    # Keep a simple home for backward compatibility
    return jsonify({"message": "TALLER_03 API - use /proveedores or /proveedor/<id>"})


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)