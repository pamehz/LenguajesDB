-- Crear tabla AUTOR 

CREATE TABLE AUTOR ( 

    ID_Autor INT NOT NULL PRIMARY KEY, 

    Nombre_Autor VARCHAR2(20) NOT NULL, 

    Apellido1_Autor VARCHAR2(20) NOT NULL, 

    Apellido2_Autor VARCHAR2(20) NOT NULL, 

    Genero_Autor INT NOT NULL 

); 

  

-- Crear tabla NACIONALIDAD 

CREATE TABLE NACIONALIDAD ( 

    ID_Nacionalidad INT NOT NULL PRIMARY KEY, 

    Nacionalidad VARCHAR2(30) NOT NULL 

); 

  

-- Crear tabla AUTOR_NACIONALIDAD 

CREATE TABLE AUTOR_NACIONALIDAD ( 

    ID_Autor INT NOT NULL, 

    ID_Nacionalidad INT NOT NULL, 

    CONSTRAINT PK_AUTOR_NACIONALIDAD PRIMARY KEY (ID_Autor, ID_Nacionalidad), 

    CONSTRAINT FK_AUTOR_NACIONALIDAD_Autor FOREIGN KEY (ID_Autor) REFERENCES AUTOR(ID_Autor), 

    CONSTRAINT FK_AUTOR_NACIONALIDAD_Nacionalidad FOREIGN KEY (ID_Nacionalidad) REFERENCES NACIONALIDAD(ID_Nacionalidad) 

); 

  

-- Crear tabla GENERO 

CREATE TABLE GENERO ( 

    ID_Genero INT NOT NULL PRIMARY KEY, 

    Nombre_Genero VARCHAR2(20) NOT NULL, 

    ID_Autor INT NOT NULL, 

    CONSTRAINT PK_GENERO PRIMARY KEY (ID_Genero), 

    CONSTRAINT FK_GENERO FOREIGN KEY (ID_Autor) REFERENCES AUTOR(ID_Autor) 

); 

  

-- Crear tabla LIBRO 

CREATE TABLE LIBRO ( 

    ID_Libro INT NOT NULL PRIMARY KEY, 

    Titulo_Libro VARCHAR2(90) NOT NULL, 

    Fecha_Publicacion DATE NOT NULL, 

    Numero_Copias INT NOT NULL, 

    ID_Genero INT NOT NULL, 

    CONSTRAINT PK_LIBRO PRIMARY KEY (ID_Libro), 

    CONSTRAINT FK_LIBRO_Genero FOREIGN KEY (ID_Genero) REFERENCES GENERO(ID_Genero) 

); 

  

-- Crear tabla IDIOMA 

CREATE TABLE IDIOMA ( 

    ID_Idioma INT NOT NULL PRIMARY KEY, 

    Nombre_Idioma VARCHAR2(20) NOT NULL 

); 

  

-- Crear tabla LIBRO_IDIOMA 

CREATE TABLE LIBRO_IDIOMA ( 

    ID_Idioma INT NOT NULL, 

    ID_Libro INT NOT NULL, 

    CONSTRAINT PK_LIBRO_IDIOMA PRIMARY KEY (ID_Idioma, ID_Libro), 

    CONSTRAINT FK_LIBRO_IDIOMA_Idioma FOREIGN KEY (ID_Idioma) REFERENCES IDIOMA(ID_Idioma), 

    CONSTRAINT FK_LIBRO_IDIOMA_Libro FOREIGN KEY (ID_Libro) REFERENCES LIBRO(ID_Libro) 

); 

  

-- Crear tabla RESERVA 

CREATE TABLE RESERVA ( 

    ID_Reserva INT NOT NULL PRIMARY KEY, 

    Fecha_Reserva DATE NOT NULL, 

    ID_Libro INT NOT NULL, 

    CONSTRAINT PK_RESERVA PRIMARY KEY (ID_Reserva), 

    CONSTRAINT FK_RESERVA_Libro FOREIGN KEY (ID_Libro) REFERENCES LIBRO(ID_Libro) 

); 

  

-- Crear tabla CLIENTE 

CREATE TABLE CLIENTE ( 

    Cedula_Cliente INT NOT NULL PRIMARY KEY, 

    Nombre_Cliente VARCHAR2(30) NOT NULL, 

    Apellido_Paterno VARCHAR2(20) NOT NULL, 

    Apellido_Materno VARCHAR2(20) NOT NULL, 

    Fecha_Nacimiento DATE NOT NULL, 

    ID_Reserva INT NOT NULL, 

    CONSTRAINT PK_CLIENTE PRIMARY KEY (Cedula_Cliente), 

    CONSTRAINT FK_CLIENTE_Reserva FOREIGN KEY (ID_Reserva) REFERENCES RESERVA(ID_Reserva) 

); 

  

-- Crear tabla TELEFONO 

CREATE TABLE TELEFONO ( 

    ID_Telefono INT NOT NULL PRIMARY KEY, 

    Numero_Telefono INT NOT NULL, 

    Cedula_Cliente INT NOT NULL, 

    CONSTRAINT PK_TELEFONO PRIMARY KEY (ID_Telefono), 

    CONSTRAINT FK_TELEFONO_Cliente FOREIGN KEY (Cedula_Cliente) REFERENCES CLIENTE(Cedula_Cliente) 

); 

  

-- Crear tabla CORREO 

CREATE TABLE CORREO ( 

    ID_Correo INT NOT NULL PRIMARY KEY, 

    Correo_Electronico VARCHAR2(70) NOT NULL, 

    Cedula_Cliente INT NOT NULL, 

    CONSTRAINT PK_CORREO PRIMARY KEY (ID_Correo), 

    CONSTRAINT FK_CORREO_Cliente FOREIGN KEY (Cedula_Cliente) REFERENCES CLIENTE(Cedula_Cliente) 

); 

  

-- Crear tabla DIRECCION 

CREATE TABLE DIRECCION ( 

    ID_Direccion INT NOT NULL PRIMARY KEY, 

    Direccion VARCHAR2(100) NOT NULL, 

    Cedula_Cliente INT NOT NULL, 

    CONSTRAINT PK_DIRECCION PRIMARY KEY (ID_Direccion), 

    CONSTRAINT FK_DIRECCION_Cliente FOREIGN KEY (Cedula_Cliente) REFERENCES CLIENTE(Cedula_Cliente) 

); 
