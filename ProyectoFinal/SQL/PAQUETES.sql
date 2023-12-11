/**PAQUETES**/
//CLIENTES
CREATE OR REPLACE PACKAGE PK1_Clientes AS
  PROCEDURE SP_EliminarCliente(p_CedulaCliente IN INT);
  PROCEDURE SP_ActualizarDireccionCliente(p_CedulaCliente IN INT, p_NuevaDireccion IN VARCHAR2);
  PROCEDURE SP_ObtenerTelefonosCliente(N1 IN INT);
  PROCEDURE SP_ActualizarCorreoCliente(CedCli IN NUMBER, NuevCorr IN VARCHAR2);
  PROCEDURE CUR_DetalleCliente;

END PK1_Clientes;

/*Brody*/
CREATE OR REPLACE PACKAGE BODY PK1_Clientes AS
  PROCEDURE SP_EliminarCliente(p_CedulaCliente IN INT) AS
    VSQLCOD NUMBER;
    VMENS VARCHAR2(500);
  BEGIN
    DELETE FROM TELEFONO WHERE Cedula_Cliente = p_CedulaCliente;
    DELETE FROM CORREO WHERE Cedula_Cliente = p_CedulaCliente;
    DELETE FROM DIRECCION WHERE Cedula_Cliente = p_CedulaCliente;
    DELETE FROM CLIENTE WHERE Cedula_Cliente = p_CedulaCliente;
    COMMIT;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
  
  PROCEDURE SP_ActualizarDireccionCliente(p_CedulaCliente IN INT, p_NuevaDireccion IN VARCHAR2) AS
    VSQLCOD NUMBER;
    VMENS VARCHAR2(500);
  BEGIN
    UPDATE DIRECCION
    SET Direccion = p_NuevaDireccion
    WHERE Cedula_Cliente = p_CedulaCliente;
    COMMIT;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;

  PROCEDURE SP_ObtenerTelefonosCliente(N1 IN INT) AS
    VSQLCOD NUMBER;
    VMENS VARCHAR2(500);
    VSQL VARCHAR2(500);
    VNUMERO_TELEFONO VARCHAR2(20);
    telefono_cursor SYS_REFCURSOR;
  BEGIN
    VSQL := 'SELECT Numero_Telefono 
             FROM TELEFONO T 
             INNER JOIN CLIENTE C ON T.Cedula_Cliente = C.Cedula_Cliente 
             WHERE C.Cedula_Cliente = :1';
    OPEN telefono_cursor FOR VSQL USING N1;
    LOOP
      FETCH telefono_cursor INTO VNUMERO_TELEFONO;

      EXIT WHEN telefono_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Número de Teléfono: ' || VNUMERO_TELEFONO);
    END LOOP;

    CLOSE telefono_cursor;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
  
  
  PROCEDURE SP_ActualizarCorreoCliente(CedCli IN NUMBER, NuevCorr IN VARCHAR2) AS
    VSQLCOD NUMBER;
    VMENS VARCHAR2(500);
    VSQL VARCHAR2(500);
  BEGIN
    VSQL := 'UPDATE CORREO SET Correo_Electronico = :nuevCorr WHERE Cedula_Cliente = :cedCli';
    EXECUTE IMMEDIATE VSQL USING NuevCorr, CedCli;
    DBMS_OUTPUT.PUT_LINE('Correo electrónico actualizado correctamente para el cliente con cédula ' || CedCli);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
  
  PROCEDURE CUR_DetalleCliente AS
    VSQLCOD NUMBER;
    VMENS VARCHAR2(500);
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
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;

END PK1_Clientes;

/*LIBROS*/
CREATE OR REPLACE PACKAGE PK1_Libros AS

  PROCEDURE SP_ListarLibrosPorAutor;
  PROCEDURE SP_ObtenerLibrosPorIdioma(p_IdIdioma IN INT);
PROCEDURE SP_BuscarLibrosPorTitulo(p_TituloLibro IN VARCHAR2);
PROCEDURE SP_ListarLibrosPorGenero(p_nombre_genero IN VARCHAR2);
  PROCEDURE SP_ListarLibrosDisponibles;
  PROCEDURE SP_ListarLibrosPorFechaPublicacion;

