use finca_campus;

-- actuallizar un nuevo producto de inventario


-- agragar un producto a inventartio 

-- registrar un nuevo cultivo

-- actualizar el estado de un cultivo 

-- registrar gastos de un insumo

-- asignar un trabajador a una tarea espesifica

-- generar detalles de ingresos por cosecha

-- monitorear el de una maquinaria

-- programar un mantenimiento de una maquina 

-- actualizar el precio de un producto
DELIMITER // 
CREATE PROCEDURE actualizar_precio(in ID_Producto int, in cambio_precio decimal(10,2))
begin
	insert into detalle_producto_precio(ID_Producto , Precio)
    value (ID_Producto, cambio_precio);
end
// DELIMITER ;

drop procedure actualizar_precio; 
call actualizar_precio('10' , '10,00');
