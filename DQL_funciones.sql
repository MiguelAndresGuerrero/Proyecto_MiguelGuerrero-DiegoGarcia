use finca_campus;

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