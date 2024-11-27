use proyecto;

-- nombre de todos los productos almacenados en inventario 
select producto.Nombre from inventario
inner join producto on producto.ID_Producto = inventario.ID_Producto;

-- detalles de los productos almacenados en el inventario 
select producto.nombre, producto.categoria, detalle_producto_precio.precio, detalle_producto_precio.Fecha_Registro from inventario
inner join producto on producto.ID_Producto = inventario.ID_Producto,
inner join detalle_producto_precio dpp on dpp.ID_Producto = producto.ID_producto;

-- Consultas sobre Inventario
-- Consultar todos los productos en inventario y su cantidad:

SELECT p.Nombre, i.Cantidad
FROM producto p
JOIN inventario i ON p.ID_Producto = i.ID_Producto;
-- Obtener productos con inventario bajo (por debajo de un umbral):

SELECT p.Nombre, i.Cantidad
FROM producto p
JOIN inventario i ON p.ID_Producto = i.ID_Producto
WHERE i.Cantidad < 10; -- Cambia 10 por el umbral deseado.
-- Contar el total de productos en inventario:

SELECT COUNT(*) AS Total_Productos
FROM inventario;
-- Consultar los productos y su valoración total en inventario (cantidad por precio):

SELECT p.Nombre, (i.Cantidad * dpp.Precio) AS Valor_Total
FROM producto p
JOIN inventario i ON p.ID_Producto = i.ID_Producto
JOIN detalle_producto_precio dpp ON p.ID_Producto = dpp.ID_Producto
WHERE dpp.Fecha_Registro = (SELECT MAX(Fecha_Registro) FROM detalle_producto_precio);
-- Consultas sobre Producción
-- Producción total por producto en el último mes:

SELECT p.Nombre, SUM(pp.Cantidad_Producida) AS Total_Producido
FROM proceso_produccion pp
JOIN producto p ON pp.ID_Producto = p.ID_Producto
WHERE pp.Fecha_Inicio >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY p.Nombre;
-- Producción mensual por empleado:

SELECT e.Nombre, e.Apellido, SUM(pp.Cantidad_Producida) AS Total_Producido
FROM proceso_produccion pp
JOIN empleado e ON pp.ID_Empleado = e.ID_Empleado
WHERE pp.Fecha_Inicio >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY e.ID_Empleado;
-- Cosecha total por cultivo en el último mes:

SELECT c.Nombre, SUM(co.Cantidad) AS Total_Cosechado
FROM cosecha co
JOIN cultivo c ON co.ID_Cultivo = c.ID_Cultivo
WHERE co.Fecha_Cosecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.Nombre;
-- Costo promedio de producción por máquina usada:

SELECT m.Nombre, AVG(mnt.Costo) AS Costo_Promedio
FROM mantenimiento mnt
JOIN maquinaria m ON mnt.ID_Maquinaria = m.ID_Maquinaria
GROUP BY m.Nombre;
-- Consulta sobre el total de procesos de producción:

SELECT COUNT(*) AS Total_Procesos 
FROM proceso_produccion;
-- Consultas sobre Ventas
-- Consultar todas las ventas realizadas en el último mes:

SELECT v.ID_Venta, c.Nombre, c.Apellido, v.Fecha_Venta, v.Total_Venta
FROM venta v
JOIN cliente c ON v.ID_Cliente = c.ID_Cliente
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
-- Total de ventas por producto:

SELECT p.Nombre, SUM(dv.Cantidad) AS Cantidad_Vendida, SUM(dv.Subtotal) AS Total_Vendido
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
GROUP BY p.Nombre;
-- Clientes que más han comprado:

SELECT c.Nombre, c.Apellido, COUNT(v.ID_Venta) AS Total_Ventas
FROM cliente c
JOIN venta v ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.ID_Cliente
ORDER BY Total_Ventas DESC
LIMIT 10;
-- Total de ventas por empleado en el último mes:

