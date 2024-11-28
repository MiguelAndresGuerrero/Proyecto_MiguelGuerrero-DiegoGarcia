use finca_campus;

-- Consultas sobre Inventarios

-- 1. Estado actual del inventario
SELECT p.Nombre, i.Cantidad 
FROM producto p 
JOIN inventario i ON p.ID_Producto = i.ID_Producto;

-- 2. Productos con bajo stock (menos de 100 unidades)
SELECT p.Nombre, i.Cantidad 
FROM producto p 
JOIN inventario i ON p.ID_Producto = i.ID_Producto 
WHERE i.Cantidad < 100;

-- 3. Total de inventario de cada producto
SELECT p.Nombre, SUM(i.Cantidad) AS TotalInventario 
FROM producto p 
JOIN inventario i ON p.ID_Producto = i.ID_Producto 
GROUP BY p.ID_Producto;

-- 4. Valor total del inventario
SELECT SUM(i.Cantidad * dpp.Precio) AS ValorTotalInventario 
FROM inventario i 
JOIN detalle_producto_precio dpp ON i.ID_Producto = dpp.ID_Producto 
WHERE dpp.Fecha_Registro = (SELECT MAX(Fecha_Registro) FROM detalle_producto_precio);

-- 5. Historial de cambios de inventario para un producto específico
SELECT p.Nombre, i.Fecha_Actualizacion, i.Cantidad 
FROM inventario i 
JOIN producto p ON i.ID_Producto = p.ID_Producto 
WHERE p.ID_Producto = 1;

-- Consultas sobre Producción

-- 6. Producción mensual por producto
SELECT p.Nombre, MONTH(pp.Fecha_Inicio) AS Mes, SUM(pp.Cantidad_Producida) AS TotalProducido 
FROM proceso_produccion pp 
JOIN producto p ON pp.ID_Producto = p.ID_Producto 
GROUP BY p.ID_Producto, MONTH(pp.Fecha_Inicio);

-- 7. Producción por empleado
SELECT e.Nombre, e.Apellido, SUM(pp.Cantidad_Producida) AS TotalProducido 
FROM proceso_produccion pp 
JOIN empleado e ON pp.ID_Empleado = e.ID_Empleado 
GROUP BY e.ID_Empleado;

-- 8. Productos producidos en un rango de fechas
SELECT p.Nombre, SUM(pp.Cantidad_Producida) AS TotalProducido 
FROM proceso_produccion pp 
JOIN producto p ON pp.ID_Producto = p.ID_Producto 
WHERE pp.Fecha_Inicio BETWEEN '2023-01-01' AND '2023-12-31' 
GROUP BY p.ID_Producto;

-- 9. Máquina con más producción acumulada
SELECT m.Nombre, SUM(pp.Cantidad_Producida) AS TotalProducido 
FROM proceso_produccion pp 
JOIN maquinaria m ON pp.ID_Maquinaria = m.ID_Maquinaria 
GROUP BY m.ID_Maquinaria 
ORDER BY TotalProducido DESC 
LIMIT 1;

-- 10. Costos operativos de producción por maquinaria
SELECT m.Nombre AS Maquinaria, SUM(dp.Precio) AS CostoTotal 
FROM proceso_produccion pp 
JOIN maquinaria m ON pp.ID_Maquinaria = m.ID_Maquinaria 
JOIN detalle_producto_precio dp ON pp.ID_Producto = dp.ID_Producto 
WHERE 
    dp.Fecha_Registro = (SELECT MAX(Fecha_Registro) 
                         FROM detalle_producto_precio 
                         WHERE ID_Producto = pp.ID_Producto)
GROUP BY m.ID_Maquinaria;

-- Consultas sobre Ventas

-- 11. Total de ventas por producto
SELECT p.Nombre, SUM(dv.Cantidad) AS TotalVendidos 
FROM detalle_venta dv 
JOIN producto p ON dv.ID_Producto = p.ID_Producto 
GROUP BY p.ID_Producto;

