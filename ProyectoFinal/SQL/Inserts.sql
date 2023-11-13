-- Inserts para la tabla NACIONALIDAD 

INSERT INTO NACIONALIDAD (ID_Nacionalidad, Nacionalidad) 

VALUES (01, 'Estado Unidos'); 

  

INSERT INTO NACIONALIDAD (ID_Nacionalidad, Nacionalidad) 

VALUES (02, 'Reino Unido'); 

  

INSERT INTO NACIONALIDAD (ID_Nacionalidad, Nacionalidad) 

VALUES (03, 'Rumania'); 

  

-- Inserts para la tabla AUTOR 

INSERT INTO AUTOR (ID_Autor, Nombre_Autor, Apellido1_Autor, Apellido2_Autor, Genero_Autor) 

VALUES (01, 'Edgar', 'Allan', 'Poe', 1); 

  

INSERT INTO AUTOR (ID_Autor, Apellido1_Autor, Apellido2_Autor, Genero_Autor) 

VALUES (02, 'J', 'K', 'Rolling', 2); 

  

INSERT INTO AUTOR (ID_Autor, Nombre_Autor, Apellido1_Autor, Apellido2_Autor, Genero_Autor) 

VALUES (03, 'John', 'Michael', 'Green', 1); 

  

INSERT INTO AUTOR (ID_Autor, Nombre_Autor, Apellido1_Autor, Apellido2_Autor, Genero_Autor) 

VALUES (04, 'Herta', 'Wagner', 'Muller', 2); 

  

-- Inserts para la tabla AUTOR_NACIONALIDAD 

INSERT INTO AUTOR_NACIONALIDAD (ID_Autor, ID_Nacionalidad) 

VALUES (01, 01); 

  

INSERT INTO AUTOR_NACIONALIDAD (ID_Autor, ID_Nacionalidad) 

VALUES (02, 02); 

  

INSERT INTO AUTOR_NACIONALIDAD (ID_Autor, ID_Nacionalidad) 

VALUES (03, 01); 

  

INSERT INTO AUTOR_NACIONALIDAD (ID_Autor, ID_Nacionalidad) 

VALUES (04, 03); 

  

-- Inserts para la tabla GENERO 

INSERT INTO GENERO (ID_Genero, Nombre_Genero, ID_Autor) 

VALUES (1, 'Romance', 01); 

  

INSERT INTO GENERO (ID_Genero, Nombre_Genero, ID_Autor) 

VALUES (2, 'Drama', 02); 

  

INSERT INTO GENERO (ID_Genero, Nombre_Genero, ID_Autor) 

VALUES (3, 'Terror', 03); 

  

INSERT INTO GENERO (ID_Genero, Nombre_Genero, ID_Autor) 

VALUES (4, 'Infantil', 04); 

  

-- Inserts para la tabla LIBRO 

INSERT INTO LIBRO (ID_Libro, Titulo_Libro, Fecha_Publicacion, Numero_Copias, ID_Genero) 

VALUES (1, 'El Cuervo', TO_DATE('2023-01-21', 'YYYY-MM-DD'), 15, 3); 

  

INSERT INTO LIBRO (ID_Libro, Titulo_Libro, Fecha_Publicacion, Numero_Copias, ID_Genero) 

VALUES (2, 'Harry Potter', TO_DATE('2022-09-11', 'YYYY-MM-DD'), 25, 2); 

  

INSERT INTO LIBRO (ID_Libro, Titulo_Libro, Fecha_Publicacion, Numero_Copias, ID_Genero) 

VALUES (3, 'Logan', TO_DATE('2021-10-08', 'YYYY-MM-DD'), 9, 3); 

  

INSERT INTO LIBRO (ID_Libro, Titulo_Libro, Fecha_Publicacion, Numero_Copias, ID_Genero) 

VALUES (4, 'American Gods', TO_DATE('2020-11-01', 'YYYY-MM-DD'), 3, 1); 

  

INSERT INTO LIBRO (ID_Libro, Titulo_Libro, Fecha_Publicacion, Numero_Copias, ID_Genero) 

VALUES (5, 'Ciudades de Papel', TO_DATE('2008-08-08', 'YYYY-MM-DD'), 11, 1); 

  

INSERT INTO LIBRO (ID_Libro, Titulo_Libro, Fecha_Publicacion, Numero_Copias, ID_Genero) 

VALUES (6, 'Bajo la Misma Estrella', TO_DATE('2012-01-12', 'YYYY-MM-DD'), 2, 1); 

  

-- Inserts para la tabla IDIOMA 

INSERT INTO IDIOMA (ID_Idioma, Nombre_Idioma) 

VALUES (1, 'Español'); 

  

INSERT INTO IDIOMA (ID_Idioma, Nombre_Idioma) 

VALUES (2, 'Ingles'); 

  

INSERT INTO IDIOMA (ID_Idioma, Nombre_Idioma) 

VALUES (3, 'Italiano'); 

  