END PK1_Libros;

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PK1_Libros AS

 PROCEDURE SP_ListarLibrosPorAutor AS
 VSQLCOD NUMBER;
 VMENS VARCHAR2(500);
  BEGIN
    FOR LibroRecord IN (
      SELECT
        L.ID_Libro,
        L.Titulo_Libro,
        L.Fecha_Publicacion,
        A.Nombre_Autor || ' ' || A.Apellido1_Autor || ' ' || A.Apellido2_Autor AS Autor
      FROM
        LIBRO L
        INNER JOIN GENERO G ON L.ID_Genero = G.ID_Genero
        INNER JOIN AUTOR A ON G.ID_Autor = A.ID_Autor
      ORDER BY
        A.Nombre_Autor, L.Fecha_Publicacion
    )
    LOOP
      DBMS_OUTPUT.PUT_LINE('ID: ' || LibroRecord.ID_Libro || 
                           ', Titulo: ' || LibroRecord.Titulo_Libro || 
                           ', Autor: ' || LibroRecord.Autor || 
                           ', Fecha de Publicacion: ' || TO_CHAR(LibroRecord.Fecha_Publicacion, 'DD-MON-YYYY'));
    END LOOP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;

 PROCEDURE SP_ObtenerLibrosPorIdioma(p_IdIdioma IN INT) AS
 VSQLCOD NUMBER;
 VMENS VARCHAR2(500);
    v_Resultado LIBRO%ROWTYPE;
  BEGIN
    SELECT l.*
    INTO v_Resultado
    FROM LIBRO l
    JOIN LIBRO_IDIOMA i ON l.ID_Libro = i.ID_Libro
    WHERE i.ID_Idioma = p_IdIdioma;

    DBMS_OUTPUT.PUT_LINE('ID_Libro: ' || v_Resultado.ID_Libro || 
                         ', Titulo: ' || v_Resultado.Titulo_Libro ||
                         ', Fecha_Publicacion: ' || TO_CHAR(v_Resultado.Fecha_Publicacion, 'DD-MON-YYYY') ||
                         ', ID_Idioma: ' || p_IdIdioma);
         EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;

PROCEDURE SP_BuscarLibrosPorTitulo(p_TituloLibro IN VARCHAR2) AS
 VSQLCOD NUMBER;
 VMENS VARCHAR2(500);
  BEGIN
    FOR v_Resultado IN (
        SELECT *
        FROM LIBRO
        WHERE UPPER(Titulo_Libro) LIKE UPPER('%'||p_TituloLibro||'%')
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID_Libro: ' || v_Resultado.ID_Libro || 
                             ', Titulo: ' || v_Resultado.Titulo_Libro ||
                             ', Fecha_Publicacion: ' || TO_CHAR(v_Resultado.Fecha_Publicacion, 'DD-MON-YYYY') ||
                             ', Numero_Copias: ' || v_Resultado.Numero_Copias ||
                             ', ID_Genero: ' || v_Resultado.ID_Genero);
    END LOOP;
     EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
  
 PROCEDURE SP_ListarLibrosPorGenero(p_nombre_genero IN VARCHAR2) AS
  VSQLCOD NUMBER;
 VMENS VARCHAR2(500);
  BEGIN
    FOR libro_rec IN (
      SELECT * 
      FROM LIBRO 
      WHERE id_genero = (SELECT id_genero FROM GENERO WHERE nombre_genero = p_nombre_genero)
    )
    LOOP
      DBMS_OUTPUT.PUT_LINE('ID Libro: ' || libro_rec.id_libro || ', Título: ' || libro_rec.titulo_libro);
    END LOOP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;

 PROCEDURE SP_ListarLibrosDisponibles AS
