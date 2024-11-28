use proyecto;

-- 1. Actualiza la cantidad de un producto en el inventario
DELIMITER //
CREATE PROCEDURE actualizar_cantidad_producto(IN producto_id INT, IN cantidad_nueva INT)
BEGIN
    UPDATE producto
    SET invetario = cantidad_nueva
    WHERE producto_id = producto_id;
END;
// DELIMITER ;

-- 2. Agrega un producto al inventario
DELIMITER //
CREATE PROCEDURE agregar_producto(IN nombre_producto VARCHAR(100), IN precio DECIMAL(10, 2), IN cantidad INT)
BEGIN
    INSERT INTO producto (nombre, precio, invetario)
    VALUES (nombre_producto, precio, cantidad);
END;
// DELIMITER ;

-- 3. Agrega una maquinaria nueva
DELIMITER //
CREATE PROCEDURE agregar_maquinaria(IN nombre_maquina VARCHAR(100), IN estado VARCHAR(50), IN precio DECIMAL(10, 2))
BEGIN
    INSERT INTO maquinaria (nombre_maquina, estado, precio)
    VALUES (nombre_maquina, estado, precio);
END;
// DELIMITER ;

-- 4. Atualiza el salario de cualquier empleado
DELIMITER //
CREATE PROCEDURE actualizar_salario_empleado(IN empleado_id INT, IN nuevo_salario DECIMAL(10, 2))
BEGIN
    UPDATE empleado
    SET salario = nuevo_salario
    WHERE empleado_id = empleado_id;
END;
// DELIMITER ;

-- 5. Actualiza los datos de cualquier proveedor
DELIMITER //
CREATE PROCEDURE actualizar_datos_proveedor(IN proveedor_id INT, IN nuevo_nombre VARCHAR(100), IN nueva_direccion VARCHAR(200))
BEGIN
    UPDATE proveedor
    SET nombre = nuevo_nombre, direccion = nueva_direccion
    WHERE proveedor_id = proveedor_id;
END;
// DELIMITER ;

-- 6. Actualiza los datos de cualquier cliente
DELIMITER //
CREATE PROCEDURE actualizar_datos_cliente(IN cliente_id INT, IN nuevo_nombre VARCHAR(100), IN nueva_direccion VARCHAR(200))
BEGIN
    UPDATE cliente
    SET nombre = nuevo_nombre, direccion = nueva_direccion
    WHERE cliente_id = cliente_id;
END;
// DELIMITER ;

-- 7. Muestra todas las maquinas por estado
DELIMITER //
CREATE PROCEDURE mostrar_maquinas_por_estado()
BEGIN
    SELECT nombre_maquina, estado
    FROM maquinaria;
END;
// DELIMITER ;

-- 8. Actualiza los datos de una maquina
DELIMITER //
CREATE PROCEDURE actualizar_datos_maquina(IN maquina_id INT, IN nuevo_nombre VARCHAR(100), IN nuevo_estado VARCHAR(50), IN nuevo_precio DECIMAL(10, 2))
BEGIN
    UPDATE maquinaria
    SET nombre_maquina = nuevo_nombre, estado = nuevo_estado, precio = nuevo_precio
    WHERE maquina_id = maquina_id;
END;
// DELIMITER ;

-- 9. Registrar un nuevo rol para un empleado
DELIMITER //
CREATE PROCEDURE registrar_rol_empleado(IN empleado_id INT, IN nuevo_rol VARCHAR(50))
BEGIN
    UPDATE empleado
    SET cargo = nuevo_rol
    WHERE empleado_id = empleado_id;
END;
// DELIMITER ;

-- 10. obten las compras mas grande que realizo algun proveedor
DELIMITER //
CREATE PROCEDURE obtener_compras_mas_grandes()
BEGIN
    SELECT proveedor_id, MAX(monto_compra) AS compra_mas_grande
    FROM compra
    GROUP BY proveedor_id;
END;
// DELIMITER ;

CALL actualizar_cantidad_producto(1, 30);
CALL agregar_producto('Producto X', 50.00, 200);
CALL agregar_maquinaria('Maquina Y', 'En operación', 15000.00);
CALL actualizar_salario_empleado(5, 60000.00);
CALL actualizar_datos_proveedor(3, 'Proveedor Nuevo', 'Calle 123');
CALL actualizar_datos_cliente(10, 'Cliente A', 'Avenida 456');
CALL mostrar_maquinas_por_estado();
CALL actualizar_datos_maquina(2, 'Maquina Z', 'En reparación', 12000.00);
CALL registrar_rol_empleado(7, 'Gerente');
CALL obtener_compras_mas_grandes();