-- 12. Ventas por cliente en el último mes
SELECT c.Nombre, SUM(v.Total_Venta) AS TotalGastado 
FROM venta v 
JOIN cliente c ON v.ID_Cliente = c.ID_Cliente 
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) 
GROUP BY c.ID_Cliente;

-- 13. Promedio de ventas mensuales
SELECT MONTH(v.Fecha_Venta) AS Mes, AVG(v.Total_Venta) AS PromedioVentas 
FROM venta v 
GROUP BY MONTH(v.Fecha_Venta);

-- 14. Ventas totales y promedio por mes
SELECT MONTH(v.Fecha_Venta) AS Mes, SUM(v.Total_Venta) AS TotalVentas, AVG(v.Total_Venta) AS PromedioVentas 
FROM venta v 
GROUP BY MONTH(v.Fecha_Venta);

-- 15. productos más vendidos en un mes específico
SELECT p.Nombre, SUM(dv.Cantidad) AS TotalVendidos 
FROM detalle_venta dv 
JOIN venta v ON dv.ID_Venta = v.ID_Venta 
JOIN producto p ON dv.ID_Producto = p.ID_Producto 
WHERE MONTH(v.Fecha_Venta) = 10 AND YEAR(v.Fecha_Venta) = 2023 
GROUP BY p.ID_Producto 
ORDER BY TotalVendidos DESC 
LIMIT 5;

-- Consultas sobre Compras a Proveedores

-- 16. Compras totales por proveedor
SELECT p.Nombre AS Proveedor, SUM(c.Total_Compra) AS TotalCompras 
FROM compra c 
JOIN proveedor p ON c.ID_Proveedor = p.ID_Proveedor 
GROUP BY p.ID_Proveedor;

-- 17. Última compra de cada producto
SELECT p.Nombre, MAX(c.Fecha_Compra) AS UltimaCompra 
FROM compra c 
JOIN detalle_compra dc ON c.ID_Compra = dc.ID_Compra 
JOIN producto p ON dc.ID_Producto = p.ID_Producto 
GROUP BY p.ID_Producto;

-- 18. Costo promedio de compras por mes
SELECT MONTH(c.Fecha_Compra) AS Mes, AVG(c.Total_Compra) AS CostoPromedio 
FROM compra c 
GROUP BY MONTH(c.Fecha_Compra);

-- 19. Total de compras en un rango de fechas
SELECT SUM(Total_Compra) AS TotalCompras 
FROM compra 
WHERE Fecha_Compra BETWEEN '2023-01-01' AND '2023-12-31';

-- 20. Número de compras realizadas por proveedor
SELECT p.Nombre AS Proveedor, COUNT(c.ID_Compra) AS TotalCompras 
FROM proveedor p 
LEFT JOIN compra c ON p.ID_Proveedor = c.ID_Proveedor 
GROUP BY p.ID_Proveedor;

-- Consultas sobre Costos Operativos

-- 21. Costo total de producción por mes
SELECT MONTH(pp.Fecha_Inicio) AS Mes, SUM(m.Costo) AS CostoTotal 
FROM proceso_produccion pp 
JOIN maquinaria m ON pp.ID_Maquinaria = m.ID_Maquinaria 
GROUP BY Mes;

-- 22. Costo total operativo en sueldos de empleados
SELECT SUM(Salario) AS TotalSueldos 
FROM empleado;

-- 23. Total costos operativos agrupados por categoría
SELECT p.Categoria, SUM(m.Costo) AS CostoTotal 
FROM maquinaria m 
JOIN proceso_produccion pp ON m.ID_Maquinaria = pp.ID_Maquinaria 
JOIN producto p ON pp.ID_Producto = p.ID_Producto 
GROUP BY p.Categoria;

-- 24. Costo total de compras por proveedor
SELECT p.Nombre AS Proveedor, SUM(c.Total_Compra) AS TotalCosto 
FROM proveedor p 
JOIN compra c ON p.ID_Proveedor = c.ID_Proveedor 
GROUP BY p.ID_Proveedor;

-- 25. Costo promedio de mantenimiento de maquinaria
SELECT AVG(Costo) AS CostoPromedio 
FROM maquinaria;

-- Consultas sobre Desempeño de Empleados