VSQLCOD NUMBER;
 VMENS VARCHAR2(500);
    CURSOR libros_cursor IS
      SELECT *
      FROM LIBRO
      WHERE Numero_Copias > 0;

    libro_rec LIBRO%ROWTYPE;

  BEGIN
    OPEN libros_cursor; 
    LOOP
      FETCH libros_cursor INTO libro_rec;
      EXIT WHEN libros_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('ID_Libro: ' || libro_rec.ID_Libro || ', Titulo: ' || libro_rec.Titulo_Libro);
    END LOOP;
    CLOSE libros_cursor;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
  
 PROCEDURE SP_ListarLibrosPorFechaPublicacion AS
  VSQLCOD NUMBER;
 VMENS VARCHAR2(500);
    VSQL VARCHAR2(500);
    VID NUMBER;
    VTITULO VARCHAR2(100);
    VFECHA DATE;
  BEGIN
    VSQL := 'SELECT ID_Libro, Titulo_Libro, Fecha_Publicacion FROM LIBRO ORDER BY Fecha_Publicacion';

    FOR LibroRecord IN (SELECT ID_Libro, Titulo_Libro, Fecha_Publicacion FROM LIBRO ORDER BY Fecha_Publicacion)
    LOOP
      VID := LibroRecord.ID_Libro;
      VTITULO := LibroRecord.Titulo_Libro;
      VFECHA := LibroRecord.Fecha_Publicacion;
      DBMS_OUTPUT.PUT_LINE('ID: ' || VID || ', Titulo: ' || VTITULO || ', Fecha de Publicacion: ' || TO_CHAR(VFECHA, 'DD-MON-YYYY'));
    END LOOP;
     EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VSQLCOD := SQLCODE;
        VMENS := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
END PK1_Libros;

/*RESERVAS*/
CREATE OR REPLACE PACKAGE PK1_Reservas AS

  PROCEDURE SP_ListarReservasPorFecha(p_FechaReserva IN DATE);
    PROCEDURE SP_ObtenerReservasCliente(p_CedulaCliente IN INT);
  PROCEDURE SP_EliminarReserva(p_id_reserva IN NUMBER);
PROCEDURE SP_ReservarLibro(
    p_IdReserva INT, p_FechaReserva DATE,
    p_IdLibro INT,   p_CedulaCliente INT);
  PROCEDURE SP_ReservasPorCliente(p_ID_Cliente IN INT);
    PROCEDURE CUR_ReservasPorFecha;
/*Funciones*/
  FUNCTION FN_ExistenReservasCliente(p_CedulaCliente IN INT) RETURN NUMBER;

END PK1_Reservas;

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PK1_Reservas AS

 PROCEDURE SP_ListarReservasPorFecha (
    p_FechaReserva IN DATE
) AS
  VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
  v_Resultado RESERVA%ROWTYPE; -- Almacena resultado de la consulta

BEGIN
  SELECT *
  INTO v_Resultado
  FROM RESERVA
  WHERE Fecha_Reserva = p_FechaReserva;

  DBMS_OUTPUT.PUT_LINE('ID_Reserva: ' || v_Resultado.ID_Reserva || ', Fecha_Reserva: ' || TO_CHAR(v_Resultado.Fecha_Reserva, 'DD-MON-YYYY') || ', ID_Libro: ' || v_Resultado.ID_Libro);

EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
END;

 PROCEDURE SP_ObtenerReservasCliente (
    p_CedulaCliente IN INT
  ) AS
  VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
    v_Resultado RESERVA%ROWTYPE;
  BEGIN
    SELECT *
    INTO v_Resultado
    FROM RESERVA
    WHERE ID_Libro IN (
        SELECT ID_Libro
        FROM LIBRO
        WHERE ID_Genero IN (
            SELECT ID_Genero
            FROM GENERO
            WHERE ID_Autor = p_CedulaCliente
        )
    );
    DBMS_OUTPUT.PUT_LINE('ID_Reserva: ' || v_Resultado.ID_Reserva ||
                         ', Fecha_Reserva: ' || TO_CHAR(v_Resultado.Fecha_Reserva, 'DD-MON-YYYY') ||
                         ', ID_Libro: ' || v_Resultado.ID_Libro);
    EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;

 PROCEDURE SP_EliminarReserva (
    p_id_reserva IN NUMBER
  ) IS
  VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
  BEGIN
    DELETE FROM RESERVA WHERE id_reserva = p_id_reserva;
    COMMIT;
 EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
