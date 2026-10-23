USE Ventas_Tech_DB;

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM territorios; 

-- CONSULTA 1 -- Muestra todos los datos con su informacion completa

SELECT
v.fecha_venta,
c.nombre AS cliente,
p.nombre_producto AS producto,
cat.nombre_categoria AS categoria,
t.provincia AS provincia,
v.cantidad,
v.precio_unitario,
(v.precio_unitario * v.cantidad) AS total_venta

FROM ventas AS v
	INNER JOIN clientes as c
	ON v.id_cliente = c.id_cliente

	INNER JOIN productos AS p
	ON v.id_producto = p.id_producto

	INNER JOIN categorias AS cat
	ON p.id_categoria = cat.id_categoria

	INNER JOIN territorios AS t
	ON v.id_territorio = t.id_territorio;

-- Hallazgo: La venta mas cara fue de 2400 pesos

-- CONSULTA 2 -- Cliente que haya hecho una compra (LEFT JOIN)

SELECT
c.id_cliente,
c.nombre AS cliente

FROM clientes AS c
LEFT JOIN ventas AS v
ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- Hallazgo: 3 clientes registrados nunca compraron


-- CONSULTA 3 --  Producto que no se haya vendido (LEFT JOIN)

SELECT
p.id_producto,
p.nombre_producto AS productito

FROM productos AS p
LEFT JOIN ventas AS v
ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- Hallazgo: Hay 2 productos que nunca fueron pedidos


-- CONSULTA 4 --
SELECT 'Sucursal Sur' AS region, provincia
FROM territorios
WHERE region = 'SUR'

UNION ALL

SELECT 'Sucursal Norte' AS region, provincia
FROM territorios
WHERE region = 'NORTE';

-- Hallazgo: Solo una provincia no corresponde ni al norte ni sur del pais.