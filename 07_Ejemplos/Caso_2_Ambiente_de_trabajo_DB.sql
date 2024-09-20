/*   UNIVERSIDAD ESTATAL A DISTANCIA
   DIRECCION DE EXTENSION UNIVERSITARIA
    AREA DE COMUNICACION Y TECNOLOGIA
       FUNDAMENTOS DE BASE DE DATOS
           CASO 2: AMBIENTE DE TRABAJO INICIAL
*/

-- BASE DE DATOS ------------------------------------------------------
-- ELIMINACION DE LA BASE DE DATOS
USE master
DROP DATABASE BD_UNED2

-- CREACION DE LA BASE DE DATOS
CREATE DATABASE BD_UNED2


-- ESTABLECER COMO ACTIVA LA BASE DE DATOS
USE BD_UNED2



-- CREACION DE TABLAS -------------------------------------------------
-- TABLA CARRERAS
CREATE TABLE Carreras(
	IdCarrera INT NOT NULL,
	Descripcion VARCHAR(50) NOT NULL,
 PRIMARY KEY (IdCarrera)
);

-- TABLA EDIFICIOS
CREATE TABLE Edificios(
	IdEdificio INT NOT NULL,
	Descripcion VARCHAR(50) NOT NULL,
 PRIMARY KEY (IdEdificio)
);

-- TABLA AULAS
CREATE TABLE Aulas(
	IdEdificio INT NOT NULL,
	IdAula INT NOT NULL,
	Capacidad INT NOT NULL,
	Piso INT NOT NULL,
 PRIMARY KEY (IdEdificio, IdAula),
 FOREIGN KEY (IdEdificio) REFERENCES Edificios(IdEdificio)
);

-- TABLA PROVINCIAS
CREATE TABLE Provincias(
	IdProvincia INT NOT NULL,
	Descripcion VARCHAR(50) NOT NULL,
 PRIMARY KEY (IdProvincia)
);

-- TABLA CANTONES
CREATE TABLE Cantones(
	IdProvincia INT NOT NULL,
	IdCanton INT NOT NULL,
	Descripcion VARCHAR(50) NOT NULL,
 PRIMARY KEY (IdProvincia, IdCanton),
 FOREIGN KEY (IdProvincia) REFERENCES Provincias(IdProvincia)
);

-- TABLA DISTRITOS
CREATE TABLE Distritos(
	IdProvincia INT NOT NULL,
	IdCanton INT NOT NULL,
	IdDistrito INT NOT NULL,
	Descripcion VARCHAR(50) NOT NULL,
 PRIMARY KEY (IdProvincia, IdCanton, IdDistrito),
 FOREIGN KEY (IdProvincia, IdCanton) REFERENCES Cantones(IdProvincia, IdCanton)
);

-- TABLA ESTUDIANTES
CREATE TABLE Estudiantes(
	IdEstudiante INT NOT NULL,
	Nombre VARCHAR(15) NOT NULL,
	Apellido1 VARCHAR(15) NOT NULL,
	Apellido2 VARCHAR(15) NOT NULL,
	FechaNacimiento DATETIME NOT NULL,
	Edad INT NOT NULL,
	IdProvincia INT NOT NULL,
	IdCanton INT NOT NULL,
	IdDistrito INT NOT NULL,
 PRIMARY KEY (IdEstudiante),
 FOREIGN KEY (IdProvincia, IdCanton, IdDistrito) REFERENCES Distritos(IdProvincia, IdCanton, IdDistrito)
);

-- TABLA TELEFONOS DE ESTUDIANTES
CREATE TABLE TelefonosEstudiante(
	Telefono INT NOT NULL,
	IdEstudiante INT NOT NULL,
 PRIMARY KEY (Telefono),
 FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante)
);

-- TABLA ASIGNATURAS
CREATE TABLE Asignaturas(
	IdAsignatura INT NOT NULL,
	Descripcion VARCHAR(50) NOT NULL,
	Creditos INT NOT NULL,
 PRIMARY KEY (IdAsignatura)
);

