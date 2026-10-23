-- SECCION DROP --
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorios;

-- SECCION CREATE --
CREATE DATABASE Ventas_Tech_DB;

USE Ventas_Tech_DB;


CREATE TABLE categorias (
id_categoria INT PRIMARY KEY,
nombre_categoria VARCHAR (50) NOT NULL,
descripcion VARCHAR (200)
)

CREATE TABLE clientes (
id_cliente INT PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
email VARCHAR (100) UNIQUE,
telefono VARCHAR(70) NOT NULL,
documento VARCHAR(50) NOT NULL
)

CREATE TABLE productos (
id_producto INT PRIMARY KEY,
nombre_producto VARCHAR (100) NOT NULL,
id_categoria INT NOT NULL,
CONSTRAINT fk_productos_categorias FOREIGN KEY (id_categoria) REFERENCES dbo.categorias(id_categoria),
precio DECIMAL (10,2) NOT NULL,
stock VARCHAR(100),
costo DECIMAL,
)

CREATE TABLE territorios (
id_territorio INT PRIMARY KEY,
provincia VARCHAR (100) NOT NULL,
region VARCHAR (100) NOT NULL
)

CREATE TABLE ventas (
id_venta INT PRIMARY KEY,
id_cliente INT NOT NULL,
CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES dbo.clientes(id_cliente),
id_producto INT NOT NULL,
CONSTRAINT fk_id_producto_productos FOREIGN KEY (id_producto) REFERENCES dbo.productos(id_producto),
precio_unitario DECIMAL NOT NULL,
cantidad INT NOT NULL,
descuento INT NOT NULL,
fecha_venta DATE NOT NULL,
id_territorio INT NOT NULL,
CONSTRAINT fk_id_territorio_territorios FOREIGN KEY (id_territorio) REFERENCES dbo.territorios(id_territorio),
)

-- SECCION INSERT --

INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
  (1, 'Computación',    'Laptops, PCs y monitores'),
  (2, 'Accesorios',     'Periféricos y complementos'),
  (3, 'Audio',          'Auriculares y parlantes'),
  (4, 'Almacenamiento', 'Discos y memorias');

INSERT INTO clientes (id_cliente, nombre, email, telefono, documento) VALUES
  (1, 'María López',  'maria@mail.com',  '+54 9 11 5937 9374', 48026408),
  (2, 'Carlos Ruiz',  'carlos@mail.com', '+54 9 11 6378 0338', 95037343),
  (3, 'Ana Gómez',    'ana@mail.com',    '+54 9 11 9267 1289', 99730945),
  (4, 'Pedro Sanz',   'pedro@mail.com',  '+54 9 11 5539 0589', 16483245),
  (5, 'Laura Torres', 'laura@mail.com',  '+54 9 11 3127 2154', 59376904),
  (6, 'Mercedes Torres', 'mercedes@mail.com',  '+54 9 11 4593 0027', 59376904),
  (7, 'Belen Torres', 'belen@mail.com',  '+54 9 11 1923 2264', 48305672),
  (8, 'Fernando Torres', 'fernando@mail.com',  '+54 9 11 0473 3396', 59832955);

  INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, costo) VALUES
  (1, 'Laptop Pro 15',      1, 1200.00, 'SI', 800),
  (2, 'Mouse Inalámbrico',  2,   28.00, 'NO', 10),
  (3, 'Monitor 4K 27',      1,  450.00, 'SI', 150),
  (4, 'Auriculares BT Pro', 3,  120.00, 'SI', 60),
  (5, 'SSD Externo 1TB',    4,  130.00, 'SI', 40),
  (6, 'Teclado Mecánico',   2,   95.00, 'NO', 28),
  (7, 'Teclado Membrana',   2,   60.00, 'SI', 13),
  (8, 'Silla Gamer',   2,   145.00, 'NO', 38),
  (9, 'Parlantes',   2,   90.00, 'SI', 9),
  (10, 'USB',   2,   15.00, 'SI', 2);

    INSERT INTO territorios (id_territorio, provincia, region) VALUES
  (1, 'Buenos Aires', 'ESTE'),
  (2, 'Chubut', 'SUR'),
  (3, 'Salta', 'NORTE'),
  (4, 'Santa Fe','NORTE'),
  (5, 'Cordoba','NORTE');

  INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, descuento, fecha_venta, id_territorio) VALUES
  ( 1, 1, 1, 2, 1200.00, 1000, '2024-03-05', 1),
  ( 2, 2, 7, 5,   60.00, 5, '2024-03-06', 4),
  ( 3, 3, 3, 1,  450.00, 30, '2024-03-07',2),
  ( 4, 1, 4, 2,  120.00, 15,'2024-03-08',2),
  ( 5, 4, 5, 3,  130.00, 7, '2024-03-10',3),
  ( 6, 2, 6, 4,   95.00, 5, '2024-03-11',1),
  ( 7, 5, 1, 1, 1200.00, 300,'2024-03-12',2),
  ( 8, 3, 2, 8,   28.00, 3, '2024-03-13',5),
  ( 9, 4, 8, 1,  145.00, 40, '2024-03-14',3),
  (10, 5, 7, 2,  60.00, 10, '2024-03-15',5);

-- SECCION VALIDACION --
SELECT * FROM categorias;   -- esperado: 4 filas

SELECT * FROM clientes;     -- esperado: 5 filas

SELECT * FROM productos;    -- esperado: 6 filas

SELECT * FROM territorios;

SELECT * FROM ventas;       -- esperado: 10 filas