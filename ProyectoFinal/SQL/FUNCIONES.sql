
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
SELECT FN_GeneroFavoritoCliente(1111) FROM CLIENTE;

CREATE OR REPLACE FUNCTION FN_TotalLibros RETURN INT IS
    v_TotalLibros INT;
BEGIN
    SELECT COUNT(*) INTO v_TotalLibros FROM LIBRO;
    RETURN v_TotalLibros;
END FN_TotalLibros;
SELECT FN_TotalLibros() FROM LIBRO;

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
SELECT FN_PrimCorreo(1111) FROM DUAL;


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
SELECT FN_CantidadLibrosPorAutor(01) FROM DUAL;

CREATE OR REPLACE FUNCTION FN_PromedioEdadClientes RETURN NUMBER AS
    v_PromedioEdad NUMBER;
BEGIN
    SELECT AVG(MONTHS_BETWEEN(SYSDATE, Fecha_Nacimiento) / 12)
    INTO v_PromedioEdad
    FROM CLIENTE;

    RETURN v_PromedioEdad;
END;
SELECT FN_PromedioEdadClientes() FROM DUAL;

CREATE OR REPLACE FUNCTION FN_ObtenerLibroMasReciente RETURN VARCHAR2 AS
    v_LibroMasReciente VARCHAR2(90);
BEGIN
    SELECT Titulo_Libro
    INTO v_LibroMasReciente
    FROM LIBRO
    WHERE Fecha_Publicacion = (SELECT MAX(Fecha_Publicacion) FROM LIBRO);

    RETURN v_LibroMasReciente;
END;
SELECT FN_ObtenerLibroMasReciente() FROM DUAL;

CREATE OR REPLACE FUNCTION FN_ExistenReservasCliente (
    p_CedulaCliente INT
) RETURN NUMBER AS
    v_ExistenReservas NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_ExistenReservas
    FROM RESERVA
    WHERE ID_Libro IN (SELECT ID_Libro FROM LIBRO WHERE ID_Genero IN (SELECT ID_Genero FROM GENERO WHERE ID_Autor = p_CedulaCliente));

    RETURN CASE WHEN v_ExistenReservas > 0 THEN 1 ELSE 0 END;
END;
SELECT FN_ExistenReservasCliente(1111) FROM DUAL;


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
SELECT FN_ExistenReservasCliente(01) FROM DUAL;


CREATE OR REPLACE FUNCTION ContarLibrosPorGenero( 
    p_nombre_genero VARCHAR2)
RETURN NUMBER
AS
    cantidad_libros NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO cantidad_libros
    FROM LIBRO
    WHERE id_genero = (SELECT id_genero FROM GENERO WHERE nombre_genero = p_nombre_genero);
    RETURN cantidad_libros;
END;
SELECT ContarLibrosPorGenero('Terror') FROM DUAL;


CREATE OR REPLACE FUNCTION ObtenerNacionalidadAutor(
    p_id_autor NUMBER
)
RETURN VARCHAR2
AS
    nacionalidad_autor VARCHAR2(50);
BEGIN
    SELECT MAX(nacionalidad)
    INTO nacionalidad_autor
    FROM NACIONALIDAD
    WHERE id_nacionalidad = (SELECT id_nacionalidad FROM AUTOR WHERE id_autor = p_id_autor);
    
    RETURN nacionalidad_autor;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL; 
END;
SELECT ObtenerNacionalidadAutor(02) FROM DUAL;


CREATE OR REPLACE FUNCTION IdiomaLibro(
    p_id_libro NUMBER
)
RETURN VARCHAR2
AS
    idioma_libro VARCHAR2(50);
BEGIN
    SELECT nombre_idioma
    INTO idioma_libro
    FROM Idioma
    WHERE id_idioma = (SELECT id_idioma FROM Libro_Idioma WHERE id_libro = p_id_libro AND ROWNUM = 1);

    RETURN idioma_libro;
END;
SELECT IdiomaLibro(02) FROM DUAL;

/**/
CREATE OR REPLACE FUNCTION FN_ObtenerLibrosPorAutor
(
    p_AutorID IN NUMBER
)
RETURN SYS_REFCURSOR
AS
    v_Cursor SYS_REFCURSOR;
BEGIN
    OPEN v_Cursor FOR
    SELECT id_libro, titulo_libro, fecha_publicacion
    FROM LIBRO
    WHERE autor_id = p_AutorID;

    RETURN v_Cursor;
END;
SELECT FN_ObtenerLibrosPorAutor(02) FROM DUAL;


CREATE OR REPLACE FUNCTION FN_ObtenerLibrosPorFechaPublicacion (
    p_FechaDesde IN DATE,
    p_FechaHasta IN DATE
) RETURN SYS_REFCURSOR
AS
    v_Cursor SYS_REFCURSOR;
BEGIN
    OPEN v_Cursor FOR
    SELECT id_libro, titulo_libro, fecha_publicacion
    FROM LIBRO
    WHERE fecha_publicacion BETWEEN p_FechaDesde AND p_FechaHasta;
    
    RETURN v_Cursor;
END FN_ObtenerLibrosPorFechaPublicacion;
SELECT FN_ObtenerLibrosPorFechaPublicacion(TO_DATE('07/08/2022', 'MM/DD/YYYY'), TO_DATE('07/08/22', 'MM/DD/YY')) as Fecha_Public FROM DUAL;
