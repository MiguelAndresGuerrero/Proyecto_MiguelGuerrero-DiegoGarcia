use finca_campus;

-- inserciones de la tabla de clientes
INSERT INTO cliente (Nombre, Apellido, Direccion, Telefono, Correo_Electronico) VALUES
('Carlos', 'Pérez', 'Calle 1', '123456789', 'carlos.perez@example.com'),
('Maria', 'Gonzalez', 'Calle 2', '234567890', 'maria.gonzalez@example.com'),
('Jose', 'Martinez', 'Calle 3', '345678901', 'jose.martinez@example.com'),
('Ana', 'Lopez', 'Calle 4', '456789012', 'ana.lopez@example.com'),
('Luis', 'Hernandez', 'Calle 5', '567890123', 'luis.hernandez@example.com'),
('Sofia', 'Castro', 'Calle 6', '678901234', 'sofia.castro@example.com'),
('Fernando', 'Alvarez', 'Calle 7', '789012345', 'fernando.alvarez@example.com'),
('Paola', 'Jimenez', 'Calle 8', '890123456', 'paola.jimenez@example.com'),
('Juan', 'Ramirez', 'Calle 9', '901234567', 'juan.ramirez@example.com'),
('Mariana', 'Torres', 'Calle 10', '0123456789', 'mariana.torres@example.com'),
('Pedro', 'Ceballos', 'Calle 11', '1122334466', 'pedro.ceballos@example.com'),
('Laura', 'Paredes', 'Calle 12', '2233445577', 'laura.paredes@example.com'),
('Hugo', 'Mendoza', 'Calle 13', '3344556688', 'hugo.mendoza@example.com'),
('Elena', 'Guerrero', 'Calle 14', '4455667799', 'elena.guerrero@example.com'),
('Alberto', 'Marquez', 'Calle 15', '5566778800', 'alberto.marquez@example.com'),
('Isabel', 'Rojas', 'Calle 16', '6677889901', 'isabel.rojas@example.com'),
('Diego', 'Salazar', 'Calle 17', '7788990012', 'diego.salazar@example.com'),
('Valeria', 'Beltran', 'Calle 18', '8899001123', 'valeria.beltran@example.com'),
('Cynthia', 'Ortega', 'Calle 19', '9900112234', 'cynthia.ortega@example.com'),
('Andres', 'Soto', 'Calle 20', '1011122235', 'andres.soto@example.com'),
('Ricardo', 'Cano', 'Calle 21', '2122233346', 'ricardo.cano@example.com'),
('Nathalia', 'Sierra', 'Calle 22', '3233344457', 'nathalia.sierra@example.com'),
('Valentina', 'Pinto', 'Calle 23', '4344455568', 'valentina.pinto@example.com'),
('Emilio', 'Castillo', 'Calle 24', '5455566679', 'emilio.castillo@example.com'),
('Andrea', 'Gálvez', 'Calle 25', '6566677780', 'andrea.galvez@example.com'),
('Alison', 'Villalobos', 'Calle 26', '7678788891', 'alison.villalobos@example.com'),
('Cristian', 'Haro', 'Calle 27', '8789899902', 'cristian.haro@example.com'),
('Patricia', 'Ruiz', 'Calle 28', '9890910013', 'patricia.ruiz@example.com'),
('Gabriel', 'Vásquez', 'Calle 29', '0902011124', 'gabriel.vasquez@example.com'),
('Diana', 'Cortés', 'Calle 30', '1012112235', 'diana.cortes@example.com'),
('Salvador', 'Urbina', 'Calle 31', '2123223346', 'salvador.urbina@example.com'),
('Viviana', 'Sánchez', 'Calle 32', '3234334457', 'viviana.sanchez@example.com'),
('Alvaro', 'Salas', 'Calle 33', '4345445568', 'alvaro.salas@example.com'),
('Martha', 'Cabrera', 'Calle 34', '5456556679', 'martha.cabrera@example.com'),
('Oscar', 'Contreras', 'Calle 35', '6567767780', 'oscar.contreras@example.com'),
('Juliana', 'Medina', 'Calle 36', '7678878891', 'juliana.medina@example.com'),
('Mauricio', 'Ramajo', 'Calle 37', '8789889902', 'mauricio.ramajo@example.com'),
('Luisa', 'Cortez', 'Calle 38', '9890901013', 'luisa.cortez@example.com'),
('Esteban', 'Ocampo', 'Calle 39', '0902012134', 'esteban.ocampo@example.com'),
('Carolina', 'Rivas', 'Calle 40', '1013112235', 'carolina.rivas@example.com');

