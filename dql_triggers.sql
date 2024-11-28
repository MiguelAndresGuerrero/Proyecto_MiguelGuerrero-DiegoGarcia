use proyecto;

-- 1. Actualiza el stock al registrar una venta
DELIMITER //
CREATE PROCEDURE actualizar_stock_venta(IN producto_id INT, IN cantidad_vendida INT)
BEGIN
    UPDATE productos
    SET stock = stock - cantidad_vendida
    WHERE producto_id = producto_id AND stock >= cantidad_vendida;
END;
// DELIMITER ;

-- 2. Evita ventas de productos sin stock
DELIMITER //
	CREATE PROCEDURE evitar_venta_sin_stock(IN producto_id INT, IN cantidad_vendida INT)
BEGIN
    DECLARE stock_actual INT;
    SELECT stock INTO stock_actual
    FROM productos
    WHERE producto_id = producto_id;

    IF stock_actual >= cantidad_vendida THEN
        SELECT 'Venta permitida';
    ELSE
        SELECT 'Stock insuficiente';
    END IF;
END;
// DELIMITER ;

-- 3. Actualizar el estado de una maquinaria al completar un proceso de produccion
DELIMITER //
CREATE PROCEDURE actualizar_estado_maquinaria(IN maquina_id INT, IN nuevo_estado VARCHAR(50))
BEGIN
    UPDATE maquinaria
    SET estado = nuevo_estado
    WHERE maquina_id = maquina_id;
END;
// DELIMITER ;

-- 4. Actualizar stock al registrar una compra
DELIMITER //
CREATE PROCEDURE actualizar_stock_compra(IN producto_id INT, IN cantidad_comprada INT)
BEGIN
    UPDATE productos
    SET stock = stock + cantidad_comprada
    WHERE producto_id = producto_id;
END;
// DELIMITER ;

-- 5. Actualizar stock al eliminar un detalle de venta
DELIMITER //
CREATE PROCEDURE actualizar_stock_eliminar_detalle(IN producto_id INT, IN cantidad_eliminada INT)
BEGIN
    UPDATE productos
    SET stock = stock + cantidad_eliminada
    WHERE producto_id = producto_id;
END;
// DELIMITER ;

-- 6. Actualizar el estado de una maquinaria cuando se inicie un proceso
DELIMITER //
CREATE PROCEDURE actualizar_estado_maquinaria_inicio(IN maquina_id INT, IN nuevo_estado VARCHAR(50))
BEGIN
    UPDATE maquinaria
    SET estado = nuevo_estado
    WHERE maquina_id = maquina_id;
END;
// DELIMITER ;

-- 7. Evita realizar compras a un proveedor inexistente
DELIMITER //
CREATE PROCEDURE evitar_compra_a_proveedor_inexistente(IN proveedor_id INT)
BEGIN
    DECLARE existe_proveedor INT;
    SELECT COUNT(*) INTO existe_proveedor
    FROM proveedores
    WHERE proveedor_id = proveedor_id;

    IF existe_proveedor > 0 THEN
        SELECT 'Proveedor existe, se puede realizar la compra';
    ELSE
        SELECT 'Proveedor no existe, compra no permitida';
    END IF;
END;
// DELIMITER ;

-- 8. Revertir los cambioss en inventarios al eliminar una compra
DELIMITER //
CREATE PROCEDURE revertir_cambios_eliminar_compra(IN producto_id INT, IN cantidad_eliminada INT)
BEGIN
    UPDATE productos
    SET stock = stock - cantidad_eliminada
    WHERE producto_id = producto_id;
END;
// DELIMITER ;

-- 9. Evita que las maquinas tengan costos negativos
DELIMITER //
CREATE PROCEDURE evitar_costo_negativo(IN maquina_id INT, IN nuevo_precio DECIMAL(10, 2))
BEGIN
    IF nuevo_precio >= 0 THEN
        UPDATE maquinaria
        SET precio = nuevo_precio
        WHERE maquina_id = maquina_id;
    ELSE
        SELECT 'Error: El costo no puede ser negativo';
    END IF;
END;
// DELIMITER ;

-- 10. Evita que una venta tegna un total negativo
DELIMITER //
CREATE PROCEDURE evitar_total_negativo(IN venta_id INT)
BEGIN
    DECLARE total_venta DECIMAL(10, 2);
    SELECT SUM(monto * cantidad) INTO total_venta
    FROM detalles_venta
    WHERE venta_id = venta_id;

    IF total_venta >= 0 THEN
        SELECT 'Venta válida';
    ELSE
        SELECT 'Error: El total de la venta no puede ser negativo';
    END IF;
END;
// DELIMITER ;

CALL actualizar_stock_venta(1, 5);
CALL evitar_venta_sin_stock(2, 3);
CALL actualizar_estado_maquinaria(1, 'Disponible');
CALL actualizar_stock_compra(3, 10);
CALL actualizar_stock_eliminar_detalle(2, 5);
CALL actualizar_estado_maquinaria_inicio(1, 'En proceso');
CALL evitar_compra_a_proveedor_inexistente(4);
CALL revertir_cambios_eliminar_compra(2, 5);
CALL evitar_costo_negativo(1, 15000.00);
CALL evitar_total_negativo(123);
