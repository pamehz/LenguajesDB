CREATE OR REPLACE PROCEDURE CUR_LibrosPorGenero (
    p_IdGenero INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT Titulo_Libro
    FROM LIBRO
    WHERE ID_Genero = p_IdGenero;
END CUR_LibrosPorGenero;

CREATE OR REPLACE PROCEDURE CUR_AutoresNacionalidad (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT a.ID_Autor, a.Nombre_Autor, a.Apellido1_Autor, a.Apellido2_Autor, n.Nacionalidad
    FROM AUTOR a
    JOIN AUTOR_NACIONALIDAD an ON a.ID_Autor = an.ID_Autor
    JOIN NACIONALIDAD n ON an.ID_Nacionalidad = n.ID_Nacionalidad;
END CUR_AutoresNacionalidad;

CREATE OR REPLACE PROCEDURE CUR_LibrosDisponibles (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT Titulo_Libro
    FROM LIBRO
    WHERE Numero_Copias > 0;
END CUR_LibrosDisponibles;

CREATE OR REPLACE PROCEDURE CUR_GenerosLiterarios (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT DISTINCT Nombre_Genero
    FROM GENERO;
END CUR_GenerosLiterarios;

CREATE OR REPLACE PROCEDURE CUR_AutoresMasProductivos (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT a.ID_Autor, a.Nombre_Autor, a.Apellido1_Autor, a.Apellido2_Autor, COUNT(l.ID_Libro) AS CantidadLibros
    FROM AUTOR a
    JOIN GENERO g ON a.ID_Autor = g.ID_Autor
    JOIN LIBRO l ON g.ID_Genero = l.ID_Genero
    GROUP BY a.ID_Autor, a.Nombre_Autor, a.Apellido1_Autor, a.Apellido2_Autor
    ORDER BY CantidadLibros DESC;
END CUR_AutoresMasProductivos;

CREATE OR REPLACE PROCEDURE CUR_ListaLibros (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT *
    FROM LIBRO;
END CUR_ListaLibros;

CREATE OR REPLACE PROCEDURE CUR_AutoresPorGenero (
    p_IdGenero INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT a.ID_Autor, a.Nombre_Autor, a.Apellido1_Autor, a.Apellido2_Autor
    FROM AUTOR a
    JOIN GENERO g ON a.ID_Autor = g.ID_Autor
    WHERE g.ID_Genero = p_IdGenero;
END CUR_AutoresPorGenero;

CREATE OR REPLACE PROCEDURE CUR_ReservasCliente (
    p_CedulaCliente INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT *
    FROM RESERVA
    WHERE ID_Reserva IN (SELECT ID_Reserva FROM CLIENTE WHERE Cedula_Cliente = p_CedulaCliente);
END CUR_ReservasCliente;

CREATE OR REPLACE PROCEDURE CUR_LibrosPorIdioma (
    p_IdIdioma INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT l.ID_Libro, l.Titulo_Libro, i.Nombre_Idioma
    FROM LIBRO l
    JOIN LIBRO_IDIOMA li ON l.ID_Libro = li.ID_Libro
    JOIN IDIOMA i ON li.ID_Idioma = i.ID_Idioma
    WHERE i.ID_Idioma = p_IdIdioma;
END CUR_LibrosPorIdioma;

CREATE OR REPLACE PROCEDURE CUR_DetalleCliente (
    p_CedulaCliente INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT *
    FROM CLIENTE
    WHERE Cedula_Cliente = p_CedulaCliente;
END CUR_DetalleCliente;


CREATE OR REPLACE PROCEDURE CUR_LibrosPorFechaPublicacion 
AS 
  CURSOR LibrosCursor IS 
    SELECT ID_Libro, Titulo_Libro, Fecha_Publicacion 
    FROM LIBRO 
    ORDER BY Fecha_Publicacion; 

  VID_LIBRO INT; 
  VTIPO_LIBRO VARCHAR2(90); 
  VFECHA_PUBLICACION DATE; 

BEGIN 
  OPEN LibrosCursor;
   
  LOOP 

    FETCH LibrosCursor INTO VID_LIBRO, VTIPO_LIBRO, VFECHA_PUBLICACION; 
    EXIT WHEN LibrosCursor%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE('ID: ' || VID_LIBRO || ' Título: ' || VTIPO_LIBRO || ' Fecha de publicación: ' || VFECHA_PUBLICACION); 

  END LOOP;   

  CLOSE LibrosCursor; 
END; 

EXEC CUR_LibrosPorFechaPublicacion; 

///////////// 

CREATE OR REPLACE PROCEDURE CUR_ReservasPorFecha 
AS 
  CURSOR ReservasCursor IS 
    SELECT ID_Reserva, Fecha_Reserva, ID_Libro 
    FROM RESERVA;    

  VID_Reserva INT; 
  VFecha_Reserva DATE; 
  VID_Libro INT; 

BEGIN 
  OPEN ReservasCursor; 

  LOOP 

    FETCH ReservasCursor INTO VID_Reserva, VFecha_Reserva, VID_Libro; 
    EXIT WHEN ReservasCursor%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE('ID_Reserva: ' || VID_Reserva || ', Fecha_Reserva: ' || VFecha_Reserva || ', ID_Libro: ' || VID_Libro); 

  END LOOP; 

  CLOSE ReservasCursor; 
END; 

EXEC CUR_ReservasPorFecha; 

////////// 

CREATE OR REPLACE PROCEDURE CUR_LibrosPorAutor 
AS 
  CURSOR LibrosPorAutor IS 
    SELECT A.Nombre_Autor || ' ' || A.Apellido1_Autor AS NombreCompleto, 
           L.Titulo_Libro, 
           L.Fecha_Publicacion 
    FROM AUTOR A 
    JOIN GENERO G ON A.ID_Autor = G.ID_Autor 
    JOIN LIBRO L ON G.ID_Genero = L.ID_Genero; 
  
  VNombreCompleto VARCHAR2(100); 
  VTituloLibro VARCHAR2(90); 
  VFechaPublicacion DATE;  

BEGIN 
  OPEN LibrosPorAutor; 

  LOOP 

    FETCH LibrosPorAutor INTO VNombreCompleto, VTituloLibro, VFechaPublicacion; 
    EXIT WHEN LibrosPorAutor%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE('Autor: ' || VNombreCompleto || ', Libro: ' || VTituloLibro || ', Fecha de Publicación: ' || VFechaPublicacion); 

  END LOOP; 

  CLOSE LibrosPorAutor; 
END; 

EXEC CUR_LibrosPorAutor; 

/////////// 
  
CREATE OR REPLACE PROCEDURE CUR_ClientesPorEdad 
AS 
  CURSOR ClientesPorEdad IS 
    SELECT Cedula_Cliente, Nombre_Cliente, Edad 
    FROM CLIENTE 
    ORDER BY Edad;  

  VCedula_Cliente INT; 
  VNombre_Cliente VARCHAR2(30); 
  VEdad INT;  

BEGIN 
  OPEN ClientesPorEdad; 

  LOOP 

    FETCH ClientesPorEdad INTO VCedula_Cliente, VNombre_Cliente, VEdad; 
    EXIT WHEN ClientesPorEdad%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE('Cedula: ' || VCedula_Cliente || ', Nombre: ' || VNombre_Cliente || ', Edad: ' || VEdad); 

  END LOOP; 

  CLOSE ClientesPorEdad; 
END;  

EXEC CUR_ClientesPorEdad; 

