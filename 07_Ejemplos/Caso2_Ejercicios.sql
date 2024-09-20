-- 2.1.	Mostrar todos los edificios.
SELECT * FROM Edificios;

--2.2.	Mostrar todos los estudiantes cuya provincia sea Cartago.
SELECT * FROM Estudiantes WHERE IdProvincia = (SELECT IdProvincia FROM Provincias WHERE Descripcion = 'Cartago');

--2.3.	Mostrar todos los distritos, ordenado por su descripción de forma descendente.
SELECT * FROM Distritos ORDER BY Descripcion DESC;


--2.4.	Mostrar todos los cantones cuyo código sea mayor o igual a 2.
SELECT * FROM Cantones WHERE IdCanton >= 2;

--2.5.	Mostrar las aulas cuyo edificio sea distinto a 1.
SELECT * FROM Aulas WHERE IdEdificio != 1;

--2.6.	Mostrar el identificador, nombre y apellidos de los profesores que pertenezcan a San Jose.
SELECT IdProfesor, Nombre, Apellido1, Apellido2 FROM Profesores 
WHERE IdProvincia = (Select IdProvincia FROM Provincias WHERE Descripcion = 'San Jose');

--2.7.	Mostrar asignaturas matriculadas por los estudiantes que obtuvieron una calificación entre 5 y 8.
SELECT * FROM AsignaturasEstudiante WHERE Calificacion <=8 AND Calificacion >=5 ORDER BY Calificacion DESC;

--2.8.	Mostrar los estudiantes que pertenecen a la provincia 3, al cantón 1 y distrito 2.
SELECT * FROM Estudiantes WHERE IdProvincia = 3 AND IdCanton = 1 AND IdDistrito = 2;

--2.9.	Mostrar los distritos cuya descripción empiece con SAN.
SELECT * FROM Distritos WHERE Descripcion LIKE 'SAN%';

--2.10.	Mostrar las provincias cuya descripción contenga NA.
SELECT * FROM Provincias WHERE Descripcion LIKE '%NA%';

--2.11.	Mostrar los profesores cuyo primer apellido no contenga MA.
SELECT * FROM Profesores WHERE Apellido1 NOT LIKE '%MA%';

--2.12.	Mostrar el nombre, apellidos, fecha de nacimiento y la fecha de nacimiento sumándole 5 días para todos los estudiantes, 
-- ordenado por el nombre descendentemente y luego por su primer apellido ascendentemente.
SELECT nombre, Apellido1, Apellido2, FechaNacimiento, DATEADD(DAY, + 5, fechaNacimiento) AS 'fechaNacimiento5dias' 
FROM Estudiantes ORDER BY nombre DESC, apellido1 ASC; 

--2.13.	Mostrar la identificación de la asignatura y el conteo estas, según la información de las asignaturas matriculadas 
--por los estudiantes, agrupado por la identificación de la asignatura.
Select IdAsignatura, COUNT(*) as conteo FROM AsignaturasEstudiante GROUP BY IdAsignatura; 

--2.14.	Mostrar para todo estudiante su identificador, su primer apellido y los 3 caracteres iniciando en la posición 2 de su primer apellido, 
--convertido a minúscula y ordenado por el nombre.
SELECT IdEstudiante, nombre, Apellido1, LOWER(SUBSTRING(Apellido1, 2,3)) AS 'ApellidoModi' FROM Estudiantes ORDER BY nombre; 

--2.15.	Mostrar el identificador de provincia y el largo de su descripción para las provincias 2, 4 y 6.
SELECT *, LEN(Descripcion) AS 'ContChar' FROM Provincias WHERE IdProvincia = 2 OR IdProvincia = 4 OR IdProvincia = 6;

--2.16.	Mostrar las descripciones de provincia, de cantón y de distrito donde vive cada estudiante, 
--junto con su identificador de estudiante y nombre completo, ordenado por los identificadores de provincia, cantón, distrito y estudiante.
Select est.IdEstudiante, Nombre, est.Apellido1, est.Apellido2, pro.Descripcion as 'Provincia', can.Descripcion as 'Cantón', dis.Descripcion as 'Distrito' 
from Estudiantes est 
inner join Provincias pro on est.IdProvincia = pro.IdProvincia 
inner join Cantones can on est.IdProvincia = can.IdProvincia AND est.IdCanton = can.idcanton  
inner join Distritos dis on est.IdProvincia = dis.IdProvincia AND est.IdCanton = dis.idcanton AND est.IdDistrito = dis.IdDistrito 
order by est.Idprovincia, est.idcanton, est.IdDistrito, est.IdEstudiante;

--2.17.	Mostrar para todas las asignaturas matriculadas por cada estudiante, el identificador de estudiante, su nombre, 
--sus apellidos, el identificador de asignatura y su descripción, ordenado por el identificador de estudiante 
--y el identificador de asignatura.
SELECT es.IdEstudiante, es.Nombre, es.Apellido1, es.Apellido2, asies.IdAsignatura, asi.Descripcion FROM AsignaturasEstudiante asies 
INNER JOIN Estudiantes es ON asies.IdEstudiante = es.IdEstudiante
INNER JOIN Asignaturas asi ON asies.IdAsignatura = asi.IdAsignatura ORDER BY IdEstudiante;

--2.18.	Mostrar el identificador y nombre completo de estudiante, así como el identificador y descripción cada asignatura que ha matriculado,
--ello para todo estudiante que exista, aunque nunca haya matriculado alguna asignatura.
SELECT es.IdEstudiante, es.Nombre, es.Apellido1, es.Apellido2, asi.IdAsignatura, asi.Descripcion FROM Estudiantes es
INNER JOIN AsignaturasEstudiante asies ON es.IdEstudiante = asies.IdEstudiante
INNER JOIN Asignaturas asi ON asi.IdAsignatura = asies.IdAsignatura;

--3.1.	Inserte un nuevo estudiante, asígnele el identificador 6 y los demás campos complételos con su información personal.
INSERT INTO Estudiantes (IdEstudiante, Nombre, Apellido1, Apellido2, FechaNacimiento, Edad, IdProvincia, IdCanton, IdDistrito) 
VALUES (6, 'BERNY', 'VALVERDE', 'GONZALEZ', '1993-07-10', 30, 2, 2, 1);

--3.2. Inserte un nuevo edificio, asígnele los siguientes valores a cada campo: 6 EDIFICIO ANEXO 1
INSERT INTO Edificios VALUES (6,'EDIFICIO ANEXO 1');

--3.3.	Inserte una nueva aula, asígnele los siguientes valores a cada campo: 6, 1, 25, 3
INSERT INTO Aulas VALUES (6, 1, 25, 3);

--4.1.	Actualice a 52 la edad de los estudiantes cuyo cantón sea 1 y su distrito sea 2.
UPDATE Estudiantes SET Edad = 52 WHERE IdCanton = 1 AND IdDistrito = 2;

--4.2.	Actualice a 6 la calificación de las asignaturas matriculadas por los estudiantes 
-- cuya asignatura sea 1 o 2 y la calificación entre 7 y 8.
UPDATE AsignaturasEstudiante SET Calificacion = 6 WHERE idasignatura = 1 OR idasignatura = 2 AND Calificacion >= 7 AND Calificacion <= 8;

--5.1. Elimine las aulas que pertenecen al edificio 6.
DELETE FROM Aulas WHERE IdEdificio = 6;

--5.2. Elimine las asignaturas matriculadas por estudiantes donde la calificación sea cero o 5 o 7.
DELETE FROM AsignaturasEstudiante where Calificacion = 0 or Calificacion = 5 or Calificacion = 7;