SELECT e.Nombre, e.Apellido, SUM(v.Total_Venta) AS Total_Vendido
FROM venta v
JOIN empleado e ON v.ID_Empleado = e.ID_Empleado
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY e.ID_Empleado;
-- Consultas sobre Compras
-- Consultar todas las compras a proveedores en el último mes:

SELECT co.ID_Compra, p.Nombre, co.Fecha_Compra, co.Total_Compra
FROM compra co
JOIN proveedor p ON co.ID_Proveedor = p.ID_Proveedor
WHERE co.Fecha_Compra >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
-- Total de compras por proveedor:

SELECT p.Nombre, SUM(co.Total_Compra) AS Total_Comprado
FROM compra co
JOIN proveedor p ON co.ID_Proveedor = p.ID_Proveedor
GROUP BY p.ID_Proveedor;
-- Productos más comprados:

SELECT pr.Nombre, SUM(dc.Cantidad) AS Total_Comprado
FROM detalle_compra dc
JOIN producto pr ON dc.ID_Producto = pr.ID_Producto
GROUP BY pr.ID_Producto
ORDER BY Total_Comprado DESC;
-- Consultas sobre Costos Operativos
-- Costo total de mantenimiento por máquina:

SELECT m.Nombre, SUM(mnt.Costo) AS Total_Costo
FROM mantenimiento mnt
JOIN maquinaria m ON mnt.ID_Maquinaria = m.ID_Maquinaria
GROUP BY m.ID_Maquinaria;
-- Costo promedio de mantenimiento por máquina en último año:

SELECT m.Nombre, AVG(mnt.Costo) AS Costo_Promedio
FROM mantenimiento mnt
JOIN maquinaria m ON mnt.ID_Maquinaria = m.ID_Maquinaria
WHERE mnt.Fecha_Mantenimiento >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY m.ID_Maquinaria;
-- Consultas sobre Desempeño de Empleados
-- Desempeño de los empleados según cantidad producida:

SELECT e.Nombre, e.Apellido, SUM(pp.Cantidad_Producida) AS Total_Producido
FROM proceso_produccion pp
JOIN empleado e ON pp.ID_Empleado = e.ID_Empleado
GROUP BY e.ID_Empleado
ORDER BY Total_Producido DESC;
-- Tiempo promedio de trabajo de cada empleado:

SELECT e.Nombre, e.Apellido, DATEDIFF(CURDATE(), e.Fecha_Ingreso) AS Dias_Trabajados
FROM empleado e;
-- Consultas con Subconsultas
-- Productos que no han tenido ventas en el último mes:

SELECT p.Nombre
FROM producto p
WHERE p.ID_Producto NOT IN (
  SELECT dv.ID_Producto
  FROM detalle_venta dv
  JOIN venta v ON dv.ID_Venta = v.ID_Venta
  WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH
));
-- Proveedores que no han vendido en los últimos tres meses:

SELECT p.Nombre
FROM proveedor p
WHERE p.ID_Proveedor NOT IN (
  SELECT co.ID_Proveedor
  FROM compra co
  WHERE co.Fecha_Compra >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
);
-- Promedio de ventas por cliente:

SELECT c.Nombre, c.Apellido, AVG(v.Total_Venta) AS Promedio_Ventas
FROM cliente c
JOIN venta v ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.ID_Cliente;
-- Máquina con el costo total más alto de mantenimiento:

SELECT m.Nombre
FROM maquinaria m
WHERE m.ID_Maquinaria = (
  SELECT mnt.ID_Maquinaria
  FROM mantenimiento mnt
  GROUP BY mnt.ID_Maquinaria
  ORDER BY SUM(mnt.Costo) DESC
  LIMIT 1
);
-- Empleado con más procesos de producción asignados:

SELECT e.Nombre, e.Apellido
FROM empleado e
WHERE e.ID_Empleado = (
  SELECT pp.ID_Empleado
  FROM proceso_produccion pp
  GROUP BY pp.ID_Empleado 
  ORDER BY COUNT(*) DESC
  LIMIT 1
);
-- Consultas de Resumen y Agregación
-- Resumen de ventas por mes:

SELECT MONTH(v.Fecha_Venta) AS Mes, SUM(v.Total_Venta) AS Total_Vendido
FROM venta v
GROUP BY Mes;
-- Suma total de todas las compras hechas:

SELECT SUM(Total_Compra) AS Total_Compras
FROM compra;
-- Cantidad total de empleados:

SELECT COUNT(*) AS Total_Empleados
FROM empleado;
-- Cantidad total de maquinaria:

SELECT COUNT(*) AS Total_Maquinaria
FROM maquinaria;
-- Resumen de producción por producto:

SELECT p.Nombre, SUM(pp.Cantidad_Producida) AS Total_Producido
FROM proceso_produccion pp
JOIN producto p ON pp.ID_Producto = p.ID_Producto
GROUP BY p.Nombre;
-- Consultas Avanzadas
-- Top 5 productos por total vendido:

SELECT p.Nombre, SUM(dv.Subtotal) AS Total_Vendido
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
GROUP BY p.Nombre
ORDER BY Total_Vendido DESC
LIMIT 5;
-- Monto total de la última compra realizada:

SELECT Total_Compra
FROM compra
ORDER BY Fecha_Compra DESC
LIMIT 1;
-- Tasa de rotación de empleados:

SELECT (COUNT(e.ID_Empleado) / (SELECT COUNT(*) FROM empleado)) * 100 AS Tasa_Rotacion
FROM empleado e
WHERE e.Fecha_Ingreso < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
-- Porcentaje de ventas por tipo de producto:

SELECT p.Categoria, (SUM(dv.Subtotal) / (SELECT SUM(Subtotal) FROM detalle_venta)) * 100 AS Porcentaje_Ventas
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
GROUP BY p.Categoria;
-- Días promedio entre la fecha de cosecha y venta de productos:

SELECT AVG(DATEDIFF(v.Fecha_Venta, co.Fecha_Cosecha)) AS Dias_Promedio
FROM venta v
JOIN detalle_venta dv ON v.ID_Venta = dv.ID_Venta
JOIN cosecha co ON dv.ID_Producto = co.ID_Cultivo; -- Ajustar según lógica de negocios
-- Consultas Generales
-- Total de empleados por cargo:

SELECT Cargo, COUNT(*) AS Total_Empleados
FROM empleado
GROUP BY Cargo;
-- Costo total de mantenimiento por cultivo en el último año:

SELECT c.Nombre, SUM(mnt.Costo) AS Total_Costo
FROM mantenimiento mnt
JOIN maquinaria ma ON mnt.ID_Maquinaria = ma.ID_Maquinaria
JOIN proceso_produccion pp ON pp.ID_Maquinaria = ma.ID_Maquinaria
JOIN cosecha co ON co.ID_Cultivo = pp.ID_Producto -- Ajustar según lógica
JOIN cultivo c ON c.ID_Cultivo = co.ID_Cultivo
WHERE mnt.Fecha_Mantenimiento >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.Nombre;
-- Total de ingresos generados por ventas en el último año:

SELECT SUM(Total_Venta) AS Ingresos_Totales
FROM venta
WHERE Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
-- Clientes que han comprado más de una vez:

SELECT c.Nombre, c.Apellido, COUNT(v.ID_Venta) AS Total_Compras
FROM cliente c
JOIN venta v ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.ID_Cliente
HAVING Total_Compras > 1;
-- Resumen de costos versus ingresos en el último mes:

SELECT (SELECT SUM(mnt.Costo) FROM mantenimiento mnt WHERE mnt.Fecha_Mantenimiento >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) AS Total_Costos,
       (SELECT SUM(v.Total_Venta) FROM venta v WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) AS Total_Ingresos;
-- Consultas sobre Ventas
-- Ventas totales por cliente en el último mes:

