CREATE OR REPLACE PROCEDURE SP_ListaCompletaLibros AS
BEGIN
    FOR libro IN (SELECT ID_Libro, Titulo_Libro FROM LIBRO) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Libro: ' || libro.ID_Libro || ', Título: ' || libro.Titulo_Libro);
    END LOOP;
END SP_ListaCompletaLibros;

CREATE OR REPLACE PROCEDURE SP_ListaLibros AS
BEGIN
    SP_ListaCompletaLibros; 
END SP_ListaLibros;



CREATE OR REPLACE PROCEDURE SP_AutoresPorGenero AS
BEGIN
    FOR autor IN (
        SELECT A.Nombre_Autor, A.Apellido1_Autor, A.Apellido2_Autor, G.Nombre_Genero
        FROM AUTOR A
        JOIN GENERO G ON A.ID_Autor = G.ID_Autor
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Autor: ' || autor.Nombre_Autor || ' ' || autor.Apellido1_Autor ||
                             ' ' || autor.Apellido2_Autor || ', Género: ' || autor.Nombre_Genero);
    END LOOP;
END SP_AutoresPorGenero;

CREATE OR REPLACE PROCEDURE SP_CAutoresPorGenero AS
BEGIN
    SP_AutoresPorGenero; 
END SP_CAutoresPorGenero;



CREATE OR REPLACE PROCEDURE SP_ReservasPorCliente(p_ID_Cliente IN INTEGER) AS
BEGIN
    FOR reserva IN (
        SELECT R.ID_Reserva, R.Fecha_Reserva, L.Titulo_Libro
        FROM RESERVA R
        JOIN LIBRO L ON R.ID_Libro = L.ID_Libro
        WHERE R.ID_Cliente = p_ID_Cliente
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Reserva: ' || reserva.ID_Reserva || ', Fecha: ' ||
                             TO_CHAR(reserva.Fecha_Reserva, 'DD-MON-YYYY') || ', Título: ' ||
                             reserva.Titulo_Libro);
    END LOOP;
END SP_ReservasPorCliente;

CREATE OR REPLACE PROCEDURE SP_ReservasCliente(p_ID_Cliente IN INTEGER) AS
BEGIN
    SP_ReservasPorCliente(p_ID_Cliente);
END SP_ReservasCliente;



CREATE OR REPLACE PROCEDURE SP_LibrosPorIdioma(p_ID_Idioma IN INTEGER) AS
BEGIN
    FOR libro_idioma IN (
        SELECT LI.ID_Libro, LI.Titulo_Libro
        FROM LIBRO_IDIOMA LI
        JOIN LIBRO L ON LI.ID_Libro = L.ID_Libro
        WHERE LI.ID_Idioma = p_ID_Idioma
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Libro: ' || libro_idioma.ID_Libro || ', Título: ' || libro_idioma.Titulo_Libro);
    END LOOP;
END SP_LibrosPorIdioma;

CREATE OR REPLACE PROCEDURE SP_CLibrosPorIdioma(p_ID_Idioma IN INTEGER) AS
BEGIN
    SP_LibrosPorIdioma(p_ID_Idioma); 
END SP_CLibrosPorIdioma;



CREATE OR REPLACE PROCEDURE SP_DetalleCliente(p_Cedula_Cliente IN INTEGER) AS
BEGIN
    -- Suponiendo que aquí se muestran los detalles completos del cliente
    -- Se debería implementar la lógica para mostrar los detalles del cliente
    DBMS_OUTPUT.PUT_LINE('Detalles del cliente con Cédula: ' || p_Cedula_Cliente);
    -- Aquí deberías llamar a otros procedimientos o realizar consultas para obtener los detalles del cliente
    -- No se ha proporcionado la implementación detallada del procedimiento SP_DetalleCliente para este ejemplo
END SP_DetalleCliente;

CREATE OR REPLACE PROCEDURE SP_CDetalleCliente(p_Cedula_Cliente IN INTEGER) AS
BEGIN
    SP_DetalleCliente(p_Cedula_Cliente); -- Llamada al procedimiento que muestra detalles del cliente
END SP_CDetalleCliente;
