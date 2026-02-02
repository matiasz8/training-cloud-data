# Módulo 03: Fundamentos de SQL para Ingeniería de Datos

Domina los fundamentos de SQL y técnicas avanzadas de consultas esenciales para flujos de trabajo modernos de ingeniería de datos.

## Descripción General

Este módulo enseña SQL desde la perspectiva de ingeniería de datos, enfocándose en escenarios del mundo real que encontrarás al trabajar con data lakes, warehouses y cargas de trabajo analíticas. Aprenderás a escribir consultas eficientes, optimizar rendimiento y aprovechar SQL a través de diferentes motores (PostgreSQL, Athena, Spark SQL).

**Duración**: 12-15 horas  
**Dificultad**: Principiante a Intermedio  
**Prerequisitos**: Comprensión básica de bases de datos y estructuras de datos

## Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

1. **Escribir consultas SQL complejas** usando SELECT, WHERE, JOIN, GROUP BY y funciones de agregación
2. **Realizar operaciones multi-tabla** con joins INNER, LEFT, RIGHT, FULL y CROSS
3. **Usar funciones de ventana** para consultas analíticas (ROW_NUMBER, RANK, LAG, LEAD, NTILE)
4. **Dominar Common Table Expressions (CTEs)** para consultas legibles y mantenibles
5. **Optimizar el rendimiento de consultas** usando EXPLAIN, índices y planificación de queries
6. **Manejar transformaciones de datos** con CASE, COALESCE, conversión de tipos y funciones de strings
7. **Trabajar con fechas y timestamps** para análisis de series temporales y particionamiento
8. **Comprender planes de ejecución de consultas** y cómo las bases de datos procesan SQL
9. **Aplicar mejores prácticas de SQL** para flujos de trabajo de ingeniería de datos
10. **Usar SQL a través de diferentes motores** (PostgreSQL, Presto/Athena, Spark SQL)
11. **Debuggear y resolver problemas** de consultas lentas y errores comunes de SQL
12. **Escribir consultas analíticas eficientes** para transformaciones de pipelines de datos


## Prerequisitos

### Conocimientos Requeridos
- Comprensión básica de bases de datos relacionales
- Familiaridad con tipos de datos (integers, strings, dates)
- Comandos básicos de línea de comandos

### Software Requerido
- Python 3.9+
- Docker y Docker Compose
- Cliente PostgreSQL (psql)
- 2GB de espacio libre en disco

### Recomendado pero Opcional
- Comprensión básica de conceptos de data warehousing
- Familiaridad con cualquier lenguaje de programación
- Experiencia con herramientas de análisis de datos

## Estructura del Módulo

```
module-03-sql-foundations/
├── theory/                      # Documentación conceptual
│   ├── concepts.md             # Fundamentos de SQL (20,000+ palabras)
│   ├── architecture.md         # Ejecución y optimización de consultas
│   └── resources.md            # Materiales de aprendizaje adicionales
├── exercises/                   # Práctica hands-on
│   ├── 01-basic-queries/       # SELECT, WHERE, ORDER BY
│   ├── 02-joins/               # Operaciones multi-tabla
│   ├── 03-aggregations/        # GROUP BY, funciones de agregación
│   ├── 04-window-functions/    # Consultas analíticas
│   ├── 05-ctes-subqueries/     # Composición de consultas complejas
│   └── 06-optimization/        # Ajuste de rendimiento
├── data/                        # Datasets de muestra
│   ├── schemas/                # Esquemas de base de datos
│   ├── seeds/                  # Datos de muestra
│   └── migrations/             # Scripts de evolución de esquema
├── infrastructure/              # Setup de desarrollo local
│   ├── docker-compose.yml      # Contenedor PostgreSQL
│   └── init.sql                # Inicialización de base de datos
├── validation/                  # Tests automatizados
│   └── test_*.py               # Validación de ejercicios
├── assets/                      # Recursos visuales
│   ├── diagrams/               # Diagramas de ejecución SQL
│   └── cheatsheets/            # Guías de referencia rápida
├── scripts/                     # Scripts de automatización
│   ├── setup.sh                # Configuración del entorno
│   └── validate.sh             # Ejecutar todas las validaciones
└── docs/                        # Documentación adicional
    ├── sql-guide.md            # Guía completa de SQL
    └── troubleshooting.md      # Problemas comunes y soluciones
```

## Comenzando

### 1. Clonar y Navegar
```bash
cd modules/module-03-sql-foundations
```

