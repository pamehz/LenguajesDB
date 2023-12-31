
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
    A.Genero_Autor = 2;
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
    CLIENTE C ON R.ID_Libro = C.ID_Reserva
JOIN
    LIBRO L ON R.ID_Libro = L.ID_Libro;
SELECT * FROM V_ReservasPorCliente;

CREATE OR REPLACE VIEW V_LibrosPorIdioma AS
SELECT
    li.ID_Libro,
    l.Titulo_Libro,
    i.Nombre_Idioma
FROM
    LIBRO_IDIOMA li
JOIN
    LIBRO l ON li.ID_Libro = l.ID_Libro
JOIN
    IDIOMA i ON li.ID_Idioma = i.ID_Idioma;
SELECT * FROM V_LibrosPorIdioma;

CREATE OR REPLACE VIEW V_AutoresPorNacionalidad AS
SELECT
    a.ID_Autor,
    a.Nombre_Autor,
    a.Apellido1_Autor,
    a.Apellido2_Autor,
    n.Nacionalidad
FROM
    AUTOR a
JOIN
    AUTOR_NACIONALIDAD an ON a.ID_Autor = an.ID_Autor
JOIN
    NACIONALIDAD n ON an.ID_Nacionalidad = n.ID_Nacionalidad;
SELECT * FROM V_AutoresPorNacionalidad;


CREATE OR REPLACE VIEW V_ResumenGeneros AS
SELECT
    g.Nombre_Genero,
    COUNT(l.ID_Libro) AS CantidadLibros
FROM
    GENERO g
LEFT JOIN
    LIBRO l ON g.ID_Genero = l.ID_Genero
GROUP BY
    g.Nombre_Genero;
SELECT * FROM V_ResumenGeneros;

CREATE OR REPLACE VIEW V_ClientesMenoresEdad AS
SELECT
    Cedula_Cliente,
    Nombre_Cliente,
    Apellido_Paterno,
    Apellido_Materno,
    Fecha_Nacimiento
FROM
    CLIENTE
WHERE
    MONTHS_BETWEEN(SYSDATE, Fecha_Nacimiento) < 216; 
SELECT * FROM V_ClientesMenoresEdad;

CREATE OR REPLACE VIEW V_ListaLibrosDisponibles AS
SELECT *
FROM LIBRO
WHERE Numero_Copias > 0;
SELECT * FROM V_ListaLibrosDisponibles;

CREATE OR REPLACE VIEW V_ReservasPendientes AS
SELECT *
FROM RESERVA
WHERE Fecha_Reserva > SYSDATE;
SELECT * FROM V_ReservasPendientes;

CREATE OR REPLACE VIEW V_DetalleCliente AS
SELECT c.*, r.Fecha_Reserva, t.Numero_Telefono, co.Correo_Electronico, d.Direccion
FROM CLIENTE c
LEFT JOIN RESERVA r ON c.ID_Reserva = r.ID_Reserva
LEFT JOIN TELEFONO t ON c.Cedula_Cliente = t.Cedula_Cliente
LEFT JOIN CORREO co ON c.Cedula_Cliente = co.Cedula_Cliente
LEFT JOIN DIRECCION d ON c.Cedula_Cliente = d.Cedula_Cliente;
SELECT * FROM V_DetalleCliente;



