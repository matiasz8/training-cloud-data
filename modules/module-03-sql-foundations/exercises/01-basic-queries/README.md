# Exercise 01: Basic Queries

## 🎯 Objetivos de Aprendizaje

Al completar este ejercicio, serás capaz de:

- Escribir consultas SELECT básicas con proyección de columnas
- Filtrar datos usando cláusulas WHERE con múltiples condiciones
- Ordenar resultados con ORDER BY (ascendente y descendente)
- Limitar resultados con LIMIT y OFFSET para paginación
- Usar operadores de comparación y lógicos (AND, OR, NOT)
- Trabajar con operadores LIKE, IN, BETWEEN para patrones
- Manejar valores NULL correctamente con IS NULL / IS NOT NULL
- Aplicar alias a columnas para mejorar legibilidad

## 📚 Conceptos Cubiertos

### 1. SELECT y Proyección
```sql
-- Seleccionar todas las columnas
SELECT * FROM users;

-- Seleccionar columnas específicas
SELECT first_name, last_name, email FROM users;

-- Usar alias
SELECT first_name AS nombre, last_name AS apellido FROM users;
```

### 2. WHERE y Filtrado
```sql
-- Condición simple
SELECT * FROM users WHERE country = 'US';

-- Múltiples condiciones con AND
SELECT * FROM users WHERE country = 'US' AND is_active = TRUE;

-- Condiciones con OR
SELECT * FROM users WHERE country = 'US' OR country = 'GB';

-- Negación con NOT
SELECT * FROM users WHERE NOT country = 'US';
```

### 3. Operadores de Comparación
```sql
-- Igualdad y desigualdad
WHERE price = 100
WHERE price != 100
WHERE price <> 100  -- Equivalente a !=

-- Mayor/menor
WHERE loyalty_points > 100
WHERE loyalty_points >= 100
WHERE price < 50
WHERE price <= 50
```

### 4. Operadores Especiales
```sql
-- IN (lista de valores)
SELECT * FROM users WHERE country IN ('US', 'GB', 'CA');

-- BETWEEN (rango inclusivo)
SELECT * FROM products WHERE price BETWEEN 50 AND 100;

-- LIKE (pattern matching)
SELECT * FROM users WHERE email LIKE '%@gmail.com';
SELECT * FROM products WHERE product_name LIKE 'Laptop%';

-- NULL checks
SELECT * FROM orders WHERE tracking_number IS NULL;
SELECT * FROM orders WHERE tracking_number IS NOT NULL;
```

### 5. ORDER BY
```sql
-- Orden ascendente (por defecto)
SELECT * FROM users ORDER BY registration_date;
SELECT * FROM users ORDER BY registration_date ASC;

-- Orden descendente
SELECT * FROM products ORDER BY price DESC;

-- Ordenar por múltiples columnas
SELECT * FROM users ORDER BY country ASC, loyalty_points DESC;
```

### 6. LIMIT y OFFSET
```sql
-- Limitar resultados
SELECT * FROM users LIMIT 10;

-- Paginación
SELECT * FROM users ORDER BY user_id LIMIT 10 OFFSET 0;  -- Página 1
SELECT * FROM users ORDER BY user_id LIMIT 10 OFFSET 10; -- Página 2
```

## 🎓 Ejercicios

### Setup
1. Asegúrate de tener la base de datos corriendo:
```bash
cd infrastructure
docker-compose up -d
```

2. Navega al directorio del ejercicio:
```bash
cd exercises/01-basic-queries
```

### Ejercicio 1: Proyección Básica
**Archivo**: `starter/01_projection.sql`

Escribe consultas para:
- Obtener todos los usuarios con solo nombre, apellido y email
- Obtener productos con nombre y precio, usando alias descriptivos en español
- Obtener las primeras 5 órdenes con id, fecha y total

### Ejercicio 2: Filtrado con WHERE
**Archivo**: `starter/02_filtering.sql`

Escribe consultas para:
- Usuarios activos de Estados Unidos
- Productos con precio menor a $50
- Órdenes con status 'delivered' o 'shipped'
- Usuarios que NO son de US, GB o CA
- Productos sin stock (stock_quantity = 0)

### Ejercicio 3: Pattern Matching
**Archivo**: `starter/03_patterns.sql`

Escribe consultas para:
- Usuarios con email de Gmail
- Productos que contienen "Laptop" en el nombre
- Usuarios cuyo nombre comienza con 'J'
- Productos en categoría 'Electronics' o 'Books'
- Órdenes en un rango de fechas específico

### Ejercicio 4: Ordenamiento
**Archivo**: `starter/04_sorting.sql`

Escribe consultas para:
- Usuarios ordenados por puntos de lealtad (mayor a menor)
- Productos ordenados por precio (menor a mayor)
- Órdenes más recientes primero
- Top 10 productos más caros
- Usuarios por país y luego por fecha de registro

### Ejercicio 5: Paginación
**Archivo**: `starter/05_pagination.sql`

Escribe consultas para:
- Primeros 10 usuarios
- Usuarios de la página 3 (registros 21-30)
- Top 5 productos más caros
- Últimos 20 usuarios registrados

### Ejercicio 6: Combinación de Técnicas
**Archivo**: `starter/06_combined.sql`

Consultas complejas combinando todo lo aprendido:
- Usuarios activos de US o GB con más de 100 puntos, ordenados por puntos
- Productos disponibles entre $20 y $100, ordenados por precio
- Últimas 10 órdenes completadas con total > $100
- Productos de Electronics con stock, excluyendo los más caros que $500

## ✅ Criterios de Éxito

Para cada consulta:
- ✓ Retorna los datos correctos
- ✓ Usa sintaxis SQL válida
- ✓ Incluye comentarios explicando la lógica
- ✓ Sigue las convenciones de formato (mayúsculas para keywords)
- ✓ Usa alias descriptivos cuando corresponda

## 🔍 Testing

Ejecuta tus consultas:
```bash
# Ejecutar archivo individual
psql -h localhost -U dataengineer -d ecommerce -f starter/01_projection.sql

# Ejecutar todos los archivos
for f in starter/*.sql; do
    echo "=== Ejecutando $f ==="
    psql -h localhost -U dataengineer -d ecommerce -f "$f"
done
```

## 💡 Hints

¿Necesitas ayuda? Consulta `hints.md` para pistas sin revelar la solución completa.

## 📖 Soluciones

Las soluciones completas están en `solution/`. Intenta resolver los ejercicios por tu cuenta primero.

## 📚 Recursos Adicionales

- [PostgreSQL SELECT Documentation](https://www.postgresql.org/docs/current/sql-select.html)
- [PostgreSQL Pattern Matching](https://www.postgresql.org/docs/current/functions-matching.html)
- [PostgreSQL Data Types](https://www.postgresql.org/docs/current/datatype.html)

## ⏱️ Tiempo Estimado

- **Lectura**: 15 minutos
- **Ejercicios**: 45-60 minutos
- **Total**: ~75 minutos

## 🎯 Próximos Pasos

Una vez completes este ejercicio, continúa con:
- **Exercise 02**: Joins - Combinar datos de múltiples tablas

---

**Tip**: Usa `\x` en psql para alternar entre formato vertical (mejor para ver registros individuales) y formato horizontal.
