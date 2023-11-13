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
