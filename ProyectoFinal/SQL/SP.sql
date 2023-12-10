/*////////////////SP//////////////////////////////////*/
CREATE OR REPLACE PROCEDURE SP_ActualizarCorreoCliente (
    CedCli IN NUMBER,
    NuevCorr   IN VARCHAR2
)
AS
BEGIN
    UPDATE CORREO
    SET Correo_Electronico = NuevCorr
    WHERE Cedula_Cliente = CedCli;

    DBMS_OUTPUT.PUT_LINE('Correo electrónico actualizado correctamente para el cliente con cédula ' || CedCli);

END;
EXEC SP_ActualizarCorreoCliente(1111, 'belgic@example.com');


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


CREATE OR REPLACE PROCEDURE SP_ObtenerNacionalidades
AS
BEGIN
    FOR NacRecord IN (SELECT ID_Nacionalidad, Nacionalidad FROM NACIONALIDAD ORDER BY ID_Nacionalidad)
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID Nacionalidad: ' || NacRecord.ID_Nacionalidad || ', Nacionalidad: ' || NacRecord.Nacionalidad);
    END LOOP;
END;

EXEC SP_ObtenerNacionalidades;


CREATE OR REPLACE PROCEDURE SP_EliminarLibro(p_ID_Libro IN INT)
AS
BEGIN
    DELETE FROM LIBRO
    WHERE ID_Libro = p_ID_Libro;
    
    DBMS_OUTPUT.PUT_LINE('Libro eliminado exitosamente.');

END;
EXEC SP_EliminarLibro(1);

CREATE OR REPLACE PROCEDURE SP_ActualizarTelefonoCliente (
    p_CedulaCliente IN INT,
    p_NuevoTelefono IN INT
) AS
BEGIN
    UPDATE TELEFONO
    SET Numero_Telefono = p_NuevoTelefono
    WHERE Cedula_Cliente = p_CedulaCliente;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE SP_ListarReservasPorFecha (
    p_FechaReserva IN DATE
) AS
BEGIN
    SELECT *
    FROM RESERVA
    WHERE Fecha_Reserva = p_FechaReserva;
END;

CREATE OR REPLACE PROCEDURE SP_ObtenerLibrosPorIdioma (
    p_IdIdioma IN INT
) AS
BEGIN
    SELECT l.*
    FROM LIBRO l
    JOIN LIBRO_IDIOMA li ON l.ID_Libro = li.ID_Libro
    WHERE li.ID_Idioma = p_IdIdioma;
END;

CREATE OR REPLACE PROCEDURE SP_EliminarCliente (
    p_CedulaCliente IN INT
) AS
BEGIN
    DELETE FROM TELEFONO WHERE Cedula_Cliente = p_CedulaCliente;
    DELETE FROM CORREO WHERE Cedula_Cliente = p_CedulaCliente;
    DELETE FROM DIRECCION WHERE Cedula_Cliente = p_CedulaCliente;
    DELETE FROM CLIENTE WHERE Cedula_Cliente = p_CedulaCliente;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE SP_ObtenerReservasCliente (
    p_CedulaCliente IN INT
) AS
BEGIN
    SELECT *
    FROM RESERVA
    WHERE ID_Libro IN (SELECT ID_Libro FROM LIBRO WHERE ID_Genero IN (SELECT ID_Genero FROM GENERO WHERE ID_Autor = p_CedulaCliente));
END;

CREATE OR REPLACE PROCEDURE SP_ActualizarDireccionCliente (
    p_CedulaCliente IN INT,
    p_NuevaDireccion IN VARCHAR2
) AS
BEGIN
    UPDATE DIRECCION
    SET Direccion = p_NuevaDireccion
    WHERE Cedula_Cliente = p_CedulaCliente;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE SP_ListarAutoresPorGenero (
    p_IdGenero IN INT
) AS
BEGIN
    SELECT a.*
    FROM AUTOR a
    WHERE a.ID_Autor IN (SELECT ID_Autor FROM GENERO WHERE ID_Genero = p_IdGenero);
END;

CREATE OR REPLACE PROCEDURE SP_BuscarLibrosPorTitulo (
    p_TituloLibro IN VARCHAR2
) AS
BEGIN
    SELECT *
    FROM LIBRO
    WHERE UPPER(Titulo_Libro) LIKE UPPER('%'||p_TituloLibro||'%');
END;



//Procedimiento para insertar autor nuevo


create or replace NONEDITIONABLE PROCEDURE SP_InsertarAutor(
    p_nombre_autor varchar2,
    p_apellido1_autor varchar2,
    p_apellido2_autor varchar2,
    p_genero_autor varchar2,
    p_correoelectronico_autor varchar2,
    p_id_nacionalidad NUMBER
)
AS
BEGIN
    INSERT INTO AUTOR (
        nombre_autor,
        apellido1_autor,
        apellido2_autor,
        genero_autor,
        correoelectronico_autor,
        id_nacionalidad
    )
    VALUES (
        p_nombre_autor,
        p_apellido1_autor,
        p_apellido2_autor,
        p_genero_autor,
        p_correoelectronico_autor,
        p_id_nacionalidad
    );
END ;

EXEC SP_InsertarAutor('Johan','Solis','Lopez','Masculino','johan.solis.lopez@hotmail.com',1)



//Actualizar libro 

