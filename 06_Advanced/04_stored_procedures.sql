/*
STORED PROCEDURES
Lección 18.4: https://youtu.be/OuJerKzV5T0?t=20033
*/

--Procedures en mysql

-- Crea un procedimiento almacenado llamado "p_all_users" que obtiene todos los datos de "users"
DELIMITER //
CREATE PROCEDURE p_all_users()
BEGIN
	SELECT * FROM users;
END//

-- Invoca al procedimiento almacenado llamado "p_all_users"
CALL p_all_users;

-- Crea un procedimiento almacenado llamado "p_age_users" parametrizado para
-- obtener usuarios con edad variable
DELIMITER //
CREATE PROCEDURE p_age_users(IN age_param int)
BEGIN
	SELECT * FROM users WHERE age = age_param;
END//

-- Invoca al procedimiento almacenado llamado "p_age_users" con un parámetro de valor 30
CALL p_age_users(30);

-- Elimina el procedimiento almacenado llamado "p_age_users"
DROP PROCEDURE p_age_users;



--Procedures en sqlserver

-- Crea un procedimiento almacenado llamado "p_all_users" que obtiene todos los datos de "users"
CREATE PROCEDURE p_all_users
AS
BEGIN
	SELECT * FROM users;
END;

-- Invoca al procedimiento almacenado llamado "p_all_users"
EXEC p_all_users;


-- Crea un procedimiento almacenado llamado "p_age_users" parametrizado para
-- obtener usuarios con edad variable
CREATE PROCEDURE p_age_users
	@age_param INT
AS
BEGIN
	SELECT * FROM users WHERE age = @age_param;
END;

-- Invoca al procedimiento almacenado llamado "p_age_users" con un parámetro de valor 30
EXEC p_age_users @age_param = 20;

--Se crea un procedimiento almacenado que: 
--Se llama SPClienteDatos.
--Recibe por parámetro el Id de Cliente.
--Si el cliente si existe, debe mostrar su Id, Nombre, Apellidos, Ciudad, Email y Teléfono. 
    --Para validar si un registro existe o no debe apoyarse en la función COUNT aplicando el 
    --filtro por cliente.
--Si el cliente no existe, debe retornar un texto que indique: “EL ID DE CLIENTE 
    --SUMINISTRADO NO EXISTE.”. Para mostrar mensajes basta con SELECT ‘texto’.

CREATE PROCEDURE SPClienteDatos (@clienteId INT)
	AS
	BEGIN
		DECLARE @clienteExistente INT; 
		SELECT @clienteExistente = COUNT(*)
		FROM sales.customers
		WHERE customer_id = @clienteId
		IF @clienteExistente >0 
		BEGIN 
			SELECT customer_id AS 'Id',
			first_name AS 'Nombre',
			last_name AS 'Apellido',
			city AS 'Ciudad',
			email AS 'Email',
			phone AS 'Teléfono'
		FROM sales.customers
		WHERE customer_id = @clienteId
		END
		ELSE
		BEGIN 
			SELECT 'EL ID DE CLIENTE SUMINISTRADO NO EXISTE.' AS 'Mensaje';
		END
	END;