-- inserciones de la tabla de proveedores
INSERT INTO proveedor (Nombre, Contacto, Telefono, Correo_Electronico, Direccion) VALUES
('Insumos Agrícolas S.A.', 'Luis Torres', '345678901', 'luis.torres@insumosagricolas.com', 'Av. Principal 1'),
('Fertilizantes Naturales Ltda.', 'Ana Smith', '456789012', 'ana.smith@fertilizantesnaturales.com', 'Av. Central 2'),
('Maquinaria Agroindustrial', 'Juan Carlos', '567890123', 'juancarlos@maquinariaagroindustrial.com', 'Calle 1'),
('Semillas de Cacao Orgánico', 'Patricia Ruiz', '678901234', 'patricia.ruiz@semillasorganicas.com', 'Calle 2'),
('Herramientas y Más', 'Fernando Martínez', '789012345', 'fernando.m@herramientasymas.com', 'Av. las Margaritas 3'),
('Proveedores de Cacao S.A.', 'Fernando Alvarado', '890123456', 'fernando@proveedoresdecacao.com', 'Calle 25'),
('Cacao y Insumos Agropecuarios', 'Juliana Gómez', '901234567', 'juliana.gomez@cacaoyinsumos.com', 'Calle 3'),
('Fertiliza Cacao', 'Emilio Serrano', '312345678', 'emilio@fertilizacao.com', 'Calle 4'),
('Distribuidores de Insumos', 'Rosa Castro', '423456789', 'rosa.castro@distribuidoresinsumos.com', 'Av. de los Tilos 5'),
('Tierra Fértil', 'Lucas Méndez', '534567890', 'lucas.mendez@tierrafertil.com', 'Calle 6'),
('Fertilizantes Verdes', 'Camila Rodríguez', '645678901', 'camila.rodriguez@fertilizantesverdes.com', 'Calle 7'),
('Maquinaria del Agro', 'Alberto Torres', '756789012', 'alberto.torres@maquinariadelagro.com', 'Calle 8'),
('Productos Orgánicos S.A.', 'Silvia Valenzuela', '867890123', 'silvia.valenzuela@productosorganicos.com', 'Calle 9'),
('Cacao y Sostenibilidad', 'Natalia Pizarro', '978901234', 'natalia.pizarro@cacaoysostenibilidad.com', 'Calle 10'),
('Cacao y Fertilizantes', 'Esteban Morales', '789012348', 'esteban.morales@cacaoyfertilizantes.com', 'Calle 11'),
('Suministros Agrícolas', 'Oscar Villalobos', '190123457', 'oscar.villalobos@suministrosagricolas.com', 'Calle 12'),
('Sesbio Cacao', 'Mónica Ruiz', '210234568', 'monica.ruiz@sesbiocacao.com', 'Calle 13'),
('Maquinarias Cacaoteras', 'Leonardo Pineda', '321345679', 'leonardo.pineda@maquinariascacaoteras.com', 'Calle 14'),
('Insumos Ecoagricultura', 'Verónica Muñoz', '432456780', 'veronica.munoz@insumosecoagricultura.com', 'Calle 15'),
('Cacao en Abundancia', 'Diego Salas', '543567891', 'diego.salas@cacaoenabundancia.com', 'Calle 16'),
('Fertilizantes Agrícolas', 'Alma Quintero', '654678902', 'alma.quintero@fertilizantesagricolas.com', 'Calle 17'),
('Agroinsumos del Valle', 'Giovanni Martínez', '765789013', 'giovanni.martinez@agroinsumosdelvalle.com', 'Calle 18'),
('Suelo Rico', 'Valeria Jiménez', '876890124', 'valeria.jimenez@suelorico.com', 'Calle 19'),
('Mundo Cacao', 'Santiago Alarcón', '987901235', 'santiago.alarcon@mundo-cacao.com', 'Calle 20'),
('Minerales y Cacao', 'Adela Pinilla', '098012346', 'adela.pinilla@mineralesycacao.com', 'Calle 21'),
('Insumos Cacaoteros', 'Héctor Barrera', '109123457', 'hector.barrera@insumos-cacaoteros.com', 'Calle 22'),
('Cacao y Salud', 'Pablo Rivera', '210234569', 'pablo.rivera@cacaoysalud.com', 'Calle 23'),
('Cacao Tierra Mejorada', 'Jessica Pacheco', '321345680', 'jessica.pacheco@cacaotierra-mejorada.com', 'Calle 24'),
('Cacao y Sostenibilidad', 'Ricardo Gómez', '432456781', 'ricardo.gomez@cacaoysostenibilidad.com', 'Calle 25'),
('Agroproyectos S.A.', 'Franco Salazar', '543567892', 'franco.salazar@agroproyectos.com', 'Calle 26'),
('Fármaco Cacao', 'Maura Camaño', '654678903', 'maura.camano@farmacacao.com', 'Calle 27'),
('Desde las Raíces', 'Milena Vargas', '765789014', 'milena.vargas@desdelasraices.com', 'Calle 28'),
('Cacao y Maquinaria', 'Alfredo Vázquez', '876890125', 'alfredo.vazquez@cacaoymaquinaria.com', 'Calle 29'),
('Agroinsumos y Fertilidad', 'Rocío Rodríguez', '987901236', 'rocio.rodriguez@agroinsumosfertilidad.com', 'Calle 30'),
('Suministros para Cacaotales', 'David Sota', '098012347', 'david.sota@suministros-cacaotales.com', 'Calle 31'),
('Ecología y Cacao', 'Gustavo Londoño', '109123458', 'gustavo.londono@ecologiaycacao.com', 'Calle 32'),
('Nutrición de Cacao', 'Flavia Arteaga', '210234570', 'flavia.arteaga@nutriciondecacao.com', 'Calle 33'),
('Cacao y Desarrollo', 'Mario Guzmán', '321345681', 'mario.guzman@cacaoydesarrollo.com', 'Calle 34'),
('Cacao y Cultivos', 'Elsa Navarrete', '432456782', 'elsa.navarrete@cacaoycultivos.com', 'Calle 35'),
('Sólidos de Cacao', 'Ignacio Ospina', '543567893', 'ignacio.ospina@solidosdecacao.com', 'Calle 36'),
('Cacao y Cultivos Saludables', 'Lina Escobar', '654678904', 'lina.escobar@cacaoycultivossaludables.com', 'Calle 37'),
('Frutos del Cacao', 'Samuel Melendez', '765789015', 'samuel.melendez@frutosdelcacao.com', 'Calle 38'),
('Materias Primas Sostenibles', 'Mauricio Salgado', '876890126', 'mauricio.salgado@materiasprimasostenibles.com', 'Calle 39'),
('Cacao Resplandor', 'Diana Requena', '987901237', 'diana.requena@cacaoresplandor.com', 'Calle 40'),
('Asesorías Cacaoteras', 'Gabriel Meza', '098012348', 'gabriel.meza@asesoriacacaotera.com', 'Calle 41');

