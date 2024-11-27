CREATE database finca_campus;

use finca_campus;

-- drop database finca_campus;


CREATE TABLE cultivo (
  ID_Cultivo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Area DECIMAL(10,2) NOT NULL
);


CREATE TABLE cosecha (
  ID_Cosecha INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Cultivo INT NOT NULL,
  Fecha_Cosecha DATE NOT NULL,
  Cantidad INT NOT NULL,
  FOREIGN KEY (ID_Cultivo) REFERENCES cultivo(ID_Cultivo) ON DELETE CASCADE
);


CREATE TABLE producto (
  ID_Producto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Categoria VARCHAR(50) NOT NULL,
  Unidad_Medida VARCHAR(20) NOT NULL,
  ID_Cultivo INT DEFAULT NULL,
  FOREIGN KEY (ID_Cultivo) REFERENCES cultivo(ID_Cultivo) -- Agregado
);


CREATE TABLE maquinaria (
  ID_Maquinaria INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Tipo VARCHAR(50) NOT NULL,
  Estado VARCHAR(50) NOT NULL,
  Fecha_Adquisicion DATE NOT NULL,
  Costo DECIMAL(10,2) NOT NULL
);


CREATE TABLE mantenimiento (
  ID_Mantenimiento INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Maquinaria INT NOT NULL,
  Descripcion VARCHAR(255) NOT NULL,
  Fecha_Mantenimiento DATE NOT NULL,
  Costo DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (ID_Maquinaria) REFERENCES maquinaria(ID_Maquinaria) ON DELETE CASCADE
);


CREATE TABLE empleado (
  ID_Empleado INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Cargo VARCHAR(50) NOT NULL,
  Fecha_Ingreso DATE NOT NULL,
  Salario DECIMAL(10,2) NOT NULL
);


CREATE TABLE empleado_rol (
  ID_Empleado_rol INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Empleado INT DEFAULT NULL,
  Rol VARCHAR(50) DEFAULT NULL,
  FOREIGN KEY (ID_Empleado) REFERENCES empleado(ID_Empleado)
);


CREATE TABLE proveedor (
  ID_Proveedor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Contacto VARCHAR(100) DEFAULT null,
  Telefono VARCHAR(20) DEFAULT null,
  Correo_Electronico VARCHAR(100) DEFAULT null,
  Direccion VARCHAR(255) NOT NULL
);

CREATE TABLE compra (
  ID_Compra INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Proveedor INT DEFAULT null,
  Fecha_Compra DATE NOT NULL,
  Total_Compra DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (ID_Proveedor) REFERENCES proveedor (ID_Proveedor)
);


CREATE TABLE detalle_compra (
  ID_Detalle_Compra INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Compra INT DEFAULT null,
  ID_Producto INT DEFAULT null,
  Cantidad INT NOT NULL,
  Precio_Compra DECIMAL(10,2) NOT NULL,
  Subtotal DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (ID_Compra) REFERENCES compra(ID_Compra),
  FOREIGN KEY (ID_Producto) REFERENCES producto(ID_Producto)
);


CREATE TABLE cliente (
  ID_Cliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Direccion VARCHAR(255) NOT NULL,
  Telefono VARCHAR(20) DEFAULT null,
  Correo_Electronico VARCHAR(100) DEFAULT null
);

CREATE TABLE venta (
  ID_Venta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Cliente INT DEFAULT null,
  Fecha_Venta DATE NOT NULL,
  Total_Venta DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (ID_Cliente) REFERENCES cliente(ID_Cliente)
);


CREATE TABLE detalle_venta (
  ID_Detalle INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Venta INT DEFAULT null,
  ID_Producto INT DEFAULT null,
  Cantidad INT NOT NULL,
  Precio_Venta DECIMAL(10,2) NOT NULL,
  Subtotal DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (ID_Venta) REFERENCES venta(ID_Venta),
  FOREIGN KEY (ID_Producto) REFERENCES producto(ID_Producto)
);


CREATE TABLE inventario (
  ID_Inventario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Producto INT DEFAULT null,
  Cantidad INT NOT NULL,
  Fecha_Actualizacion DATE NOT NULL,
  FOREIGN KEY (ID_Producto) REFERENCES producto(ID_Producto)
);


CREATE TABLE proceso_produccion (
  ID_Proceso INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Producto INT DEFAULT null,
  ID_Empleado INT DEFAULT null,
  ID_Maquinaria INT DEFAULT null,
  Fecha_Inicio DATE NOT NULL,
  Fecha_Fin DATE DEFAULT null,
  Cantidad_Producida INT NOT NULL,
  FOREIGN KEY (ID_Producto) REFERENCES producto(ID_Producto),
  FOREIGN KEY (ID_Empleado) REFERENCES empleado(ID_Empleado),
  FOREIGN KEY (ID_Maquinaria) REFERENCES maquinaria(ID_Maquinaria)
);


CREATE TABLE proceso_cosecha (
  ID_Proceso_Cosecha INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Proceso INT NOT NULL,
  ID_Cosecha INT NOT NULL,
  FOREIGN KEY (ID_Proceso) REFERENCES proceso_produccion(ID_Proceso),
  FOREIGN KEY (ID_Cosecha) REFERENCES cosecha(ID_Cosecha)
);


CREATE TABLE mantenimiento_proceso (
  ID_Mantenimiento_Proceso INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Mantenimiento INT NOT NULL,
  ID_Proceso INT NOT NULL,
  FOREIGN KEY (ID_Mantenimiento) REFERENCES mantenimiento(ID_Mantenimiento),
  FOREIGN KEY (ID_Proceso) REFERENCES proceso_produccion(ID_Proceso)
);


CREATE TABLE detalle_producto_precio (
  ID_Detalle_Precio INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Producto INT DEFAULT null,
  Precio DECIMAL(10,2) NOT NULL,
  Fecha_Registro DATE NOT NULL,
  FOREIGN KEY (ID_Producto) REFERENCES producto(ID_Producto)
);