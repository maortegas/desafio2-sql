

CREATE TABLE INSCRITOS
(
    cantidad INT,
    fecha DATE,
    fuente VARCHAR
);
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS
    (cantidad, fecha, fuente)
VALUES
    ( 99, '01/08/2021', 'Página' );


--1. ¿Cuántos registros hay?
SELECT COUNT(1) as Cantidad_Registos
FROM INSCRITOS;

--2. ¿Cuántos inscritos hay en total?
SELECT SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS;

--3. ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT cantidad, fecha, fuente
FROM INSCRITOS
WHERE fecha=(
	SELECT MIN(fecha)
FROM INSCRITOS
);

--4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante).
SELECT fecha, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
GROUP BY fecha
ORDER BY fecha;

--5. ¿Cuántos inscritos hay por fuente?
SELECT fuente, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
GROUP BY fuente
ORDER BY fuente;

--6. ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se inscribieron en ese día?
SELECT fecha, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
GROUP BY fecha
ORDER BY Cantidad_Inscritos DESC 
LIMIT 1;

--7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron?
SELECT fecha
, SUM
(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
WHERE fuente ILIKE 'blog'
GROUP BY fecha
ORDER BY Cantidad_Inscritos DESC 
LIMIT 1;

--8. ¿Cuál es el promedio de personas inscritas por día?

SELECT fecha, CAST(AVG(cantidad) AS FLOAT) AS promedio_inscritos_diario
FROM INSCRITOS
GROUP BY fecha
ORDER BY fecha;

SELECT CAST(AVG(inscritos) AS FLOAT) AS promedio_inscritos
FROM (
    SELECT fecha, SUM(cantidad) AS inscritos
    FROM INSCRITOS
    GROUP BY fecha
) AS inscripciones_por_dia;

-- 9. ¿Qué días se inscribieron más de 50 personas?
SELECT fecha, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
GROUP BY fecha
HAVING SUM(cantidad)>50
ORDER BY fecha

--10. ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante,
--     considerando únicamente las fechas posteriores o iguales a la indicada?

SELECT fecha, CAST(AVG(cantidad) AS FLOAT) AS promedio_inscritos_diario
FROM INSCRITOS
WHERE fecha >='2021-01-03'
GROUP BY fecha
ORDER BY fecha;