-- TABLA PROFESORES
CREATE TABLE Profesores(
	IdProfesor INT NOT NULL,
	Nombre VARCHAR(15) NOT NULL,
	Apellido1 VARCHAR(15) NOT NULL,
	Apellido2 VARCHAR(15) NOT NULL,
	FechaNacimiento DATETIME NOT NULL,
	IdProvincia INT NOT NULL,
	IdCanton INT NOT NULL,
	IdDistrito INT NOT NULL,
 PRIMARY KEY (IdProfesor),
 FOREIGN KEY (IdProvincia, IdCanton, IdDistrito) REFERENCES Distritos(IdProvincia, IdCanton, IdDistrito)
);

-- TABLA TELEFONOS DE PROFESORES
CREATE TABLE TelefonosProfesor(
	Telefono INT NOT NULL,
	IdProfesor INT NOT NULL,
 PRIMARY KEY (Telefono),
 FOREIGN KEY (IdProfesor) REFERENCES Profesores(IdProfesor)
);

-- TABLA ASIGNATURAS DE PROFESORES
CREATE TABLE AsignaturasProfesor(
	IdAsignatura INT NOT NULL,
	IdProfesor INT NOT NULL,
 PRIMARY KEY (IdAsignatura),
 FOREIGN KEY (IdAsignatura) REFERENCES Asignaturas(IdAsignatura),
 FOREIGN KEY (IdProfesor) REFERENCES Profesores(IdProfesor)
);

-- TABLA CARRERA DE PROFESOR
CREATE TABLE CarreraProfesor(
	IdCarrera INT NOT NULL,
	IdProfesor INT NOT NULL,
 PRIMARY KEY (IdCarrera),
 FOREIGN KEY (IdCarrera) REFERENCES Carreras(IdCarrera),
 FOREIGN KEY (IdProfesor) REFERENCES Profesores(IdProfesor)
);

-- TABLA ASIGNATURAS DE CARRERAS
CREATE TABLE AsignaturasCarrera(
	IdAsignatura INT NOT NULL,
	IdCarrera INT NOT NULL,
 PRIMARY KEY (IdAsignatura, IdCarrera),
 FOREIGN KEY (IdAsignatura) REFERENCES Asignaturas(IdAsignatura),
 FOREIGN KEY (IdCarrera) REFERENCES Carreras(IdCarrera)
);

-- TABLA ASIGNATURAS DE ESTUDIANTES
CREATE TABLE AsignaturasEstudiante(
	IdAsignatura INT NOT NULL,
	IdEstudiante INT NOT NULL,
	Calificacion INT NOT NULL,
 PRIMARY KEY (IdAsignatura, IdEstudiante),
 FOREIGN KEY (IdAsignatura) REFERENCES Asignaturas(IdAsignatura),
 FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante)
);


-- TABLA ASIGNATURAS DE AULAS
CREATE TABLE AsignaturasAula(
	IdAsignatura INT NOT NULL,
	IdEdificio INT NOT NULL,
	IdAula INT NOT NULL,
 PRIMARY KEY (IdAsignatura, IdEdificio, IdAula),
 FOREIGN KEY (IdAsignatura) REFERENCES Asignaturas(IdAsignatura),
 FOREIGN KEY (IdEdificio, IdAula) REFERENCES Aulas(IdEdificio, IdAula)
);



-- OPERACIONES DE INSERCION DE DATOS ----------------------------------------------------

INSERT INTO Carreras    (IdCarrera, Descripcion) VALUES (1, 'INGENIERIA EN SISTEMAS')
INSERT INTO Carreras    (IdCarrera, Descripcion) VALUES (2, 'CIENCIAS CRIMINOLOGICAS')
INSERT INTO Carreras    (IdCarrera, Descripcion) VALUES (3, 'ADMINISTRACION DE EMPRESAS')
INSERT INTO Carreras    (IdCarrera, Descripcion) VALUES (4, 'ENSEÑANZA DEL INGLES')
INSERT INTO Carreras    (IdCarrera, Descripcion) VALUES (5, 'EDUCACION ESPECIAL')
INSERT INTO Carreras    (IdCarrera, Descripcion) VALUES (6, 'INGENIERIA DE DATOS')


