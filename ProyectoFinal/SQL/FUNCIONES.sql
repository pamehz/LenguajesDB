
/*////////////////FUNCIONES//////////////////////////////////*/
CREATE OR REPLACE FUNCTION FN_GeneroFavoritoCliente(CedulaCliente IN INT)
RETURN VARCHAR2
AS
    GenFav VARCHAR2(20);
BEGIN
    SELECT g.Nombre_Genero
    INTO GenFav
    FROM LIBRO l
    JOIN GENERO g ON l.ID_Genero = g.ID_Genero
    JOIN RESERVA r ON l.ID_Libro = r.ID_Libro
    JOIN CLIENTE c ON r.ID_Reserva = c.ID_Reserva
    WHERE c.Cedula_Cliente = CedulaCliente
    GROUP BY g.Nombre_Genero
    ORDER BY COUNT(*) DESC;

    RETURN GenFav;
END;
SELECT GeneroFavoritoCliente(11111) FROM CLIENTES;


CREATE OR REPLACE FUNCTION FN_CantidadLibrosPorIdioma(ID_Idioma IN NUMBER)
RETURN NUMBER
AS
  V_COUNT NUMBER;
BEGIN
  SELECT COUNT(*) INTO V_COUNT
  FROM LIBRO_IDIOMA LI
  WHERE LI.ID_Idioma = ID_Idioma;

  RETURN V_COUNT;
END;
SELECT FN_CantidadLibrosPorIdioma(1) AS CantLibros_Ingles FROM DUAL;


CREATE OR REPLACE FUNCTION FN_PrimCorreo(CEDULA_CLIENTE_IN IN NUMBER)
RETURN VARCHAR2
AS
    V_CORREO VARCHAR2(70);
BEGIN
    SELECT Correo_Electronico
    INTO V_CORREO
    FROM CORREO
    WHERE Cedula_Cliente = CEDULA_CLIENTE_IN
    ORDER BY ID_Correo;

    RETURN V_CORREO;
END;
SELECT OBTENER_PRIMER_CORREO(11111) FROM DUAL;


CREATE OR REPLACE FUNCTION FN_CantLibroAnio(ANIO IN NUMBER)
RETURN NUMBER
AS
  VCANTIDAD NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO VCANTIDAD
  FROM LIBRO
  WHERE EXTRACT(YEAR FROM Fecha_Publicacion) = ANIO;

  RETURN VCANTIDAD;
END;
SELECT FN_CantLibroAnio(2022) FROM DUAL;

CREATE OR REPLACE FUNCTION FN_CantidadLibrosPorAutor (
    p_IdAutor INT
) RETURN INT AS
    v_CantidadLibros INT;
BEGIN
    SELECT COUNT(l.ID_Libro)
    INTO v_CantidadLibros
    FROM LIBRO l
    JOIN GENERO g ON l.ID_Genero = g.ID_Genero
    WHERE g.ID_Autor = p_IdAutor;

    RETURN v_CantidadLibros;
END;

CREATE OR REPLACE FUNCTION FN_PromedioEdadClientes RETURN NUMBER AS
    v_PromedioEdad NUMBER;
BEGIN
    SELECT AVG(MONTHS_BETWEEN(SYSDATE, Fecha_Nacimiento) / 12)
    INTO v_PromedioEdad
    FROM CLIENTE;

    RETURN v_PromedioEdad;
END;

CREATE OR REPLACE FUNCTION FN_ObtenerLibroMasReciente RETURN VARCHAR2 AS
    v_LibroMasReciente VARCHAR2(90);
BEGIN
    SELECT Titulo_Libro
    INTO v_LibroMasReciente
    FROM LIBRO
    WHERE Fecha_Publicacion = (SELECT MAX(Fecha_Publicacion) FROM LIBRO);

    RETURN v_LibroMasReciente;
END;

CREATE OR REPLACE FUNCTION FN_ExistenReservasCliente (
    p_CedulaCliente INT
) RETURN BOOLEAN AS
    v_ExistenReservas BOOLEAN;
BEGIN
    SELECT COUNT(*)
    INTO v_ExistenReservas
    FROM RESERVA
    WHERE ID_Libro IN (SELECT ID_Libro FROM LIBRO WHERE ID_Genero IN (SELECT ID_Genero FROM GENERO WHERE ID_Autor = p_CedulaCliente));

    RETURN v_ExistenReservas > 0;
END;

CREATE OR REPLACE FUNCTION FN_ListarLibrosPorGenero (
    p_IdGenero INT
) RETURN SYS_REFCURSOR AS
    v_Cursor SYS_REFCURSOR;
BEGIN
    OPEN v_Cursor FOR
    SELECT Titulo_Libro
    FROM LIBRO
    WHERE ID_Genero = p_IdGenero;

    RETURN v_Cursor;
END;