INSERT INTO IDIOMA (ID_Idioma, Nombre_Idioma) 

VALUES (4, 'Frances'); 

  

-- Inserts para la tabla LIBRO_IDIOMA 

INSERT INTO LIBRO_IDIOMA (ID_Idioma, ID_Libro) 

VALUES (1, 1); 

  

INSERT INTO LIBRO_IDIOMA (ID_Idioma, ID_Libro) 

VALUES (2, 2); 

  

INSERT INTO LIBRO_IDIOMA (ID_Idioma, ID_Libro) 

VALUES (3, 3); 

  

INSERT INTO LIBRO_IDIOMA (ID_Idioma, ID_Libro) 

VALUES (4, 4); 

  

-- Inserts para la tabla RESERVA 

INSERT INTO RESERVA (ID_Reserva, Fecha_Reserva, ID_Libro) 

VALUES (1, TO_DATE('2023-08-21', 'YYYY-MM-DD'), 1); 

  

INSERT INTO RESERVA (ID_Reserva, Fecha_Reserva, ID_Libro) 

VALUES (2, TO_DATE('2022-07-22', 'YYYY-MM-DD'), 2); 

  

INSERT INTO RESERVA (ID_Reserva, Fecha_Reserva, ID_Libro) 

VALUES (3, TO_DATE('2021-06-23', 'YYYY-MM-DD'), 3); 

  

INSERT INTO RESERVA (ID_Reserva, Fecha_Reserva, ID_Libro) 

VALUES (4, TO_DATE('2020-05-24', 'YYYY-MM-DD'), 4); 

  

-- Inserts para la tabla CLIENTE 

INSERT INTO CLIENTE (Cedula_Cliente, Nombre_Cliente, Apellido_Paterno, Apellido_Materno, Fecha_Nacimiento, ID_Reserva) 

VALUES (1111, 'Mario', 'Carrillo', 'Alfaro', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 1); 

  

INSERT INTO CLIENTE (Cedula_Cliente, Nombre_Cliente, Apellido_Paterno, Apellido_Materno, Fecha_Nacimiento, ID_Reserva) 

VALUES (2222, 'Carlos', 'Arrieta', 'Quiros', TO_DATE('2002-11-10', 'YYYY-MM-DD'), 2); 

  

INSERT INTO CLIENTE (Cedula_Cliente, Nombre_Cliente, Apellido_Paterno, Apellido_Materno, Fecha_Nacimiento, ID_Reserva) 

VALUES (3333, 'Juan', 'Aguilar', 'Jimenez', TO_DATE('1999-08-05', 'YYYY-MM-DD'), 3); 

  

INSERT INTO CLIENTE (Cedula_Cliente, Nombre_Cliente, Apellido_Paterno, Apellido_Materno, Fecha_Nacimiento, ID_Reserva) 

VALUES (4444, 'José', 'Espinoza', 'Solorzano', TO_DATE('2007-10-02', 'YYYY-MM-DD'), 4); 

  

-- Inserts para la tabla TELEFONO 

INSERT INTO TELEFONO (ID_Telefono, Numero_Telefono, Cedula_Cliente) 

VALUES (1, '11111111', 1111); 

  

INSERT INTO TELEFONO (ID_Telefono, Numero_Telefono, Cedula_Cliente) 

VALUES (2, '22222222', 2222); 

  

INSERT INTO TELEFONO (ID_Telefono, Numero_Telefono, Cedula_Cliente) 

VALUES (3, '33333333', 2222); 

  

INSERT INTO TELEFONO (ID_Telefono, Numero_Telefono, Cedula_Cliente) 

VALUES (4, '44444444', 3333); 

  

-- Inserts para la tabla DIRECCION 

INSERT INTO DIRECCION (ID_Direccion, Direccion, Cedula_Cliente) 

VALUES (1, 'San Pedro', 1111); 

  

INSERT INTO DIRECCION (ID_Direccion, Direccion, Cedula_Cliente) 

VALUES (2, 'Curridabat', 2222); 

  

INSERT INTO DIRECCION (ID_Direccion, Direccion, Cedula_Cliente) 

VALUES (3, 'Cartago Centro', 3333); 

  

INSERT INTO DIRECCION (ID_Direccion, Direccion, Cedula_Cliente) 

VALUES (4, 'Guadalupe', 4444); 

  

-- Inserts para la tabla CORREO 

INSERT INTO CORREO (ID_Correo, Correo_Electronico, Cedula_Cliente) 

VALUES (1, 'mario@gmail.com', 1111); 

  

INSERT INTO CORREO (ID_Correo, Correo_Electronico, Cedula_Cliente) 

VALUES (2, 'carlos@hotmail.com', 2222); 

  

INSERT INTO CORREO (ID_Correo, Correo_Electronico, Cedula_Cliente) 

VALUES (3, 'juan@outlook.es', 3333); 

  

INSERT INTO CORREO (ID_Correo, Correo_Electronico, Cedula_Cliente) 

VALUES (4, 'jose@gmail.com', 4444); 
