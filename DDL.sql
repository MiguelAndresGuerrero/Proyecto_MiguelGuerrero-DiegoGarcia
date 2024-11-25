CREATE database finca_campus;

use finca_campus;

-- drop database finca_campus;

CREATE TABLE cliente (
  ID_Cliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Direccion VARCHAR(255) NOT NULL,
  Telefono VARCHAR(20) DEFAULT null,
  Correo_Electronico VARCHAR(100) DEFAULT null
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
  FOREIGN KEY (ID_Proveedor)
  REFERENCES proveedor (ID_Proveedor));

CREATE TABLE producto (
  ID_Producto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Categoria VARCHAR(50) NOT NULL,
  Unidad_Medida VARCHAR(20) NOT NULL
);

CREATE TABLE detalle_compra (
  ID_Detalle_Compra INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Compra INT DEFAULT null,
  ID_Producto INT DEFAULT null,
  Cantidad INT NOT NULL,
  Precio_Compra DECIMAL(10,2) NOT NULL,
  Subtotal DECIMAL(10,2) NOT NULL,
  foreign key (ID_Compra) references compra(ID_Compra),
  foreign key (ID_Producto) references producto(ID_Producto)
);

CREATE TABLE detalle_producto_precio (
  ID_Detalle_Precio INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Producto INT DEFAULT null,
  Precio DECIMAL(10,2) NOT NULL,
  Fecha_Registro DATE NOT NULL,
  foreign key (ID_Producto) references producto(ID_Producto)
);

CREATE TABLE venta (
  ID_Venta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Cliente INT DEFAULT null,
  Fecha_Venta DATE NOT NULL,
  Total_Venta DECIMAL(10,2) NOT NULL,
  foreign key (ID_Cliente) references cliente(ID_Cliente)
);

CREATE TABLE detalle_venta (
  ID_Detalle INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Venta INT DEFAULT null,
  ID_Producto INT DEFAULT null,
  Cantidad INT NOT NULL,
  Precio_Venta DECIMAL(10,2) NOT NULL,
  Subtotal DECIMAL(10,2) NOT NULL,
  foreign key (ID_Venta) references venta(ID_Venta),
  foreign key (ID_Producto) references producto(ID_Producto)
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
  ID_Empleado INT DEFAULT null,
  Rol VARCHAR(50) DEFAULT null,
  foreign key (ID_Empleado) references empleado(ID_Empleado)
);

CREATE TABLE inventario (
  ID_Inventario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Producto INT DEFAULT null,
  Cantidad INT NOT NULL,
  Fecha_Actualizacion DATE NOT NULL,
  foreign key (ID_Producto) references producto(ID_Producto)
);

CREATE TABLE maquinaria (
  ID_Maquinaria INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Tipo VARCHAR(50) NOT NULL,
  Estado VARCHAR(50) NOT NULL,
  Fecha_Adquisicion DATE NOT NULL,
  Costo DECIMAL(10,2) NOT NULL
);

CREATE TABLE proceso_produccion (
  ID_Proceso INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_Producto INT DEFAULT null,
  ID_Empleado INT DEFAULT null,
  ID_Maquinaria INT DEFAULT null,
  Fecha_Inicio DATE NOT NULL,
  Fecha_Fin DATE DEFAULT null,
  Cantidad_Producida INT NOT NULL,
  foreign key (ID_Producto) references producto(ID_Producto),
  foreign key (ID_Empleado) references empleado(ID_Empleado),
  foreign key (ID_Maquinaria) references maquinaria(ID_Maquinaria)
);


