USE Ventas_Tech_DB;

SELECT * FROM ventas;

--Consulta 1 --

SELECT
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
COUNT (*) AS cantidad_pedidos,
AVG (cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH (fecha_venta)
ORDER BY mes;

-- Consulta 2 --

SELECT TOP 5 
id_producto,
SUM (cantidad) AS unidades_vendidas,
SUM (cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- Consulta 3 --

SELECT 
id_cliente,
COUNT (*) AS total_pedidos,
SUM (cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*) > 1
ORDER BY total_pedidos DESC;

-- Consulta 4 --

WITH ventas_mensuales AS (
SELECT 
     MONTH(fecha_venta) AS mes,
     SUM(cantidad * precio_unitario) AS total_mes
FROM ventas
GROUP BY MONTH(fecha_venta)
)

SELECT 
    mes,
    total_mes,
  CASE 
     WHEN total_mes >= (SELECT AVG(total_mes) FROM ventas_mensuales) THEN 'Por encima'
     ELSE 'Por debajo'
  END AS comparativa_promedio
FROM ventas_mensuales
ORDER BY mes;

-- El producto que m[as veces se vendio a su vez es el que menos facturacion dejo --
-- El producto con el ID multiplica por 10 veces en ventas al producto mas bajo --
-- Todos los clientes hicieron la misma cantidad de pedidos --