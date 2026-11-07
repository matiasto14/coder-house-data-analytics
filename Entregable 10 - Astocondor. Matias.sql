USE Ventas_Tech_DB;

SELECT * FROM ventas	

-- a) Ticket promedio real vs. representativo --

SELECT AVG(precio_total) OVER() AS  Media FROM ventas;

SELECT TOP 1 PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY precio_total) OVER() AS Mediana FROM ventas;


-- Detección de outliers con IQR Aplicá el método IQR sobre la columna precio_total deL dataset --
WITH q AS (
  SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY precio_total) OVER() AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY precio_total) OVER() AS q3
  FROM ventas
)
SELECT
  q1, q3,
  (q3 - q1)          AS iqr,
  q1 - 1.5*(q3 - q1) AS limite_inferior,
  q3 + 1.5*(q3 - q1) AS limite_superior
FROM q;

-- Detección de la venta donde ocurre el outlier y sus datos correspondientes --
WITH q AS (
  SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY precio_total) OVER() AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY precio_total) OVER() AS q3
  FROM ventas
)
SELECT v.*
FROM ventas v, q
WHERE v.precio_total < q.q1 - 1.5*(q.q3 - q.q1)
   OR v.precio_total > q.q3 + 1.5*(q.q3 - q.q1);
