-- Trigger #1: Actualizar el total de copias disponibles cuando se realiza una reserva: 

CREATE OR REPLACE TRIGGER reserva_trigger
AFTER INSERT ON RESERVA
FOR EACH ROW
BEGIN
   UPDATE LIBRO
   SET Numero_Copias = Numero_Copias - 1
   WHERE ID_Libro = :NEW.ID_Libro;
END;

  
-- Trigger #2: Update de cantidad de Libros Después de Reservar

CREATE OR REPLACE TRIGGER actualizar_cantidad_libros
AFTER INSERT ON RESERVA
FOR EACH ROW
DECLARE
   v_nueva_cantidad NUMBER;
BEGIN
   SELECT (l.Numero_Copias - 1) INTO v_nueva_cantidad
   FROM LIBRO l
   WHERE l.ID_Libro = :NEW.ID_Libro;
   UPDATE LIBRO
   SET Numero_Copias = v_nueva_cantidad
   WHERE ID_Libro = :NEW.ID_Libro;
END;

-- Trigger #3: Actualizar reserva cliente

CREATE OR REPLACE TRIGGER actualizar_reserva_cliente
AFTER INSERT ON RESERVA
FOR EACH ROW
DECLARE
   v_nueva_reserva NUMBER;
BEGIN

   SELECT (c.ID_Reserva + 1) INTO v_nueva_reserva
   FROM CLIENTE c
   WHERE c.Cedula_Cliente = :NEW.ID_Libro; 

   UPDATE CLIENTE
   SET ID_Reserva = v_nueva_reserva
   WHERE Cedula_Cliente = :NEW.ID_Libro; 
END;

-- Trigger #4: Actualizar copias tras la inserción de idiomas 

CREATE OR REPLACE TRIGGER actualizar_cantidad_copias_libro_idioma
AFTER INSERT ON LIBRO_IDIOMA
FOR EACH ROW
DECLARE
   v_nueva_cantidad NUMBER;
BEGIN
   SELECT (l.Numero_Copias - 1) INTO v_nueva_cantidad
   FROM LIBRO l
   WHERE l.ID_Libro = :NEW.ID_Libro;

   UPDATE LIBRO
   SET Numero_Copias = v_nueva_cantidad
   WHERE ID_Libro = :NEW.ID_Libro;
END;

-- Trigger #5: Actualizar copias tras eliminar reserva

CREATE OR REPLACE TRIGGER actualizar_cantidad_copias_eliminar_reserva
AFTER DELETE ON RESERVA
FOR EACH ROW
DECLARE
   v_nueva_cantidad NUMBER;
BEGIN
   SELECT (l.Numero_Copias + 1) INTO v_nueva_cantidad
   FROM LIBRO l
   WHERE l.ID_Libro = :OLD.ID_Libro;

   UPDATE LIBRO
   SET Numero_Copias = v_nueva_cantidad
   WHERE ID_Libro = :OLD.ID_Libro;
END;
