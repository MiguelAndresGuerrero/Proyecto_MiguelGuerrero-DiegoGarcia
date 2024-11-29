use finca_campus;

-- Crear Usuario Administrador
CREATE USER 'adminUser'@'localhost' IDENTIFIED BY 'adminPassword';
-- 3. Asignar todos los permisos al usuario administrador
GRANT ALL PRIVILEGES ON finca_campus.* TO 'adminUser'@'localhost';

-- Crear Usuario Vendedor
CREATE USER 'vendedorUser'@'localhost' IDENTIFIED BY 'vendedorPassword';
-- 5. Asignar permisos al vendedor
GRANT SELECT, INSERT, UPDATE ON finca_campus.venta TO 'vendedorUser'@'localhost';
GRANT SELECT, UPDATE ON finca_campus.inventario TO 'vendedorUser'@'localhost';
GRANT SELECT ON finca_campus.cliente TO 'vendedorUser'@'localhost';

-- Crear Usuario Contador
CREATE USER 'contadorUser'@'localhost' IDENTIFIED BY 'contadorPassword';
-- 7. Asignar permisos al contador
GRANT SELECT ON finca_campus.maquinaria TO 'contadorUser'@'localhost';
GRANT SELECT ON finca_campus.compra TO 'contadorUser'@'localhost';
GRANT SELECT ON finca_campus.detalle_compra TO 'contadorUser'@'localhost';
GRANT SELECT ON finca_campus.Venta TO 'contadorUser'@'localhost';
GRANT SELECT ON finca_campus.detalle_venta TO 'contadorUser'@'localhost';
GRANT SELECT, INSERT ON finca_campus.detalle_producto_precio TO 'contadorUser'@'localhost';

-- Crear Usuario Empleado
CREATE USER 'empleadoUser'@'localhost' IDENTIFIED BY 'empleadoPassword';
-- Asignar permisos al empleado (acceso limitado a su propio registro)
GRANT SELECT ON finca_campus.empleado TO 'empleadoUser'@'localhost';

-- Crear Usuario Proveedor
CREATE USER 'proveedorUser'@'localhost' IDENTIFIED BY 'proveedorPassword';
-- Asignar permisos al proveedor
GRANT SELECT, INSERT ON finca_campus.producto TO 'proveedorUser'@'localhost';

-- Verificar los privilegios asignados a cada usuario
SHOW GRANTS FOR 'adminUser'@'localhost';
SHOW GRANTS FOR 'vendedorUser'@'localhost';
SHOW GRANTS FOR 'contadorUser'@'localhost';
SHOW GRANTS FOR 'empleadoUser'@'localhost';
SHOW GRANTS FOR 'proveedorUser'@'localhost';