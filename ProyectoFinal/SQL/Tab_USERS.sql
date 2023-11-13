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
/

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
/

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
/

BEGIN
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Juan', 'juan@gmail.com', 'juan123');
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Jose', 'jose@gmail.com', 'jose456');
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Anyi', 'anyi@gmail.com', 'anyi789');
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Joseth', 'joseth@gmail.com', 'joseth101');
    PKG_USER_MANAGEMENT.PCD_INSERT_USER('Jonathan', 'jonathan@gmail.com', 'jonathan202');
    COMMIT;
END;
/