CREATE OR REPLACE PROCEDURE SP_ActualizarLibro(
    p_id_libro IN NUMBER,
    p_titulo_libro IN VARCHAR2,
    p_apellido1_autor IN VARCHAR2,
    p_fecha_publicacion IN DATE,
    p_numero_copias IN NUMBER,
    p_id_idioma IN NUMBER,
    p_id_genero IN NUMBER
)
IS
BEGIN
    UPDATE LIBRO
    SET
        titulo_libro = p_titulo_libro,
        apellido1_autor = p_apellido1_autor,
        fecha_publicacion = p_fecha_publicacion,
        numero_copias = p_numero_copias,
        id_idioma = p_id_idioma,
        id_genero = p_id_genero
    WHERE id_libro = p_id_libro;
    COMMIT;
END;

EXECUTE SP_ActualizarLibro(1,  'Nuevo Título', 'Nuevo Autor',  TO_DATE('2023-01-01', 'YYYY-MM-DD'),10, 2,3 );



//ELIMINAR RESERVA 

CREATE OR REPLACE PROCEDURE SP_EliminarReserva(
    p_id_reserva IN NUMBER
)
IS
BEGIN
    DELETE FROM RESERVA WHERE id_reserva = p_id_reserva;
    COMMIT;
END;

EXECUTE SP_EliminarReserva(1);



//LISTAR LOS LIBROS POR GENERO
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

EXECUTE SP_ListarLibrosPorGenero('Ciencia Ficción');

//Obtener clientes por edad 


CREATE OR REPLACE PROCEDURE SP_ObtenerClientesPorEdad(
    p_edad NUMBER
)
IS
BEGIN
    FOR cliente_bucle IN (SELECT * FROM CLIENTE WHERE edad = p_edad)
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID Cliente: ' || cliente_bucle.id_cliente || ', Nombre: ' || cliente_bucle.nombre_cliente);
    END LOOP;
END;

// Contar libros por GENERO 
CREATE OR REPLACE PROCEDURE SP_ContarLibrosPorGenero
IS
BEGIN
    FOR genero_rec IN (SELECT g.nombre_genero, COUNT(l.id_libro) as cantidad_libros
                       FROM GENERO g
                       LEFT JOIN LIBRO l ON g.id_genero = l.id_genero
                       GROUP BY g.nombre_genero)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Género: ' || genero_rec.nombre_genero || ', Cantidad de Libros: ' || genero_rec.cantidad_libros);
    END LOOP;
END;

//Buscar autor por nacionalidad

CREATE OR REPLACE PROCEDURE SP_BuscarAutorPorNacionalidad(
    p_nacionalidad IN VARCHAR2
)
IS
BEGIN
    FOR autor_rec IN (SELECT *
                      FROM AUTOR
                      WHERE id_nacionalidad = (SELECT id_nacionalidad FROM NACIONALIDAD WHERE nacionalidad = p_nacionalidad))
    LOOP
        -- Puedes hacer lo que quieras con los resultados, por ejemplo, imprimir información
        DBMS_OUTPUT.PUT_LINE('ID Autor: ' || autor_rec.id_autor || ', Apellido: ' || autor_rec.apellido1_autor);
    END LOOP;
END;

EXECUTE SP_BuscarAutorPorNacionalidad('Española');

//MOSTRAR INFORMACION DEL LIBRO

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
    SELECT titulo_libro, apellido1_autor, fecha_publicacion, numero_copias
    INTO v_TituloLibro, v_ApellidoAutor, v_FechaPublicacion, v_NumeroCopias
    FROM LIBRO
    WHERE id_libro = p_LibroID;

    DBMS_OUTPUT.PUT_LINE('ID del Libro: ' || p_LibroID);
    DBMS_OUTPUT.PUT_LINE('Título del Libro: ' || v_TituloLibro);
    DBMS_OUTPUT.PUT_LINE('Apellido del Autor: ' || v_ApellidoAutor);
    DBMS_OUTPUT.PUT_LINE('Fecha de Publicación: ' || TO_CHAR(v_FechaPublicacion, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Número de Copias: ' || v_NumeroCopias);
END;

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
END SP_ReservarLibro;

CREATE OR REPLACE PROCEDURE SP_ListarLibrosDisponibles AS
BEGIN
    SELECT *
    FROM LIBRO
    WHERE Numero_Copias > 0;
END SP_ListarLibrosDisponibles;

CREATE OR REPLACE PROCEDURE SP_ObtenerTelefonosCliente (
    p_CedulaCliente INT
) AS
BEGIN
    SELECT Numero_Telefono
    FROM TELEFONO
    WHERE Cedula_Cliente = p_CedulaCliente;
END SP_ObtenerTelefonosCliente;

CREATE OR REPLACE PROCEDURE SP_ListarLibrosPorFechaPublicacion AS
BEGIN
    SELECT *
    FROM LIBRO
    ORDER BY Fecha_Publicacion;
END SP_ListarLibrosPorFechaPublicacion;

CREATE OR REPLACE PROCEDURE SP_GenerarReporteReservas AS
BEGIN
    -- Aquí puedes implementar la lógica para generar el informe de reservas
    NULL;
END SP_GenerarReporteReservas;

CREATE OR REPLACE PROCEDURE SP_AsignarNacionalidadAutor (
    p_IdAutor INT,
    p_IdNacionalidad INT
) AS
BEGIN
    INSERT INTO AUTOR_NACIONALIDAD (ID_Autor, ID_Nacionalidad)
    VALUES (p_IdAutor, p_IdNacionalidad);
END SP_AsignarNacionalidadAutor;


