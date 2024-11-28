use proyecto;

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
