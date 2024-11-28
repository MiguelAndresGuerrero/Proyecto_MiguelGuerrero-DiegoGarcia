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