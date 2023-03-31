SELECT * FROM FABRICANTE;
SELECT NOMBRE FROM PRODUCTO;
SELECT NOMBRE, PRECIO FROM PRODUCTO;
SELECT * FROM PRODUCTO;
SELECT NOMBRE, ROUND(PRECIO) AS precio_redond FROM PRODUCTO;
SELECT P.CODIGO_FABRICANTE FROM PRODUCTO P INNER JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO;
SELECT DISTINCT P.CODIGO_FABRICANTE FROM PRODUCTO P INNER JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO;
SELECT NOMBRE FROM FABRICANTE order by NOMBRE ASC;
/*Lista los nombres de los productos ordenados en primer lugar por el nombre de forma
ascendente y en segundo lugar por el precio de forma descendente.*/
SELECT NOMBRE FROM PRODUCTO ORDER BY NOMBRE ASC, PRECIO DESC;
SELECT * FROM FABRICANTE LIMIT 5;
/*Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
ORDER BY y LIMIT)*/
SELECT NOMBRE, PRECIO FROM PRODUCTO ORDER BY PRECIO ASC LIMIT 1;
SELECT NOMBRE, PRECIO FROM PRODUCTO ORDER BY PRECIO DESC LIMIT 1;
SELECT NOMBRE FROM PRODUCTO WHERE PRECIO <= 120;
SELECT * FROM PRODUCTO WHERE PRECIO BETWEEN 60 AND 200;
SELECT * FROM PRODUCTO WHERE CODIGO_FABRICANTE IN (1, 3, 5);
SELECT NOMBRE FROM PRODUCTO WHERE NOMBRE LIKE '%Portátil%';
/*Devuelve una lista con el código del producto, nombre del producto, código del fabricante
y nombre del fabricante, de todos los productos de la base de datos.*/
SELECT P.CODIGO, P.NOMBRE, F.CODIGO, F.NOMBRE FROM PRODUCTO P, FABRICANTE F WHERE P.CODIGO_FABRICANTE = F.CODIGO;
/*Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
orden alfabético.*/
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P, FABRICANTE F WHERE P.CODIGO_FABRICANTE = F.CODIGO ORDER BY F.NOMBRE;
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P, FABRICANTE F WHERE P.CODIGO_FABRICANTE = F.CODIGO ORDER BY PRECIO ASC LIMIT 1;
/*Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT * FROM PRODUCTO P INNER JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE F.NOMBRE = 'Lenovo';
SELECT * FROM PRODUCTO P INNER JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE F.NOMBRE = 'Crucial' AND P.PRECIO > 200;
/*Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard.
Utilizando el operador IN.*/
SELECT * FROM PRODUCTO P INNER JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE F.NOMBRE IN ('Asus', 'Hewlett-Packard', '');
/*Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
ascendente)*/
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P INNER JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE P.PRECIO >= 180 ORDER BY P.PRECIO DESC, P.NOMBRE ASC;
/*Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
fabricantes que no tienen productos asociados.*/
SELECT * FROM FABRICANTE F LEFT JOIN PRODUCTO P ON F.CODIGO = P.CODIGO_FABRICANTE;
SELECT * FROM FABRICANTE F WHERE NOT EXISTS (SELECT * FROM PRODUCTO P WHERE P.CODIGO_FABRICANTE = F.CODIGO);
/*Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT * FROM PRODUCTO P WHERE EXISTS (SELECT * FROM FABRICANTE F WHERE F.CODIGO = P.CODIGO_FABRICANTE AND F.NOMBRE = 'Lenovo');
/*Devuelve todos los datos de los productos que tienen el mismo precio que el producto
más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT * FROM PRODUCTO P WHERE P.PRECIO = (SELECT MAX(PRECIO) FROM PRODUCTO P WHERE P.CODIGO_FABRICANTE IN (SELECT CODIGO FROM FABRICANTE WHERE NOMBRE = 'Lenovo'));
/*Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT P.NOMBRE FROM PRODUCTO P WHERE P.PRECIO = (SELECT MAX(PRECIO) FROM PRODUCTO P WHERE P.CODIGO_FABRICANTE IN (SELECT CODIGO FROM FABRICANTE WHERE NOMBRE = 'Lenovo'));
/*Lista todos los productos del fabricante Asus que tienen un precio superior al precio
medio de todos sus productos.*/
SELECT * FROM PRODUCTO P WHERE P.PRECIO > (SELECT AVG(PRECIO) FROM PRODUCTO WHERE CODIGO_FABRICANTE IN (SELECT CODIGO FROM FABRICANTE F WHERE F.NOMBRE = 'Asus')) and p.codigo_fabricante in (SELECT CODIGO FROM FABRICANTE F WHERE F.NOMBRE = 'Asus');
/*Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o
NOT IN).*/
SELECT F.NOMBRE FROM FABRICANTE F WHERE F.CODIGO IN (SELECT CODIGO_FABRICANTE FROM PRODUCTO);
SELECT F.NOMBRE FROM FABRICANTE F WHERE F.CODIGO NOT IN (SELECT CODIGO_FABRICANTE FROM PRODUCTO);
/*Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número
de productos que el fabricante Lenovo.*/
SELECT F.NOMBRE FROM FABRICANTE F INNER JOIN PRODUCTO P ON F.CODIGO = P.CODIGO_FABRICANTE GROUP BY F.CODIGO HAVING COUNT(P.CODIGO) in (SELECT CODIGO_FABRICANTE FROM PRODUCTO WHERE CODIGO_FABRICANTE = (SELECT CODIGO FROM FABRICANTE WHERE NOMBRE = 'Lenovo')) and F.NOMBRE <> 'Lenovo';