SELECT c.Nombre, c.Apellido, SUM(v.Total_Venta) AS Total_Vendido
FROM venta v
JOIN cliente c ON v.ID_Cliente = c.ID_Cliente
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.ID_Cliente;
-- Ventas por categoría de producto:

SELECT p.Categoria, SUM(dv.Cantidad) AS Total_Vendido
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
GROUP BY p.Categoria;
-- Días promedio entre la compra de un producto y su venta:

SELECT AVG(DATEDIFF(v.Fecha_Venta, co.Fecha_Compra)) AS Dias_Promedio
FROM venta v
JOIN detalle_venta dv ON v.ID_Venta = dv.ID_Venta
JOIN detalle_compra dc ON dv.ID_Producto = dc.ID_Producto
JOIN compra co ON dc.ID_Compra = co.ID_Compra;
-- Lista de productos que generaron ventas con un margen de ganancia específico (ejemplo: más del 20%):

SELECT p.Nombre, SUM(dv.Subtotal) AS Total_Vendido
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
GROUP BY p.Nombre
HAVING (Total_Vendido - (SELECT SUM(dc.Precio_Compra)
                          FROM detalle_compra dc
                          WHERE dc.ID_Producto = p.ID_Producto)) / Total_Vendido > 0.20;
-- Clientes cuyo total de ventas excede un importe específico:

SELECT c.Nombre, c.Apellido, SUM(v.Total_Venta) AS Total_Vendido
FROM venta v
JOIN cliente c ON v.ID_Cliente = c.ID_Cliente
GROUP BY c.ID_Cliente
HAVING Total_Vendido > 1000; -- Cambiar 1000 para el importe que se desee
-- Consultas sobre Compras
-- Compras promedio por proveedor en el último año:

SELECT p.Nombre, AVG(co.Total_Compra) AS Promedio_Compras
FROM compra co
JOIN proveedor p ON co.ID_Proveedor = p.ID_Proveedor
WHERE co.Fecha_Compra >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.ID_Proveedor;
-- Proveedores con mayor cantidad de compras en el último mes:

SELECT p.Nombre, COUNT(co.ID_Compra) AS Total_Compras
FROM compra co
JOIN proveedor p ON co.ID_Proveedor = p.ID_Proveedor
WHERE co.Fecha_Compra >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY p.ID_Proveedor
ORDER BY Total_Compras DESC;
-- Total gastado en compras por mes:

SELECT MONTH(Fecha_Compra) AS Mes, SUM(Total_Compra) AS Total_Gastado
FROM compra
GROUP BY Mes;
-- Costo total de productos comprados por cada proveedor:

SELECT p.Nombre, SUM(dc.Cantidad * dc.Precio_Compra) AS Total_Costo
FROM detalle_compra dc
JOIN compra co ON dc.ID_Compra = co.ID_Compra
JOIN proveedor p ON co.ID_Proveedor = p.ID_Proveedor
GROUP BY p.Nombre;
-- Consultas sobre Desempeño de Empleados
-- Salario promedio por cargo de los empleados:

SELECT Cargo, AVG(Salario) AS Salario_Promedio
FROM empleado
GROUP BY Cargo;
-- Desempeño de los empleados según ventas generadas:

SELECT e.Nombre, e.Apellido, SUM(v.Total_Venta) AS Total_Vendido
FROM venta v
JOIN empleado e ON v.ID_Empleado = e.ID_Empleado
GROUP BY e.ID_Empleado
ORDER BY Total_Vendido DESC;
-- Total de mantenimiento dedicado por empleado en procesos de producción:

SELECT e.Nombre, e.Apellido, SUM(mnt.Costo) AS Total_Mantenimiento
FROM mantenimiento_proceso mp
JOIN mantenimiento mnt ON mp.ID_Mantenimiento = mnt.ID_Mantenimiento
JOIN proceso_produccion pp ON mp.ID_Proceso = pp.ID_Proceso
JOIN empleado e ON pp.ID_Empleado = e.ID_Empleado
GROUP BY e.ID_Empleado;
-- Porcentaje de empleados en cada rol:

