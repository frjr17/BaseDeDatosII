import mariadb

def getConnexion():
    connector = mariadb.connect(
        user="root",
        password="secret",
        host="0.0.0.0",
        port=3306,
        database="taller3_2"
    )

    return connector

def getCursor():
    cursor = getConnexion().cursor()
    return cursor

def getEntidad(nombre):
    cursor = getCursor()
    query = "SELECT * FROM {}".format(nombre)

    print("query",query)

    cursor.execute(query)
    result = cursor.fetchall()

    return result

if __name__ == "__main__":
    testData = getEntidad("proveedor")
    print(testData)

