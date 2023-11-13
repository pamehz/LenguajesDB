CREATE TABLE Tab_USERS (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100),
    correo VARCHAR2(100),
    contrasenna VARCHAR2(100)
);

CREATE TABLE Tab_AUDITORIA_USERS (
    id NUMBER GENERATED ALWAYS AS IDENTITY,
    evento VARCHAR2(100),
    fecha_registro TIMESTAMP,
    nombre_usuario VARCHAR2(100),
    correo VARCHAR2(100),
    contrasenna VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER TGR_REGISTRO_AUDITORIA
AFTER INSERT ON Tab_USERS
FOR EACH ROW
BEGIN
    INSERT INTO Tab_AUDITORIA_USERS (evento, fecha_registro, nombre_usuario, correo, contrasenna)
    VALUES ('INSERT', SYSTIMESTAMP, :NEW.nombre, :NEW.correo, :NEW.contrasenna);
END;


CREATE OR REPLACE PACKAGE PKG_USER_MANAGEMENT IS

    PROCEDURE PCD_INSERT_USER(
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_contrasenna IN VARCHAR2
    );

    PROCEDURE PCD_DELETE_USER(
        p_id_usuario IN NUMBER
    );

END PKG_USER_MANAGEMENT;


CREATE OR REPLACE PACKAGE BODY PKG_USER_MANAGEMENT AS

    PROCEDURE PCD_INSERT_USER(
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_contrasenna IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Tab_USERS (nombre, correo, contrasenna)
        VALUES (p_nombre, p_correo, p_contrasenna);
        
        COMMIT;
    END PCD_INSERT_USER;

    PROCEDURE PCD_DELETE_USER(
        p_id_usuario IN NUMBER
    ) AS
    BEGIN
        DELETE FROM Tab_USERS WHERE id = p_id_usuario;
        COMMIT;
    END PCD_DELETE_USER;

END PKG_USER_MANAGEMENT;


BEGIN
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Juan', 'juan@gmail.com', 'juan123');
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Jose', 'jose@gmail.com', 'jose456');
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Anyi', 'anyi@gmail.com', 'anyi789');
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Joseth', 'joseth@gmail.com', 'joseth101');
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Jonathan', 'jonathan@gmail.com', 'jonathan202');
    COMMIT;
END;

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
