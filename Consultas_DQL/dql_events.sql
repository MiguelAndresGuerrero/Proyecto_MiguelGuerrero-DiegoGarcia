use finca_campus;

-- 1. Elimina del inventario los productos que sean obsoletas cada mes
DELIMITER //
CREATE EVENT eliminar_productos_obsoletos
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    DELETE FROM producto
    WHERE fecha_obsolescencia <= CURDATE();
END;
// DELIMITER ;

-- 2. Actualiza el estado de las maquinas cada semana
DELIMITER //
CREATE EVENT actualizar_estado_maquinas
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    UPDATE maquinaria
    SET estado = 'En revisión'
    WHERE DATEDIFF(CURDATE(), fecha_ultimo_mantenimiento) > 7;
END;
// DELIMITER ;

-- 3. Actualizar el precio promedio de productos caada semana
DELIMITER //
CREATE EVENT actualizar_precio_promedio
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    UPDATE productos
    SET precio_promedio = (
        SELECT AVG(precio)
        FROM precios_productos
        WHERE productos.producto_id = precios_productos.producto_id
    );
END;
// DELIMITER ;

-- 4. Muestra a los empleados inactivos que no han producido nada en 6 meses
DELIMITER //
CREATE EVENT mostrar_empleados_inactivos
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    SELECT empleado_id, nombre, apellido
    FROM empleados
    WHERE empleado_id NOT IN (
        SELECT DISTINCT empleado_id
        FROM produccion
        WHERE fecha_produccion >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    );
END;
// DELIMITER ;

-- 5. Genera un resumen de las ventas diarias
DELIMITER //
CREATE EVENT resumen_ventas_diarias
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    SELECT 
        DATE(fecha_venta) AS fecha,
        SUM(monto * cantidad) AS total_ventas,
        COUNT(*) AS numero_transacciones
    FROM ventas
    GROUP BY DATE(fecha_venta);
END;
// DELIMITER ;

-- 6. Muestra los productos mas vendidos semanalmente
DELIMITER //
CREATE EVENT productos_mas_vendidos
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    SELECT producto_id, SUM(cantidad) AS total_vendido
    FROM detalles_venta
    WHERE fecha_venta >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
    GROUP BY producto_id
    ORDER BY total_vendido DESC
    LIMIT 5;
END;
// DELIMITER ;

-- 7. Registra la maquinaria en proceso mensual de revision
DELIMITER //
CREATE EVENT registrar_maquinaria_revision
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    INSERT INTO revision_maquinaria (maquina_id, fecha_revision, estado)
    SELECT maquina_id, CURDATE(), 'En revisión'
    FROM maquinaria
    WHERE DATEDIFF(CURDATE(), fecha_ultimo_mantenimiento) >= 30;
END;
// DELIMITER ;

-- 8. Muestra las maquinas que se demoran mas de 6 meses en ser reparadas
DELIMITER //
CREATE EVENT maquinas_demoradas_reparacion
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    SELECT nombre_maquina, DATEDIFF(CURDATE(), fecha_ultimo_reparacion) AS dias_reparacion
    FROM maquinaria
    WHERE DATEDIFF(CURDATE(), fecha_ultimo_reparacion) > 180;
END;
// DELIMITER ;

-- 9. Genera una notificacion cada vez que un producto en stock este bajo
DELIMITER //
CREATE EVENT notificar_stock_bajo
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    DECLARE stock_minimo INT DEFAULT 10;
    DECLARE producto_id INT;
    DECLARE stock_actual INT;
    DECLARE nombre_producto VARCHAR(100);

    DECLARE producto_cursor CURSOR FOR
    SELECT producto_id, stock, nombre
    FROM productos
    WHERE stock < stock_minimo;

    OPEN producto_cursor;

    FETCH producto_cursor INTO producto_id, stock_actual, nombre_producto;
    WHILE FOUND DO
        INSERT INTO notificaciones (mensaje, fecha)
        VALUES (CONCAT('El producto ', nombre_producto, ' (ID: ', producto_id, ') tiene un stock bajo: ', stock_actual), CURDATE());

        FETCH producto_cursor INTO producto_id, stock_actual, nombre_producto;
    END WHILE;

    CLOSE producto_cursor;
