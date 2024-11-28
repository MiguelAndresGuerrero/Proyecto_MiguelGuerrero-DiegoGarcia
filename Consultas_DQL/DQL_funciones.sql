use finca_campus;

-- 1. Calcula el total de una venta
DELIMITER //
CREATE FUNCTION calcular_total_venta(venta_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT monto * cantidad INTO total
    FROM detalles_venta
    WHERE venta_id = venta_id;
    RETURN total;
END;
// DELIMITER ;

-- 2. Obtener el precio mas reciente de algun producto
DELIMITER //
CREATE FUNCTION obtener_precio_reciente(producto_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10, 2);
    SELECT precio INTO precio
    FROM precios_productos
    WHERE producto_id = producto_id
    ORDER BY fecha_registro DESC
    LIMIT 1;
    RETURN precio;
END;
// DELIMITER ;

-- 3. Calcula el salario promedio de los empleados

DELIMITER //
CREATE FUNCTION calcular_salario_promedio()
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10, 2);
    SELECT AVG(salario) INTO promedio
    FROM empleados;
    RETURN promedio;
END;
// DELIMITER ;

-- 4. Calcula el total de los productos vendidos
DELIMITER //
CREATE FUNCTION total_productos_vendidos()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(cantidad) INTO total
    FROM detalles_venta;
    RETURN total;
END;
// DELIMITER ;

-- 5. Muestra el estado en el que se encuentre cualquier maquina
DELIMITER //
CREATE FUNCTION obtener_estado_maquina(maquina_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE estado VARCHAR(50);
    SELECT estado INTO estado
    FROM maquinaria
    WHERE maquina_id = maquina_id;
    RETURN estado;
END;
// DELIMITER ;

-- 6. Calcula si un producto tiene suficiente de ese mismo producto en stock
DELIMITER //
CREATE FUNCTION verificar_stock(producto_id INT, cantidad_requerida INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE estado VARCHAR(50);
    SELECT CASE 
               WHEN stock >= cantidad_requerida THEN 'Suficiente stock'
               ELSE 'Stock insuficiente'
           END INTO estado
    FROM productos
    WHERE producto_id = producto_id;
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
    SELECT CONCAT(nombre, ' ', apellido) INTO nombre_completo
    FROM empleados
    WHERE empleado_id = emp_id;
    RETURN nombre_completo;
END;
// DELIMITER ;

-- 8. Muestra la cantidad total que se encuentran en el inventario
DELIMITER //
CREATE FUNCTION total_inventario()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(stock) INTO total
    FROM productos;
    RETURN total;
END;
// DELIMITER ;

-- 9. Calcula la cantidad total producida de un producto en proceso de produccion
DELIMITER //
CREATE FUNCTION cantidad_producida_producto(producto_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_produccion INT;
    SELECT SUM(cantidad_producida) INTO total_produccion
    FROM produccion
    WHERE producto_id = producto_id
      AND estado = 'En proceso';
    RETURN total_produccion;
END;
// DELIMITER ;

-- 10. Muestra el nombre completo de un cliente por su ID
DELIMITER //
CREATE FUNCTION obtener_nombre_completo_cliente(cliente_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(100);
    SELECT CONCAT(nombre, ' ', apellido) INTO nombre_completo
    FROM clientes
    WHERE cliente_id = cliente_id;
    RETURN nombre_completo;
END;
// DELIMITER ;

SELECT calcular_total_venta(123);
SELECT obtener_precio_reciente(456);

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