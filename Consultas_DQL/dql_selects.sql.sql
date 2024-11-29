use finca_campus;

-- 1. Listar todos los cientes
select * from cliente;

-- 2. Listar todos los elementos del inventario
SELECT * FROM inventario;

-- 3. Devuelve todos los proveedores
SELECT * FROM proveedor;

-- 4. Devuelve todos los empleados que tienen más de 30 años
SELECT * FROM empleado WHERE TIMESTAMPDIFF(YEAR, Fecha_Ingreso, CURDATE()) > 30;

-- 5. Devuelve un listado de todas las máquinas que se encuentran en reparación
SELECT * FROM maquinaria WHERE Estado = 'REPARACION';

-- 6. Devuelve un listado con todos los productos ordenados por categorías
SELECT * FROM producto ORDER BY Categoria;

-- 7. Devuelve un listado con todos los productos que la finca le compró al proveedor
SELECT p.Nombre, d.Cantidad FROM detalle_compra d
JOIN producto p ON d.ID_Producto = p.ID_Producto;

-- 8. Devuelve un listado con los detalles de las compras que su cantidad sea mayor a 10
SELECT * FROM detalle_compra WHERE Cantidad > 10;

-- 9. Devuelve un listado con todas las fechas de ventas y el total de la venta
SELECT Fecha_Venta, Total_Venta FROM venta;

-- 10. Devuelve un listado con todos los detalles de las ventas
SELECT * FROM detalle_venta;

-- 11. Devuelve un listado con todos los detalles que lleva el proceso de producción
SELECT * FROM proceso_produccion;

-- 12. Devuelve un listado con el nombre de los empleados que poseen el rol de operador
SELECT e.Nombre, e.Apellido FROM empleado e
JOIN empleado_rol r ON e.ID_Empleado = r.ID_Empleado
WHERE r.Rol = 'OPERADOR';

-- 13. Devuelve un listado con los nombres y apellidos de los 15 empleados que tienen más alto su salario
SELECT Nombre, Apellido FROM empleado ORDER BY Salario DESC LIMIT 15;

-- 15. Devuelve un listado con la fecha y el nombre de la máquina en donde se adquirió dicha maquinaria
SELECT Nombre, Fecha_Adquisicion FROM maquinaria;

-- 16. Devuelve un listado con toda la información de los empleados que tengan el rol de supervisor
SELECT e.* FROM empleado e 
JOIN empleado_rol r ON e.ID_Empleado = r.ID_Empleado WHERE r.Rol = 'SUPERVISOR';

-- 17. Devuelve un listado con toda la información de contacto de los proveedores
SELECT Nombre, Telefono, Correo_Electronico, Direccion FROM proveedor;

-- 18. Devuelve un listado con la menor cantidad de productos en el inventario
SELECT * FROM inventario ORDER BY Cantidad ASC LIMIT 1;

-- 19. Devuelve un listado con las fechas de los empleados que son operadores de alguna maquinaria
SELECT e.Nombre, e.Apellido, p.Fecha_Inicio FROM proceso_produccion p
JOIN empleado e ON p.ID_Empleado = e.ID_Empleado
JOIN empleado_rol r ON e.ID_Empleado = r.ID_Empleado WHERE r.Rol = 'OPERADOR';

-- 20. Devuelve un listado con las compras que realizó un cliente
SELECT v.ID_Venta, v.Fecha_Venta, v.Total_Venta FROM venta v WHERE v.ID_Cliente IS NOT NULL;

-- 21. Devuelve un listado con el costo de operación de las máquinas y su conductor
SELECT m.Nombre AS Maquina, m.Costo AS Costo_Operacion, e.Nombre AS Conductor FROM maquinaria m
JOIN proceso_produccion p ON m.ID_Maquinaria = p.ID_Maquinaria 
JOIN empleado e ON p.ID_Empleado = e.ID_Empleado;

-- 22. Devuelve un listado con todos los tractores y sus respectivos conductores
SELECT m.Nombre AS Tractor, e.Nombre AS Conductor FROM maquinaria m
JOIN proceso_produccion p ON m.ID_Maquinaria = p.ID_Maquinaria 
JOIN empleado e ON p.ID_Empleado = e.ID_Empleado WHERE m.Tipo = 'TRACTOR';

-- 23. Devuelve un listado con todos los tipos de máquinas y su costo de operación
SELECT Tipo, SUM(Costo) AS Costo_Total FROM maquinaria GROUP BY Tipo;

-- 24. Devuelve un listado con todas las máquinas que se encuentran activas y su costo de producción
SELECT * FROM maquinaria WHERE Estado = 'OPERATIVA';

-- 25. Devuelve un listado con todos los nombres y categorías de los productos disponibles
SELECT Nombre, Categoria FROM producto;

-- 26. Devuelve un listado con todos los productos donde su unidad de medida sea en kilogramos
SELECT * FROM producto WHERE Unidad_Medida LIKE '%kilogramos%';

-- 27. Devuelve un listado con todos los productos que se cosecharon en el transcurso de un mes
SELECT p.Nombre, pp.Fecha_Inicio, pp.Cantidad_Producida FROM proceso_produccion pp
JOIN producto p ON pp.ID_Producto = p.ID_Producto
WHERE MONTH(pp.Fecha_Inicio) = MONTH(CURDATE());

-- 29. Devuelve un listado con todos los productos de la categoría cacao
SELECT * FROM producto WHERE Categoria = 'cacao';