-- 26. Desempeño de empleados por producción
SELECT e.Nombre, e.Apellido, SUM(pp.Cantidad_Producida) AS TotalProducido 
FROM proceso_produccion pp 
JOIN empleado e ON pp.ID_Empleado = e.ID_Empleado 
GROUP BY e.ID_Empleado 
ORDER BY TotalProducido DESC;

-- 27. Empleados que no han producido nada
SELECT e.Nombre, e.Apellido 
FROM empleado e 
LEFT JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
WHERE pp.ID_Proceso_produccion IS NULL;

-- 28. Ventajas salariales por empleado comparado con producción
SELECT e.Nombre, e.Apellido, e.Salario, SUM(pp.Cantidad_Producida) AS TotalProducido 
FROM empleado e 
LEFT JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
GROUP BY e.ID_Empleado;

-- 29. Empleados con más cantidad de producción
SELECT e.Nombre, e.Apellido, SUM(pp.Cantidad_Producida) AS TotalCantidad 
FROM proceso_produccion pp 
JOIN empleado e ON pp.ID_Empleado = e.ID_Empleado 
GROUP BY e.ID_Empleado 
ORDER BY TotalCantidad DESC
LIMIT 0, 1000;

-- 30. Empleados que realizan más de X procesos de producción
SELECT e.Nombre, COUNT(pp.ID_Proceso_produccion) AS TotalProcesos 
FROM empleado e 
JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
GROUP BY e.ID_Empleado 
HAVING TotalProcesos > 1;

-- Consultas Avanzadas con Subconsultas y Agregaciones

-- 31. Ventas por cliente que superan el promedio
SELECT c.Nombre, SUM(v.Total_Venta) AS TotalVentas 
FROM venta v 
JOIN cliente c ON v.ID_Cliente = c.ID_Cliente 
GROUP BY c.ID_Cliente 
HAVING TotalVentas > (SELECT AVG(Total_Venta) FROM venta);

-- 32. Clientes que no han hecho compras en el último año
SELECT c.Nombre 
FROM cliente c 
WHERE c.ID_Cliente NOT IN (SELECT v.ID_Cliente FROM venta v WHERE v.Fecha_Venta >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR));

-- 33. Empleados que generan más ingresos que su costo
SELECT e.Nombre, e.Apellido 
FROM empleado e 
JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
JOIN detalle_venta dv ON pp.ID_Producto = dv.ID_Producto 
GROUP BY e.ID_Empleado 
HAVING SUM(dv.Precio_Venta * dv.Cantidad) > SUM(e.Salario);

-- 34. Proveedor con mayor cantidad de productos comprados
SELECT p.Nombre, SUM(dc.Cantidad) AS TotalProductosComprados 
FROM detalle_compra dc 
JOIN compra c ON dc.ID_Compra = c.ID_Compra 
JOIN proveedor p ON c.ID_Proveedor = p.ID_Proveedor 
GROUP BY p.ID_Proveedor 
ORDER BY TotalProductosComprados DESC 
LIMIT 1;

-- 35. Empleados cuyo desempeño ha disminuido en el último año
SELECT e.Nombre, e.Apellido 
FROM empleado e 
JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
WHERE SUM(pp.Cantidad_Producida) < (SELECT AVG(pp2.Cantidad_Producida) FROM proceso_produccion pp2 WHERE pp2.ID_Empleado = e.ID_Empleado AND pp2.Fecha_Inicio >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR));

-- 36. Clientes que han gastado más en compras que su promedio general
SELECT c.Nombre 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
GROUP BY c.ID_Cliente 
HAVING SUM(v.Total_Venta) > (SELECT AVG(Total_Venta) FROM venta);
  
-- 37. Proveedor más costoso en compras
SELECT p.Nombre, SUM(c.Total_Compra) AS TotalInversion 
FROM proveedor p 
JOIN compra c ON p.ID_Proveedor = c.ID_Proveedor 
GROUP BY p.ID_Proveedor 
ORDER BY TotalInversion DESC 
LIMIT 1;

