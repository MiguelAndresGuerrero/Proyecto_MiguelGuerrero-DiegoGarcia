USE finca_campus;



DELIMITER $$
-- 1. Actualizar inventario al registrar una compra
CREATE TRIGGER ActualizarInventarioCompra
AFTER INSERT ON detalle_compra
FOR EACH ROW
BEGIN
    INSERT INTO inventario (ID_Producto, Cantidad, Fecha_Actualizacion)
    VALUES (NEW.ID_Producto, NEW.Cantidad, NOW())
    ON DUPLICATE KEY UPDATE
        Cantidad = Cantidad + NEW.Cantidad,
        Fecha_Actualizacion = NOW();
END;

-- 2. Actualizar inventario al realizar una venta
CREATE TRIGGER ActualizarInventarioVenta
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    UPDATE inventario
    SET Cantidad = Cantidad - NEW.Cantidad,
        Fecha_Actualizacion = NOW()
    WHERE ID_Producto = NEW.ID_Producto;
END;

-- 3. Evitar ventas si no hay suficiente stock
CREATE TRIGGER ValidarStockVenta
BEFORE INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    DECLARE stock_actual INT;
    SELECT Cantidad INTO stock_actual
    FROM inventario
    WHERE ID_Producto = NEW.ID_Producto;
    
    IF stock_actual IS NULL OR stock_actual < NEW.Cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la venta.';
    END IF;
END;

-- 4. Registrar historial de precios al cambiar precio de un producto
CREATE TRIGGER RegistrarHistorialPrecio
BEFORE UPDATE ON detalle_producto_precio
FOR EACH ROW
BEGIN
    INSERT INTO detalle_producto_precio (ID_Producto, Precio, Fecha_Registro)
    SELECT OLD.ID_Producto, OLD.Precio, NOW();
END;

-- 5. Log de eliminación de clientes
CREATE TRIGGER LogEliminacionCliente
AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (ID_Cliente, Nombre, Apellido, Fecha_Eliminacion)
    VALUES (OLD.ID_Cliente, OLD.Nombre, OLD.Apellido, NOW());
END;

-- 6. Evitar la creación de empleados con salario negativo
CREATE TRIGGER ValidarSalarioEmpleado
BEFORE INSERT ON empleado
FOR EACH ROW
BEGIN
    IF NEW.Salario < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El salario no puede ser negativo.';
    END IF;
END;

-- 7. Registrar cambios en el estado de maquinaria
CREATE TRIGGER LogCambioEstadoMaquinaria
AFTER UPDATE ON maquinaria
FOR EACH ROW
BEGIN
    IF OLD.Estado <> NEW.Estado THEN
        INSERT INTO historial_maquinaria (ID_Maquinaria, Estado_Anterior, Estado_Nuevo, Fecha_Cambio)
        VALUES (OLD.ID_Maquinaria, OLD.Estado, NEW.Estado, NOW());
    END IF;
END;

-- 8. Recalcular el total de una compra al agregar un detalle
CREATE TRIGGER RecalcularTotalCompra
AFTER INSERT ON detalle_compra
FOR EACH ROW
BEGIN
    UPDATE compra
    SET Total_Compra = Total_Compra + (NEW.Cantidad * NEW.Precio_Compra)
    WHERE ID_Compra = NEW.ID_Compra;
END;

-- 9. Recalcular el total de una venta al agregar un detalle
CREATE TRIGGER RecalcularTotalVenta
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    UPDATE venta
    SET Total_Venta = Total_Venta + (NEW.Cantidad * NEW.Precio_Venta)
    WHERE ID_Venta = NEW.ID_Venta;
END;

-- 10. Evitar duplicación de proveedores por teléfono
CREATE TRIGGER ValidarTelefonoProveedor
BEFORE INSERT ON proveedor
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM proveedor WHERE Telefono = NEW.Telefono) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número de teléfono ya está registrado para otro proveedor.';
    END IF;
END; $$
DELIMITER ;