-- 30. Devuelve un listado con la maquinaria usada en la producción de cacao en el mes de junio
SELECT DISTINCT m.Nombre AS Maquinaria, p.Nombre AS Producto FROM proceso_produccion pp
JOIN maquinaria m ON pp.ID_Maquinaria = m.ID_Maquinaria JOIN producto p ON pp.ID_Producto = p.ID_Producto
WHERE p.Categoria = 'cacao' AND MONTH(pp.Fecha_Inicio) = 6;

-- 31. Devuelve un listado con las fechas y el total de las compras que realizó cada proveedor
SELECT c.Fecha_Compra, c.Total_Compra, p.Nombre AS Proveedor FROM compra c
JOIN proveedor p ON c.ID_Proveedor = p.ID_Proveedor;

-- 32. Devuelve un listado con los 10 proveedores que más gastaron en sus compras
SELECT p.Nombre, SUM(c.Total_Compra) AS Total_Gastado FROM compra c
JOIN proveedor p ON c.ID_Proveedor = p.ID_Proveedor GROUP BY p.ID_Proveedor 
ORDER BY Total_Gastado DESC LIMIT 10;

-- 33. Devuelve un listado con el total de compra del mes de febrero
SELECT SUM(Total_Compra) AS Total_Febrero FROM compra WHERE MONTH(Fecha_Compra) = 2;

-- 34. Devuelve un listado con los proveedores que gastaron menos en sus compras
SELECT p.Nombre, SUM(c.Total_Compra) AS Total_Gastado FROM compra c
JOIN proveedor p ON c.ID_Proveedor = p.ID_Proveedor GROUP BY p.ID_Proveedor 
ORDER BY Total_Gastado ASC LIMIT 1;

-- 35. Devuelve un listado con los empleados que fueron contratados en el mes de noviembre
SELECT * FROM empleado WHERE MONTH(Fecha_Ingreso) = 11;

-- 36. Devuelve un listado con los productos que fueron cosechados en el mes de abril
SELECT DISTINCT p.Nombre FROM proceso_produccion pp
JOIN producto p ON pp.ID_Producto = p.ID_Producto WHERE MONTH(pp.Fecha_Inicio) = 4;

-- 37. Devuelve un listado con los roles de supervisor y sus respectivos salarios
SELECT e.Nombre, e.Apellido, e.Salario FROM empleado e
JOIN empleado_rol r ON e.ID_Empleado = r.ID_Empleado WHERE r.Rol = 'SUPERVISOR';

-- 38. Devuelve un listado con el número de un cliente en específico
SELECT Telefono FROM cliente WHERE Nombre = 'Nombre_Cliente';

-- 39. Devuelve los productos del inventario que sean mayores a 300
SELECT * FROM inventario WHERE Cantidad > 300;

-- 40. Devuelve los productos con una cantidad menor a 100
SELECT * FROM inventario WHERE Cantidad < 100;

-- 41. Devuelve un listado con la maquinaria que supera el costo de 5.000
SELECT * FROM maquinaria WHERE Costo > 5000;

-- 42. Devuelve los detalles de ventas incluyendo los productos vendidos
SELECT dv.*, p.Nombre AS Producto FROM detalle_venta dv
JOIN producto p ON dv.ID_Producto = p.ID_Producto;

-- 43. Devuelve el número total de clientes
SELECT COUNT(*) AS Total_Clientes FROM cliente;

-- 44. Devuelve el salario promedio de los empleados
SELECT AVG(Salario) AS Salario_Promedio FROM empleado;

-- 45. Devuelve el total de ventas realizadas
SELECT SUM(Total_Venta) AS Total_Ventas FROM venta;

-- 46. Devuelve la maquinaria mas costosa
SELECT * FROM maquinaria ORDER BY costo DESC LIMIT 1;

-- 47. Devuelve los empleados que tienen un salario inferior a 60.000
SELECT * FROM empleado WHERE salario < 60000;

-- 48. Devuelve el total de las ventas realizadas en el mes de noviembre
SELECT SUM(Total_Venta) FROM venta WHERE MONTH(fecha_venta) = 11;

-- 49. Devuelve  un listado con todos los supervisores que ganan mas de 50.000
SELECT * FROM empleado WHERE cargo = 'Supervisor' AND salario > 50000;

-- 50. Devuelve un listado con los 5 productos más vendidos
SELECT ID_Producto, SUM(Cantidad) AS cantidad_vendida
FROM detalle_venta
GROUP BY ID_Producto
ORDER BY cantidad_vendida DESC
LIMIT 5;

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
WHERE pp.Fecha_Inicio >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) -- Filtra solo el último año
GROUP BY e.ID_Empleado
HAVING SUM(pp.Cantidad_Producida) < (
    SELECT AVG(pp2.Cantidad_Producida)
    FROM proceso_produccion pp2
    WHERE pp2.ID_Empleado = e.ID_Empleado
    AND pp2.Fecha_Inicio >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)
);

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
    SUM(pp.Cantidad_Producida) AS TotalProduccion, 
    COALESCE(SUM(dv.Cantidad), 0) AS TotalVentas  -- Se utiliza COALESCE para manejar casos donde no hay ventas
FROM 
    empleado e
JOIN 
    proceso_produccion pp ON pp.ID_Empleado = e.ID_Empleado
LEFT JOIN  -- Usamos LEFT JOIN para incluir empleados sin ventas
    venta v ON v.ID_Empleado = e.ID_Empleado
LEFT JOIN 
    detalle_venta dv ON dv.ID_Venta = v.ID_Venta
GROUP BY 
    e.ID_Empleado;
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