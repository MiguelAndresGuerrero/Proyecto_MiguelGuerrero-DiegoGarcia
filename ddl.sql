create database finca_campus;

use finca_campus;

-- Crear tabla Cliente
CREATE TABLE cliente (
  ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Direccion VARCHAR(255),
  Telefono VARCHAR(20) NOT NULL,
  Correo_Electronico VARCHAR(100) UNIQUE
);

-- Crear tabla Proveedor
CREATE TABLE proveedor (
  ID_Proveedor INT PRIMARY KEY AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Contacto VARCHAR(100),
  Telefono VARCHAR(20) NOT NULL UNIQUE,
  Correo_Electronico VARCHAR(100) UNIQUE,
  Direccion VARCHAR(255)
);

-- Crear tabla Empleado
CREATE TABLE empleado (
  ID_Empleado INT PRIMARY KEY AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Cargo VARCHAR(50) NOT NULL,
  Fecha_Ingreso DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Salario DECIMAL(10,2) NOT NULL CHECK(Salario >= 0)
);

-- Crear tabla Maquinaria
CREATE TABLE maquinaria (
  ID_Maquinaria INT PRIMARY KEY AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Tipo VARCHAR(50) NOT NULL,
  Estado ENUM('OPERATIVA', 'REPARACION', 'OBSOLETA') NOT NULL,
  Fecha_Adquisicion DATETIME NOT NULL,
  Costo DECIMAL(10,2) NOT NULL
);

-- Crear tabla Producto
CREATE TABLE producto (
  ID_Producto INT PRIMARY KEY AUTO_INCREMENT,
  Nombre VARCHAR(100) NOT NULL,
  Categoria VARCHAR(50) NOT NULL,
  Unidad_Medida VARCHAR(100) NOT NULL
);


-- Crear tabla Compra
CREATE TABLE compra (
  ID_Compra INT PRIMARY KEY AUTO_INCREMENT,
  ID_Proveedor INT,
  Fecha_Compra DATETIME NOT NULL,
  Total_Compra DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (ID_Proveedor) REFERENCES proveedor(ID_Proveedor)
  );
  
  -- Crear tabla Detalles de compra
CREATE TABLE detalle_compra (
  ID_Detalle_Compra INT PRIMARY KEY AUTO_INCREMENT,
  ID_Compra INT,
  ID_Producto INT,
  Cantidad INT NOT NULL,
  Precio_Compra DECIMAL(10,2) NOT NULL CHECK(Precio_Compra >= 0),
  foreign key (ID_Compra) references compra(ID_Compra),
  foreign key (ID_Producto) references producto(ID_Producto)
);


-- Crear tabla Detalles de Precio del Producto
CREATE TABLE detalle_producto_precio (
  ID_Detalle_Precio INT PRIMARY KEY AUTO_INCREMENT,
  ID_Producto INT,
  Precio DECIMAL(10,2) NOT NULL CHECK(Precio >= 0),
  Fecha_Registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  foreign key (ID_Producto) references producto(ID_Producto)
);


-- Crear tabla Venta
CREATE TABLE venta (
  ID_Venta INT PRIMARY KEY AUTO_INCREMENT,
  ID_Cliente INT,
  Fecha_Venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Total_Venta DECIMAL(10,2) NOT NULL CHECK(Total_Venta >= 0),
  foreign key (ID_Cliente) references cliente(ID_Cliente)
);

-- Crear tabla Detalles de Venta
CREATE TABLE detalle_venta (
  ID_Detalle INT PRIMARY KEY AUTO_INCREMENT,
  ID_Venta INT,
  ID_Producto INT,
  Cantidad INT NOT NULL CHECK(Cantidad > 0),
  Precio_Venta DECIMAL(10,2) NOT NULL CHECK(Precio_Venta >= 0),
  foreign key (ID_Venta) references venta(ID_Venta),
  foreign key (ID_Producto) references producto(ID_Producto)
);

-- Crear tabla Emplado Rol
CREATE TABLE empleado_rol (
  ID_Empleado_rol INT PRIMARY KEY AUTO_INCREMENT,
  ID_Empleado INT,
  Rol ENUM('ADMIN', 'SUPERVISOR', 'OPERADOR', 'EMPLEADO', 'PROVEEDOR') NOT NULL,
  foreign key (ID_Empleado) references empleado(ID_Empleado)
);

-- Crear tabla Inventario
CREATE TABLE inventario (
  ID_Inventario INT PRIMARY KEY AUTO_INCREMENT,
  ID_Producto INT,
  Cantidad INT NOT NULL CHECK(Cantidad >= 0),
  Fecha_Actualizacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  foreign key (ID_Producto) references producto(ID_Producto)
);

-- Crear tabla Proceso de Produccion
CREATE TABLE proceso_produccion (
  ID_Proceso_produccion INT PRIMARY KEY AUTO_INCREMENT,
  ID_Producto INT,
  ID_Empleado INT,
  ID_Maquinaria INT,
  Fecha_Inicio DATETIME NOT NULL,
  Fecha_Fin DATETIME,
  Cantidad_Producida INT NOT NULL CHECK(Cantidad_Producida >= 0),
  foreign key (ID_Producto) references producto(ID_Producto),
  foreign key (ID_Empleado) references empleado(ID_Empleado),
  foreign key (ID_Maquinaria) references maquinaria(ID_Maquinaria)
);

-- Mostrar todas las tablas en la base de datos finca_campus
SHOW TABLES FROM finca_campus;