INSERT INTO Edificios   (IdEdificio, Descripcion) VALUES (1, 'FALCULTAD DE INGENIERIAS')
INSERT INTO Edificios   (IdEdificio, Descripcion) VALUES (2, 'FACULTAD DE CIENCIAS')
INSERT INTO Edificios   (IdEdificio, Descripcion) VALUES (3, 'EDIFICIO DE INVESTIGACION')
INSERT INTO Edificios   (IdEdificio, Descripcion) VALUES (4, 'CENTRO DE IDIOMAS')
INSERT INTO Edificios   (IdEdificio, Descripcion) VALUES (5, 'EDIFICIO PRINCIPAL')


INSERT INTO Aulas       (IdEdificio, IdAula, Capacidad, Piso) VALUES (1, 1, 50, 1)
INSERT INTO Aulas       (IdEdificio, IdAula, Capacidad, Piso) VALUES (1, 2, 50, 2)
INSERT INTO Aulas       (IdEdificio, IdAula, Capacidad, Piso) VALUES (2, 1, 50, 3)
INSERT INTO Aulas       (IdEdificio, IdAula, Capacidad, Piso) VALUES (2, 2, 50, 4)
INSERT INTO Aulas       (IdEdificio, IdAula, Capacidad, Piso) VALUES (3, 1, 50, 5)
INSERT INTO Aulas       (IdEdificio, IdAula, Capacidad, Piso) VALUES (3, 2, 50, 6)


INSERT INTO Provincias  (IdProvincia, Descripcion) VALUES (1, 'SAN JOSE')
INSERT INTO Provincias  (IdProvincia, Descripcion) VALUES (2, 'ALAJUELA')
INSERT INTO Provincias  (IdProvincia, Descripcion) VALUES (3, 'CARTAGO')
INSERT INTO Provincias  (IdProvincia, Descripcion) VALUES (4, 'HEREDIA')
INSERT INTO Provincias  (IdProvincia, Descripcion) VALUES (5, 'GUANACASTE')
INSERT INTO Provincias  (IdProvincia, Descripcion) VALUES (6, 'PUNTARENAS')
INSERT INTO Provincias  (IdProvincia, Descripcion) VALUES (7, 'LIMON')


INSERT INTO Cantones    (IdProvincia, IdCanton, Descripcion) VALUES (1, 1, 'DESAMPARADOS')
INSERT INTO Cantones    (IdProvincia, IdCanton, Descripcion) VALUES (1, 2, 'ESCAZU')
INSERT INTO Cantones    (IdProvincia, IdCanton, Descripcion) VALUES (2, 1, 'PALMARES')
INSERT INTO Cantones    (IdProvincia, IdCanton, Descripcion) VALUES (2, 2, 'SAN RAMON')
INSERT INTO Cantones    (IdProvincia, IdCanton, Descripcion) VALUES (3, 1, 'EL GUARCO')
INSERT INTO Cantones    (IdProvincia, IdCanton, Descripcion) VALUES (3, 2, 'TURRIALBA')


INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (1, 1, 1, 'SAN ANTONIO')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (1, 1, 2, 'SAN RAFAEL ARRIBA')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (1, 2, 1, 'SAN FRANCISCO')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (1, 2, 2, 'GUACHIPELIN')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (2, 1, 1, 'CANDELARIA')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (2, 1, 2, 'SANTIAGO')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (2, 2, 1, 'PIEDADES NORTE')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (2, 2, 2, 'PIEDADES SUR')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (3, 1, 1, 'PALMITAL')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (3, 1, 2, 'PATIO DE AGUA')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (3, 2, 1, 'SANTA CRUZ')
INSERT INTO Distritos   (IdProvincia, IdCanton, IdDistrito, Descripcion) VALUES (3, 2, 2, 'SANTA TERESITA')


INSERT INTO Estudiantes (IdEstudiante, Nombre, Apellido1, Apellido2, FechaNacimiento, Edad, IdProvincia, IdCanton, IdDistrito)
   VALUES(1, 'JUAN', 'SALAS', 'RODRIGUEZ', '01-09-1982', 40, 1, 2, 1)
