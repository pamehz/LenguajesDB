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



