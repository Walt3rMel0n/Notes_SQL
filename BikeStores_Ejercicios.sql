--Se muestra el Número de Orden, Codigo de Cliente y identificador de producto
    --de todas las ordenes asociadas a cada cliente.
--Ordenado por Codigo de cliente, Número de Orden y Descripción de producto.
--Solo para los clientes con código entre 500 y 599, sin utilizar los operadores >= y <=.

select o.order_id AS 'Numero de Orden', c.customer_id as 'Código de CLiente', oi.product_id as 'Identificador de producto', 
	p.product_name as 'Descripción de ¨Producto'
	FROM sales.orders o JOIN sales.customers c on o.customer_id = c.customer_id
	JOIN sales.order_items oi ON o.order_id = oi.order_id
	JOIN production.products p ON oi.product_id = p.product_id
	WHERE c.customer_id BETWEEN 500 AND 599
	ORDER BY c.customer_id, o.order_id; --EL campo descripción no existe en la tabla sales.orders


--Se muestra el Codigo de producto, Nombre de producto y el Conteo de las ventas 
--  realizadas para cada producto. 
--Ordenado por Código de producto descendentemente.

SELECT pp.product_id, pp.product_name, sum(soi.quantity) AS 'Total_ventas' FROM production.products pp 
	JOIN sales.order_items soi ON pp.product_id = soi.product_id group by pp.product_id, pp.product_name;


--Se obtiene todo el detalle de productos vendidos, donde muestre el Numero de orden, 
    --Fecha de orden, Estado de orden, Codigo y Nombre completo de cliente, Codigo y 
    --Nombre de tienda, Codigo y Nombre completo del vendedor (staff), Codigo y Descripcion 
    --de producto, Codigo y Descripcion de marca del producto, Codigo y Descripcion de la categoría 
    --asociada al producto.
--Se Muestra los resultados solo para los clientes cuyo Primer nombre termine con "ana" 
    --y solo las Categorías de producto 2, 4 y 6 sin utilizar el operador de comparación OR.
--Ordenado por el Codigo de orden y Codigo de producto. (10 pts)

SELECT o.order_id AS 'Numero de orden', o.order_date AS 'Fecha de orden',
		o.order_status AS 'Estado de orden', c.customer_id AS 'Codigo de cliente',
		CONCAT(c.first_name, ' ',c.last_name) AS 'Nombre de cliente',
		s.store_id AS 'Codigo de tienda', s.store_name AS 'Nombre de tienda',
		CONCAT(st.first_name,' ', st.last_name) AS 'Nombre del vendedor',
		st.staff_id AS 'Codigo del producto', p.product_name AS 'Descripcion de producto',
		b.brand_id AS 'Codigo de marca', b.brand_name AS 'Descripcion de marca', 
		pc.category_id AS 'Codigo de categoria', pc.category_name AS 'Descripcion de categoria'
		FROM sales.orders o 
		JOIN sales.customers c ON o.customer_id = c.customer_id
		JOIN sales.stores s ON o.store_id = s.store_id
		JOIN sales.staffs st ON o.store_id = st.staff_id
		JOIN sales.order_items oi ON o.order_id = oi.order_id
		JOIN production.products p ON oi.product_id = p.product_id
		JOIN production.brands b ON p.brand_id = b.brand_id
		JOIN production.categories pc ON p.category_id = pc.category_id
		JOIN sales.customers tc ON c.customer_id = tc.customer_id
		JOIN sales.orders so ON c.customer_id = so.customer_id
		JOIN sales.order_items toi ON so.order_id = toi.order_id
		JOIN production.products tp ON toi.product_id = tp.product_id
		WHERE RIGHT(c.first_name, 4) LIKE '%ana'
		AND p.category_id IN (2, 4, 6)
		ORDER BY o.order_id, p.product_id;


--Se muestra el Codigo y Nombre completo de los clientes que NO tienen 
    --Ordenes de pedido asociadas, ordenado por Codigo de cliente. 

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS 'Nombre del cliente', o.order_id FROM sales.customers c 
		INNER JOIN sales.orders o ON c.customer_id = o.customer_id
		WHERE c.customer_id NOT IN (SELECT DISTINCT customer_id FROM sales.orders)
		ORDER BY customer_id; 
--Ninguna línea cumple con la condición el resultado es un resultado vacío.


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

--Como crear la siguiente tabla:
/*
Tabla:	ControlClientes	Contendrá datos de los clientes por ciudad creados en cierta fecha y hora por un usuario.
Campos:	Ningún campo debe aceptar Nulos
	Customer_id	Clave primaria
	Usuario	Clave primaria
	Fecha_creado	Clave primaria
	Ciudad	
Clave primaria:	Customer_id, Usuario y Fecha_creado
Relaciones:	Deberá relacionar esta tabla apropiadamente con la tabla CUSTOMERS.
*/

USE BikeStores_BVG;
CREATE TABLE ControlClientes (
	customer_id INT NOT NULL,
	usuario VARCHAR (255) NOT NULL,
	fecha_creado DATETIME NOT NuLL,
	ciudad VARCHAR (255) NOT NULL,
	PRIMARY KEY (customer_id, usuario, fecha_creado),
	FOREIGN KEY(customer_id) REFERENCES sales.customers(customer_id) 
	);

--Se crea un trigger con las siguientes características:
--Llamado NuevoCliente. 
--Asociado al evento INSERT de la tabla sales.customers.
/*Se graba en la tabla ControlClientes un registro cada vez que se inserte un 
cliente en la tabla sales.customers, ello solo cuando la ciudad asociada al 
nuevo cliente sea ALAJUELA.

Se cargan los valores a insertar en la tabla ControlClientes utilizando la tabla temporal 
INSERTED y haciendo uso de variables declaradas dentro del trigger.
*/
--Asuma el valor ‘JPIEDRA’ para la columna usuario.

CREATE TRIGGER NuevoCliente
	ON sales.customers
	AFTER INSERT
	AS DECLARE 
			@idCliente NUMERIC(6,0),
			@usuario VARCHAR(50),
			@fecha DATETIME,
			@ciudad VARCHAR(50);
	SELECT @idCliente = s.customer_id FROM sales.customers s;
	SELECT @usuario = 'JPIEDRA';
	SELECT @fecha = GETDATE();
	SELECT @ciudad = s.city FROM sales.customers s;
	IF @ciudad = 'ALAJUELA'
	BEGIN
		SET NOCOUNT OFF;
		INSERT INTO ControlClientes (customer_id, usuario, fecha_creado, ciudad)
		VALUES (@idCliente, @usuario, @fecha, @ciudad); 
	END



