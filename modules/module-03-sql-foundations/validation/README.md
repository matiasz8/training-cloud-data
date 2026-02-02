# Validation Tests

Este directorio contiene tests automatizados para validar los ejercicios del módulo SQL Foundations.

## 📋 Contenido

```
validation/
├── conftest.py              # Configuración pytest y fixtures
├── helpers.py               # Utilidades de validación
├── test_exercise_01.py      # Tests para Basic Queries
├── test_exercise_02.py      # Tests para Joins
├── test_exercises_03_06.py  # Tests para Aggregations, Window Functions, CTEs, Optimization
└── README.md                # Este archivo
```

## 🚀 Setup

### 1. Instalar Dependencias

```bash
# Asegúrate de estar en el directorio del módulo
cd modules/module-03-sql-foundations

# Instalar pytest y dependencias
pip install pytest pytest-postgresql psycopg2-binary python-dotenv
```

### 2. Configurar Base de Datos

Los tests requieren que la base de datos esté corriendo con datos:

```bash
# Desde el directorio infrastructure/
cd infrastructure
docker-compose up -d

# Esperar a que PostgreSQL esté listo
sleep 5

# Verificar que la BD tiene datos
psql -h localhost -U dataengineer -d ecommerce -c "SELECT COUNT(*) FROM users;"
```

### 3. Configurar Variables de Entorno (Opcional)

Por defecto, los tests usan:
- Host: `localhost`
- Port: `5432`
- Database: `ecommerce`
- User: `dataengineer`
- Password: `training123`

Para personalizar, crea un archivo `.env`:

```bash
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_DB=ecommerce
POSTGRES_USER=dataengineer
POSTGRES_PASSWORD=training123
```

## 🧪 Ejecutar Tests

### Todos los Tests

```bash
# Desde el directorio del módulo
pytest validation/ -v
```

### Tests por Ejercicio

```bash
# Exercise 01: Basic Queries
pytest validation/ -v -m exercise01

# Exercise 02: Joins
pytest validation/ -v -m exercise02

# Exercise 03: Aggregations
pytest validation/ -v -m exercise03

# Exercise 04: Window Functions
pytest validation/ -v -m exercise04

# Exercise 05: CTEs & Subqueries
pytest validation/ -v -m exercise05

# Exercise 06: Optimization
pytest validation/ -v -m exercise06
```

### Tests Específicos

```bash
# Test específico por nombre
pytest validation/test_exercise_01.py::TestProjection::test_select_specific_columns -v

# Clase de tests
pytest validation/test_exercise_01.py::TestProjection -v

# Archivo completo
pytest validation/test_exercise_01.py -v
```

### Opciones Útiles

```bash
# Mostrar output detallado
pytest validation/ -v -s

# Detener en primer fallo
pytest validation/ -x

# Ejecutar tests en paralelo (requiere pytest-xdist)
pytest validation/ -n auto

# Excluir tests lentos
pytest validation/ -v -m "not slow"

# Generar reporte de cobertura (requiere pytest-cov)
pytest validation/ --cov=validation --cov-report=html
```

## 📊 Estructura de Tests

### conftest.py

Fixtures compartidas:

- `db_connection`: Conexión a base de datos (scope: session)
- `db_cursor`: Cursor con auto-rollback (scope: function)
- `execute_query`: Helper para ejecutar queries
- `execute_file`: Helper para ejecutar archivos SQL
- `verify_db_setup`: Verifica que la BD esté configurada

### helpers.py

Utilidades:

- `compare_results()`: Comparar resultados de queries
- `validate_schema()`: Validar columnas esperadas
- `benchmark_query()`: Medir performance
- `assert_no_nulls()`: Verificar ausencia de NULLs
- `assert_unique()`: Verificar unicidad
- `assert_range()`: Verificar rangos de valores
- `get_query_plan()`: Obtener EXPLAIN plan
- `QueryValidator`: Validaciones comunes (pagination, JOIN integrity)

## 📝 Ejemplo de Uso

### Test Básico

```python
@pytest.mark.exercise01
def test_select_users(execute_query):
    """Test selecting users."""
    query = "SELECT * FROM users LIMIT 5"
    results = execute_query(query)
    
    assert len(results) == 5
    assert 'first_name' in results[0]
```

### Test con Validaciones

```python
from conftest import assert_query_returns_columns

@pytest.mark.exercise01
def test_projection(execute_query):
    """Test column projection."""
    query = """
    SELECT first_name, last_name, email
    FROM users
    LIMIT 10
    """
    results = execute_query(query)
    
    assert_query_returns_columns(
        results, 
        ['first_name', 'last_name', 'email']
    )
```

### Test de Performance

```python
from helpers import benchmark_query

@pytest.mark.slow
def test_join_performance(db_cursor):
    """Benchmark JOIN query."""
    query = """
    SELECT o.*, u.first_name
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    """
    
    stats = benchmark_query(db_cursor, query, iterations=5)
    
    # Verificar que promedio es razonable
    assert stats['avg'] < 1.0  # Less than 1 second
```

## ✅ Qué Validan los Tests

### Exercise 01: Basic Queries