SELECT er.Rol, COUNT(e.ID_Empleado) * 100.0 / (SELECT COUNT(*) FROM empleado) AS Porcentaje
FROM empleado_rol er
JOIN empleado e ON er.ID_Empleado = e.ID_Empleado
GROUP BY er.Rol;
-- Días de trabajo promedio de empleados por cargo:

SELECT Cargo, AVG(DATEDIFF(CURDATE(), Fecha_Ingreso)) AS Dias_Trabajo
FROM empleado
GROUP BY Cargo;
-- Consultas sobre Producción
-- Producción total por máquina en el último mes:

SELECT ma.Nombre, SUM(pp.Cantidad_Producida) AS Total_Producido
FROM proceso_produccion pp
JOIN maquinaria ma ON pp.ID_Maquinaria = ma.ID_Maquinaria
WHERE pp.Fecha_Inicio >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY ma.ID_Maquinaria;
-- Máquinas más rentables (producción comparada con costos de mantenimiento):

SELECT ma.Nombre, SUM(pp.Cantidad_Producida) AS Producción_Total, SUM(mnt.Costo) AS Costo_Total
FROM proceso_produccion pp
JOIN maquinaria ma ON pp.ID_Maquinaria = ma.ID_Maquinaria
LEFT JOIN mantenimiento mnt ON ma.ID_Maquinaria = mnt.ID_Maquinaria
GROUP BY ma.Nombre
HAVING Producción_Total - Costo_Total > 0;
-- Análisis de rendimiento de cultivos por periodo:

SELECT c.Nombre, SUM(co.Cantidad) AS Total_Cosechado
FROM cosecha co
JOIN cultivo c ON co.ID_Cultivo = c.ID_Cultivo
GROUP BY c.ID_Cultivo;
-- Cultivos que generaron más ingresos por venta:

SELECT c.Nombre, SUM(dv.Subtotal) AS Total_Ingresos
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
JOIN cosecha co ON p.ID_Cultivo = co.ID_Cultivo
JOIN cultivo c ON co.ID_Cultivo = c.ID_Cultivo
GROUP BY c.ID_Cultivo
ORDER BY Total_Ingresos DESC;
-- Consultas Generales y Análisis de Datos
-- Porcentaje de productos en estado crítico de inventario:

SELECT (SELECT COUNT(*) FROM inventario WHERE Cantidad < 10) * 100.0 / COUNT(*) AS Porcentaje_Critico
FROM inventario;
-- Resumen total de gastos a proveedores en el último año:

SELECT SUM(Total_Compra) AS Total_Gastos_Proveedores
FROM compra
WHERE Fecha_Compra >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
-- Ranking de productos con menor rotación de inventario:

SELECT p.Nombre, COUNT(dv.ID_Producto) AS Total_Ventas
FROM producto p
LEFT JOIN detalle_venta dv ON p.ID_Producto = dv.ID_Producto
GROUP BY p.ID_Producto
ORDER BY Total_Ventas ASC;
-- Gastos totales en mantenimiento por año:

SELECT YEAR(Fecha_Mantenimiento) AS Año, SUM(Costo) AS Total_Gastos
FROM mantenimiento
GROUP BY Año;
-- Análisis de costo de alimentos por empleado:

SELECT e.Nombre, e.Apellido, SUM(m.Costo) AS Total_Sueldos
FROM empleado e
JOIN venta v ON e.ID_Empleado = v.ID_Cliente -- Suponiendo que se relaciona de alguna manera
GROUP BY e.ID_Empleado;
-- Consultas sobre Desempeño y Reportes
-- Días promedio de mantenimiento por máquina:

SELECT ma.Nombre, AVG(DATEDIFF(NOW(), m.Fecha_Mantenimiento)) AS Dias_Promedio
FROM mantenimiento m
JOIN maquinaria ma ON m.ID_Maquinaria = ma.ID_Maquinaria
GROUP BY ma.ID_Maquinaria;
-- Interacciones de clientes en el último mes:

