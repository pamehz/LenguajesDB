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