-- 38. Desempeño de producción comparado con ventas
SELECT 
    e.Nombre, 
    SUM(pp.Cantidad_Producida) as TotalProduccion, 
    (SELECT SUM(dv.Cantidad) FROM detalle_venta dv JOIN venta v ON dv.ID_Venta = v.ID_Venta WHERE v.ID_Empleado = e.ID_Empleado) AS TotalVentas
FROM empleado e
JOIN proceso_produccion pp ON pp.ID_Empleado = e.ID_Empleado
GROUP BY e.ID_Empleado;

-- 39. Clientes que han realizado más de 10 compras
SELECT c.Nombre, COUNT(v.ID_Venta) AS TotalCompras 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
GROUP BY c.ID_Cliente 
HAVING COUNT(v.ID_Venta) > 10;

-- 40. Proyección de costos de producción para el próximo año
SELECT 
    YEAR(NOW()) + 1 AS Año, 
    SUM(m.Costo) * (SELECT COUNT(pp.ID_Proceso_produccion) FROM proceso_produccion pp WHERE YEAR(pp.Fecha_Inicio) = YEAR(NOW())) AS CostoProyectado
FROM maquinaria m;

-- Consultas adicionales útiles para la operación

-- 41. Análisis de las ventas por mes del año
SELECT 
    MONTH(v.Fecha_Venta) AS Mes, 
    SUM(v.Total_Venta) as TotalVentas 
FROM venta v 
GROUP BY MONTH(v.Fecha_Venta);

-- 42. Empleados sin ventas asociadas
SELECT e.Nombre, e.Apellido 
FROM empleado e 
WHERE e.ID_Empleado NOT IN (SELECT DISTINCT ID_Empleado FROM venta);

-- 43. Filtro de productos que tuvieron cambios en el precio
SELECT p.Nombre, dp.Precio 
FROM detalle_producto_precio dp 
JOIN producto p ON dp.ID_Producto = p.ID_Producto 
WHERE dp.Precio <> (SELECT dpp.Precio FROM detalle_producto_precio dpp WHERE dpp.ID_Producto = p.ID_Producto ORDER BY dpp.Fecha_Registro DESC LIMIT 1 OFFSET 1);

-- 44. Total de efectivo recibido por mes
SELECT MONTH(v.Fecha_Venta) AS Mes, SUM(v.Total_Venta) AS TotalEfectivo 
FROM venta v 
GROUP BY MONTH(v.Fecha_Venta);

-- 45. Clientes que han comprado productos específicos
SELECT DISTINCT c.Nombre 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
JOIN detalle_venta dv ON v.ID_Venta = dv.ID_Venta 
WHERE dv.ID_Producto = 1;  -- Reemplazar con el ID del producto específico

-- 46. Proyectos de producción que han sido exitosos (más de 1000 unidades producidas)
SELECT p.Nombre, SUM(pp.Cantidad_Producida) AS TotalProduccion 
FROM proceso_produccion pp 
JOIN producto p ON pp.ID_Producto = p.ID_Producto 
GROUP BY p.ID_Producto 
HAVING TotalProduccion > 1000;

-- 47. Proveedor que ha proporcionado más productos
SELECT p.Nombre, COUNT(pc.ID_Producto) AS TotalProductos 
FROM proveedor p 
JOIN compra c ON p.ID_Proveedor = c.ID_Proveedor 
JOIN detalle_compra dc ON c.ID_Compra = dc.ID_Compra 
JOIN producto pc ON dc.ID_Producto = pc.ID_Producto 
GROUP BY p.ID_Proveedor 
ORDER BY TotalProductos DESC 
LIMIT 1;

-- 48. Costos acumulados de maquinaria por mes
SELECT MONTH(m.Fecha_Adquisicion) AS Mes, SUM(m.Costo) AS CostoAcumulado 
FROM maquinaria m 
GROUP BY MONTH(m.Fecha_Adquisicion);

-- 49. Evaluación del desempeño de la maquinaria
SELECT m.Nombre, AVG(pp.Cantidad_Producida) AS PromedioProduccion 
FROM proceso_produccion pp 
JOIN maquinaria m ON pp.ID_Maquinaria = m.ID_Maquinaria 
GROUP BY m.ID_Maquinaria;

