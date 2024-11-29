use finca_campus;

-- 1. Calcula el total de una venta
DELIMITER //
CREATE FUNCTION calcular_total_venta(ID_Venta INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);

    SELECT SUM(Precio_Venta * Cantidad) INTO total
    FROM detalle_venta
    WHERE ID_Venta = ID_Venta;
    RETURN COALESCE(total, 0);
END;
// DELIMITER ;

-- 2. Obtener el precio más reciente de un producto
DELIMITER //
CREATE FUNCTION obtener_precio_reciente(producto_id INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10, 2);
    SELECT Precio INTO precio 
    FROM detalle_producto_precio
    WHERE ID_Producto = producto_id
    ORDER BY Fecha_Registro DESC
    LIMIT 1;
    RETURN COALESCE(precio, 0);
END;
// DELIMITER ;

-- 3. Calcula el salario promedio de los empleados
DELIMITER //
CREATE FUNCTION calcular_salario_promedio()
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10, 2);
    SELECT AVG(Salario) INTO promedio
    FROM empleado;
    RETURN COALESCE(promedio, 0);
END;
// DELIMITER ;

-- 4. Calcula el total de los productos vendidos
DELIMITER //
CREATE FUNCTION total_productos_vendidos()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(Cantidad) INTO total
    FROM detalle_venta;
    RETURN COALESCE(total, 0);
END;
// DELIMITER ;