### 2. Instalar Dependencias de Python
```bash
pip install -r requirements.txt
```

### 3. Iniciar Base de Datos PostgreSQL
```bash
cd infrastructure
docker-compose up -d
cd ..
```

### 4. Inicializar Base de Datos de Muestra
```bash
bash scripts/setup.sh
```

### 5. Verificar Conexión a la Base de Datos
```bash
psql -h localhost -p 5432 -U dataeng -d training
# Password: dataeng123
```

### 6. Leer Primero la Teoría
```bash
# Comenzar con fundamentos
cat theory/concepts.md | less

# Luego revisar arquitectura
cat theory/architecture.md | less
```

### 7. Completar Ejercicios en Orden
```bash
cd exercises/01-basic-queries
cat README.md
# Seguir instrucciones en cada ejercicio
```

### 8. Validar tu Aprendizaje
```bash
bash scripts/validate.sh
# o
pytest validation/ -v
```

## Ejercicios

### Ejercicio 01: Consultas Básicas
**Objetivo**: Dominar operaciones fundamentales de SQL

**Temas**:
- SELECT de columnas y expresiones
- Filtrado con cláusula WHERE
- Ordenamiento con ORDER BY
- Paginación con LIMIT y OFFSET
- DISTINCT para valores únicos
- Operaciones básicas de strings y matemáticas

**Datasets**: Transacciones de e-commerce (100k filas)

**Tiempo**: 2 horas

---

### Ejercicio 02: Joins y Relaciones
**Objetivo**: Combinar datos de múltiples tablas

**Temas**:
- INNER JOIN para registros coincidentes
- LEFT/RIGHT JOIN para preservar filas
- FULL OUTER JOIN para todos los registros
- CROSS JOIN para productos cartesianos
- Self joins para datos jerárquicos
- Consideraciones de rendimiento de JOIN

**Datasets**: Users, Orders, Products (multi-tabla)

**Tiempo**: 2-3 horas

---

### Ejercicio 03: Agregaciones y Agrupamiento
**Objetivo**: Resumir y analizar datos

**Temas**:
- COUNT, SUM, AVG, MIN, MAX
- GROUP BY con una o múltiples columnas
- HAVING para agregados filtrados
- Agregaciones con DISTINCT
- GROUP BY con JOINs
- Patrones comunes de agregación

**Datasets**: Datos de ventas con categorías

**Tiempo**: 2 horas

---

### Ejercicio 04: Funciones de Ventana
**Objetivo**: Realizar consultas analíticas avanzadas

**Temas**:
- ROW_NUMBER para ranking
- RANK y DENSE_RANK
- LAG y LEAD para comparaciones
- Totales acumulados con SUM OVER
- PARTITION BY para grupos
- Window frames (ROWS, RANGE)

**Datasets**: Actividad de usuarios en series temporales

**Tiempo**: 3 horas

---

### Ejercicio 05: CTEs y Subconsultas
**Objetivo**: Escribir consultas complejas y mantenibles

**Temas**:
- Common Table Expressions (WITH)
- CTEs recursivos
- Subconsultas en SELECT, WHERE, FROM
- Subconsultas correlacionadas vs no correlacionadas
- Mejores prácticas de legibilidad de consultas
- Comparación de rendimiento

**Datasets**: Escenarios complejos multi-tabla

**Tiempo**: 2-3 horas

---

### Ejercicio 06: Optimización de Consultas
**Objetivo**: Analizar y mejorar el rendimiento de consultas

**Temas**:
- EXPLAIN y EXPLAIN ANALYZE
- Tipos y uso de índices
- Planificación y ejecución de consultas
- Optimización del orden de JOINs
- Evitar anti-patrones comunes
- Monitorear rendimiento de consultas

**Datasets**: Dataset grande (1M+ filas)

**Tiempo**: 2-3 horas

---

## Esquema de Base de Datos de Muestra

El módulo utiliza una base de datos realista de e-commerce:

```sql
-- Tabla de usuarios
users (user_id, email, first_name, last_name, created_at, country)

-- Tabla de productos
products (product_id, name, category, price, stock)

-- Tabla de órdenes
orders (order_id, user_id, order_date, total_amount, status)

-- Tabla de items de orden
order_items (item_id, order_id, product_id, quantity, price)

-- Tabla de actividad de usuarios
user_activity (activity_id, user_id, event_type, event_time, session_id)
```

## Recursos

