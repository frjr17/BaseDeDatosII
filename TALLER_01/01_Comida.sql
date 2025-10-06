-- =========================================
-- DB: catalogo_productos_simple
-- =========================================
DROP DATABASE IF EXISTS catalogo_productos_simple;
CREATE DATABASE catalogo_productos_simple;
USE catalogo_productos_simple;

CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL
);

CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  category_id INT NOT NULL,
  product_type VARCHAR(20) NOT NULL, -- 'FOOD', 'FURNITURE' o 'GENERIC'
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Subtipos (1:1 con product usando la misma PK como FK)
CREATE TABLE foods (
  product_id INT PRIMARY KEY,
  expiration_date DATE NOT NULL,
  calories INT NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE furnitures (
  product_id INT PRIMARY KEY,
  manufacture_date DATE NOT NULL,
  material VARCHAR(80) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Pedidos
CREATE TABLE `orders` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME NOT NULL,
  customer_name VARCHAR(120) NOT NULL
);

CREATE TABLE order_lines (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES `orders`(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- =========================================
-- INSERT (datos de ejemplo)
-- =========================================
INSERT INTO categories (name) VALUES
 ('Groceries'),
 ('Home');

INSERT INTO products (name, price, category_id, product_type) VALUES
 ('Leche', 1.20, 1, 'COMIDA'),
 ('Manzana', 0.50, 1, 'COMIDA'),
 ('Silla', 35.00, 2, 'MUEBLES'),
 ('Bolígrafo', 2.00, 2, 'GENERICO');

INSERT INTO foods (product_id, expiration_date, calories) VALUES
 (1, '2025-10-20', 150),
 (2, '2025-10-17', 95);

INSERT INTO furnitures (product_id, manufacture_date, material) VALUES
 (3, '2025-09-06', 'Pino');

INSERT INTO `orders` (created_at, customer_name) VALUES
 ('2025-10-06 10:00:00', 'Hernan'),
 ('2025-10-06 11:00:00', 'Maryon');

INSERT INTO order_lines (order_id, product_id, quantity, unit_price) VALUES
 (1, 1, 2, 1.20),
 (1, 2, 6, 0.50),
 (2, 3, 1, 35.00);

-- =========================================
-- SELECT / WHERE / JOIN (ejemplos)
-- =========================================

-- Productos con su categoría
SELECT p.id, p.name, c.name AS category, p.price
FROM products p
JOIN categories c ON c.id = p.category_id
ORDER BY p.id;

-- Solo productos de tipo COMIDA
SELECT p.id, p.name, f.expiration_date, f.calories
FROM products p
JOIN foods f ON f.product_id = p.id
WHERE p.product_type = 'COMIDA';

-- Totales por orden (suma simple)
SELECT o.id, o.customer_name,
       SUM(ol.quantity * ol.unit_price) AS total
FROM `orders` o
JOIN order_lines ol ON ol.order_id = o.id
GROUP BY o.id, o.customer_name
ORDER BY o.id;

-- Muebles con su material
SELECT p.id, p.name, p.price, fu.material
FROM products p
JOIN furnitures fu ON fu.product_id = p.id
WHERE p.product_type = 'MUEBLES';