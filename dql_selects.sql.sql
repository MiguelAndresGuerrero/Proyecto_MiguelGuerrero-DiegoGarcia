use proyecto;

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
SELECT * FROM empleados WHERE salario < 60000;

-- 48. Devuelve el total de las ventas realizadas en el mes de noviembre
SELECT SUM(monto) FROM ventas WHERE MONTH(fecha_venta) = 11;

-- 49. Devuelve  un listado con todos los supervisores que ganan mas de 50.000
SELECT * FROM empleados WHERE cargo = 'Supervisor' AND salario > 50000;

-- 50. Devuelve un listado con los 5 productos mas vendidos
SELECT producto_id, COUNT(*) AS cantidad_vendida FROM ventas
GROUP BY producto_id ORDER BY cantidad_vendida DESC LIMIT 5;
