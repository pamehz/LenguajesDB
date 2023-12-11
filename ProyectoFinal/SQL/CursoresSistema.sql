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

EXEC SP_ListaLibros();
/**/
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

EXEC SP_CAutoresPorGenero();

/**/
SELECT * FROM RESERVA
CREATE OR REPLACE PROCEDURE SP_ReservasPorCliente(p_ID_Cliente IN INT) AS
BEGIN
    FOR reserva_rec IN (
        SELECT R.ID_Reserva, R.Fecha_Reserva, L.Titulo_Libro, C.Nombre_Cliente, C.Apellido_Paterno, C.Apellido_Materno
FROM RESERVA R
JOIN LIBRO L ON R.ID_Libro = L.ID_Libro
JOIN CLIENTE C ON R.ID_Reserva = C.ID_Reserva
WHERE C.Cedula_Cliente = p_ID_Cliente

    ) 
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID Reserva: ' || reserva_rec.ID_Reserva || ', Fecha: ' ||
                             TO_CHAR(reserva_rec.Fecha_Reserva, 'DD-MON-YYYY') || ', Título: ' ||
                             reserva_rec.Titulo_Libro);
    END LOOP;
END SP_ReservasPorCliente;

CREATE OR REPLACE PROCEDURE SP_ReservasCliente(p_ID_Cliente IN INTEGER) AS
BEGIN
    SP_ReservasPorCliente(p_ID_Cliente);
END SP_ReservasCliente;

EXEC SP_ReservasCliente(1111);

/**/
CREATE OR REPLACE PROCEDURE SP_LibrosPorIdioma(p_ID_Idioma IN INTEGER) AS
BEGIN
    FOR libro_idioma IN (
        SELECT LI.ID_Libro, L.Titulo_Libro, I.Nombre_Idioma
FROM LIBRO_IDIOMA LI
JOIN LIBRO L ON LI.ID_Libro = L.ID_Libro
JOIN IDIOMA I ON LI.ID_Idioma = I.ID_Idioma
WHERE LI.ID_Idioma = p_ID_Idioma

    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Libro: ' || libro_idioma.ID_Libro || ', Título: ' || libro_idioma.Titulo_Libro);
    END LOOP;
END SP_LibrosPorIdioma;

CREATE OR REPLACE PROCEDURE SP_CLibrosPorIdioma(p_ID_Idioma IN INTEGER) AS
BEGIN
    SP_LibrosPorIdioma(p_ID_Idioma); 
END SP_CLibrosPorIdioma;

EXEC SP_CLibrosPorIdioma(1);