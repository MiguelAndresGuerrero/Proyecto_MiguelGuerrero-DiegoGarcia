use finca_campus;

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

-- 1. Registrar un cliente nuevo

DELIMITER //
CREATE PROCEDURE RegistrarCliente(
    IN p_Nombre VARCHAR(100),
    IN p_Apellido VARCHAR(100),
    IN p_Direccion VARCHAR(255),
    IN p_Telefono VARCHAR(20),
    IN p_Correo VARCHAR(100)
)
BEGIN
    INSERT INTO cliente (Nombre, Apellido, Direccion, Telefono, Correo_Electronico)
    VALUES (p_Nombre, p_Apellido, p_Direccion, p_Telefono, p_Correo);
END //
DELIMITER ;

call RegistrarCliente('lina','castro','calle 10#10-37','3154598745','caslina@gmail.com');

-- 2. Registrar una compra de insumos

DELIMITER //
CREATE PROCEDURE RegistrarCompra(
    IN p_ID_Proveedor INT,
    IN p_Fecha_Compra DATETIME,
    IN p_Total_Compra DECIMAL(10,2)
)
BEGIN
    INSERT INTO compra (ID_Proveedor, Fecha_Compra, Total_Compra)
    VALUES (p_ID_Proveedor, p_Fecha_Compra, p_Total_Compra);
END //
DELIMITER ;

CALL RegistrarCompra(1, '2023-10-01 08:00:00', 5000.00);

-- 3. Actualizar el estado de una maquinaria

DELIMITER //
CREATE PROCEDURE ActualizarEstadoMaquinaria(
    IN p_ID_Maquinaria INT,
    IN p_NuevoEstado ENUM('OPERATIVA', 'REPARACION', 'OBSOLETA')
)
BEGIN
    UPDATE maquinaria
    SET Estado = p_NuevoEstado
    WHERE ID_Maquinaria = p_ID_Maquinaria;
END //
DELIMITER ;

CALL ActualizarEstadoMaquinaria(1, 'OPERATIVA');

-- 4. Registrar un nuevo empleado

DELIMITER //
CREATE PROCEDURE RegistrarEmpleado(
    IN p_Nombre VARCHAR(100),
    IN p_Apellido VARCHAR(100),
    IN p_Cargo VARCHAR(50),
    IN p_Salario DECIMAL(10,2)
)
BEGIN
    INSERT INTO empleado (Nombre, Apellido, Cargo, Salario)
    VALUES (p_Nombre, p_Apellido, p_Cargo, p_Salario);
END //
DELIMITER ;

CALL RegistrarEmpleado('John', 'Doe', 'Operario', 1200.00);

-- 5. Registrar un nuevo producto

DELIMITER //
CREATE PROCEDURE RegistrarProducto(
    IN p_Nombre VARCHAR(100),
    IN p_Categoria VARCHAR(50),
    IN p_UnidadMedida VARCHAR(100)
)
BEGIN
    INSERT INTO producto (Nombre, Categoria, Unidad_Medida)
    VALUES (p_Nombre, p_Categoria, p_UnidadMedida);
END //
DELIMITER ;

CALL RegistrarProducto('Nuevo Producto', 'Cacao', 'Kilogramo');

-- 6. Actualizar el precio de un producto

DELIMITER //
CREATE PROCEDURE ActualizarPrecioProducto(
    IN p_ID_Producto INT,
    IN p_NuevoPrecio DECIMAL(10,2)
)
BEGIN
    INSERT INTO detalle_producto_precio (ID_Producto, Precio)
    VALUES (p_ID_Producto, p_NuevoPrecio);
END //
DELIMITER ;

CALL ActualizarPrecioProducto(1, 250.00);

-- 7. Registrar una venta

DELIMITER //
CREATE PROCEDURE RegistrarVenta(
    IN p_ID_Cliente INT,
    IN p_Total_Venta DECIMAL(10,2)
)
BEGIN
    INSERT INTO venta (ID_Cliente, Total_Venta)
    VALUES (p_ID_Cliente, p_Total_Venta);
END //
DELIMITER ;

CALL RegistrarVenta(1, 1500.75);

-- 8. Agregar productos al inventario

DELIMITER //
CREATE PROCEDURE AgregarInventario(
    IN p_ID_Producto INT,
    IN p_Cantidad INT
)
BEGIN
    INSERT INTO inventario (ID_Producto, Cantidad)
    VALUES (p_ID_Producto, p_Cantidad)
    ON DUPLICATE KEY UPDATE Cantidad = Cantidad + p_Cantidad;
END //
DELIMITER ;

CALL AgregarInventario(1, 50);

-- 9. Registrar un proceso de producción

DELIMITER //
CREATE PROCEDURE RegistrarProcesoProduccion(
    IN p_ID_Producto INT,
    IN p_ID_Empleado INT,
    IN p_ID_Maquinaria INT,
    IN p_Fecha_Inicio DATETIME,
    IN p_Fecha_Fin DATETIME,
    IN p_Cantidad_Producida INT
)
BEGIN
    INSERT INTO proceso_produccion (ID_Producto, ID_Empleado, ID_Maquinaria, Fecha_Inicio, Fecha_Fin, Cantidad_Producida)
    VALUES (p_ID_Producto, p_ID_Empleado, p_ID_Maquinaria, p_Fecha_Inicio, p_Fecha_Fin, p_Cantidad_Producida);
END //
DELIMITER ;

CALL RegistrarProcesoProduccion(1, 1, 1, '2023-01-10 08:00:00', '2023-01-10 14:00:00', 500);

-- 10. Obtener el inventario de productos de cacao

DELIMITER //
CREATE PROCEDURE ObtenerInventarioCacao()
BEGIN
    SELECT p.Nombre, i.Cantidad, p.Unidad_Medida
    FROM inventario i
    JOIN producto p ON i.ID_Producto = p.ID_Producto
    WHERE p.Categoria = 'Cacao';
END //
DELIMITER ; 

CALL ObtenerInventarioCacao();
