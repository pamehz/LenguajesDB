
/*////////////////VISTAS//////////////////////////////////*/
CREATE OR REPLACE VIEW V_Libros AS
SELECT
    L.ID_Libro,
    L.Titulo_Libro,
    L.Fecha_Publicacion,
    L.Numero_Copias
FROM
    LIBRO L
WHERE
    L.Numero_Copias >= 2;
Select * from V_Libros;


CREATE OR REPLACE VIEW V_AutoresFemeninos AS
SELECT
    A.ID_Autor,
    A.Nombre_Autor,
    A.Apellido1_Autor,
    A.Apellido2_Autor,
    N.Nacionalidad
FROM
    AUTOR A
    JOIN AUTOR_NACIONALIDAD AN ON A.ID_Autor = AN.ID_Autor
    JOIN NACIONALIDAD N ON AN.ID_Nacionalidad = N.ID_Nacionalidad
WHERE
    A.Genero_Autor = 'Femenino';
Select * from V_AutoresFemeninos;


CREATE OR REPLACE VIEW V_ReservasPorCliente AS
SELECT
    R.ID_Reserva,
    R.Fecha_Reserva,
    C.Cedula_Cliente,
    C.Nombre_Cliente,
    C.Apellido_Paterno,
    C.Apellido_Materno,
    L.ID_Libro,
    L.Titulo_Libro,
    L.Fecha_Publicacion
FROM
    RESERVA R
JOIN
    CLIENTE C ON R.ID_Libro = L.ID_Libro
JOIN
    LIBRO L ON C.ID_Reserva = R.ID_Reserva;
SELECT * FROM V_ReservasPorCliente;