-- 50. Análisis de costos en comparación a ventas
SELECT 
    (SELECT SUM(Total_Compra) FROM compra) AS TotalCostos, 
    (SELECT SUM(Total_Venta) FROM venta) AS TotalVentas;

-- Consultas sobre Comparativas y Resúmenes

-- 51. Comparativa entre costo de producción y ventas generadas
SELECT 
    SUM(pp.Costo) AS TotalCostosProduccion, 
    (SELECT SUM(v.Total_Venta) FROM venta v) AS TotalVentas 
FROM proceso_produccion pp;

-- 52. Comparativa de desempeño de ventas por año
SELECT 
    YEAR(v.Fecha_Venta) AS Año,
    SUM(v.Total_Venta) AS TotalVentas 
FROM venta v 
GROUP BY YEAR(v.Fecha_Venta);

-- 53. Tendencias de compra por mes
SELECT 
    MONTH(c.Fecha_Compra) AS Mes, 
    SUM(c.Total_Compra) AS TotalCompras 
FROM compra c 
GROUP BY MONTH(c.Fecha_Compra);
  
-- 54. Aumentos en venta anuales
SELECT 
    YEAR(v.Fecha_Venta) AS Año, 
    SUM(v.Total_Venta) AS TotalAnual 
FROM venta v 
GROUP BY YEAR(v.Fecha_Venta);

-- 55. Análisis de costos por tipo de maquinaria
SELECT m.Tipo, SUM(m.Costo) AS TotalCostos 
FROM maquinaria m 
GROUP BY m.Tipo;

-- 56. Historial de ventas por cliente
SELECT c.Nombre, v.Fecha_Venta, v.Total_Venta 
FROM venta v 
JOIN cliente c ON v.ID_Cliente = c.ID_Cliente 
ORDER BY v.Fecha_Venta DESC;

-- 57. Resumen de costos semanales
SELECT 
    YEARWEEK(c.Fecha_Compra) AS Semana, 
    SUM(c.Total_Compra) AS CostoSemanal 
FROM compra c 
GROUP BY Semana;

-- 58. Promedio de costos por compra de proveedor
SELECT 
    p.Nombre AS Proveedor, 
    AVG(c.Total_Compra) AS CostoPromedio 
FROM proveedor p 
JOIN compra c ON p.ID_Proveedor = c.ID_Proveedor 
GROUP BY p.ID_Proveedor;

-- 59. Empleados que han mejorado su desempeño
SELECT e.Nombre, e.Apellido 
FROM empleado e 
JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
GROUP BY e.ID_Empleado 
HAVING SUM(pp.Cantidad_Producida) > (SELECT AVG(pp2.Cantidad_Producida) FROM proceso_produccion pp2 WHERE pp2.ID_Empleado = e.ID_Empleado);

-- 60. Clientes que han obtenido descuentos por volumen
SELECT DISTINCT c.Nombre 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
WHERE v.Total_Venta > 500;  -- Suponiendo que el descuento inicia a partir de un monto específico

-- Consultas sobre Satisfacción del Cliente y Comentarios

-- 61. Comentarios de clientes sobre productos específicos
SELECT c.Nombre, c.Comentario 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
JOIN detalle_venta dv ON v.ID_Venta = dv.ID_Venta 
WHERE dv.ID_Producto = 2;  -- Reemplazar con el ID del producto específico

-- 62. Satisfacción de clientes en relación a precios
SELECT c.Nombre, AVG(c.SatisfaccionPrecio) AS SatisfaccionPromedio 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
GROUP BY c.ID_Cliente;

-- 63. Clientes que han recomendado productos
SELECT DISTINCT c.Nombre 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
WHERE c.Recomendaria = 'Sí';

-- 64. Análisis de satisfacción de productos vendidos
SELECT 
    p.Nombre, 
    AVG(c.Satisfaccion) AS SatisfaccionPromedio 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
JOIN detalle_venta dv ON v.ID_Venta = dv.ID_Venta 
JOIN producto p ON dv.ID_Producto = p.ID_Producto 
GROUP BY p.ID_Producto;

