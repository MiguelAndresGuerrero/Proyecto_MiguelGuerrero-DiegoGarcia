use proyecto;

-- nombre de todos los productos almacenados en inventario 
select producto.Nombre from inventario
inner join producto on producto.ID_Producto = inventario.ID_Producto;

-- detalles de los productos almacenados en el inventario 
select producto.nombre, producto.categoria, detalle_producto_precio.precio, detalle_producto_precio.Fecha_Registro from inventario
inner join producto on producto.ID_Producto = inventario.ID_Producto,
inner join detalle_producto_precio dpp on dpp.ID_Producto = producto.ID_producto;

-- nombre de los clientes jontos con el detalle de la venta y la informacion del producto 


-- lista todas la maquinaria con estado operativo
	

-- listar la maquinaria fuera de sercicio 


-- nombre de los productos cosechados


-- nombre de los empleados que cosecharon pa produccion por fecha 


-- maquinaria imbolucrada en la cosecha	