-- inserciones de la tabala de empleado
INSERT INTO empleado (Nombre, Apellido, Cargo, Salario) VALUES
('Pedro', 'Lopez', 'Gerente', 1500.00),
('Luisa', 'Martinez', 'Supervisor', 1200.00),
('Carlos', 'Pérez', 'Operador de Cosecha', 1100.00),
('María', 'Gonzalez', 'Agrónomo', 1300.00),
('José', 'Martinez', 'Técnico de Cacao', 1250.00),
('Ana', 'Lopez', 'Asistente Administrativo', 950.00),
('Luis', 'Hernandez', 'Operador', 800.00),
('Sofia', 'Castro', 'Operaria', 800.00),
('Fernando', 'Alvarez', 'Contador', 1400.00),
('Paola', 'Jimenez', 'Supervisor', 1150.00),
('Juan', 'Ramirez', 'Jefe de Cultivo', 1100.00),
('Mariana', 'Torres', 'Supervisor de Campo', 1200.00),
('Pedro', 'Ceballos', 'Operador', 900.00),
('Laura', 'Paredes', 'Encargada de Logística', 1000.00),
('Hugo', 'Mendoza', 'Operador de Cosecha', 1350.00),
('Elena', 'Guerrero', 'Técnico de Fertilización', 1200.00),
('Alberto', 'Marquez', 'Encargado de Seguridad', 950.00),
('Isabel', 'Rojas', 'Jefa de Recursos Humanos', 1300.00),
('Diego', 'Salazar', 'Operador', 1400.00),
('Valeria', 'Beltran', 'Observadora de Calidad', 850.00),
('Cynthia', 'Ortega', 'Asistente', 800.00),
('Andres', 'Soto', 'Operador de Maquinaria', 900.00),
('Ricardo', 'Cano', 'Coordinador de Embarque', 1000.00),
('Nathalia', 'Sierra', 'Operador', 950.00),
('Valentina', 'Pinto', 'Asistente Técnico', 800.00),
('Emilio', 'Castillo', 'Transportista', 700.00),
('Andrea', 'Gálvez', 'Asistente', 750.00),
('Alison', 'Villalobos', 'Secretaria', 850.00),
('Cristian', 'Haro', 'Operador de Proyectos', 1100.00),
('Patricia', 'Ruiz', 'Cosechadora', 650.00),
('Gabriel', 'Vásquez', 'Cocinero', 800.00),
('Diana', 'Cortés', 'Recepcionista', 750.00),
('Salvador', 'Urbina', 'Operador de Riego', 900.00),
('Viviana', 'Sánchez', 'Asistente de Supervisión', 800.00),
('Alvaro', 'Salas', 'Operador', 850.00),
('Martha', 'Cabrera', 'Agricultora', 700.00),
('Oscar', 'Contreras', 'Logística de Cosecha', 950.00),
('Juliana', 'Medina', 'Marketero', 1000.00),
('Mauricio', 'Ramajo', 'Planificador', 1200.00),
('Luisa', 'Cortez', 'Control de Calidad', 950.00),
('Esteban', 'Ocampo', 'Operario General', 700.00),
('Carolina', 'Rivas', 'Recepcionista', 800.00),
('Estefania', 'Taboada', 'Encargada de Recursos', 900.00),
('Felipe', 'Figueroa', 'Ayudante de Cultivo', 650.00),
('Camila', 'Castañeda', 'Supervisor', 1100.00),
('Rafael', 'Ballesteros', 'Asistente', 1150.00),
('Julián', 'Duran', 'Gerente de Mantenimiento', 1300.00),
('Silvia', 'Morales', 'Analista de Mercadeo', 900.00),
('Marcos', 'Gonzalo', 'Distribuidor de Producto', 800.00),
('Nora', 'Pinto', 'Operador de Transporte', 700.00),
('Ariel', 'Montes', 'Instructor de Prácticas', 800.00),
('Fabiola', 'Echeverria', 'Desarrolladora', 1250.00);

