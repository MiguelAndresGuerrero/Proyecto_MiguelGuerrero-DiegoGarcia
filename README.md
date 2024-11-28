# PROYECTO_Finca_Campus

## Descripción del Proyecto

Este proyecto tiene como objetivo el diseño e implementación de un **sistema de base de datos (DDBB)** para la **Finca Campuslands**, con el fin de mejorar la eficiencia y sostenibilidad de los procesos operativos. Actualmente, la finca enfrenta dificultades en la gestión de sus operaciones, lo que afecta la toma de decisiones y el seguimiento adecuado de los recursos y productos agrícolas. El sistema propuesto facilitará el almacenamiento y la consulta eficiente de la información relevante.

---

## Requisitos del Sistema

- **MySQL Installer** versión 8.0.40
- **MySQL Workbench** (para la gestión visual de la base de datos)

---

## Instalación y Configuración

1. **Crear la base de datos**  
   Ejecuta el archivo `ddl.sql` para crear la estructura de la base de datos.

2. **Cargar datos iniciales**  
   Ejecuta el archivo `dml.sql` para insertar los datos iniciales en las tablas.

3. **Ejecutar consultas**  
   Utiliza los archivos `dql_select.sql`, `dql_procedimientos.sql`, `dql_funciones.sql`, `dql_triggers.sql` para ejecutar los procedimientos, funciones y triggers que se han creado.

---

## Estructura de la Base de Datos

La base de datos está organizada en las siguientes tablas clave:

### 1. **Cliente**
   - Almacena información de los clientes (nombre, apellido, dirección, teléfono, correo electrónico).

### 2. **Proveedor**
   - Contiene datos de los proveedores (nombre, contacto, teléfono, correo electrónico, dirección).

### 3. **Empleado**
   - Registra a los empleados (nombre, apellido, cargo, fecha de ingreso, salario).

### 4. **Maquinaria**
   - Almacena datos sobre la maquinaria (nombre, tipo, estado, fecha de adquisición, costo).

### 5. **Producto**
   - Contiene información sobre los productos agrícolas (nombre, categoría, unidad de medida).

### 6. **Compra**
   - Registra las compras realizadas a proveedores (proveedor, fecha de compra, total).

### 7. **Detalle Compra**
   - Desglosa las compras en productos específicos (cantidad y precio de compra).

### 8. **Detalle Producto Precio**
   - Guarda el historial de precios de los productos (fecha y precio de venta).

### 9. **Venta**
   - Registra las ventas realizadas a clientes (fecha y total de la venta).

### 10. **Detalle Venta**
   - Desglosa las ventas en productos específicos (cantidad y precio de cada producto).

### 11. **Empleado Rol**
   - Define los roles de los empleados (administrador, supervisor, operador, etc.).

### 12. **Inventario**
   - Registra la cantidad de productos disponibles y la fecha de la última actualización.

### 13. **Proceso Producción**
   - Lleva control de los procesos de producción (producto, empleado responsable, maquinaria utilizada, fechas y cantidad producida).

---

## Ejemplos de Consultas

**Estado actual del inventario**

```sql
SELECT p.Nombre, i.Cantidad 
FROM producto p 
JOIN inventario i ON p.ID_Producto = i.ID_Producto;

-- Productos con bajo stock (menos de 100 unidades)
SELECT p.Nombre, i.Cantidad 
FROM producto p 
JOIN inventario i ON p.ID_Producto = i.ID_Producto 
WHERE i.Cantidad < 100;

-- Total de inventario de cada producto
SELECT p.Nombre, SUM(i.Cantidad) AS TotalInventario 
FROM producto p 
JOIN inventario i ON p.ID_Producto = i.ID_Producto 
GROUP BY p.ID_Producto;

-- Valor total del inventario
SELECT SUM(i.Cantidad * dpp.Precio) AS ValorTotalInventario 
FROM inventario i 
JOIN detalle_producto_precio dpp ON i.ID_Producto = dpp.ID_Producto 
WHERE dpp.Fecha_Registro = (SELECT MAX(Fecha_Registro) FROM detalle_producto_precio);
```
## Otras consultas que se encuentra en los documentos son

Además de las consultas anteriores, se han incluido las siguientes funcionalidades:

- Subconsultas

- Procedimientos
- Funciones
- Triggers
- Roles de Usuario y Permisos

## Roles de Usuario y Permisos

**AdminUser**: Puede realizar todas las acciones en el sistema.
**vendedorUser**: Accede a información básica y puede actualizar e insertar datos en las tablas venta, inventario, y cliente.
**contadorUser**: Acceso a informes financieros y registros de detalles financieros.
**empleadoUser**: Acceso a su propia información en la tabla empleado.
**proveedorUser**: Puede acceder e insertar datos en la tabla producto.

## Contribuciones

- Miguel Andres Guerrero Martinez 


- Diego Alexander Garcia Rodriguez


## Contacto

Para cualquier consulta sobre el proyecto, por favor contacta a:

Correo: dgarciarodriguez370@gmail.com

Correo: Guerreromiguelmartinez@gmail.com

sql
tu-repositorio

    ├── ddl.sql                     # Creación de las tablas y la base de datos
    ├── dml.sql                     # Inserción de datos iniciales
    ├── Roles_Usuario_Permisos.sql  # Creacion de roles de usuarios y permisos
    ├── consultas
    │   ├── dql_select.sql          # Consultas select
    │   ├── dql_procedimientos.sql  # Procedimientos almacenados
    │   ├── dql_funciones.sql       # Funciones
    │   ├── dql_triggers.sql        # Triggers
    ├── README.md                   # Este archivo
    ├── diagramaER.jpg              # Diagrama de Entidad-Relación