-- 65. Ofertas recibidas por clientes insatisfechos
SELECT c.Nombre, o.Detalle 
FROM cliente c 
JOIN oferta o ON c.ID_Cliente = o.ID_Cliente 
WHERE c.Satisfaccion < 3;  -- 1 a 5 escala de satisfacción

-- Consultas sobre Análisis Financiero y Predicciones

-- 66. Rapido análisis de ingreso mensual
SELECT 
    MONTH(v.Fecha_Venta) AS Mes, 
    SUM(v.Total_Venta) AS TotalIngresos 
FROM venta v 
GROUP BY MONTH(v.Fecha_Venta);

-- 67. Análisis del crecimiento de ingresos
SELECT 
    YEAR(v.Fecha_Venta) AS Año, 
    SUM(v.Total_Venta) AS TotalIngresos, 
    (SELECT SUM(Total_Venta) FROM venta WHERE YEAR(Fecha_Venta) = YEAR(v.Fecha_Venta) - 1) AS IngresosPasados 
FROM venta v 
GROUP BY YEAR(v.Fecha_Venta);

-- 68. Tendencias en costos de mantenimiento de maquinaria
SELECT 
    MONTH(m.Fecha_Adquisicion) AS Mes, 
    SUM(m.Costo) AS TotalCostos 
FROM maquinaria m 
GROUP BY MONTH(m.Fecha_Adquisicion);

-- 69. Proyección de ventas a seis meses
SELECT 
    MONTH(v.Fecha_Venta) AS Mes, 
    SUM(v.Total_Venta) * 1.10 AS VentasPronosticadas 
FROM venta v 
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) 
GROUP BY MONTH(v.Fecha_Venta);

-- 70. Análisis de presupuestos vs gastos
SELECT 
    b.Nombre AS Tipo, 
    SUM(b.Monto) AS TotalPresupuesto, 
    (SELECT SUM(c.Total_Compra) FROM compra c WHERE c.Tipo_Maquinaria = b.Tipo) AS TotalGastado 
FROM presupuesto b 
GROUP BY b.Tipo;

-- Consultas sobre Tendencias y Pronósticos

-- 71. Pronóstico de ventas para el próximo trimestre
SELECT 
    MONTH(v.Fecha_Venta) AS Mes, 
    SUM(v.Total_Venta) * 1.10 AS Pronostico 
FROM venta v 
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 QUARTER) 
GROUP BY MONTH(v.Fecha_Venta);

-- 72. Tendencia de producción de los últimos seis meses
SELECT 
    MONTH(pp.Fecha_Inicio) AS Mes, 
    SUM(pp.Cantidad_Producida) AS TotalProduccion 
FROM proceso_produccion pp 
WHERE pp.Fecha_Inicio >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) 
GROUP BY MONTH(pp.Fecha_Inicio);

-- 73. Proyección de costos de mantenimiento para el próximo año
SELECT 
    SUM(m.Costo) * 1.05 AS ProyeccionCostoMantenimiento 
FROM maquinaria m;

-- 74. Análisis de ventas y costos de marzo del año pasado
SELECT 
    SUM(c.Total_Compra) AS TotalCompras, 
    (SELECT SUM(v.Total_Venta) FROM venta v WHERE MONTH(v.Fecha_Venta) = 3 AND YEAR(v.Fecha_Venta) = YEAR(CURDATE()) - 1) AS TotalVentas 
FROM compra c 
WHERE MONTH(c.Fecha_Compra) = 3 AND YEAR(c.Fecha_Compra) = YEAR(CURDATE()) - 1;

-- 75. Consumibles que no se han vendido dentro del último año
SELECT p.Nombre 
FROM producto p 
WHERE p.ID_Producto NOT IN (SELECT dv.ID_Producto FROM detalle_venta dv WHERE dv.ID_Venta IN (SELECT v.ID_Venta FROM venta v WHERE v.Fecha_Venta >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)));

-- 76. Filtrar empleados con producción por debajo de la media
SELECT 
    e.Nombre, e.Apellido 