-- inserciones de la tabla maquinaria
INSERT INTO maquinaria (Nombre, Tipo, Estado, Fecha_Adquisicion, Costo) VALUES
('Tractor Cacao', 'Tractor', 'OPERATIVA', '2020-01-10', 15000.00),
('Cosechadora Cacao', 'Cosechadora', 'OPERATIVA', '2019-06-15', 12000.00),
('Pulverizador de Fertilizantes', 'Pulverizador', 'OPERATIVA', '2021-03-20', 7500.00),
('Desbrozadora', 'Desbrozadora', 'REPARACION', '2018-11-05', 3000.00),
('Compactador de Suelo', 'Compactador', 'OPERATIVA', '2022-07-18', 6000.00),
('Mezcladora de Fertilizantes', 'Mezcladora', 'OBSOLETA', '2015-02-22', 2000.00),
('Cosechadora Manual', 'Manual', 'OPERATIVA', '2020-08-30', 1200.00),
('Picadora de Forraje', 'Picadora', 'OPERATIVA', '2021-12-12', 2200.00),
('Sembradora', 'Sembradora', 'OPERATIVA', '2019-03-05', 4000.00),
('Carretilla', 'Manual', 'OPERATIVA', '2017-04-18', 150.00),
('Bomba de Agua', 'Bomba', 'OBSOLETA', '2016-09-10', 800.00),
('Cortadora de Cacao', 'Cortadora', 'OPERATIVA', '2021-11-01', 3500.00),
('Tractores de Arrastre', 'Tractor', 'REPARACION', '2020-05-07', 14000.00),
('Arado', 'Arado', 'OPERATIVA', '2019-01-14', 2500.00),
('Transpaleta', 'Manual', 'OPERATIVA', '2020-10-22', 900.00),
('Carro de Cosecha', 'Carro', 'OPERATIVA', '2018-12-05', 3000.00),
('Cisternas de Agua', 'Cisterna', 'OPERATIVA', '2022-06-15', 5000.00),
('Desmalezadora', 'Desmalezadora', 'OPERATIVA', '2021-07-10', 2800.00),
('Carretón de Transporte', 'Carretón', 'REPARACION', '2020-04-19', 700.00),
('Motoniveladora', 'Motoniveladora', 'OPERATIVA', '2019-09-25', 16000.00),
('Tractor Frontal', 'Tractor', 'OBSOLETA', '2015-10-30', 13000.00),
('Tijeras de Cosecha', 'Manual', 'OPERATIVA', '2018-07-21', 100.00),
('Autobomba', 'Bomba', 'REPARACION', '2016-11-15', 1200.00),
('Rodillo Compactador', 'Rodillo', 'OBSOLETA', '2014-08-12', 5000.00),
('Tanque de Abono', 'Tanque', 'OPERATIVA', '2021-01-01', 4500.00),
('Borradora de Cacao', 'Borradora', 'OPERATIVA', '2022-04-04', 1000.00),
('Escarificador', 'Escarificador', 'REPARACION', '2017-12-30', 1700.00),
('Pala Excavadora', 'Excavadora', 'OPERATIVA', '2020-02-11', 8500.00),
('Trituradora de Residuos', 'Trituradora', 'OPERATIVA', '2021-05-20', 3600.00),
('Generador Eléctrico', 'Generador', 'OBSOLETA', '2016-03-14', 1500.00),
('Poda de Árbore', 'Poda', 'OPERATIVA', '2019-05-05', 800.00),
('Contenedor de Fertilizante', 'Contenedor', 'OPERATIVA', '2022-03-03', 1200.00),
('Aspersor de Agua', 'Aspersor', 'OPERATIVA', '2021-02-22', 500.00),
('Carreta de Transporte', 'Carreta', 'REPARACION', '2019-11-09', 1500.00),
('Laminadora', 'Laminadora', 'OPERATIVA', '2020-09-16', 2500.00),
('Tanque de Compost', 'Tanque', 'OPERATIVA', '2021-05-30', 2000.00),
('Excavadora de Suelo', 'Excavadora', 'OPERATIVA', '2022-06-25', 20000.00),
('Asador de Cacao', 'Asador', 'OPERATIVA', '2020-12-12', 3000.00),
('Transportador', 'Transportador', 'OPERATIVA', '2021-01-30', 7000.00),
('Carro de Recolección', 'Carro', 'OBSOLETA', '2015-04-15', 4000.00),
('Compuerta de Riego', 'Riego', 'OPERATIVA', '2022-08-12', 600.00),
('Horma de Cacao', 'Horma', 'OPERATIVA', '2021-11-18', 1500.00),
('Mini-tractor', 'Tractor', 'OPERATIVA', '2021-09-14', 9500.00),
('Aspersor de Fertilizante', 'Aspersor', 'REPARACION', '2019-06-10', 1800.00),
('Montacargas', 'Montacargas', 'OBSOLETA', '2014-10-20', 12000.00),
('Caballete de Riego', 'Caballete', 'OPERATIVA', '2020-09-01', 800.00),
('Balanza de Cosecha', 'Balanza', 'OPERATIVA', '2021-05-02', 1500.00),
('Sistema de Riego', 'Sistema', 'OPERATIVA', '2022-07-05', 5000.00);

