use finca_campus;

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