FROM empleado e 
JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
GROUP BY e.ID_Empleado 
HAVING SUM(pp.Cantidad_Producida) < (SELECT AVG(Cantidad_Producida) FROM proceso_produccion);

-- 77. Clientes que han hecho la mayor cantidad de compras
SELECT 
    c.Nombre, 
    COUNT(v.ID_Venta) AS TotalCompras 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
GROUP BY c.ID_Cliente 
ORDER BY TotalCompras DESC 
LIMIT 10;

-- 78. Análisis de inventario por categoría
SELECT p.Categoria, SUM(i.Cantidad) AS TotalInventario 
FROM inventario i 
JOIN producto p ON i.ID_Producto = p.ID_Producto 
GROUP BY p.Categoria;

-- 79. Cálculo de tasa de ventas por empleado
SELECT 
    e.Nombre, 
    COUNT(v.ID_Venta) AS TotalVentas, 
    (COUNT(v.ID_Venta)/SUM(IF(pp.ID_Empleado IS NOT NULL, 1, 0))) AS TasaVenta 
FROM empleado e 
LEFT JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
LEFT JOIN venta v ON pp.ID_Venta = v.ID_Venta 
GROUP BY e.ID_Empleado;

-- 80. Análisis de productos en el inventario no vendidos
SELECT p.Nombre 
FROM producto p 
WHERE p.ID_Producto NOT IN (SELECT dv.ID_Producto FROM detalle_venta dv);

-- Consultas sobre Satisfacción del Cliente y Comentarios

-- 81. Comentarios de clientes sobre productos específicos
SELECT c.Nombre, c.Comentario 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
JOIN detalle_venta dv ON v.ID_Venta = dv.ID_Venta 
WHERE dv.ID_Producto = 2;  -- Reemplazar con el ID del producto específico

-- 82. Satisfacción de clientes en relación a precios
SELECT c.Nombre, AVG(c.SatisfaccionPrecio) AS SatisfaccionPromedio 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
GROUP BY c.ID_Cliente;

-- 83. Clientes que han recomendado productos
SELECT DISTINCT c.Nombre 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
WHERE c.Recomendaria = 'Sí';

-- 84. Análisis de satisfacción de productos vendidos
SELECT 
    p.Nombre, 
    AVG(c.Satisfaccion) AS SatisfaccionPromedio 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
JOIN detalle_venta dv ON v.ID_Venta = dv.ID_Venta 
JOIN producto p ON dv.ID_Producto = p.ID_Producto 
GROUP BY p.ID_Producto;

-- 85. Ofertas recibidas por clientes insatisfechos
SELECT c.Nombre, o.Detalle 
FROM cliente c 
JOIN oferta o ON c.ID_Cliente = o.ID_Cliente 
WHERE c.Satisfaccion < 3;  -- 1 a 5 escala de satisfacción

-- Consultas sobre Análisis Financiero y Predicciones

-- 86. Rapido análisis de ingreso mensual
SELECT 
    MONTH(v.Fecha_Venta) AS Mes, 
    SUM(v.Total_Venta) AS TotalIngresos 
FROM venta v 
GROUP BY MONTH(v.Fecha_Venta);

-- 87. Análisis del crecimiento de ingresos
SELECT 
    YEAR(v.Fecha_Venta) AS Año, 
    SUM(v.Total_Venta) AS TotalIngresos, 
    (SELECT SUM(Total_Venta) FROM venta WHERE YEAR(Fecha_Venta) = YEAR(v.Fecha_Venta) - 1) AS IngresosPasados 
FROM venta v 
GROUP BY YEAR(v.Fecha_Venta);

-- 88. Tendencias en costos de mantenimiento de maquinaria
SELECT 
    MONTH(m.Fecha_Adquisicion) AS Mes, 
    SUM(m.Costo) AS TotalCostos 
FROM maquinaria m 
GROUP BY MONTH(m.Fecha_Adquisicion);

-- 89. Proyección de ventas a seis meses
SELECT 
    MONTH(v.Fecha_Venta) AS Mes, 
    SUM(v.Total_Venta) * 1.10 AS VentasPronosticadas 
