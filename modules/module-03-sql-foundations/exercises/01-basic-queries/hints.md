# Hints - Exercise 01: Basic Queries

¿Necesitas ayuda? Aquí hay pistas sin revelar las soluciones completas.

## Proyección (01_projection.sql)

**Query 1 - Nombre y email**
- 💡 Usa `SELECT column1, column2, column3 FROM table`
- 💡 No necesitas WHERE si quieres todos los registros

**Query 2 - Alias en español**
- 💡 Sintaxis de alias: `column_name AS alias_name`
- 💡 Los alias pueden tener espacios si usas comillas: `AS "nombre producto"`

**Query 3 - Primeras 5 órdenes**
- 💡 `LIMIT n` va al final de la query
- 💡 Ordena primero si necesitas las "primeras" de algún criterio específico

**Query 5 - Todas excepto timestamps**
- 💡 No existe `SELECT * EXCEPT` en PostgreSQL
- 💡 Debes listar explícitamente las columnas que quieres

## Filtrado (02_filtering.sql)

**Query 1 - Múltiples condiciones**
- 💡 Usa `AND` para combinar condiciones que deben cumplirse todas
- 💡 Sintaxis: `WHERE condition1 AND condition2`

**Query 3 - OR vs IN**
- 💡 `WHERE status = 'a' OR status = 'b'` es equivalente a `WHERE status IN ('a', 'b')`
- 💡 `IN` es más legible con muchos valores

**Query 4 - Negación**
- 💡 `NOT IN ('a', 'b', 'c')` es la forma más clara
- 💡 También válido: `!= 'a' AND != 'b' AND != 'c'` pero más verboso

**Query 8 - Booleanos**
- 💡 En PostgreSQL: `WHERE column = TRUE` o `WHERE column = FALSE`
- 💡 También válido: `WHERE column` o `WHERE NOT column`

## Pattern Matching (03_patterns.sql)

**Query 1 - Email de Gmail**
- 💡 `%` significa "cualquier secuencia de caracteres"
- 💡 Para emails que terminan en gmail.com: `'%@gmail.com'`

**Query 2 - Contiene Laptop**
- 💡 Para "contiene": `'%palabra%'`
- 💡 Para "comienza con": `'palabra%'`
- 💡 Para "termina en": `'%palabra'`

**Query 5 - BETWEEN**
- 💡 `BETWEEN a AND b` es inclusivo (incluye a y b)
- 💡 Equivalente a: `>= a AND <= b`

**Query 6 - Fechas con BETWEEN**
- 💡 Formato de fecha: `'YYYY-MM-DD'`
- 💡 Para todo 2023: desde '2023-01-01' hasta '2023-12-31'

**Query 7 - NULL checks**
- 💡 NO uses `= NULL` o `!= NULL`, no funciona
- 💡 Usa `IS NULL` o `IS NOT NULL`

## Ordenamiento (04_sorting.sql)

**Query 1 - Mayor a menor**
- 💡 `DESC` = descendente (de mayor a menor)
- 💡 `ASC` = ascendente (de menor a mayor)

**Query 4 - Top N**
- 💡 Combina `ORDER BY column DESC` con `LIMIT n`
- 💡 El orden es: WHERE → ORDER BY → LIMIT

**Query 5 - Ordenar por múltiples columnas**
- 💡 Sintaxis: `ORDER BY col1 ASC, col2 DESC, col3 ASC`
- 💡 Se ordena primero por col1, luego por col2 (para empates), etc.

**Query 7 - Últimos N**
- 💡 "Últimos" = más recientes = orden descendente por fecha
- 💡 No confundir con los últimos de la tabla (eso sería ORDER BY primary_key DESC)

## Paginación (05_pagination.sql)

**Query 2-3 - OFFSET**
- 💡 `OFFSET n` salta los primeros n registros
- 💡 Página 1: OFFSET 0, Página 2: OFFSET 10, Página 3: OFFSET 20

**Query 8 - Fórmula de paginación**
- 💡 Para página N con tamaño P: `OFFSET = (N - 1) * P`
- 💡 Ejemplos:
  - Página 1: (1-1) * 10 = 0
  - Página 2: (2-1) * 10 = 10
  - Página 4: (4-1) * 15 = 45

**Importante sobre ORDER BY**
- 💡 SIEMPRE usa ORDER BY con LIMIT/OFFSET
- 💡 Sin ORDER BY, el orden es indeterminado y puede cambiar entre queries

## Combinación (06_combined.sql)

**Query 1 - Múltiples condiciones**
- 💡 Orden recomendado: WHERE → (más restricciones primero) → ORDER BY → LIMIT
- 💡 Usa paréntesis para claridad si combinas AND/OR

**Query 3 - Filtrar y limitar**
- 💡 WHERE se aplica ANTES de ORDER BY y LIMIT
- 💡 Flujo: Filtrar → Ordenar → Limitar

**Query 6 - OR con LIKE**
- 💡 Necesitas paréntesis: `WHERE is_available = TRUE AND (condicion1 OR condicion2)`
- 💡 Sin paréntesis: `AND` tiene precedencia sobre `OR`

**Query BONUS - Query complejo**
- 💡 Construye paso a paso:
  1. Empieza con la condición más restrictiva
  2. Agrega condiciones con AND
  3. Agrega ORDER BY al final
  4. Agrega LIMIT
- 💡 Prueba cada condición individualmente antes de combinarlas

## Tips Generales

### Debugging de Queries
1. Empieza con `SELECT * FROM table` sin WHERE
2. Agrega una condición a la vez
3. Verifica el count: `SELECT COUNT(*) FROM table WHERE ...`
4. Si no retorna nada, verifica que los valores existan en la tabla

### Performance
- `IN` vs múltiples `OR`: usa `IN` para mejor performance
- `BETWEEN` vs `>= AND <=`: usa `BETWEEN` para claridad
- Siempre incluye `ORDER BY` con `LIMIT` para resultados consistentes

### Estilo SQL
- MAYÚSCULAS para keywords: SELECT, FROM, WHERE
- snake_case para nombres de columnas
- Indentación consistente
- Comentarios para queries complejos

### Testing
```bash
# Ver primeras líneas del resultado
psql -h localhost -U dataengineer -d ecommerce -c "SELECT * FROM users LIMIT 5"

# Contar resultados
psql -h localhost -U dataengineer -d ecommerce -c "SELECT COUNT(*) FROM users WHERE country = 'US'"

# Formato vertical para mejor lectura
psql -h localhost -U dataengineer -d ecommerce -c "\x" -c "SELECT * FROM users LIMIT 1"
```

### Common Pitfalls

❌ **Error**: `WHERE column = NULL`  
✅ **Correcto**: `WHERE column IS NULL`

❌ **Error**: `LIMIT 10 ORDER BY column`  
✅ **Correcto**: `ORDER BY column LIMIT 10`

❌ **Error**: `WHERE country = 'US' OR 'GB'`  
✅ **Correcto**: `WHERE country IN ('US', 'GB')`

❌ **Error**: `LIKE 'gmail.com'` (busca exacto)  
✅ **Correcto**: `LIKE '%gmail.com'` (busca que termine en)

❌ **Error**: No usar ORDER BY con LIMIT  
✅ **Correcto**: Siempre `ORDER BY` antes de `LIMIT` para resultados determinísticos

### Need More Help?

1. Consulta la documentación de PostgreSQL
2. Revisa los ejemplos en el README.md
3. Usa `\d table_name` en psql para ver la estructura de la tabla
4. Si aún estás atascado, mira la solución correspondiente en `solution/`