-- inserciones de la tabala 
INSERT INTO producto (Nombre, Categoria, Unidad_Medida) VALUES
('Cacao en grano', 'Cacao', 'Kilogramo'),
('Cacao en polvo', 'Cacao', 'Kilogramo'),
('Manteca de cacao', 'Cacao', 'Kilogramo'),
('Licor de cacao', 'Cacao', 'Kilogramo'),
('Granos de cacao fermentados', 'Cacao', 'Kilogramo'),
('Granos de cacao secos', 'Cacao', 'Kilogramo'),
('Cáscara de cacao', 'Cacao', 'Kilogramo'),
('Semilla de cacao', 'Cacao', 'Kilogramo'),
('Miel de cacao', 'Subproducto', 'Litro'),
('Cacao orgánico', 'Cacao', 'Kilogramo'),
('Chocolate oscuro', 'Productos terminados', 'Barra'),
('Chocolate con leche', 'Productos terminados', 'Barra'),
('Chocolate blanco', 'Productos terminados', 'Barra'),
('Barras de cacao crudo', 'Productos terminados', 'Unidad'),
('Cacao en pasta', 'Cacao', 'Kilogramo'),
('Cacao en grano tostado', 'Cacao', 'Kilogramo'),
('Cacao en polvo orgánico', 'Cacao', 'Kilogramo'),
('Cocoa butter', 'Subproducto', 'Kilogramo'),
('Polvo de cacao orgánico', 'Cacao', 'Kilogramo'),
('Cacao fino de aroma', 'Cacao', 'Kilogramo'),
('Cacao nacional', 'Cacao', 'Kilogramo'),
('Cacao en tabletas', 'Productos terminados', 'Unidad'),
('Cacao en cápsulas', 'Productos terminados', 'Unidad'),
('Semillas de cacao fermentadas', 'Cacao', 'Kilogramo'),
('Cacao en crema', 'Productos terminados', 'Frasco'),
('Cacao liofilizado', 'Cacao', 'Kilogramo'),
('Cacao sin azúcar', 'Cacao', 'Kilogramo'),
('Chocolate gourmet', 'Productos terminados', 'Unidad'),
('Cacao para repostería', 'Cacao', 'Kilogramo'),
('Granos de cacao para tostado', 'Cacao', 'Kilogramo'),
('Granos de cacao frescos', 'Cacao', 'Kilogramo'),
('Cacao para bebidas', 'Cacao', 'Kilogramo'),
('Granos de cacao deshidratados', 'Cacao', 'Kilogramo'),
('Chocolate para fondue', 'Productos terminados', 'Unidad'),
('Cacao aromatizado', 'Cacao', 'Kilogramo'),
('Cacao en tabletas rellenas', 'Productos terminados', 'Unidad'),
('Chocolate blanco relleno', 'Productos terminados', 'Unidad'),
('Cacao dulce', 'Cacao', 'Kilogramo'),
('Cacao sin gluten', 'Cacao', 'Kilogramo'),
('Chocolate con relleno de cacao', 'Productos terminados', 'Unidad'),
('Cacao ecológico', 'Cacao', 'Kilogramo'),
('Bebida de cacao', 'Bebidas', 'Litro'),
('Cacao en polvo para bebidas', 'Cacao', 'Kilogramo'),
('Cocoa en polvo', 'Cacao', 'Kilogramo'),
('Cacao de comercio justo', 'Cacao', 'Kilogramo'),
('Granos de cacao tostado', 'Cacao', 'Kilogramo'),
('Pasta de cacao sin azúcar', 'Cacao', 'Kilogramo'),
('Cacao en barra con almendras', 'Productos terminados', 'Unidad'),
('Cocoa orgánico en polvo', 'Cacao', 'Kilogramo'),
('Cacao de calidad superior', 'Cacao', 'Kilogramo'),
('Cáscaras de cacao para compostaje', 'Subproducto', 'Kilogramo'),
('Chocolate artesanal', 'Productos terminados', 'Unidad'),
('Cacao en polvo instantáneo', 'Cacao', 'Kilogramo'),
('Cacao sin procesar', 'Cacao', 'Kilogramo'),
('Cacao para relleno de bombones', 'Cacao', 'Kilogramo'),
('Cacao de alta pureza', 'Cacao', 'Kilogramo');
    