/**/
   PROCEDURE SP_ReservarLibro (
    p_IdReserva INT,
    p_FechaReserva DATE,
    p_IdLibro INT,
    p_CedulaCliente INT
  ) AS
   VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
  BEGIN
    INSERT INTO RESERVA (ID_Reserva, Fecha_Reserva, ID_Libro)
    VALUES (p_IdReserva, p_FechaReserva, p_IdLibro);

    UPDATE CLIENTE
    SET ID_Reserva = p_IdReserva
    WHERE Cedula_Cliente = p_CedulaCliente;
    
     EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
/**/
  PROCEDURE SP_ReservasPorCliente (
    p_ID_Cliente IN INT
  ) AS
  VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
  BEGIN
    FOR reserva_rec IN (
        SELECT R.ID_Reserva, R.Fecha_Reserva, L.Titulo_Libro, C.Nombre_Cliente, C.Apellido_Paterno, C.Apellido_Materno
        FROM RESERVA R
        JOIN LIBRO L ON R.ID_Libro = L.ID_Libro
        JOIN CLIENTE C ON R.ID_Reserva = C.ID_Reserva
        WHERE C.Cedula_Cliente = p_ID_Cliente
    ) 
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID Reserva: ' || reserva_rec.ID_Reserva ||
                             ', Fecha: ' || TO_CHAR(reserva_rec.Fecha_Reserva, 'DD-MON-YYYY') ||
                             ', Título: ' || reserva_rec.Titulo_Libro);
    END LOOP;
   EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
 
/**/
 PROCEDURE CUR_ReservasPorFecha AS
VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
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
      EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;
/*Funciones*/
 FUNCTION FN_ExistenReservasCliente (
    p_CedulaCliente IN INT
  ) RETURN NUMBER AS
   VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
    v_ExistenReservas NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_ExistenReservas
    FROM RESERVA
    WHERE ID_Libro IN (SELECT ID_Libro FROM LIBRO WHERE ID_Genero IN (SELECT ID_Genero FROM GENERO WHERE ID_Autor = p_CedulaCliente));

    RETURN CASE WHEN v_ExistenReservas > 0 THEN 1 ELSE 0 END;
    EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
  END;

END PK1_Reservas;

/*REPORTES*/
CREATE OR REPLACE PACKAGE PK1_Reportes AS

 PROCEDURE SP_GenerarReporteReservas; 

END PK1_Reportes;

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PK1_Reportes AS


 PROCEDURE SP_GenerarReporteReservas 
AS 
 VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
  VSQL VARCHAR2(1000);
  VIDR INT;
  VFR DATE;
  VTLIBRO VARCHAR2(20);
  VNOMBRE VARCHAR2(20);
  VAPELLID VARCHAR2(50);

BEGIN 
  VSQL := 'SELECT R.ID_Reserva, R.Fecha_Reserva, L.Titulo_Libro, C.Nombre_Cliente, C.Apellido_Paterno ||'' ''||C.Apellido_Materno as apellidos ' ||
          'FROM RESERVA R ' ||
          'JOIN LIBRO L ON R.ID_Libro = L.ID_Libro ' ||
          'JOIN CLIENTE C ON R.ID_Reserva = C.ID_Reserva';

  EXECUTE IMMEDIATE VSQL INTO VIDR, VFR, VTLIBRO, VNOMBRE, VAPELLID;

  DBMS_OUTPUT.PUT_LINE('ID_Reserva: ' || VIDR || 
                       ' Fecha_Reserva: ' || VFR || 
                       ' Título del Libro: ' || VTLIBRO || 
                       ' Nombre del Cliente: ' || VNOMBRE || 
                       ' Apellidos: ' || VAPELLID);

EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
END;
END PK1_Reportes;

/*AUTORES*/
CREATE OR REPLACE PACKAGE PK1_Autores AS

    PROCEDURE SP_InsertarAutor(p_nombre_autor VARCHAR2, p_apellido1_autor VARCHAR2,
    p_apellido2_autor VARCHAR2,  p_genero_autor VARCHAR2,  p_id_nacionalidad NUMBER);
    PROCEDURE SP_BuscarAutorPorNacionalidad(p_nacionalidad IN VARCHAR2);
    PROCEDURE SP_ActualizarNacionalidad(ID_AUTOR IN INT,ID_NAC IN INT);
    /*Funcion*/
        FUNCTION FN_CantidadLibrosPorAutor(p_IdAutor INT) RETURN INT;
        FUNCTION ObtenerNacionalidadAutor(p_id_autor NUMBER) RETURN VARCHAR2;

