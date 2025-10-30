#Jeyson Rodriguez
import mariadb


def getConnexion():
    connector = mariadb.connect(
        user="root",
        password="secret",
        host="0.0.0.0",
        port=3306,
        database="taller3"
    )

    return connector

def getCursor():
    cursor = getConnexion().cursor()
    return cursor

def getEntidad(nombre):
    # Open a connection and return rows as list of dicts (column-name -> value)
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

def createProveedor(ciudad, proveedor, status):
    conn = getConnexion()
    cursor = conn.cursor()
    query = "INSERT INTO proveedor (ciudad, proveedor, `status`) VALUES (?, ?, ?)"
    print("Query: ", query)
    cursor.execute(query, (ciudad, proveedor, status))
    conn.commit()
    last_id = cursor.lastrowid
    cursor.close()
    conn.close()
    return last_id

def getProveedorById(proveedor_id):
    conn = getConnexion()
    cursor = conn.cursor()
    query = "SELECT * FROM proveedor WHERE id = ?"
    print("Query: ", query)
    cursor.execute(query, (proveedor_id,))
    row = cursor.fetchone()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = dict(zip(columns, row)) if row else None
    cursor.close()
    conn.close()
    return result

def updateProveedor(proveedor_id, ciudad=None, proveedor=None, status=None):
    fields = []
    params = []
    if ciudad is not None:
        fields.append("ciudad = ?")
        params.append(ciudad)
    if proveedor is not None:
        fields.append("proveedor = ?")
        params.append(proveedor)
    if status is not None:
        fields.append("`status` = ?")
        params.append(status)
    if not fields:
        return 0  # nothing to update

    params.append(proveedor_id)
    query = "UPDATE proveedor SET " + ", ".join(fields) + " WHERE id = ?"
    print("Query: ", query)
    conn = getConnexion()
    cursor = conn.cursor()
    cursor.execute(query, tuple(params))
    conn.commit()
    affected = cursor.rowcount
    cursor.close()
    conn.close()
    return affected

def deleteProveedor(proveedor_id):
    conn = getConnexion()
    cursor = conn.cursor()
    query = "DELETE FROM proveedor WHERE id = ?"
    print("Query: ", query)
    cursor.execute(query, (proveedor_id,))
    conn.commit()
    affected = cursor.rowcount
    cursor.close()
    conn.close()
    return affected

if __name__ == "__main__":
    testData = getEntidad("proveedor")
    print(testData)