-- inserciones de la tabla compra
INSERT INTO compra (ID_Proveedor, Total_Compra, Fecha_Compra) VALUES
(1, 5000.00, '2024-01-15 10:00:00'),
(2, 3500.00, '2024-01-16 11:15:00'),
(3, 1200.00, '2024-01-17 12:30:00'),
(4, 4500.00, '2024-01-18 13:45:00'),
(5, 3000.00, '2024-01-19 14:00:00'),
(6, 2400.00, '2024-01-20 09:30:00'),
(7, 5000.00, '2024-01-21 08:30:00'),
(8, 3700.00, '2024-01-22 10:00:00'),
(9, 5500.00, '2024-01-23 11:00:00'),
(10, 2900.00, '2024-01-24 14:00:00'),
(11, 4000.00, '2024-01-25 10:30:00'),
(12, 3200.00, '2024-01-26 09:15:00'),
(13, 2600.00, '2024-01-27 15:00:00'),
(14, 4800.00, '2024-01-28 16:00:00'),
(15, 4100.00, '2024-01-29 12:00:00'),
(16, 5400.00, '2024-01-30 11:30:00'),
(17, 2800.00, '2024-02-01 10:00:00'),
(18, 3000.00, '2024-02-02 08:30:00'),
(19, 6000.00, '2024-02-03 13:00:00'),
(20, 4500.00, '2024-02-04 10:00:00'),
(21, 3800.00, '2024-02-05 11:45:00'),
(22, 2900.00, '2024-02-06 14:30:00'),
(23, 3300.00, '2024-02-07 13:00:00'),
(24, 4600.00, '2024-02-08 12:15:00'),
(25, 5200.00, '2024-02-09 09:00:00'),
(26, 4500.00, '2024-02-10 10:45:00'),
(27, 3700.00, '2024-02-11 14:30:00'),
(28, 3000.00, '2024-02-12 11:00:00'),
(29, 4400.00, '2024-02-13 13:15:00'),
(30, 5200.00, '2024-02-14 09:30:00'),
(31, 4700.00, '2024-02-15 15:00:00'),
(32, 4100.00, '2024-02-16 10:00:00'),
(33, 3800.00, '2024-02-17 11:30:00'),
(34, 5000.00, '2024-02-18 12:00:00'),
(35, 3600.00, '2024-02-19 10:15:00'),
(36, 5300.00, '2024-02-20 08:45:00'),
(37, 4300.00, '2024-02-21 09:30:00'),
(38, 3900.00, '2024-02-22 14:00:00'),
(39, 5500.00, '2024-02-23 10:15:00'),
(40, 3800.00, '2024-02-24 12:45:00'),
(41, 5100.00, '2024-02-25 15:00:00'),
(42, 4200.00, '2024-02-26 11:30:00'),
(43, 3100.00, '2024-02-27 14:30:00'),
(44, 4800.00, '2024-02-28 16:00:00'),
(45, 4700.00, '2024-03-01 13:00:00');
    
