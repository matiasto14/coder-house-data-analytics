-- SECCION CREATE --
CREATE DATABASE Ventas_Tech_DB;

USE Ventas_Tech_DB;

-- SECCION DROP --

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorios;

CREATE TABLE categorias (
id_categoria INT PRIMARY KEY,
nombre_categoria VARCHAR (50) NOT NULL,
descripcion VARCHAR (200)
);

CREATE TABLE territorios (
id_territorio INT PRIMARY KEY,
provincia VARCHAR (50) NOT NULL,
region VARCHAR (50) NOT NULL
);

CREATE TABLE clientes (
id_cliente INT PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
email VARCHAR (100) UNIQUE,
id_territorio INT NOT NULL,
CONSTRAINT fk_clientes_territorios FOREIGN KEY (id_territorio) REFERENCES dbo.territorios(id_territorio),
fecha_registro DATE NOT NULL
);

CREATE TABLE productos (
id_producto INT PRIMARY KEY,
nombre_producto VARCHAR (100) NOT NULL,
id_categoria INT NOT NULL,
CONSTRAINT fk_productos_categorias FOREIGN KEY (id_categoria) REFERENCES dbo.categorias(id_categoria),
precio DECIMAL (10,2) NOT NULL,
stock INT DEFAULT 0,
activo BIT DEFAULT 1
);

CREATE TABLE ventas (
id_venta INT PRIMARY KEY,
id_cliente INT NOT NULL,
CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES dbo.clientes(id_cliente),
id_producto INT NOT NULL,
CONSTRAINT fk_id_producto_productos FOREIGN KEY (id_producto) REFERENCES dbo.productos(id_producto),
cantidad INT NOT NULL,
precio_unitario DECIMAL (10,2) NOT NULL,
fecha_venta DATE NOT NULL
);

-- SECCION INSERT --

INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
  (1, 'Computación',    'Laptops, PCs y monitores'),
  (2, 'Accesorios',     'Periféricos y complementos'),
  (3, 'Audio',          'Auriculares y parlantes'),
  (4, 'Almacenamiento', 'Discos y memorias');

INSERT INTO territorios (id_territorio, provincia, region) VALUES
	(1, 'Buenos Aires', 'ESTE'),
	(2, 'Chubut',  'SUR'),
	(3, 'Salta', 'NORTE'),
	(4, 'Santa Fe', 'NORTE'),
	(5, 'Cordoba', 'NORTE');

INSERT INTO clientes (id_cliente, nombre, email, id_territorio, fecha_registro) VALUES
  (1, 'María López',  'maria@mail.com', 1, '2024-01-05'),
  (2, 'Carlos Ruiz',  'carlos@mail.com', 2, '2024-01-10'),
  (3, 'Ana Gómez',    'ana@mail.com', 1, '2024-02-01'),
  (4, 'Pedro Sanz',   'pedro@mail.com', 1, '2024-02-15'),
  (5, 'Laura Torres', 'laura@mail.com', 2, '2024-03-01'),
  (6, 'Belen Torres', 'belen@mail.com', 3, '2024-03-01'),
  (7, 'Matias Torres', 'matias@mail.com', 1, '2024-04-03'),
  (8, 'Jimena Torres', 'jimena@mail.com', 1, '2024-08-30');


  INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES
  (1, 'Laptop Pro 15',      1, 1200.00, 15, 1),
  (2, 'Mouse Inalámbrico',  2,   28.00, 80, 1),
  (3, 'Monitor 4K 27',      1,  450.00, 12, 1),
  (4, 'Auriculares BT Pro', 3,  120.00, 35, 1),
  (5, 'SSD Externo 1TB',    4,  130.00, 18, 1),
  (6, 'Teclado Mecánico',   2,   95.00, 40, 1),
  (7, 'Teclado Membrana',   2,   95.00, 40, 1),
  (8, 'Silla Gamer',   4,   170.00, 8, 1);


  INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
  ( 1, 1, 1, 2, 1200.00, '2024-03-05'),
  ( 2, 2, 2, 5,   28.00, '2024-03-06'),
  ( 3, 3, 3, 1,  450.00, '2024-03-07'),
  ( 4, 1, 4, 2,  120.00, '2024-03-08'),
  ( 5, 4, 5, 3,  130.00, '2024-03-10'),
  ( 6, 2, 6, 4,   95.00, '2024-03-11'),
  ( 7, 5, 1, 1, 1200.00, '2024-03-12'),
  ( 8, 3, 2, 8,   28.00, '2024-03-13'),
  ( 9, 4, 4, 1,  120.00, '2024-03-14'),
  (10, 5, 3, 2,  450.00, '2024-03-15');

-- SECCION VALIDACION --
SELECT * FROM categorias;   -- esperado: 4 filas

SELECT * FROM territorios;  -- esperado: 5 filas

SELECT * FROM clientes;     -- esperado: 5 filas

SELECT * FROM productos;    -- esperado: 6 filas

SELECT * FROM ventas;       -- esperado: 10 filas