END;
// DELIMITER ;

-- 10. Genera un informe mensual de la maquinaria mas usada
DELIMITER //
CREATE EVENT informe_maquinaria_mas_usada
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    SELECT maquina_id, COUNT(*) AS veces_usada
    FROM produccion
    WHERE fecha_produccion >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    GROUP BY maquina_id
    ORDER BY veces_usada DESC
    LIMIT 5;
END;
// DELIMITER ;

-- 1. Actualizar el estado de maquinaria obsoleta
CREATE EVENT ActualizarMaquinariaObsoleta
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE maquinaria
    SET Estado = 'OBSOLETA'
    WHERE DATEDIFF(CURDATE(), Fecha_Adquisicion) > 3650;

-- 2. Reposición automática de productos escasos
CREATE EVENT RestockProductos
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE inventario
    SET Cantidad = Cantidad + 50
    WHERE Cantidad < 10;

-- 3. Registrar el historial de precios diariamente
CREATE EVENT RegistrarHistorialPrecios
ON SCHEDULE EVERY 1 DAY
DO
    INSERT INTO detalle_producto_precio (ID_Producto, Precio)
    SELECT ID_Producto, Precio
    FROM producto;

-- 4. Cerrar procesos de producción inactivos
CREATE EVENT CerrarProcesosProduccion
ON SCHEDULE EVERY 1 WEEK
DO
    UPDATE proceso_produccion
    SET Fecha_Fin = CURDATE()
    WHERE Fecha_Fin IS NULL AND DATEDIFF(CURDATE(), Fecha_Inicio) > 30;

-- 5. Eliminar clientes inactivos
CREATE EVENT EliminarClientesInactivos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM cliente
    WHERE ID_Cliente NOT IN (
        SELECT DISTINCT ID_Cliente 
        FROM venta 
        WHERE Fecha_Venta >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
    );

-- 6. Auditoría de ventas diarias
CREATE EVENT AuditoriaVentasDiarias
ON SCHEDULE EVERY 1 DAY
DO
    INSERT INTO auditoria_ventas (Fecha, Total)
    SELECT CURDATE() - INTERVAL 1 DAY, SUM(Total_Venta)
    FROM venta
    WHERE DATE(Fecha_Venta) = CURDATE() - INTERVAL 1 DAY;

-- 7. Recalcular inventarios automáticamente
CREATE EVENT RecalcularInventario
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE inventario i
    SET Cantidad = (
        (SELECT IFNULL(SUM(dc.Cantidad), 0) FROM detalle_compra dc WHERE dc.ID_Producto = i.ID_Producto) -
        (SELECT IFNULL(SUM(dv.Cantidad), 0) FROM detalle_venta dv WHERE dv.ID_Producto = i.ID_Producto)
    );

-- 8. Promoción de empleados anualmente
CREATE EVENT PromoverEmpleados
ON SCHEDULE EVERY 1 YEAR
DO
    UPDATE empleado e
    JOIN empleado_rol er ON e.ID_Empleado = er.ID_Empleado
    SET er.Rol = CASE
        WHEN er.Rol = 'EMPLEADO' THEN 'OPERADOR'
        WHEN er.Rol = 'OPERADOR' THEN 'SUPERVISOR'
        WHEN er.Rol = 'SUPERVISOR' THEN 'ADMIN'
        ELSE er.Rol
    END
    WHERE DATEDIFF(CURDATE(), e.Fecha_Ingreso) > 1825;

-- 9. Eliminar registros antiguos de procesos de producción
CREATE EVENT LimpiarProcesosProduccionAntiguos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM proceso_produccion
    WHERE Fecha_Fin IS NOT NULL AND DATEDIFF(CURDATE(), Fecha_Fin) > 1825;

-- 10. Revisión semanal de proveedores
CREATE EVENT RevisarProveedores
ON SCHEDULE EVERY 1 WEEK
DO
    UPDATE proveedor
    SET Contacto = CONCAT(Contacto, ' (REVISAR)')
    WHERE ID_Proveedor NOT IN (
        SELECT DISTINCT ID_Proveedor 
        FROM compra 
        WHERE Fecha_Compra >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    );