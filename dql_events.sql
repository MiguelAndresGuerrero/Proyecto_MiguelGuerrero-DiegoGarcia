use proyecto;

-- 1. Elimina del inventario los productos que sean obsoletas cada mes
DELIMITER //
CREATE EVENT eliminar_productos_obsoletos
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    DELETE FROM productos
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