-- inserciones de la tabla detalles de compra
INSERT INTO detalle_compra (ID_Compra, ID_Producto, Cantidad, Precio_Compra)
VALUES
(46, 1, 100, 20.00),
(47, 2, 50, 35.00),
(48, 3, 75, 40.00),
(49, 4, 40, 55.00),
(50, 5, 200, 15.00),
(51, 6, 120, 30.00),
(52, 7, 80, 25.00),
(53, 8, 150, 22.00),
(54, 9, 100, 50.00),
(55, 10, 250, 10.00),
(56, 11, 60, 45.00),
(57, 12, 100, 40.00),
(58, 13, 120, 38.00),
(59, 14, 90, 60.00),
(60, 15, 80, 70.00),
(61, 16, 200, 18.00),
(62, 17, 110, 28.00),
(63, 18, 140, 75.00),
(64, 19, 250, 12.00),
(65, 20, 180, 20.00),
(66, 21, 100, 25.00),
(67, 22, 130, 70.00),
(68, 23, 75, 90.00),
(69, 24, 150, 22.00),
(70, 25, 110, 30.00),
(71, 26, 200, 15.00),
(72, 27, 160, 20.00),
(73, 28, 100, 65.00),
(74, 29, 130, 50.00),
(75, 30, 200, 25.00),
(76, 31, 80, 40.00),
(77, 32, 120, 30.00),
(78, 33, 140, 50.00),
(79, 34, 90, 60.00),
(80, 35, 100, 15.00),
(81, 36, 110, 80.00),
(82, 37, 75, 75.00),
(83, 38, 160, 18.00),
(84, 39, 150, 22.00),
(85, 40, 180, 25.00),
(86, 41, 120, 65.00),
(87, 42, 200, 12.00),
(88, 43, 90, 35.00),
(89, 44, 110, 48.00),
(90, 45, 180, 20.00),
(50, 46, 130, 28.00),
(51, 47, 140, 38.00),
(52, 48, 150, 32.00),
(53, 49, 80, 55.00),
(54, 50, 100, 60.00),
(55, 51, 60, 70.00),
(56, 52, 150, 40.00),
(58, 53, 180, 20.00);