-- 5. Muestra el estado en el que se encuentre cualquier máquina
DELIMITER //
CREATE FUNCTION obtener_estado_maquina(maquina_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE estado VARCHAR(50);
    SELECT Estado INTO estado
    FROM maquinaria
    WHERE ID_Maquinaria = maquina_id;
    RETURN COALESCE(estado, 'Estado no encontrado');
END;
// DELIMITER ;

-- 6. Verificar si un producto tiene suficiente stock
DELIMITER //
CREATE FUNCTION verificar_stock(producto_id INT, cantidad_requerida INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE estado VARCHAR(50);
    DECLARE stock_actual INT;

    -- Obtener el stock actual del producto
    SELECT Cantidad INTO stock_actual
    FROM inventario
    WHERE ID_Producto = producto_id;

    -- Determinar si hay suficiente stock
    SET estado = CASE 
                   WHEN stock_actual >= cantidad_requerida THEN 'Suficiente stock'
                   ELSE 'Stock insuficiente'
                 END;

    RETURN estado;
END;
// DELIMITER ;

-- 7. Muestra el nombre completo de un empleado
DELIMITER //
CREATE FUNCTION obtener_nombre_completo_empleado(emp_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(100);
    SELECT CONCAT(Nombre, ' ', Apellido) INTO nombre_completo
    FROM empleado
    WHERE ID_Empleado = emp_id;
    RETURN COALESCE(nombre_completo, 'Empleado no encontrado');
END;
// DELIMITER ;

-- 8. Muestra la cantidad total que se encuentra en el inventario
DELIMITER //
CREATE FUNCTION total_inventario()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(Cantidad) INTO total
    FROM inventario;
    RETURN COALESCE(total, 0);
END;
// DELIMITER ;

-- 9. Calcula la cantidad total producida de un producto en proceso de producción
DELIMITER //
CREATE FUNCTION cantidad_producida_producto(producto_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_produccion INT;
    SELECT SUM(Cantidad_Producida) INTO total_produccion
    FROM proceso_produccion
    WHERE ID_Producto = producto_id
      AND Fecha_Fin IS NULL;  -- Esto significa que aún está en proceso
    RETURN COALESCE(total_produccion, 0);
END;
// DELIMITER ;

-- 10. Muestra el nombre completo de un cliente por su ID
DELIMITER //
CREATE FUNCTION obtener_nombre_completo_cliente(cliente_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(100);
    SELECT CONCAT(Nombre, ' ', Apellido) INTO nombre_completo
    FROM cliente
    WHERE ID_Cliente = cliente_id;
    RETURN COALESCE(nombre_completo, 'Cliente no encontrado');
END;
// DELIMITER ;

-- Llamadas de las funciones creadas

-- 1. Calcular el total de una venta
SET @id_venta = 1;
SELECT calcular_total_venta(@id_venta) AS Total_Venta;

-- 2. Obtener el precio más reciente de un producto
SET @producto_id = 1;
SELECT obtener_precio_reciente(@producto_id) AS Precio_Recién;

-- 3. Calcular el salario promedio de los empleados
SELECT calcular_salario_promedio() AS Salario_Promedio;

-- 4. Calcular el total de los productos vendidos
SELECT total_productos_vendidos() AS Total_Productos_Vendidos;

-- 5. Mostrar el estado en el que se encuentre cualquier máquina
SET @maquina_id = 1; -- Cambia por el ID de la máquina que desees
SELECT obtener_estado_maquina(@maquina_id) AS Estado_Maquina;

-- 6. Verificar stock para un producto
SET @producto_id_stock = 1;
SET @cantidad_requerida = 10;
SELECT verificar_stock(@producto_id_stock, @cantidad_requerida) AS Verificacion_Stock;

-- 7. Mostrar el nombre completo de un empleado
SET @emp_id = 1;
SELECT obtener_nombre_completo_empleado(@emp_id) AS Nombre_Completo_Empleado;

-- 8. Mostrar la cantidad total de inventario
SELECT total_inventario() AS Total_Inventario;

-- 9. Calcular la cantidad total producida de un producto en proceso de producción
SET @producto_id_produccion = 1;
SELECT cantidad_producida_producto(@producto_id_produccion) AS Cantidad_Produccion;

-- 10. Mostrar el nombre completo de un cliente por su ID
SET @cliente_id = 1;
SELECT obtener_nombre_completo_cliente(@cliente_id) AS Nombre_Completo_Cliente;

DELIMITER //

-- 1. Calcular el total de ventas de un cliente
CREATE FUNCTION TotalVentasCliente(p_ID_Cliente INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(Total_Venta) INTO total
    FROM venta
    WHERE ID_Cliente = p_ID_Cliente;
    RETURN IFNULL(total, 0);
END //

-- 2. Calcular el total invertido en maquinaria
CREATE FUNCTION TotalInvertidoMaquinaria() 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(Costo) INTO total
    FROM maquinaria;
    RETURN IFNULL(total, 0);
END //

-- 3. Obtener la cantidad disponible de un producto
CREATE FUNCTION CantidadDisponible(p_ID_Producto INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT Cantidad INTO cantidad
    FROM inventario
    WHERE ID_Producto = p_ID_Producto;
    RETURN IFNULL(cantidad, 0);
END //

-- 4. Calcular el precio promedio de un producto
CREATE FUNCTION PrecioPromedioProducto(p_ID_Producto INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(Precio) INTO promedio
    FROM detalle_producto_precio
    WHERE ID_Producto = p_ID_Producto;
    RETURN IFNULL(promedio, 0);
END //

-- 5. Calcular el total producido por un empleado
CREATE FUNCTION TotalProducidoEmpleado(p_ID_Empleado INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(Cantidad_Producida) INTO total
    FROM proceso_produccion
    WHERE ID_Empleado = p_ID_Empleado;
    RETURN IFNULL(total, 0);
END //

-- 6. Obtener el nombre completo de un cliente
CREATE FUNCTION NombreCompletoCliente(p_ID_Cliente INT) 
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(200);
    SELECT CONCAT(Nombre, ' ', Apellido) INTO nombre_completo
    FROM cliente
    WHERE ID_Cliente = p_ID_Cliente;
    RETURN nombre_completo;
END //

-- 7. Obtener el estado de una maquinaria
CREATE FUNCTION EstadoMaquinaria(p_ID_Maquinaria INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE estado VARCHAR(50);
    SELECT Estado INTO estado
    FROM maquinaria
    WHERE ID_Maquinaria = p_ID_Maquinaria;
    RETURN estado;
END //

-- 8. Calcular el total de compras realizadas a un proveedor
CREATE FUNCTION TotalComprasProveedor(p_ID_Proveedor INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(Total_Compra) INTO total
    FROM compra
    WHERE ID_Proveedor = p_ID_Proveedor;
    RETURN IFNULL(total, 0);
END //

-- 9. Calcular la cantidad total producida de un producto
CREATE FUNCTION CantidadTotalProducida(p_ID_Producto INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(Cantidad_Producida) INTO total
    FROM proceso_produccion
    WHERE ID_Producto = p_ID_Producto;
    RETURN IFNULL(total, 0);
END //

-- 10. Calcular el total de ventas de cacao por categoría
CREATE FUNCTION TotalVentasCacao() 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(dv.Cantidad * dv.Precio_Venta) INTO total
    FROM detalle_venta dv
    JOIN producto p ON dv.ID_Producto = p.ID_Producto
    WHERE p.Categoria = 'Cacao';
    RETURN IFNULL(total, 0);
END //


DELIMITER ;

-- Consulta el total de ventas de un cliente
SELECT TotalVentasCliente(1) AS Total_Ventas_Cliente;

-- Consulta el total invertido en maquinaria
SELECT TotalInvertidoMaquinaria() AS Total_Invertido_Maquinaria;

-- Consulta la cantidad disponible de un producto
SELECT CantidadDisponible(1) AS Cantidad_Disponible_Producto;

-- Consulta el precio promedio de un producto
SELECT PrecioPromedioProducto(1) AS Precio_Promedio_Producto;

-- Consulta el total producido por un empleado
SELECT TotalProducidoEmpleado(2) AS Total_Producido_Empleado;

-- Consulta el nombre completo de un cliente
SELECT NombreCompletoCliente(1) AS Nombre_Completo_Cliente;

-- Consulta el estado de una maquinaria
SELECT EstadoMaquinaria(1) AS Estado_Maquinaria;

-- Consulta el total de compras realizadas a un proveedor
SELECT TotalComprasProveedor(1) AS Total_Compras_Proveedor;

-- Consulta la cantidad total producida de un producto
SELECT CantidadTotalProducida(1) AS Cantidad_Total_Producida;

-- Consulta el total de ventas de cacao por categoría
SELECT TotalVentasCacao() AS Total_Ventas_Cacao;