### Documentación Oficial
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [AWS Athena SQL Reference](https://docs.aws.amazon.com/athena/latest/ug/ddl-sql-reference.html)
- [Spark SQL Guide](https://spark.apache.org/docs/latest/sql-programming-guide.html)

### Aprendizaje Interactivo
- [SQLBolt](https://sqlbolt.com/) - Lecciones interactivas de SQL
- [Mode SQL Tutorial](https://mode.com/sql-tutorial/) - Enfocado en analítica
- [PostgreSQL Exercises](https://pgexercises.com/) - Problemas de práctica

### Libros y Guías
- "SQL for Data Analysis" by Cathy Tanimura
- "Practical SQL" by Anthony DeBarros
- Ver `theory/resources.md` para lista completa

### Contenido en Video
- [SQL Tutorial - Full Database Course](https://www.youtube.com/watch?v=HXV3zeQKqGY)
- [Advanced SQL for Data Engineers](https://www.youtube.com/playlist?list=PLBgogxgQVM9v0xG0QTFQ5PTbNrj8uGSS-)

## Validación

### Ejecutar Todos los Tests
```bash
bash scripts/validate.sh
```

### Ejecutar Tests de Ejercicios Específicos
```bash
pytest validation/test_exercise_01.py -v
pytest validation/test_exercise_02.py -v
```

### Verificar Rendimiento de Consultas
```bash
# Ejecutar benchmarks de optimización
python validation/benchmark_queries.py
```

## Lista de Verificación de Progreso

### Teoría
- [ ] Leer `theory/concepts.md` (fundamentos de SQL)
- [ ] Leer `theory/architecture.md` (ejecución de consultas)
- [ ] Revisar `theory/resources.md` (materiales adicionales)

### Ejercicios
- [ ] Ejercicio 01: Consultas Básicas ✓
- [ ] Ejercicio 02: Joins y Relaciones ✓
- [ ] Ejercicio 03: Agregaciones y Agrupamiento ✓
- [ ] Ejercicio 04: Funciones de Ventana ✓
- [ ] Ejercicio 05: CTEs y Subconsultas ✓
- [ ] Ejercicio 06: Optimización de Consultas ✓

### Validación
- [ ] Todos los tests pasando (`pytest validation/`)
- [ ] Benchmarks de rendimiento revisados
- [ ] Puedo explicar planes de ejecución de consultas

### Desafíos Opcionales
- [ ] Resolver todos los problemas bonus en ejercicios
- [ ] Escribir 5 consultas complejas desde cero
- [ ] Optimizar una consulta lenta 10x
- [ ] Completar PostgreSQL Exercises (pgexercises.com)

## Problemas Comunes

### Fallo en Conexión a Base de Datos
```bash
# Verificar que Docker está corriendo
docker ps

# Reiniciar PostgreSQL
cd infrastructure
docker-compose restart
```

### Consultas Lentas
```sql
-- Usar EXPLAIN para analizar
EXPLAIN ANALYZE
SELECT * FROM large_table WHERE condition;

-- Verificar índices faltantes
SELECT * FROM pg_indexes WHERE tablename = 'your_table';
```

### Datos de Muestra Faltantes
```bash
# Re-inicializar base de datos
bash scripts/setup.sh --reset
```

Ver `docs/troubleshooting.md` para guía completa de resolución de problemas.

## Siguientes Pasos

Después de completar este módulo:

1. **Módulo 04: Transformación de Datos** - Aplicar SQL en pipelines ETL
2. **Módulo 05: Data Warehousing** - Modelado dimensional con SQL
3. **Módulo 06: Analítica Avanzada** - SQL para ingeniería de features de ML

## Recursos Adicionales

- **Cheat Sheets**: Ver `assets/cheatsheets/` para referencias rápidas
- **Guía de Estilo SQL**: Seguir formato consistente (ver `docs/sql-guide.md`)
- **Ejemplos del Mundo Real**: Revisar `exercises/*/examples/` para patrones de producción

## Soporte

- Consultar `docs/troubleshooting.md` para problemas comunes
- Revisar pistas de ejercicios en `exercises/*/hints.md`
- Consultar documentación de PostgreSQL para referencias de funciones

---

**Estado del Módulo 03**: Listo para Aprendizaje  
**Última Actualización**: Febrero 2026  
**Versión**: 1.0.0

- [ ] Todas las validaciones pasando
- [ ] Listo para siguiente módulo

## Siguientes Pasos

Después de completar este módulo, estarás listo para:
[Lista de módulos que dependen de este]
