CREATE OR REPLACE PACKAGE PKG_Utiles AS
    -- Función para calcular la edad
    FUNCTION FN_CalcularEdad(p_FechaNacimiento DATE) RETURN NUMBER;
    -- Procedimiento para imprimir un mensaje
    PROCEDURE SP_ImprimirMensaje(p_Mensaje VARCHAR2);
END PKG_Utiles;


CREATE OR REPLACE PACKAGE BODY PKG_Utiles AS
    FUNCTION FN_CalcularEdad(p_FechaNacimiento DATE) RETURN NUMBER IS
    BEGIN
        RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, p_FechaNacimiento) / 12);
    END FN_CalcularEdad;

    PROCEDURE SP_ImprimirMensaje(p_Mensaje VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(p_Mensaje);
    END SP_ImprimirMensaje;
END PKG_Utiles;
**
  
CREATE OR REPLACE PACKAGE PKG_Reportes AS
    -- Función para obtener el total de libros por género
    FUNCTION FN_TotalLibrosPorGenero(p_IdGenero INT) RETURN NUMBER;
    -- Procedimiento para generar un informe de reservas
    PROCEDURE SP_GenerarInformeReservas;
END PKG_Reportes;


CREATE OR REPLACE PACKAGE BODY PKG_Reportes AS
    FUNCTION FN_TotalLibrosPorGenero(p_IdGenero INT) RETURN NUMBER IS
        v_TotalLibros NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_TotalLibros
        FROM LIBRO
        WHERE ID_Genero = p_IdGenero;

        RETURN v_TotalLibros;
    END FN_TotalLibrosPorGenero;

    PROCEDURE SP_GenerarInformeReservas IS
    BEGIN
        -- Lógica para generar el informe de reservas
        NULL;
    END SP_GenerarInformeReservas;
END PKG_Reportes;

**
  
CREATE OR REPLACE PACKAGE PKG_GestionAutores AS
    -- Procedimiento para agregar un nuevo autor
    PROCEDURE SP_AgregarAutor(p_Nombre VARCHAR2, p_Apellido1 VARCHAR2, p_Apellido2 VARCHAR2, p_Genero INT);
    -- Procedimiento para actualizar información de un autor
    PROCEDURE SP_ActualizarAutor(p_IdAutor INT, p_Nombre VARCHAR2, p_Apellido1 VARCHAR2, p_Apellido2 VARCHAR2, p_Genero INT);
    -- Procedimiento para eliminar un autor y sus referencias
    PROCEDURE SP_EliminarAutor(p_IdAutor INT);
END PKG_GestionAutores;


CREATE OR REPLACE PACKAGE BODY PKG_GestionAutores AS
    PROCEDURE SP_AgregarAutor(p_Nombre VARCHAR2, p_Apellido1 VARCHAR2, p_Apellido2 VARCHAR2, p_Genero INT) IS
    BEGIN
        -- Lógica para agregar un nuevo autor
        NULL;
    END SP_AgregarAutor;

    PROCEDURE SP_ActualizarAutor(p_IdAutor INT, p_Nombre VARCHAR2, p_Apellido1 VARCHAR2, p_Apellido2 VARCHAR2, p_Genero INT) IS
    BEGIN
        -- Lógica para actualizar la información de un autor
        NULL;
    END SP_ActualizarAutor;

    PROCEDURE SP_EliminarAutor(p_IdAutor INT) IS
    BEGIN
        -- Lógica para eliminar un autor y sus referencias
        NULL;
    END SP_EliminarAutor;
END PKG_GestionAutores;

**

CREATE OR REPLACE PACKAGE PKG_GestionClientes AS
    -- Procedimiento para agregar un nuevo cliente
    PROCEDURE SP_AgregarCliente(p_Cedula INT, p_Nombre VARCHAR2, p_ApellidoPaterno VARCHAR2, p_ApellidoMaterno VARCHAR2, p_FechaNacimiento DATE);
    -- Procedimiento para actualizar la información de un cliente
    PROCEDURE SP_ActualizarCliente(p_Cedula INT, p_Nombre VARCHAR2, p_ApellidoPaterno VARCHAR2, p_ApellidoMaterno VARCHAR2, p_FechaNacimiento DATE);
    -- Procedimiento para eliminar un cliente y sus referencias
    PROCEDURE SP_EliminarCliente(p_Cedula INT);
    -- Función para obtener detalles de un cliente
    FUNCTION FN_ObtenerDetalleCliente(p_Cedula INT) RETURN SYS_REFCURSOR;
END PKG_GestionClientes;


CREATE OR REPLACE PACKAGE BODY PKG_GestionClientes AS
    PROCEDURE SP_AgregarCliente(p_Cedula INT, p_Nombre VARCHAR2, p_ApellidoPaterno VARCHAR2, p_ApellidoMaterno VARCHAR2, p_FechaNacimiento DATE) IS
    BEGIN
        -- Lógica para agregar un nuevo cliente
        NULL;
    END SP_AgregarCliente;

    PROCEDURE SP_ActualizarCliente(p_Cedula INT, p_Nombre VARCHAR2, p_ApellidoPaterno VARCHAR2, p_ApellidoMaterno VARCHAR2, p_FechaNacimiento DATE) IS
    BEGIN
        -- Lógica para actualizar la información de un cliente
        NULL;
    END SP_ActualizarCliente;

    PROCEDURE SP_EliminarCliente(p_Cedula INT) IS
    BEGIN
        -- Lógica para eliminar un cliente y sus referencias
        NULL;
    END SP_EliminarCliente;

    FUNCTION FN_ObtenerDetalleCliente(p_Cedula INT) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
        SELECT *
        FROM CLIENTE
        WHERE Cedula_Cliente = p_Cedula;

        RETURN v_Cursor;
    END FN_ObtenerDetalleCliente;
END PKG_GestionClientes;

**

CREATE OR REPLACE PACKAGE PKG_GestionLibros AS
    -- Procedimiento para agregar un nuevo libro
    PROCEDURE SP_AgregarLibro(p_IdLibro INT, p_Titulo VARCHAR2, p_FechaPublicacion DATE, p_NumeroCopias INT, p_IdGenero INT);
    -- Procedimiento para actualizar información de un libro
    PROCEDURE SP_ActualizarLibro(p_IdLibro INT, p_Titulo VARCHAR2, p_FechaPublicacion DATE, p_NumeroCopias INT, p_IdGenero INT);
    -- Procedimiento para eliminar un libro
    PROCEDURE SP_EliminarLibro(p_IdLibro INT);
    -- Función para obtener detalles de un libro
    FUNCTION FN_ObtenerDetalleLibro(p_IdLibro INT) RETURN SYS_REFCURSOR;
END PKG_GestionLibros;


CREATE OR REPLACE PACKAGE BODY PKG_GestionLibros AS
    PROCEDURE SP_AgregarLibro(p_IdLibro INT, p_Titulo VARCHAR2, p_FechaPublicacion DATE, p_NumeroCopias INT, p_IdGenero INT) IS
    BEGIN
        -- Lógica para agregar un nuevo libro
        NULL;
    END SP_AgregarLibro;

    PROCEDURE SP_ActualizarLibro(p_IdLibro INT, p_Titulo VARCHAR2, p_FechaPublicacion DATE, p_NumeroCopias INT, p_IdGenero INT) IS
    BEGIN
        -- Lógica para actualizar información de un libro
        NULL;
    END SP_ActualizarLibro;

    PROCEDURE SP_EliminarLibro(p_IdLibro INT) IS
    BEGIN
        -- Lógica para eliminar un libro
        NULL;
    END SP_EliminarLibro;

    FUNCTION FN_ObtenerDetalleLibro(p_IdLibro INT) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
        SELECT *
        FROM LIBRO
        WHERE ID_Libro = p_IdLibro;

        RETURN v_Cursor;
    END FN_ObtenerDetalleLibro;
END PKG_GestionLibros;

**

CREATE OR REPLACE PACKAGE PKG_GestionReservas AS
    -- Procedimiento para realizar una reserva
    PROCEDURE SP_RealizarReserva(p_IdReserva INT, p_FechaReserva DATE, p_IdLibro INT);
    -- Procedimiento para actualizar una reserva
    PROCEDURE SP_ActualizarReserva(p_IdReserva INT, p_FechaReserva DATE, p_IdLibro INT);
    -- Procedimiento para cancelar una reserva
    PROCEDURE SP_CancelarReserva(p_IdReserva INT);
    -- Función para obtener detalles de una reserva
    FUNCTION FN_ObtenerDetalleReserva(p_IdReserva INT) RETURN SYS_REFCURSOR;
END PKG_GestionReservas;


CREATE OR REPLACE PACKAGE BODY PKG_GestionReservas AS
    PROCEDURE SP_RealizarReserva(p_IdReserva INT, p_FechaReserva DATE, p_IdLibro INT) IS
    BEGIN
        -- Lógica para realizar una reserva
        NULL;
    END SP_RealizarReserva;

    PROCEDURE SP_ActualizarReserva(p_IdReserva INT, p_FechaReserva DATE, p_IdLibro INT) IS
    BEGIN
        -- Lógica para actualizar una reserva
        NULL;
    END SP_ActualizarReserva;

    PROCEDURE SP_CancelarReserva(p

**
