## Desafío - Consultas Agrupadas

Aplicando los conceptos y herramientas aprendidas hasta ahora, crea las queries SQL
necesarias que permitan responder las siguientes preguntas.

### 1. ¿Cuántos registros hay?

```sql
SELECT COUNT(1) as Cantidad_Registos
FROM INSCRITOS;

cantidad_registos|
-----------------+
               16|
```



### 2. ¿Cuántos inscritos hay en total?

```sql
SELECT SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS;

cantidad_inscritos|
------------------+
               774|
```

### 3. ¿Cuál o cuáles son los registros de mayor antigüedad?

```sql
SELECT cantidad, fecha, fuente 
FROM INSCRITOS
WHERE fecha=(
	SELECT MIN(fecha) 
	FROM INSCRITOS
);

cantidad|fecha     |fuente|
--------+----------+------+
      44|2021-01-01|Blog  |
      56|2021-01-01|Página|
```

### 4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante).

```sql
SELECT fecha, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
GROUP BY fecha
ORDER BY fecha;

fecha     |cantidad_inscritos|
----------+------------------+
2021-01-01|               100|
2021-01-02|               120|
2021-01-03|               103|
2021-01-04|                93|
2021-01-05|                88|
2021-01-06|                30|
2021-01-07|                58|
2021-01-08|               182|
```

### 5. ¿Cuántos inscritos hay por fuente?

```sql
SELECT fuente, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
GROUP BY fuente
ORDER BY fuente;

fuente|cantidad_inscritos|
------+------------------+
Blog  |               333|
Página|               441|
```

### 6. ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se inscribieron en ese día?

```sql
SELECT fecha, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
GROUP BY fecha
ORDER BY Cantidad_Inscritos DESC 
LIMIT 1;

fecha     |cantidad_inscritos|
----------+------------------+
2021-01-08|               182|
```

### 7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron?

```sql
SELECT fecha, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
WHERE fuente ILIKE 'blog'
GROUP BY fecha
ORDER BY Cantidad_Inscritos DESC 
LIMIT 1;

fecha     |cantidad_inscritos|
----------+------------------+
2021-01-08|                83|
```

### 8. ¿Cuál es el promedio de personas inscritas por día?

```sql
SELECT CAST(AVG(inscritos) AS FLOAT) AS promedio_inscritos
FROM (
    SELECT fecha, SUM(cantidad) AS inscritos
    FROM INSCRITOS
    GROUP BY fecha
) AS inscripciones_por_dia;

promedio_inscritos|
------------------+
             96.75|
```

### 9. ¿Qué días se inscribieron más de 50 personas?

```sql
SELECT fecha, SUM(cantidad) as Cantidad_Inscritos
FROM INSCRITOS
GROUP BY fecha
HAVING SUM(cantidad)>50
ORDER BY fecha

fecha     |cantidad_inscritos|
----------+------------------+
2021-01-01|               100|
2021-01-02|               120|
2021-01-03|               103|
2021-01-04|                93|
2021-01-05|                88|
2021-01-07|                58|
2021-01-08|               182|
```

### 10. ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante, considerando únicamente las fechas posteriores o iguales a la indicada?

```sql
SELECT fecha, CAST(AVG(cantidad) AS FLOAT) AS promedio_inscritos_diario
FROM INSCRITOS
WHERE fecha >='2021-01-03'
GROUP BY fecha
ORDER BY fecha;

fecha     |promedio_inscritos_diario|
----------+-------------------------+
2021-01-03|                     51.5|
2021-01-04|                     46.5|
2021-01-05|                     44.0|
2021-01-06|                     15.0|
2021-01-07|                     29.0|
2021-01-08|                     91.0|
```