SELECT c.Nombre, c.Apellido, COUNT(v.ID_Venta) AS Total_Ventas
FROM cliente c
LEFT JOIN venta v ON c.ID_Cliente = v.ID_Cliente
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.ID_Cliente;
-- Ventas fallidas (ejemplo: canceladas, si corresponde):

SELECT COUNT(*) AS Total_Ventas_Fallidas FROM venta WHERE estado = 'Cancelada'; -- Suponiendo que hay un estado
-- Ranking de empleados por productividad:

SELECT e.Nombre, e.Apellido, COUNT(pp.ID_Proceso) AS Total_Produccion
FROM empleado e
LEFT JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado
GROUP BY e.ID_Empleado
ORDER BY Total_Produccion DESC;
-- Promedio de días entre cosecha y producción:

SELECT AVG(DATEDIFF(pp.Fecha_Inicio, co.Fecha_Cosecha)) AS Promedio_Dias
FROM proceso_produccion pp
JOIN proceso_cosecha pc ON pp.ID_Proceso = pc.ID_Proceso
JOIN cosecha co ON pc.ID_Cosecha = co.ID_Cosecha;
-- Costos de producción por categoría de producto:

SELECT p.Categoria, SUM(pp.Cantidad_Producida) AS Produccion_Total
FROM proceso_produccion pp
JOIN producto p ON pp.ID_Producto = p.ID_Producto
GROUP BY p.Categoria;
-- Consultas finales
-- Histórico de precios de productos:

SELECT p.Nombre, dpp.Fecha_Registro, dpp.Precio
FROM detalle_producto_precio dpp
JOIN producto p ON dpp.ID_Producto = p.ID_Producto
ORDER BY dpp.Fecha_Registro DESC;
-- Productos por debajo del costo de compra:

SELECT p.Nombre, (SUM(dc.Precio_Compra) - SUM(dv.Subtotal)) AS Margen
FROM detalle_compra dc
JOIN producto p ON dc.ID_Producto = p.ID_Producto
LEFT JOIN detalle_venta dv ON p.ID_Producto = dv.ID_Producto
GROUP BY p.ID_Producto
HAVING Margen < 0;
-- Días promedio en que los productos están en inventario:

SELECT p.Nombre, AVG(DATEDIFF(NOW(), i.Fecha_Actualizacion)) AS Dias_En_Inventario
FROM inventario i
JOIN producto p ON i.ID_Producto = p.ID_Producto
GROUP BY p.Nombre;
-- Proveedores con retrasos en entregas:

SELECT p.Nombre, COUNT(co.ID_Compra) AS Total_Retrasos
FROM compra co
JOIN proveedor p ON co.ID_Proveedor = p.ID_Proveedor
WHERE co.Fecha_Compra < CURDATE() - INTERVAL 30 DAY -- Suponiendo un retraso de 30 días
GROUP BY p.ID_Proveedor;
-- Clasificación de productos por ganancias (Ganancia = Ventas - Costo):

SELECT p.Nombre, (SUM(dv.Subtotal) - (SELECT SUM(dc.Precio_Compra)
                                         FROM detalle_compra dc
                                         WHERE dc.ID_Producto = p.ID_Producto)) AS Ganancia
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
GROUP BY p.ID_Producto
ORDER BY Ganancia DESC;
-- Costo total de producción de cultivos en un periodo definido:

SELECT c.Nombre, SUM(pp.Cantidad_Producida * dc.Precio_Compra) AS Costo_Total
FROM proceso_produccion pp
JOIN cultivo c ON pp.ID_Producto = c.ID_Cultivo
JOIN detalle_compra dc ON pp.ID_Producto = dc.ID_Producto
WHERE pp.Fecha_Inicio >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.Nombre;
-- Porcentaje de retención de clientes:

SELECT COUNT(DISTINCT v.ID_Cliente) * 100.0 / (SELECT COUNT(DISTINCT ID_Cliente) FROM cliente) AS Porcentaje_Retencion
FROM venta v
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
-- Costo de producción por empleado en un periodo específico:

SELECT e.Nombre, e.Apellido, SUM(mnt.Costo) AS Total_Costo_Produccion
FROM mantenimiento_proceso mp
JOIN mantenimiento mnt ON mp.ID_Mantenimiento = mnt.ID_Mantenimiento
JOIN proceso_produccion pp ON mp.ID_Proceso = pp.ID_Proceso
JOIN empleado e ON pp.ID_Empleado = e.ID_Empleado
WHERE mnt.Fecha_Mantenimiento >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY e.ID_Empleado;
-- Ranking de cultivos según ingresos generados:

SELECT c.Nombre, SUM(dv.Subtotal) AS Total_Ingresos
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
JOIN cultivo c ON p.ID_Cultivo = c.ID_Cultivo
GROUP BY c.Nombre
ORDER BY Total_Ingresos DESC;
-- Tiempo promedio de mantenimiento por maquinaria:

SELECT ma.Nombre, AVG(DATEDIFF(NOW(), m.Fecha_Mantenimiento)) AS Tiempo_Promedio_Mantenimiento
FROM mantenimiento m
JOIN maquinaria ma ON m.ID_Maquinaria = ma.ID_Maquinaria
GROUP BY ma.ID_Maquinaria;
-- Comparación de ingresos y gastos anuales:

SELECT YEAR(Fecha_Venta) AS Año, SUM(Total_Venta) AS Ingresos, 
       (SELECT SUM(Total_Compra) FROM compra WHERE YEAR(Fecha_Compra) = YEAR(v.Fecha_Venta)) AS Gastos
FROM venta v
GROUP BY Año;
-- Consultas Adicionales
-- Verificación de clientes sin compras en el último año:

SELECT c.Nombre, c.Apellido
FROM cliente c
WHERE c.ID_Cliente NOT IN (
    SELECT v.ID_Cliente
    FROM venta v
    WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);
-- Resumen mensual de costos de mantenimiento:

SELECT MONTH(m.Fecha_Mantenimiento) AS Mes, SUM(m.Costo) AS Total_Gastos
FROM mantenimiento m
GROUP BY Mes;
-- Número total de cultivos plantados durante el año:

SELECT COUNT(ID_Cultivo) AS Total_Cultivos_Planteados
FROM cultivo
WHERE YEAR(Fecha_Cultivo) = YEAR(CURDATE()); -- Suponiendo que hay una columna Fecha_Cultivo
-- Ranking de empleados basado en costos generados y ventas:

SELECT e.Nombre, e.Apellido, SUM(v.Total_Venta) - SUM(mp.Costo) AS Ganancia_Neta
FROM empleado e
LEFT JOIN venta v ON e.ID_Empleado = v.ID_Cliente -- Suponiendo que se relacionan
LEFT JOIN mantenimiento_proceso mp ON mp.ID_Proceso = (SELECT ID_Proceso FROM proceso_produccion)
GROUP BY e.ID_Empleado
ORDER BY Ganancia_Neta DESC;
-- Gastos de maquinaria por segmento:
SELECT ma.Tipo, SUM(m.Costo) AS Total_Gastos
FROM mantenimiento m
JOIN maquinaria ma ON m.ID_Maquinaria = ma.ID_Maquinaria
GROUP BY ma.Tipo;
-- Margen por venta de cada empleado:

SELECT e.Nombre, e.Apellido, 
AVG(dv.Subtotal - (SELECT SUM(dc.Precio_Compra) 
                   FROM detalle_compra dc 
                   JOIN producto p ON dc.ID_Producto = p.ID_Producto 
                   WHERE p.ID_Producto = dv.ID_Producto)) AS Margen
