from flask import Flask
from flask import request, jsonify
from db.conexion import *

app = Flask(__name__)

@app.route("/")
def home():
    info = getEntidad("proveedor")
    return jsonify(info)    


if __name__ == "__main__":
    app.run(host="0.0.0.0",debug=True)