FROM venta v 
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) 
GROUP BY MONTH(v.Fecha_Venta);

-- 90. Análisis de presupuestos vs gastos
SELECT 
    b.Nombre AS Tipo, 
    SUM(b.Monto) AS TotalPresupuesto, 
    (SELECT SUM(c.Total_Compra) FROM compra c WHERE c.Tipo_Maquinaria = b.Tipo) AS TotalGastado 
FROM presupuesto b 
GROUP BY b.Tipo;

-- Consultas sobre Tendencias y Pronósticos

-- 91. Pronóstico de ventas para el próximo trimestre
SELECT 
    MONTH(v.Fecha_Venta) AS Mes, 
    SUM(v.Total_Venta) * 1.10 AS Pronostico 
FROM venta v 
WHERE v.Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 1 QUARTER) 
GROUP BY MONTH(v.Fecha_Venta);

-- 92. Tendencia de producción de los últimos seis meses
SELECT 
    MONTH(pp.Fecha_Inicio) AS Mes, 
    SUM(pp.Cantidad_Producida) AS TotalProduccion 
FROM proceso_produccion pp 
WHERE pp.Fecha_Inicio >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) 
GROUP BY MONTH(pp.Fecha_Inicio);

-- 93. Proyección de costos de mantenimiento para el próximo año
SELECT 
    SUM(m.Costo) * 1.05 AS ProyeccionCostoMantenimiento 
FROM maquinaria m;

-- 94. Análisis de ventas y costos de marzo del año pasado
SELECT 
    SUM(c.Total_Compra) AS TotalCompras, 
    (SELECT SUM(v.Total_Venta) FROM venta v WHERE MONTH(v.Fecha_Venta) = 3 AND YEAR(v.Fecha_Venta) = YEAR(CURDATE()) - 1) AS TotalVentas 
FROM compra c 
WHERE MONTH(c.Fecha_Compra) = 3 AND YEAR(c.Fecha_Compra) = YEAR(CURDATE()) - 1;

-- 95. Consumibles que no se han vendido dentro del último año
SELECT p.Nombre 
FROM producto p 
WHERE p.ID_Producto NOT IN (SELECT dv.ID_Producto FROM detalle_venta dv WHERE dv.ID_Venta IN (SELECT v.ID_Venta FROM venta v WHERE v.Fecha_Venta >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)));

-- 96. Filtrar empleados con producción por debajo de la media
SELECT 
    e.Nombre, e.Apellido 
FROM empleado e 
JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
GROUP BY e.ID_Empleado 
HAVING SUM(pp.Cantidad_Producida) < (SELECT AVG(Cantidad_Producida) FROM proceso_produccion);

-- 97. Clientes que han hecho la mayor cantidad de compras
SELECT 
    c.Nombre, 
    COUNT(v.ID_Venta) AS TotalCompras 
FROM cliente c 
JOIN venta v ON c.ID_Cliente = v.ID_Cliente 
GROUP BY c.ID_Cliente 
ORDER BY TotalCompras DESC 
LIMIT 10;

-- 98. Análisis de inventario por categoría
SELECT p.Categoria, SUM(i.Cantidad) AS TotalInventario 
FROM inventario i 
JOIN producto p ON i.ID_Producto = p.ID_Producto 
GROUP BY p.Categoria;

-- 99. Cálculo de tasa de ventas por empleado
SELECT 
    e.Nombre, 
    COUNT(v.ID_Venta) AS TotalVentas, 
    (COUNT(v.ID_Venta)/SUM(IF(pp.ID_Empleado IS NOT NULL, 1, 0))) AS TasaVenta 
FROM empleado e 
LEFT JOIN proceso_produccion pp ON e.ID_Empleado = pp.ID_Empleado 
LEFT JOIN venta v ON pp.ID_Venta = v.ID_Venta 
GROUP BY e.ID_Empleado;

-- 100. Análisis de productos en el inventario no vendidos
SELECT p.Nombre 
FROM producto p 
WHERE p.ID_Producto NOT IN (SELECT dv.ID_Producto FROM detalle_venta dv);