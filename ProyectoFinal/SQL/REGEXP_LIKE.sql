//REGEXP_LIKE//////////////////////////////
REM Buscar autores cuyo nombre empiece con 'J' y segundo apellido tengan una 'n':
SELECT *
FROM AUTOR
WHERE REGEXP_LIKE(Nombre_Autor, '^J') AND REGEXP_LIKE(Apellido2_Autor, 'n', 'i');


REM Buscar clientes cuyo correo electrónico sea de Gmail:
SELECT * 
FROM CLIENTE c
JOIN CORREO co ON c.Cedula_Cliente = co.Cedula_Cliente
WHERE REGEXP_LIKE(co.Correo_Electronico, 'gmail\.com$');

REM Buscar clientes cuyo número de teléfono empiece con '2':
SELECT * 
FROM CLIENTE c
JOIN TELEFONO t ON c.Cedula_Cliente = t.Cedula_Cliente
WHERE REGEXP_LIKE(t.Numero_Telefono, '^2');

REM Buscar libros cuyo título contiene la palabra 'Harry':
SELECT * 
FROM LIBRO
WHERE REGEXP_LIKE(Titulo_Libro, 'Harry');