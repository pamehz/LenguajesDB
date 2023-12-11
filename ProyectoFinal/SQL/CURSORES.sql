SELECT * FROM GENERO
CREATE OR REPLACE PROCEDURE CUR_LibrosPorGenero(p_NombreGenero IN VARCHAR2)
AS
  CURSOR LibrosCursor IS
    SELECT L.ID_Libro, L.Titulo_Libro, L.Fecha_Publicacion
    FROM LIBRO L
    INNER JOIN GENERO G ON L.ID_Genero = G.ID_Genero
    WHERE G.Nombre_Genero = p_NombreGenero
    ORDER BY L.Fecha_Publicacion;

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
END CUR_LibrosPorGenero;
EXEC CUR_LibrosPorGenero('Romance');

/////////
CREATE OR REPLACE PROCEDURE CUR_LibrosDisponibles 
AS 
  CURSOR LibrosCursor IS 
    SELECT L.ID_Libro, L.Titulo_Libro, L.Fecha_Publicacion
    FROM LIBRO L
    LEFT JOIN RESERVA R ON L.ID_Libro = R.ID_Libro
    WHERE R.ID_Libro IS NULL
    ORDER BY L.Fecha_Publicacion; 

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
EXEC CUR_LIBROSDISPONIBLES;

//////////
CREATE OR REPLACE PROCEDURE CUR_GenerosLibros 
AS 
  CURSOR GenerosCursor IS 
    SELECT DISTINCT G.Nombre_Genero
    FROM GENERO G
    ORDER BY G.Nombre_Genero;

  VGenero VARCHAR2(20); 

BEGIN 
  OPEN GenerosCursor;
   
  LOOP 
    FETCH GenerosCursor INTO VGenero; 
    EXIT WHEN GenerosCursor%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE('Género: ' || VGenero); 
  END LOOP;   

  CLOSE GenerosCursor; 
END; 
EXEC CUR_GenerosLibros;


/////////////
CREATE OR REPLACE PROCEDURE CUR_LibrosPorFechaPublicacion 
AS 
  CURSOR LibrosCursor IS 
    SELECT L.ID_Libro, L.Titulo_Libro, L.Fecha_Publicacion, A.Nombre_Autor, G.Nombre_Genero
    FROM LIBRO L
    JOIN GENERO G ON L.ID_Genero = G.ID_Genero
    JOIN AUTOR A ON G.ID_Autor = A.ID_Autor
    ORDER BY L.Fecha_Publicacion; 

  VID_LIBRO INT; 
  VTIPO_LIBRO VARCHAR2(90); 
  VFECHA_PUBLICACION DATE; 
  VAUTOR VARCHAR2(60); 
  VGENERO VARCHAR2(20); 

BEGIN 
  OPEN LibrosCursor;
   
  LOOP 
    FETCH LibrosCursor INTO VID_LIBRO, VTIPO_LIBRO, VFECHA_PUBLICACION, VAUTOR, VGENERO; 
    EXIT WHEN LibrosCursor%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE('ID: ' || VID_LIBRO || 
                         ', Título: ' || VTIPO_LIBRO || 
                         ', Autor: ' || VAUTOR || 
                         ', Género: ' || VGENERO ||
                         ', Fecha de publicación: ' || VFECHA_PUBLICACION); 
  END LOOP;   

  CLOSE LibrosCursor; 
END CUR_LibrosPorFechaPublicacion;

EXEC CUR_LibrosPorFechaPublicacion;
///////
CREATE OR REPLACE PROCEDURE CUR_ListarLibros AS
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
END CUR_ListarLibros;
EXEC CUR_ListarLibros;
/////////////////
CREATE OR REPLACE PROCEDURE CUR_AutoresPorGenero(p_GeneroID IN INT) 
AS 
  CURSOR AutoresCursor IS 
    SELECT A.ID_Autor, A.Nombre_Autor, A.Apellido1_Autor, A.Apellido2_Autor
    FROM AUTOR A
    INNER JOIN GENERO G ON A.ID_Autor = G.ID_Autor
    WHERE G.ID_Genero = p_GeneroID;
  
  VIDAUTOR INT;
  VNombre_Autor VARCHAR2(20);
  VApellido1_Autor VARCHAR2(20);
  VApellido2_Autor VARCHAR2(20);
  
BEGIN 
  OPEN AutoresCursor;
   
  LOOP 
    FETCH AutoresCursor INTO VIDAUTOR, VNombre_Autor, VApellido1_Autor, VApellido2_Autor; 
    EXIT WHEN AutoresCursor%NOTFOUND; 
    DBMS_OUTPUT.PUT_LINE('ID Autor: ' || VIDAUTOR || ', Nombre: ' || VNombre_Autor || 
                         ', Apellido1: ' || VApellido1_Autor || ', Apellido2: ' || VApellido2_Autor);
  END LOOP;   

  CLOSE AutoresCursor; 
