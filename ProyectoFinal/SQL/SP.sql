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