FROM detalle_venta dv
JOIN venta v ON dv.ID_Venta = v.ID_Venta
JOIN empleado e ON v.ID_Empleado = e.ID_Empleado
GROUP BY e.ID_Empleado;
-- Costo total por maquinaria en un periodo específico:

SELECT ma.Nombre, SUM(m.Costo) AS Total_Costo
FROM mantenimiento m
JOIN maquinaria ma ON m.ID_Maquinaria = ma.ID_Maquinaria
WHERE m.Fecha_Mantenimiento >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY ma.ID_Maquinaria;
-- Porcentaje de ingresos totales generados por cada producto:

SELECT p.Nombre, (SUM(dv.Subtotal) / (SELECT SUM(dv2.Subtotal) FROM detalle_venta dv2)) * 100 AS Porcentaje_Ingresos
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
GROUP BY p.ID_Producto;
-- Conteo de maquinaria por estado:

SELECT Estado, COUNT(*) AS Total_Maquinaria
FROM maquinaria
GROUP BY Estado;
-- Clientes que han hecho más de 5 compras:

SELECT c.Nombre, c.Apellido, COUNT(v.ID_Venta) AS Total_Compras
FROM cliente c
JOIN venta v ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.ID_Cliente
HAVING Total_Compras > 5;
-- Total de productos vendidos por categoría en el último mes:

SELECT p.Categoria, SUM(dv.Cantidad) AS Total_Vendido
FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto
JOIN venta v ON dv.ID_Venta = v.ID_Venta
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY p.Categoria;
-- Análisis de descuentos aplicados a las ventas (si tiene una columna de descuento):

SELECT SUM(v.Descuento) AS Total_Descuentos
FROM venta v
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
-- Total de ventas acumulado por cliente en el transcurso de los años:

SELECT c.Nombre, c.Apellido, YEAR(v.Fecha_Venta) AS Año, SUM(v.Total_Venta) AS Total_Vendido
FROM venta v
JOIN cliente c ON v.ID_Cliente = c.ID_Cliente
GROUP BY c.ID_Cliente, YEAR(v.Fecha_Venta);
-- Ventas finales de productos filtradas por empleados:

SELECT e.Nombre, e.Apellido, SUM(v.Total_Venta) AS Total_Vendido
FROM venta v
JOIN empleado e ON v.ID_Empleado = e.ID_Empleado
GROUP BY e.ID_Empleado;
-- Productos que no tienen compras registradas:

SELECT p.Nombre
FROM producto p
WHERE p.ID_Producto NOT IN (
    SELECT dc.ID_Producto
    FROM detalle_compra dc
);
-- Tiempo promedio entre cosechas:

SELECT AVG(DATEDIFF(co2.Fecha_Cosecha, co1.Fecha_Cosecha)) AS Dias_Promedio_Between_Cosechas
FROM cosecha co1
JOIN cosecha co2 ON co1.ID_Cultivo = co2.ID_Cultivo AND co1.ID_Cosecha < co2.ID_Cosecha;
-- Ranking de cultivos según área sembrada:

SELECT c.Nombre, SUM(c.Area) AS Total_Area
FROM cultivo c
GROUP BY c.ID_Cultivo
ORDER BY Total_Area DESC;
-- Comparación de ingresos y costos de un producto específico:

SELECT p.Nombre, SUM(dv.Subtotal) AS Ingresos, SUM(dc.Precio_Compra) AS Costos
FROM producto p
JOIN detalle_venta dv ON p.ID_Producto = dv.ID_Producto
JOIN detalle_compra dc ON p.ID_Producto = dc.ID_Producto
GROUP BY p.ID_Producto;
-- Diferencia entre costos y precios en un intervalo específico de tiempo:

SELECT (SUM(dv.Subtotal) - SUM(dc.Precio_Compra)) AS Diferencia
FROM detalle_venta dv
JOIN detalle_compra dc ON dv.ID_Producto = dc.ID_Producto
WHERE dv.Fecha_Venta BETWEEN '2023-01-01' AND '2023-12-31'; -- Cambiar según los requerimientos