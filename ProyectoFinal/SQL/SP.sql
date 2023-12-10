/*////////////////SP//////////////////////////////////*/
CREATE OR REPLACE PROCEDURE SP_ListarLibrosPorAutor AS
BEGIN
    BEGIN
        FOR LibroRecord IN (
            SELECT 
                L.ID_Libro, 
                L.Titulo_Libro, 
                L.Fecha_Publicacion,
                A.Nombre_Autor || ' ' || A.Apellido1_Autor || ' ' || A.Apellido2_Autor AS Autor
            FROM 
                LIBRO L
            INNER JOIN 
                GENERO G ON L.ID_Genero = G.ID_Genero
            INNER JOIN 
                AUTOR A ON G.ID_Autor = A.ID_Autor
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
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado al listar libros: ' || SQLERRM);
    END;
END;
EXEC SP_ListarLibrosPorAutor;

CREATE OR REPLACE PROCEDURE SP_ObtenerNacionalidades AS
BEGIN
    BEGIN
        FOR NacRecord IN (SELECT ID_Nacionalidad, Nacionalidad FROM NACIONALIDAD ORDER BY ID_Nacionalidad)
        LOOP
            DBMS_OUTPUT.PUT_LINE('ID Nacionalidad: ' || NacRecord.ID_Nacionalidad || ', Nacionalidad: ' || NacRecord.Nacionalidad);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado al obtener nacionalidades: ' || SQLERRM);
    END;
END;
EXEC SP_ObtenerNacionalidades;


CREATE OR REPLACE PROCEDURE SP_EliminarLibro(p_ID_Libro IN INT)
AS
BEGIN
    BEGIN
        DELETE FROM LIBRO
        WHERE ID_Libro = p_ID_Libro;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se encontró ningún libro con el ID especificado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Libro eliminado exitosamente.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al intentar eliminar el libro: ' || SQLERRM);
    END;
END;
EXEC SP_EliminarLibro(1);

select * from telefono
CREATE OR REPLACE PROCEDURE SP_ActualizarTelefonoCliente (
    p_CedulaCliente IN INT,
    p_NuevoTelefono IN INT
) AS
BEGIN
    BEGIN
        UPDATE TELEFONO
        SET Numero_Telefono = p_NuevoTelefono
        WHERE Cedula_Cliente = p_CedulaCliente;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se encontró ningún teléfono asociado al cliente especificado.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Teléfono actualizado exitosamente.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al intentar actualizar el teléfono: ' || SQLERRM);
    END;
END;
EXEC SP_ActualizarTelefonoCliente(1111, 86225677);

select * from reserva
CREATE OR REPLACE PROCEDURE SP_ListarReservasPorFecha (
    p_FechaReserva IN DATE
) AS
    v_Resultado RESERVA%ROWTYPE; 
BEGIN
    BEGIN
        SELECT *
        INTO v_Resultado
        FROM RESERVA
        WHERE Fecha_Reserva = p_FechaReserva;

        DBMS_OUTPUT.PUT_LINE('ID_Reserva: ' || v_Resultado.ID_Reserva || ', Fecha_Reserva: ' || v_Resultado.Fecha_Reserva || ', ID_Libro: ' || v_Resultado.ID_Libro);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron reservas para la fecha especificada.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
EXEC SP_ListarReservasPorFecha('24/05/20');

select * from idioma
CREATE OR REPLACE PROCEDURE SP_ObtenerLibrosPorIdioma (
    p_IdIdioma IN INT
) AS
    v_Resultado LIBRO%ROWTYPE;

BEGIN
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
            DBMS_OUTPUT.PUT_LINE('No se encontraron libros para el idioma proporcionado.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
EXEC SP_ObtenerLibrosPorIdioma(01);

CREATE OR REPLACE PROCEDURE SP_EliminarCliente (
    p_CedulaCliente IN INT
) AS
BEGIN
    BEGIN
        DELETE FROM TELEFONO WHERE Cedula_Cliente = p_CedulaCliente;
        DELETE FROM CORREO WHERE Cedula_Cliente = p_CedulaCliente;
        DELETE FROM DIRECCION WHERE Cedula_Cliente = p_CedulaCliente;
        DELETE FROM CLIENTE WHERE Cedula_Cliente = p_CedulaCliente;
        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
EXEC SP_EliminarCliente(1111);

SELECT * FROM RESERVA
CREATE OR REPLACE PROCEDURE SP_ObtenerReservasCliente (
    p_CedulaCliente IN INT
) AS
    v_Resultado RESERVA%ROWTYPE;
BEGIN
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
                             ', Fecha_Reserva: ' || v_Resultado.Fecha_Reserva ||
                             ', ID_Libro: ' || v_Resultado.ID_Libro);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron reservas para el cliente.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
EXEC SP_ObtenerReservasCliente(02);

SELECT * FROM DIRECCION
CREATE OR REPLACE PROCEDURE SP_ActualizarDireccionCliente (
    p_CedulaCliente IN INT,
    p_NuevaDireccion IN VARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE DIRECCION
        SET Direccion = p_NuevaDireccion
        WHERE Cedula_Cliente = p_CedulaCliente;
        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Dirección actualizada exitosamente.');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron registros para actualizar.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
EXEC SP_ActualizarDireccionCliente(2222,'Desamparados');


CREATE OR REPLACE PROCEDURE SP_ListarAutoresPorGenero (
    p_IdGenero IN INT
) AS
    v_Resultado AUTOR%ROWTYPE; 
BEGIN
    SELECT *
    INTO v_Resultado
    FROM AUTOR a
    WHERE a.ID_Autor IN (SELECT ID_Autor FROM GENERO WHERE ID_Genero = p_IdGenero);

    DBMS_OUTPUT.PUT_LINE('ID_Autor: ' || v_Resultado.ID_Autor || 
                         ', Nombre_Autor: ' || v_Resultado.Nombre_Autor ||
                         ', Apellido1_Autor: ' || v_Resultado.Apellido1_Autor ||
                         ', Apellido2_Autor: ' || v_Resultado.Apellido2_Autor ||
                         ', Genero_Autor: ' || v_Resultado.Genero_Autor);
END;
EXEC SP_ListarAutoresPorGenero(01);

SELECT * FROM LIBRO
CREATE OR REPLACE PROCEDURE SP_BuscarLibrosPorTitulo (
    p_TituloLibro IN VARCHAR2
) AS
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
END;
EXEC SP_BuscarLibrosPorTitulo('El');

CREATE OR REPLACE PROCEDURE SP_InsertarAutor(
    p_nombre_autor VARCHAR2,
    p_apellido1_autor VARCHAR2,
    p_apellido2_autor VARCHAR2,
    p_genero_autor VARCHAR2,
    p_id_nacionalidad NUMBER
)
AS
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
END;

SELECT * FROM AUTOR
EXEC SP_InsertarAutor('Johan','Solis','Lopez',1,05);


CREATE OR REPLACE PROCEDURE SP_ActualizarLibro(
    p_id_libro IN NUMBER,
    p_titulo_libro IN VARCHAR2,
    p_fecha_publicacion IN DATE,
    p_numero_copias IN NUMBER,
    p_id_genero IN NUMBER
)
IS
BEGIN
    UPDATE LIBRO
    SET
        titulo_libro = p_titulo_libro,
        fecha_publicacion = p_fecha_publicacion,
        numero_copias = p_numero_copias,
        id_genero = p_id_genero
    WHERE id_libro = p_id_libro;
    COMMIT;
END;
SELECT * FROM LIBRO
EXECUTE SP_ActualizarLibro(03,  'Loganctio',TO_DATE('07/10/21', 'DD/MM/YY'),10, 2 );


CREATE OR REPLACE PROCEDURE SP_EliminarReserva(
    p_id_reserva IN NUMBER
)
IS
BEGIN
    DELETE FROM RESERVA WHERE id_reserva = p_id_reserva;
    COMMIT;
END;

EXECUTE SP_EliminarReserva(1);


CREATE OR REPLACE PROCEDURE SP_ListarLibrosPorGenero(
    p_nombre_genero IN VARCHAR2
)
IS
BEGIN
    FOR libro_rec IN (SELECT * FROM LIBRO WHERE id_genero = (SELECT id_genero FROM GENERO WHERE nombre_genero = p_nombre_genero))
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID Libro: ' || libro_rec.id_libro || ', Título: ' || libro_rec.titulo_libro);
    END LOOP;
END;
EXECUTE SP_ListarLibrosPorGenero('Terror');


CREATE OR REPLACE PROCEDURE SP_ContarLibrosPorGenero(p_nombre_genero IN VARCHAR2)
IS
BEGIN
    FOR genero_rec IN (SELECT g.nombre_genero, COUNT(l.id_libro) as cantidad_libros
                       FROM GENERO g
                       LEFT JOIN LIBRO l ON g.id_genero = l.id_genero
                       WHERE g.nombre_genero = p_nombre_genero
                       GROUP BY g.nombre_genero)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Género: ' || genero_rec.nombre_genero || ', Cantidad de Libros: ' || genero_rec.cantidad_libros);
    END LOOP;
END;
EXECUTE SP_ContarLibrosPorGenero('Terror');

select * from nacionalidad
CREATE OR REPLACE PROCEDURE SP_BuscarAutorPorNacionalidad(
    p_nacionalidad IN VARCHAR2
)
IS
    v_id_nacionalidad AUTOR_NACIONALIDAD.ID_Nacionalidad%TYPE;
BEGIN
    SELECT ID_Nacionalidad
    INTO v_id_nacionalidad
    FROM NACIONALIDAD
    WHERE nacionalidad = p_nacionalidad;

 //CURSOR
    FOR autor_rec IN (
        SELECT a.ID_Autor,a.Nombre_Autor, a.Apellido1_Autor ||' '|| a.Apellido2_Autor as apellidos
        FROM AUTOR_NACIONALIDAD an
        JOIN AUTOR a ON an.ID_Autor = a.ID_Autor
        WHERE an.ID_Nacionalidad = v_id_nacionalidad
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID Autor: ' || autor_rec.ID_Autor || ', Nombre: ' ||autor_rec.Nombre_Autor || ', Apellidos: ' || autor_rec.apellidos);
    END LOOP;
END;
EXEC SP_BuscarAutorPorNacionalidad('Rumania');


CREATE OR REPLACE PROCEDURE SP_MostrarInfoLibro
(
    p_LibroID IN NUMBER
)
AS
    v_TituloLibro VARCHAR2(100);
    v_ApellidoAutor VARCHAR2(50);
    v_FechaPublicacion DATE;
    v_NumeroCopias NUMBER;
BEGIN
    SELECT l.titulo_libro, a.Apellido1_Autor, l.fecha_publicacion, l.numero_copias
    INTO v_TituloLibro, v_ApellidoAutor, v_FechaPublicacion, v_NumeroCopias
    FROM LIBRO l
    JOIN GENERO g ON l.ID_Genero = g.ID_Genero
    JOIN AUTOR a ON g.ID_Autor = a.ID_Autor
    WHERE l.id_libro = p_LibroID;

    DBMS_OUTPUT.PUT_LINE('ID del Libro: ' || p_LibroID);
    DBMS_OUTPUT.PUT_LINE('Título del Libro: ' || v_TituloLibro);
    DBMS_OUTPUT.PUT_LINE('Apellido del Autor: ' || v_ApellidoAutor);
    DBMS_OUTPUT.PUT_LINE('Fecha de Publicación: ' || TO_CHAR(v_FechaPublicacion, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Número de Copias: ' || v_NumeroCopias);
END;
EXEC SP_MostrarInfoLibro(1);

CREATE OR REPLACE PROCEDURE SP_ReservarLibro (
    p_IdReserva INT,
    p_FechaReserva DATE,
    p_IdLibro INT,
    p_CedulaCliente INT
) AS
BEGIN
    INSERT INTO RESERVA (ID_Reserva, Fecha_Reserva, ID_Libro)
    VALUES (p_IdReserva, p_FechaReserva, p_IdLibro);

    UPDATE CLIENTE
    SET ID_Reserva = p_IdReserva
    WHERE Cedula_Cliente = p_CedulaCliente;
END;
SELECT * FROM RESERVA;
EXEC SP_ReservarLibro( 07,SYSDATE,4,4444);


CREATE OR REPLACE PROCEDURE SP_ListarLibrosDisponibles
AS
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
END SP_ListarLibrosDisponibles;
EXEC SP_ListarLibrosDisponibles();

/*DINAMIC*/
CREATE OR REPLACE PROCEDURE SP_ObtenerTelefonosCliente(N1 IN INT) 
AS
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
END;
EXEC SP_ObtenerTelefonosCliente(1111); 


/**********AQUÍ QUEDÉ*/////////////
CREATE OR REPLACE PROCEDURE SP_ListarLibrosPorFechaPublicacion 
AS 
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
END;
EXEC SP_ListarLibrosPorFechaPublicacion; 

/*DINAMIC */
CREATE OR REPLACE PROCEDURE SP_GenerarReporteReservas 
AS 
  VSQL VARCHAR2(1000);
  CURSOR c_reservas IS
    SELECT R.ID_Reserva, R.Fecha_Reserva, L.Titulo_Libro, C.Nombre_Cliente, C.Apellido_Paterno, C.Apellido_Materno
    FROM RESERVA R 
    JOIN LIBRO L ON R.ID_Libro = L.ID_Libro 
    JOIN CLIENTE C ON R.ID_Reserva = C.ID_Reserva;

BEGIN 
  VSQL := 'SELECT R.ID_Reserva, R.Fecha_Reserva, L.Titulo_Libro, C.Nombre_Cliente, C.Apellido_Paterno, C.Apellido_Materno ' ||
          'FROM RESERVA R ' ||
          'JOIN LIBRO L ON R.ID_Libro = L.ID_Libro ' ||
          'JOIN CLIENTE C ON R.ID_Reserva = C.ID_Reserva';

  FOR reserva_rec IN (EXECUTE IMMEDIATE VSQL)
  LOOP
    DBMS_OUTPUT.PUT_LINE('ID_Reserva: ' || reserva_rec.ID_Reserva || 
                         ' Fecha_Reserva: ' || reserva_rec.Fecha_Reserva || 
                         ' Título del Libro: ' || reserva_rec.Titulo_Libro || 
                         ' Nombre del Cliente: ' || reserva_rec.Nombre_Cliente || 
                         ' Apellido Paterno: ' || reserva_rec.Apellido_Paterno || 
                         ' Apellido Materno: ' || reserva_rec.Apellido_Materno);
  END LOOP;
END;



EXEC SP_GenerarReporteReservas; 


/*DINAMIC */
CREATE OR REPLACE PROCEDURE SP_ActualizarNacionalidad( 
    ID_AUTOR IN INT, 
    ID_NAC IN INT 
) 
AS 
  VSQL VARCHAR2(500); 
BEGIN 
    VSQL := 'UPDATE AUTOR_NACIONALIDAD 
             SET ID_Nacionalidad = :1 
             WHERE ID_Autor = :2';  
    EXECUTE IMMEDIATE VSQL USING ID_NAC, ID_AUTOR;  
    DBMS_OUTPUT.PUT_LINE('Se actualizó la nacionalidad del autor con ID ' || ID_AUTOR || ' a ' || ID_NAC); 
END; 

EXEC SP_ActualizarNacionalidad(1, 2);  

/*DINAMIC */
CREATE OR REPLACE PROCEDURE SP_ActualizarCorreoCliente ( 
    CedCli IN NUMBER, 
    NuevCorr   IN VARCHAR2 
) 
AS 
  VSQL VARCHAR2(500); 
BEGIN 
  VSQL := 'UPDATE CORREO 
           SET Correo_Electronico = :nuevCorr 
           WHERE Cedula_Cliente = :cedCli'; 
  EXECUTE IMMEDIATE VSQL USING NuevCorr, CedCli; 
  DBMS_OUTPUT.PUT_LINE('Correo electrónico actualizado correctamente para el cliente con cédula ' || CedCli); 
END;  

EXEC SP_ActualizarCorreoCliente(1111, 'belgic@example.com'); 

/**/
CREATE OR REPLACE PROCEDURE SP_ListarLibrosPorAutor 
AS 
BEGIN 
    FOR LibroRecord IN ( 
        SELECT  
            L.ID_Libro,  
            L.Titulo_Libro,  
            L.Fecha_Publicacion, 
            A.Nombre_Autor || ' ' || A.Apellido1_Autor || ' ' || A.Apellido2_Autor AS Autor 
        FROM  
            LIBRO L 
        INNER JOIN  
            GENERO G ON L.ID_Genero = G.ID_Genero 
        INNER JOIN  
            AUTOR A ON G.ID_Autor = A.ID_Autor 
        ORDER BY  
            A.Nombre_Autor, L.Fecha_Publicacion 
    ) 
    LOOP 
        DBMS_OUTPUT.PUT_LINE('ID: ' || LibroRecord.ID_Libro ||  

                             ', Titulo: ' || LibroRecord.Titulo_Libro ||  

                             ', Autor: ' || LibroRecord.Autor ||  

                             ', Fecha de Publicacion: ' || TO_CHAR(LibroRecord.Fecha_Publicacion, 'DD-MON-YYYY')); 
    END LOOP; 
END; 
EXEC SP_LISTARLIBROSPORAUTOR;
/**/
CREATE OR REPLACE PROCEDURE SP_ListarLibrosPorAutor 
AS 
BEGIN 
    FOR LibroRecord IN ( 
        SELECT  
            L.ID_Libro,  
            L.Titulo_Libro,  
            L.Fecha_Publicacion, 
            A.Nombre_Autor || ' ' || A.Apellido1_Autor || ' ' || A.Apellido2_Autor AS Autor 
        FROM  
            LIBRO L 
        INNER JOIN  
            GENERO G ON L.ID_Genero = G.ID_Genero 
        INNER JOIN  
            AUTOR A ON G.ID_Autor = A.ID_Autor 
        ORDER BY  
            A.Nombre_Autor, L.Fecha_Publicacion 
    ) 
    LOOP 
        DBMS_OUTPUT.PUT_LINE('ID: ' || LibroRecord.ID_Libro ||  
                             ', Titulo: ' || LibroRecord.Titulo_Libro ||  
                             ', Autor: ' || LibroRecord.Autor ||  
                             ', Fecha de Publicacion: ' || TO_CHAR(LibroRecord.Fecha_Publicacion, 'DD-MON-YYYY')); 

    END LOOP; 

END; 
EXEC SP_ListarLibrosPorAutor; 

//////// 
CREATE OR REPLACE PROCEDURE SP_ObtenerNacionalidades 
AS 
BEGIN 
    FOR NacRecord IN (SELECT ID_Nacionalidad, Nacionalidad FROM NACIONALIDAD ORDER BY ID_Nacionalidad) 
    LOOP 
        DBMS_OUTPUT.PUT_LINE('ID Nacionalidad: ' || NacRecord.ID_Nacionalidad || ', Nacionalidad: ' || NacRecord.Nacionalidad); 
    END LOOP; 
END; 

EXEC SP_ObtenerNacionalidades; 