INSERT INTO Estudiantes (IdEstudiante, Nombre, Apellido1, Apellido2, FechaNacimiento, Edad, IdProvincia, IdCanton, IdDistrito)
   VALUES(2, 'MARTA', 'ARCE', 'CASTRILLO', '25-10-2002', 20, 2, 1, 2)
INSERT INTO Estudiantes (IdEstudiante, Nombre, Apellido1, Apellido2, FechaNacimiento, Edad, IdProvincia, IdCanton, IdDistrito)
   VALUES(3, 'LUIS', 'MARQUEZ', 'FALLAS',  '19-08-1986', 37, 3, 1, 1)
INSERT INTO Estudiantes (IdEstudiante, Nombre, Apellido1, Apellido2, FechaNacimiento, Edad, IdProvincia, IdCanton, IdDistrito)
   VALUES(4, 'JOSE', 'VELEZ', 'DIAZ',      '08-01-1982', 41, 1, 2, 2)
INSERT INTO Estudiantes (IdEstudiante, Nombre, Apellido1, Apellido2, FechaNacimiento, Edad, IdProvincia, IdCanton, IdDistrito)
   VALUES(5, 'ANA', 'VARGAS', 'RODRIGUEZ', '14-10-1994', 28, 3, 1, 2)


INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(88776611, 1)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(81122334, 1)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(89988776, 2)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(72694635, 2)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(69654889, 3)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(23457659, 3)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(89513575, 4)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(73469528, 4)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(61479632, 5)
INSERT INTO TelefonosEstudiante (Telefono, IdEstudiante) VALUES(75624862, 5)


INSERT INTO Asignaturas  (IdAsignatura, Descripcion, Creditos) VALUES (1, 'BASES DE DATOS', 4)
INSERT INTO Asignaturas  (IdAsignatura, Descripcion, Creditos) VALUES (2, 'PROGRAMACION WEB', 4)
INSERT INTO Asignaturas  (IdAsignatura, Descripcion, Creditos) VALUES (3, 'POLITICA CRIMINAL', 4)
INSERT INTO Asignaturas  (IdAsignatura, Descripcion, Creditos) VALUES (4, 'BIOLOGIA FORENSE', 3)
INSERT INTO Asignaturas  (IdAsignatura, Descripcion, Creditos) VALUES (5, 'CONTABILIDAD I', 3)
INSERT INTO Asignaturas  (IdAsignatura, Descripcion, Creditos) VALUES (6, 'ECONOMIA GENERAL', 4)


INSERT INTO Profesores (IdProfesor, Nombre, Apellido1, Apellido2, FechaNacimiento, IdProvincia, IdCanton, IdDistrito)
   VALUES(1, 'ALEJANDRO', 'RAMIREZ', 'PEREZ', '28-03-1976', 1, 2, 1)
INSERT INTO Profesores (IdProfesor, Nombre, Apellido1, Apellido2, FechaNacimiento, IdProvincia, IdCanton, IdDistrito)
   VALUES(2, 'GLENDA', 'MATAMOROS', 'CASTRO', '15-09-1975', 1, 1, 2)
INSERT INTO Profesores (IdProfesor, Nombre, Apellido1, Apellido2, FechaNacimiento, IdProvincia, IdCanton, IdDistrito)
   VALUES(3, 'DIEGO', 'ALFARO', 'VASQUEZ', '7-01-1980', 2, 1, 2)
INSERT INTO Profesores (IdProfesor, Nombre, Apellido1, Apellido2, FechaNacimiento, IdProvincia, IdCanton, IdDistrito)
   VALUES(4, 'MARIA', 'MACHADO', 'MEJIA', '2-04-1979', 3, 2, 1)
INSERT INTO Profesores (IdProfesor, Nombre, Apellido1, Apellido2, FechaNacimiento, IdProvincia, IdCanton, IdDistrito)
   VALUES(5, 'FERNANDO', 'MARTINEZ', 'CALDERON', '24-08-1983', 3, 1, 1)

