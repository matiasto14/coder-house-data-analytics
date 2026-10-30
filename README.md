RetailPro – Análisis de ventas de una empresa tecnológica

Proyecto de análisis de datos desarrollado en el marco del curso de Data Analytics de Coder House. Consiste en una base de datos en SQL Server para una empresa tecnológica que vende computadoras, memorias y otros productos, diseñada para analizar el comportamiento del negocio: qué se vende, a quién, dónde y cuánto se factura.

Objetivo

Construir un modelo de datos el cual luego junto con Power BI se pueda entrelazar para usar sus herramientas en función de realizar un riguroso, preciso y eficaz análisis del rumbo del negocio y así planificar distintas estrategias operativas.
Esto va a poder lograrse usando gráficos, KPIs y otros indicadores dinámicos que nos den datos con los cuales luego tomar las mejores decisiones posibles. Algunos de esos datos puede responder preguntas como:

¿Cuánto se factura por mes y cuál es el ticket promedio?
¿Qué productos y categorías generan más ingresos?
¿En qué provincias y regiones están los clientes que más compran?

Modelo de datos
El modelo es de tipo copo de nieve (snowflake): una tabla de hechos rodeada de dimensiones, algunas de las cuales se normalizan en tablas adicionales.

Tabla	- Tipo	- Descripción
ventas	- Hechos	- Registra cada venta: fecha, cliente, producto, cantidad y precio unitario.
clientes -	Dimensión -	Datos de los clientes. Se relaciona con territorios.
productos	- Dimensión	- Catálogo de productos. Se relaciona con categorias.
categorias -	Dimensión	- Categorías de los productos (se conecta a productos, no a ventas).
territorios -	Dimensión	- Ciudades, regiones y provincias donde se ubican los clientes.

Relaciones principales:

ventas ──► clientes ──► territorios
   │
   └────► productos ──► categorias
   
Estructura del repositorio
Archivo	Contenido
  ventas_tech_db.sql	= Creación de la base de datos, las tablas dimensionales y la tabla de hechos, junto con la carga de datos.
  m4_consultas_negocio.sql	= Consultas de negocio: resumen ejecutivo mensual y ranking de productos por total facturado.
  m5_consultas_joins.sql	= Consultas con INNER JOIN que unen la tabla de hechos con las dimensiones para obtener el detalle de cada venta en una sola fila.
  Pipeline_ETL_Astocondor_Matias.pbix =	Archivo de Power BI con el pipeline de extracción, transformación y carga.
  Astocondor_Matias_Checkpoint2.pbix	= Archivo de Power BI correspondiente al segundo checkpoint del curso.

Herramientas utilizadas
  SQL Server: motor de base de datos.
  SQL Server Management Studio (SSMS): creación y ejecución de los scripts.
  T-SQL: lenguaje de consulta (INNER JOIN, funciones de agregación, GROUP BY, ORDER BY).
  Power BI Desktop: ETL y visualización (archivos .pbix).
  Git y GitHub: control de versiones y entrega de los trabajos.

Cómo ejecutar los scripts SQL
  Requisitos previos
  
  SQL Server instalado (por ejemplo, la edición Express o Developer).
  
  SQL Server Management Studio (SSMS). Asegurarse de que al usar SQL SMS, estemos conectados a la misma ruta donde hayamos guardado los archivos y así funcionen bien ya que mi ruta no es la misma que ustedes van a tener en su computadora
  Power BI Desktop, solo si querés abrir los archivos .pbix. Asegurarse de que al usar POWER BI, estemos conectados a la misma ruta donde hayamos guardado los archivos y así funcionen bien ya que mi ruta no es la misma que ustedes van a tener en su computadora
  
  Pasos
  
  Cloná el repositorio:
  
  bash
  
   git clone https://github.com/matiasto14/coder-house-data-analytics.git
 
  Abrí SSMS y conectate a tu instancia de SQL Server.
  
  Creá la base de datos y las tablas. En SSMS elegí Archivo > Abrir > Archivo…, seleccioná ventas_tech_db.sql y ejecutalo con F5.
 
  Verificá la carga de datos con una consulta simple:
 
  sql
  
   SELECT COUNT(*) FROM ventas;
  Ejecutá las consultas de negocio. Abrí m4_consultas_negocio.sql, asegurate de tener seleccionada la base de datos correcta en el selector de SSMS (o agregá USE nombre_de_la_base; al inicio) y ejecutalo con F5.
  Ejecutá las consultas con JOIN. Repetí el paso anterior con m5_consultas_joins.sql.

Orden recomendado: ventas_tech_db.sql → m4_consultas_negocio.sql → m5_consultas_joins.sql. Los dos últimos dependen de que las tablas ya existan y tengan datos.

Ejemplo de consulta

Detalle de ventas en una sola fila, uniendo la tabla de hechos con sus dimensiones:

sql
SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS cliente,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    t.provincia,
    v.cantidad,
    v.precio_unitario,
    (v.precio_unitario * v.cantidad) AS total_venta
FROM ventas AS v
    INNER JOIN clientes AS c
        ON v.id_cliente = c.id_cliente
    INNER JOIN productos AS p
        ON v.id_producto = p.id_producto
    INNER JOIN categorias AS cat
        ON p.id_categoria = cat.id_categoria
    INNER JOIN territorios AS t
        ON c.id_territorio = t.id_territorio
ORDER BY v.fecha_venta, c.nombre;
Autor

Matias Astocondor GitHub: @matiasto14