-- inserciones de la tabla de empleado rol
INSERT INTO empleado_rol (ID_Empleado, Rol) VALUES
(1, 'ADMIN'),
(2, 'SUPERVISOR'),
(3, 'OPERADOR'),
(4, 'EMPLEADO'),
(5, 'EMPLEADO'),
(6, 'ADMIN'),
(7, 'OPERADOR'),
(8, 'EMPLEADO'),
(9, 'ADMIN'),
(10, 'SUPERVISOR'),
(11, 'SUPERVISOR'),
(12, 'SUPERVISOR'),
(13, 'OPERADOR'),
(14, 'ADMIN'),
(15, 'OPERADOR'),
(16, 'EMPLEADO'),
(17, 'ADMIN'),
(18, 'ADMIN'),
(19, 'OPERADOR'),
(20, 'EMPLEADO'),
(21, 'ADMIN'),
(22, 'EMPLEADO'),
(23, 'OPERADOR'),
(24, 'EMPLEADO'),
(25, 'OPERADOR'),
(26, 'ADMIN'),
(27, 'EMPLEADO'),
(28, 'ADMIN'),
(29, 'EMPLEADO'),
(30, 'EMPLEADO'),
(31, 'EMPLEADO'),
(32, 'EMPLEADO'),
(33, 'OPERADOR'),
(34, 'EMPLEADO'),
(35, 'EMPLEADO'),
(36, 'EMPLEADO'),
(37, 'EMPLEADO'),
(38, 'EMPLEADO'),
(39, 'EMPLEADO'),
(40, 'EMPLEADO'),
(41, 'OPERADOR'),
(42, 'EMPLEADO'),
(43, 'EMPLEADO'),
(44, 'EMPLEADO'),
(45, 'EMPLEADO'),
(46, 'EMPLEADO'),
(47, 'ADMIN'),
(48, 'EMPLEADO'),
(49, 'EMPLEADO'),
(50, 'EMPLEADO');