END;
EXEC CUR_AutoresPorGenero(01);
//////////////////
CREATE OR REPLACE PROCEDURE CUR_ReservasCliente(p_CedulaCliente IN NUMBER) AS
  CURSOR ReservasCursor IS
    SELECT R.ID_Reserva, R.Fecha_Reserva, L.Titulo_Libro
    FROM RESERVA R
    JOIN LIBRO L ON R.ID_Libro = L.ID_Libro
    JOIN CLIENTE C ON R.ID_Reserva = C.ID_Reserva
    WHERE C.Cedula_Cliente = p_CedulaCliente;

  VID_RESERVA INT;
  VFECHA_RESERVA DATE;
  VTITULO_LIBRO VARCHAR2(90);
BEGIN
  OPEN ReservasCursor;

  LOOP
    FETCH ReservasCursor INTO VID_RESERVA, VFECHA_RESERVA, VTITULO_LIBRO;
    EXIT WHEN ReservasCursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID Reserva: ' || VID_RESERVA || ', Fecha: ' ||
                         TO_CHAR(VFECHA_RESERVA, 'DD-MON-YYYY') || ', Título: ' ||
                         VTITULO_LIBRO);
  END LOOP;

  CLOSE ReservasCursor;
END CUR_ReservasCliente;
EXEC CUR_ReservasCliente(1111);


/**/
CREATE OR REPLACE PROCEDURE CUR_LibrosPorIdioma(p_IdiomaId IN INT) AS
  CURSOR LibrosCursor IS
    SELECT L.ID_Libro, L.Titulo_Libro, L.Fecha_Publicacion
    FROM LIBRO L
    JOIN LIBRO_IDIOMA LI ON L.ID_Libro = LI.ID_Libro
    JOIN IDIOMA I ON LI.ID_Idioma = I.ID_Idioma
    WHERE I.ID_Idioma = p_IdiomaId
    ORDER BY L.Fecha_Publicacion;

  v_ID_Libro LIBRO.ID_LIBRO%TYPE;
  v_Titulo_Libro LIBRO.TITULO_LIBRO%TYPE;
  v_Fecha_Publicacion LIBRO.FECHA_PUBLICACION%TYPE;
BEGIN
  OPEN LibrosCursor;

  LOOP
    FETCH LibrosCursor INTO v_ID_Libro, v_Titulo_Libro, v_Fecha_Publicacion;
    EXIT WHEN LibrosCursor%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('ID: ' || v_ID_Libro || ', Título: ' || v_Titulo_Libro || ', Fecha de publicación: ' || v_Fecha_Publicacion);
  END LOOP;

  CLOSE LibrosCursor;
END CUR_LibrosPorIdioma;
EXEC CUR_LibrosPorIdioma(01);

/**/
CREATE OR REPLACE PROCEDURE CUR_DetalleCliente AS
  CURSOR DetalleClienteCursor IS
    SELECT
      C.Cedula_Cliente,
      C.Nombre_Cliente,
      C.Apellido_Paterno,
      C.Apellido_Materno,
      C.Fecha_Nacimiento,
      D.Direccion,
      T.Numero_Telefono,
      CO.Correo_Electronico
    FROM CLIENTE C
    LEFT JOIN DIRECCION D ON C.Cedula_Cliente = D.Cedula_Cliente
    LEFT JOIN TELEFONO T ON C.Cedula_Cliente = T.Cedula_Cliente
    LEFT JOIN CORREO CO ON C.Cedula_Cliente = CO.Cedula_Cliente;
  
  v_Cedula_Cliente CLIENTE.Cedula_Cliente%TYPE;
  v_Nombre_Cliente CLIENTE.Nombre_Cliente%TYPE;
  v_Apellido_Paterno CLIENTE.Apellido_Paterno%TYPE;
  v_Apellido_Materno CLIENTE.Apellido_Materno%TYPE;
  v_Fecha_Nacimiento CLIENTE.Fecha_Nacimiento%TYPE;
  v_Direccion DIRECCION.Direccion%TYPE;
  v_Numero_Telefono TELEFONO.Numero_Telefono%TYPE;
  v_Correo_Electronico CORREO.Correo_Electronico%TYPE;
BEGIN
  OPEN DetalleClienteCursor;
  
  LOOP
    FETCH DetalleClienteCursor INTO
      v_Cedula_Cliente,
      v_Nombre_Cliente,
      v_Apellido_Paterno,
      v_Apellido_Materno,
      v_Fecha_Nacimiento,
      v_Direccion,
      v_Numero_Telefono,
      v_Correo_Electronico;
    
    EXIT WHEN DetalleClienteCursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('Cedula: ' || v_Cedula_Cliente ||
                         ', Nombre: ' || v_Nombre_Cliente ||
                         ', Apellido Paterno: ' || v_Apellido_Paterno ||
                         ', Apellido Materno: ' || v_Apellido_Materno ||
                         ', Fecha de Nacimiento: ' || TO_CHAR(v_Fecha_Nacimiento, 'DD-MON-YYYY') ||
                         ', Direccion: ' || v_Direccion ||
                         ', Telefono: ' || v_Numero_Telefono ||
                         ', Correo Electronico: ' || v_Correo_Electronico);
  END LOOP;

  CLOSE DetalleClienteCursor;
END ;
EXEC CUR_DetalleCliente;
//////////////
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