- ✓ Proyección de columnas específicas
- ✓ Uso de alias
- ✓ Filtrado con WHERE (=, <, >, !=)
- ✓ Operadores lógicos (AND, OR, NOT)
- ✓ Pattern matching (LIKE, IN, BETWEEN)
- ✓ NULL handling (IS NULL, IS NOT NULL)
- ✓ Ordenamiento (ORDER BY ASC/DESC)
- ✓ Paginación (LIMIT, OFFSET)
- ✓ Queries combinados

### Exercise 02: Joins

- ✓ INNER JOIN correctness
- ✓ LEFT JOIN preservation
- ✓ Finding unmatched records
- ✓ Multiple JOINs (3+ tables)
- ✓ Aggregations with JOINs
- ✓ JOIN cardinality

### Exercise 03: Aggregations

- ✓ COUNT, SUM, AVG, MIN, MAX
- ✓ GROUP BY
- ✓ HAVING clause
- ✓ Aggregations with JOINs

### Exercise 04: Window Functions

- ✓ ROW_NUMBER(), RANK(), DENSE_RANK()
- ✓ PARTITION BY
- ✓ LAG() and LEAD()
- ✓ Running totals
- ✓ Moving averages

### Exercise 05: CTEs & Subqueries

- ✓ Basic CTEs
- ✓ Multiple chained CTEs
- ✓ Subqueries in WHERE
- ✓ Subqueries in SELECT
- ✓ Recursive CTEs

### Exercise 06: Optimization

- ✓ EXPLAIN plan generation
- ✓ Index usage
- ✓ JOIN optimization
- ✓ LIMIT effectiveness
- ✓ EXISTS vs IN comparison

## 🐛 Troubleshooting

### Error: "Missing required tables"

**Causa**: Base de datos no inicializada.

**Solución**:
```bash
cd infrastructure
docker-compose down -v
docker-compose up -d
sleep 5
psql -h localhost -U dataengineer -d ecommerce -f init.sql
```

### Error: "Connection refused"

**Causa**: PostgreSQL no está corriendo.

**Solución**:
```bash
cd infrastructure
docker-compose up -d
docker-compose ps  # Verificar estado
```

### Error: "Table is empty"

**Causa**: `init.sql` no ejecutó correctamente o no tiene datos de muestra.

**Solución**:
```bash
psql -h localhost -U dataengineer -d ecommerce -f infrastructure/init.sql
```

### Tests Fallan Intermitentemente

**Causa**: Rollback no funciona correctamente.

**Solución**: Asegúrate de que `db_connection` tiene `autocommit=False`:
```python
conn = psycopg2.connect(**DB_CONFIG)
conn.autocommit = False
```

### Tests Muy Lentos

**Solución**:
```bash
# Excluir tests marcados como slow
pytest validation/ -m "not slow"

# O ejecutar en paralelo
pytest validation/ -n auto
```

## 📚 Recursos

- [Pytest Documentation](https://docs.pytest.org/)
- [pytest-postgresql](https://pytest-postgresql.readthedocs.io/)
- [psycopg2 Documentation](https://www.psycopg.org/docs/)
- [PostgreSQL Testing Best Practices](https://www.postgresql.org/docs/current/regress.html)

## 🎯 Best Practices

### Escribir Tests

1. **Un concepto por test**: Cada test debe validar una sola cosa
2. **Nombres descriptivos**: `test_select_users_with_active_status` > `test_query1`
3. **Assertions claras**: Usar helpers que den mensajes de error útiles
4. **Cleanup automático**: Usar fixtures con rollback
5. **Datos consistentes**: No asumir datos específicos, verificar condiciones

### Performance

1. **Usar markers**: Marca tests lentos con `@pytest.mark.slow`
2. **Fixtures con scope apropiado**: `session` para conexión, `function` para cursor
3. **Evitar sleep**: Usar health checks en lugar de esperar tiempos fijos
4. **Limitar datasets**: Usa LIMIT en tests cuando sea posible

### Mantenibilidad

1. **Helpers reutilizables**: Centraliza lógica común en `helpers.py`
2. **Fixtures compartidas**: Define en `conftest.py`
3. **Documentación**: Docstrings claros en cada test
4. **Markers organizados**: Usa markers para agrupar tests lógicamente

## 🔄 CI/CD Integration

### GitHub Actions Example

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15-alpine
        env:
          POSTGRES_DB: ecommerce
          POSTGRES_USER: dataengineer
          POSTGRES_PASSWORD: training123
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
      
      - name: Initialize database
        run: |
          psql -h localhost -U dataengineer -d ecommerce -f infrastructure/init.sql
        env:
          PGPASSWORD: training123
      
      - name: Run tests
        run: |
          pytest validation/ -v --junitxml=junit/test-results.xml
        env:
          POSTGRES_HOST: localhost
          POSTGRES_PORT: 5432
          POSTGRES_DB: ecommerce
          POSTGRES_USER: dataengineer
          POSTGRES_PASSWORD: training123
      
      - name: Upload test results
        uses: actions/upload-artifact@v3
        with:
          name: test-results
          path: junit/test-results.xml
```

---

**Última Actualización**: Febrero 2026  
**Mantenido por**: Equipo de Training Data Engineering