END PK1_Autores;

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PK1_Autores AS

 PROCEDURE SP_InsertarAutor(
    p_nombre_autor VARCHAR2,
    p_apellido1_autor VARCHAR2,
    p_apellido2_autor VARCHAR2,
    p_genero_autor VARCHAR2,
    p_id_nacionalidad NUMBER
)
AS
 VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
    v_id_autor NUMBER;
BEGIN
    SELECT MAX(ID_Autor) + 1 INTO v_id_autor FROM AUTOR;

    INSERT INTO AUTOR (
        ID_Autor,
        Nombre_Autor,
        Apellido1_Autor,
        Apellido2_Autor,
        Genero_Autor
    )
    VALUES (
        v_id_autor,
        p_nombre_autor,
        p_apellido1_autor,
        p_apellido2_autor,
        p_genero_autor
    );
    COMMIT;

EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
END;
/**/
 PROCEDURE SP_BuscarAutorPorNacionalidad(
    p_nacionalidad IN VARCHAR2
)
IS
 VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
    v_id_nacionalidad AUTOR_NACIONALIDAD.ID_Nacionalidad%TYPE;
BEGIN
    SELECT ID_Nacionalidad
    INTO v_id_nacionalidad
    FROM NACIONALIDAD
    WHERE nacionalidad = p_nacionalidad;

 /*CURSOR*/
    FOR autor_rec IN (
        SELECT a.ID_Autor,a.Nombre_Autor, a.Apellido1_Autor ||' '|| a.Apellido2_Autor as apellidos
        FROM AUTOR_NACIONALIDAD an
        JOIN AUTOR a ON an.ID_Autor = a.ID_Autor
        WHERE an.ID_Nacionalidad = v_id_nacionalidad
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID Autor: ' || autor_rec.ID_Autor || ', Nombre: ' ||autor_rec.Nombre_Autor || ', Apellidos: ' || autor_rec.apellidos);
    END LOOP;
    EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
END;
/**/
PROCEDURE SP_ActualizarNacionalidad( 
    ID_AUTOR IN INT, 
    ID_NAC IN INT 
) 
AS 
VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
  VSQL VARCHAR2(500); 
BEGIN 
    VSQL := 'UPDATE AUTOR_NACIONALIDAD 
             SET ID_Nacionalidad = :1 
             WHERE ID_Autor = :2';  
    EXECUTE IMMEDIATE VSQL USING ID_NAC, ID_AUTOR;  
    DBMS_OUTPUT.PUT_LINE('Se actualizó la nacionalidad del autor con ID ' || ID_AUTOR || ' a ' || ID_NAC);
     EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
END; 

/*FUNCION*/
FUNCTION FN_CantidadLibrosPorAutor (
    p_IdAutor INT
) RETURN INT AS
VSQLCOD NUMBER;
  VMENS VARCHAR2(500);
    v_CantidadLibros INT;
BEGIN
    SELECT COUNT(l.ID_Libro)
    INTO v_CantidadLibros
    FROM LIBRO l
    JOIN GENERO g ON l.ID_Genero = g.ID_Genero
    WHERE g.ID_Autor = p_IdAutor;

    RETURN v_CantidadLibros;
     EXCEPTION
  WHEN TOO_MANY_ROWS  THEN
    VSQLCOD := SQLCODE;
    VMENS := SQLERRM;
    DBMS_OUTPUT.PUT_LINE('***** ' || VSQLCOD || ' ' || VMENS);
END;
/**/
FUNCTION ObtenerNacionalidadAutor(
    p_id_autor NUMBER
)
RETURN VARCHAR2
AS
    nacionalidad_autor VARCHAR2(50);
BEGIN
    SELECT MAX(nacionalidad)
    INTO nacionalidad_autor
    FROM NACIONALIDAD
    WHERE id_nacionalidad = (SELECT id_nacionalidad FROM AUTOR WHERE id_autor = p_id_autor);
    
    RETURN nacionalidad_autor;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL; 
END;
END PK1_Autores;