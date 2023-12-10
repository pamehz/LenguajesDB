BEGIN
    INSERT INTO NACIONALIDAD (ID_Nacionalidad, Nacionalidad) VALUES (01, 'Estado Unidos');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ya existe una entrada con ID_Nacionalidad = 01.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado al insertar en NACIONALIDAD: ' || SQLERRM);
END;

BEGIN
    INSERT INTO NACIONALIDAD (ID_Nacionalidad, Nacionalidad) VALUES (02, 'Reino Unido');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ya existe una entrada con ID_Nacionalidad = 02.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado al insertar en NACIONALIDAD: ' || SQLERRM);
END;

BEGIN
    INSERT INTO NACIONALIDAD (ID_Nacionalidad, Nacionalidad) VALUES (03, 'Rumania');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ya existe una entrada con ID_Nacionalidad = 03.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado al insertar en NACIONALIDAD: ' || SQLERRM);
END;
