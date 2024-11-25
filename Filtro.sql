create database proyecto;

use proyecto;

create table Producto (
	id_producto int primary key auto_increment,
    nombre_producto varchar(150) not null,
    descripcion varchar(300),
    estado_producto varchar(60) not null,
    precio_producto decimal(10,2) not null,
    id_inventario int,
    foreign key (id_inventario) references Inventario(id_inventario)
);

create table Empleado (
	id_empleado int primary key auto_increment,
    nombre varchar(80) not null,
    apellido varchar(80) not null,
    edad int,
    cedula varchar(20) not null unique,
    telefono varchar(20) not null,
    ciudad varchar(100) not null,
    sueldo decimal(10,2) not null,
    id_ventas int,
    id_usuario int,
	foreign key (id_ventas) references Ventas(id_ventas),
    foreign key (id_usuario) references Usuario(id_usuario)
);

create table Maquinaria (
	id_maquinaria int primary key auto_increment,
    nombre varchar(150) not null,
    estado varchar(80) not null,
    descripcion varchar(300) not null,
    id_inventario int,
    foreign key (id_inventario) references Inventario(id_inventario)
);

create table Ventas (
	id_ventas int primary key auto_increment,
    descripcion varchar(300) not null,
    total_pagado decimal(10,2) not null,
    cantidad int not null
);

create table Inventario (
	id_inventario int primary key auto_increment,
    nombre varchar(140) not null,
    descripcion varchar(300) not null,
    cantidad int,
    id_historial int,
    foreign key (id_historial) references Historial(id_historial)
);

create table Proveedor (
	id_proveedor int primary key auto_increment,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    telefono varchar(20) not null,
    cedula varchar(20) not null unique,
    id_usuario int,
    foreign key (id_usuario) references Usuario(id_usuario)
);

create table Cliente (
	id_cliente int primary key auto_increment,
    nombre varchar(80) not null,
    apellido varchar(80) not null,
    telefono varchar(20) not null,
    cedula varchar(20) not null unique,
    id_usuario int, 
    foreign key (id_usuario) references Usuario(id_usuario)
);

create table Herramienta (
	id_herramienta int primary key auto_increment,
    nombre varchar(100) not null,
    estado varchar(60),
    cantidad int,
    id_inventario int,
    foreign key (id_inventario) references Inventario(id_inventario)
);

create table Historial (
	id_historial int primary key auto_increment,
    descripcion varchar(300) not null,
    fecha date not null
);

create table Usuario (
	id_usuario int primary key auto_increment,
    nombre varchar(80) not null,
    contraseña varchar(190) not null
);

create table Cultivos (
	id_cultivos int primary key auto_increment,
    nombre_cultivo varchar(200) not null,
    tipo varchar(80),
    estado_cultivo enum('activo', 'inactivo', 'mantenimiento') not null,
    fecha_siembra date not null,
    fecha_cosecha date not null,
    id_parcela int,
    id_finca int,
    foreign key (id_parcela) references Parcela(id_parcela),
    foreign key (id_finca) references Finca(id_finca)
);

create table Recursos (
	id_recursos int primary key auto_increment,
    nombre varchar(100) not null,
    tipo varchar(80),
    cantidad decimal(10,2),
    unidad varchar(60),
    costo decimal(10,2),
    id_cultivo int,
	foreign key (id_cultivo) references Cultivos(id_cultivo)
);

create table Finca (
	id_finca int primary key auto_increment,
    nombre_finca varchar(100),
    ubicacion varchar(200),
    propietario varchar(100) not null
);

create table Parcela (
	id_parcela int primary key auto_increment,
    nombre_parcela varchar(100),
    tamaño decimal(10,2),
    estado varchar(80),
    id_finca int,
    foreign key (id_finca) references Finca(id_finca)
);
