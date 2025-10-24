#Jeyson Rodriguez
from flask import Flask
from flask import request, jsonify
from db2.conexion import *

app = Flask(__name__)

@app.route("/")
def home():
    info = getEntidad("proveedor")
    return jsonify(info)

if __name__ == "__main__":
    app.run(debug=True)