INSERT INTO TelefonosProfesor (Telefono, IdProfesor) VALUES(76543210, 1)
INSERT INTO TelefonosProfesor (Telefono, IdProfesor) VALUES(69512357, 1)
INSERT INTO TelefonosProfesor (Telefono, IdProfesor) VALUES(26952048, 2)
INSERT INTO TelefonosProfesor (Telefono, IdProfesor) VALUES(82685233, 2)
INSERT INTO TelefonosProfesor (Telefono, IdProfesor) VALUES(83576548, 3)
INSERT INTO TelefonosProfesor (Telefono, IdProfesor) VALUES(24567890, 3)
INSERT INTO TelefonosProfesor (Telefono, IdProfesor) VALUES(75931575, 4)


INSERT INTO CarreraProfesor (IdCarrera, IdProfesor) VALUES(1, 2)
INSERT INTO CarreraProfesor (IdCarrera, IdProfesor) VALUES(2, 3)
INSERT INTO CarreraProfesor (IdCarrera, IdProfesor) VALUES(3, 4)
INSERT INTO CarreraProfesor (IdCarrera, IdProfesor) VALUES(4, 5)
INSERT INTO CarreraProfesor (IdCarrera, IdProfesor) VALUES(5, 1)


INSERT INTO AsignaturasProfesor (IdAsignatura, IdProfesor) VALUES(1, 1)
INSERT INTO AsignaturasProfesor (IdAsignatura, IdProfesor) VALUES(2, 1)
INSERT INTO AsignaturasProfesor (IdAsignatura, IdProfesor) VALUES(3, 1)
INSERT INTO AsignaturasProfesor (IdAsignatura, IdProfesor) VALUES(4, 2)
INSERT INTO AsignaturasProfesor (IdAsignatura, IdProfesor) VALUES(5, 3)

INSERT INTO AsignaturasCarrera (IdAsignatura, IdCarrera) VALUES(1, 1)
INSERT INTO AsignaturasCarrera (IdAsignatura, IdCarrera) VALUES(2, 1)
INSERT INTO AsignaturasCarrera (IdAsignatura, IdCarrera) VALUES(3, 2)
INSERT INTO AsignaturasCarrera (IdAsignatura, IdCarrera) VALUES(4, 2)
INSERT INTO AsignaturasCarrera (IdAsignatura, IdCarrera) VALUES(5, 3)
INSERT INTO AsignaturasCarrera (IdAsignatura, IdCarrera) VALUES(6, 3)



INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(1, 1, 8)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(1, 2, 7)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(2, 1, 9)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(2, 2, 8)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(3, 3, 5)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(3, 4, 3)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(4, 3, 0)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(4, 4, 9)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(5, 5, 6)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(5, 1, 9)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(1, 5, 8)
INSERT INTO AsignaturasEstudiante (IdAsignatura, IdEstudiante, Calificacion) VALUES(2, 4, 8)


INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(1, 1, 1)
INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(1, 3, 2)
INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(2, 2, 1)
INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(2, 3, 1)
INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(3, 1, 2)
INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(3, 3, 2)
INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(4, 2, 1)
INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(1, 2, 2)
INSERT INTO AsignaturasAula (IdAsignatura, IdEdificio, IdAula) VALUES(1, 2, 1)

SELECT * FROM INFORMATION_SCHEMA.TABLES T

SELECT * FROM Carreras
SELECT * FROM Edificios
SELECT * FROM Aulas
SELECT * FROM Provincias
SELECT * FROM Cantones
SELECT * FROM Distritos
SELECT * FROM Estudiantes
SELECT * FROM TelefonosEstudiante
SELECT * FROM Asignaturas
SELECT * FROM Profesores
SELECT * FROM TelefonosProfesor
SELECT * FROM AsignaturasProfesor
SELECT * FROM CarreraProfesor
SELECT * FROM AsignaturasCarrera
SELECT * FROM AsignaturasEstudiante
SELECT * FROM AsignaturasAula
