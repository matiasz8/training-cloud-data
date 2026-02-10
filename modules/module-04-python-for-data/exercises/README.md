# Ejercicios: Python para Ingeniería de Datos

Esta carpeta contiene 6 ejercicios progresivos diseñados para construir habilidades de Python aplicadas a data engineering. Cada ejercicio incluye teoría, código starter con TODOs, soluciones completas y tests automatizados.

## Estructura de Ejercicios

```
exercises/
├── 01-python-basics/           # Fundamentos de Python
├── 02-data-structures/         # Listas, dicts, comprehensions
├── 03-file-operations/         # CSV, JSON, Parquet
├── 04-pandas-fundamentals/     # DataFrames y operaciones
├── 05-data-transformation/     # ETL, joins, aggregations
└── 06-error-handling/          # Logging, excepciones, producción
```

## Cómo Usar los Ejercicios

### Opción 1: Modo Guided (Recomendado para Aprender)

1. **Leer teoría**: Abre el `README.md` de cada ejercicio
2. **Intentar starter**: Trabaja en `starter/ejercicio.py`
   - Busca los comentarios `# TODO:`
   - Implementa las funciones marcadas
3. **Ejecutar tests**: Verifica tu solución
   ```bash
   pytest exercises/01-python-basics/tests/ -v
   ```
4. **Comparar con solution**: Si te atoras, revisa `solution/`
5. **Repetir con ejemplos**: Explora `examples/` para casos avanzados

### Opción 2: Modo Autodidacta

1. Lee el README
2. Implementa tu propia versión desde cero
3. Compara con solution después

### Opción 3: Modo Review

1. Lee solution directamente
2. Ejecuta tests
3. Modifica y experimenta

---

## Lista de Ejercicios

### 📘 Ejercicio 01: Python Basics

**Duración**: 1-2 horas  
**Dificultad**: ⭐☆☆☆☆

**Temas**:
- Variables y tipos de datos
- Funciones y documentación
- Control de flujo (if/else, loops)
- Operaciones básicas con strings y números

**Objetivos**:
- Escribir funciones con type hints
- Documentar código con docstrings
- Manejar casos edge (valores vacíos, None)

**Archivos**:
- `README.md` - Teoría
- `starter/basics.py` - Tu código aquí
- `solution/basics.py` - Solución completa
- `tests/test_basics.py` - 15 tests

---

### 📗 Ejercicio 02: Data Structures

**Duración**: 2-3 horas  
**Dificultad**: ⭐⭐☆☆☆

**Temas**:
- Listas y tuplas
- Diccionarios y sets
- List comprehensions
- Dictionary comprehensions
- Nested structures

**Objetivos**:
- Manipular estructuras de datos eficientemente
- Usar comprehensions para código conciso
- Trabajar con datos nested

**Archivos**:
- `README.md` - Teoría
- `starter/data_structures.py` - Tu código aquí
- `solution/data_structures.py` - Solución completa
- `examples/comprehensions.py` - Ejemplos avanzados
- `tests/test_data_structures.py` - 20 tests

---

### 📙 Ejercicio 03: File Operations

**Duración**: 2-3 horas  
**Dificultad**: ⭐⭐⭐☆☆

**Temas**:
- Leer/escribir archivos de texto
- CSV con csv module
- JSON con json module
- Parquet con pandas/pyarrow
- Context managers

**Objetivos**:
- Manejar múltiples formatos de archivo
- Usar encoding correcto (UTF-8)
- Implementar error handling robusto
- Trabajar con datos reales del módulo

**Archivos**:
- `README.md` - Teoría
- `starter/file_io.py` - Tu código aquí
- `solution/file_io.py` - Solución completa
- `tests/test_file_io.py` - 18 tests

---

### 📕 Ejercicio 04: Pandas Fundamentals

**Duración**: 3-4 horas  
**Dificultad**: ⭐⭐⭐☆☆

**Temas**:
- Crear DataFrames
- Selección y filtrado
- Agregaciones y groupby
- Merge y join
- Data cleaning básico

**Objetivos**:
- Dominar operaciones core de pandas
- Limpiar datos sucios (nulls, duplicados)
- Realizar análisis exploratorio
- Usar datos reales del módulo

**Archivos**:
- `README.md` - Teoría
- `starter/pandas_basics.py` - Tu código aquí
- `solution/pandas_basics.py` - Solución completa
- `notebooks/pandas_tutorial.ipynb` - Tutorial interactivo
- `tests/test_pandas.py` - 25 tests

---

### 📔 Ejercicio 05: Data Transformation

**Duración**: 3-4 horas  
**Dificultad**: ⭐⭐⭐⭐☆

**Temas**:
- ETL pipelines
- Flatten nested JSON
- Joins complejos (inner, left, right, outer)
- Pivot y reshape
- Validación de datos

**Objetivos**:
- Construir pipeline ETL completo
- Normalizar estructuras nested
- Integrar múltiples datasets
- Calcular métricas de negocio

**Archivos**:
- `README.md` - Teoría
- `starter/transformation.py` - Tu código aquí
- `solution/transformation.py` - Solución completa
- `examples/etl_pipeline.py` - Pipeline completo
- `tests/test_transformation.py` - 22 tests

---

### 📓 Ejercicio 06: Error Handling & Production

**Duración**: 2-3 horas  
**Dificultad**: ⭐⭐⭐⭐☆

**Temas**:
- Try/except/finally
- Excepciones personalizadas
- Logging estructurado
- Validación de inputs
- Retry logic

**Objetivos**:
- Escribir código production-ready
- Manejar errores elegantemente
- Implementar logging útil
- Validar datos con schemas

**Archivos**:
- `README.md` - Teoría
- `starter/error_handling.py` - Tu código aquí
- `solution/error_handling.py` - Solución completa
- `examples/production_pipeline.py` - Pipeline robusto
- `tests/test_error_handling.py` - 20 tests

---

## Ejecución de Tests

### Ejecutar todos los tests

```bash
# Desde la raíz del módulo
pytest exercises/ -v

# Con coverage
pytest exercises/ --cov=exercises --cov-report=html
```

### Ejecutar tests de un ejercicio específico

```bash
pytest exercises/01-python-basics/tests/ -v
pytest exercises/04-pandas-fundamentals/tests/ -v
```

### Ejecutar un test específico

```bash
pytest exercises/01-python-basics/tests/test_basics.py::test_suma -v
```

### Ejecutar tests con output detallado

```bash
pytest exercises/ -v -s  # -s muestra prints
```

---

## Progreso Sugerido

### Semana 1: Fundamentos
- ✅ Día 1-2: Ejercicio 01 (Python Basics)
- ✅ Día 3-4: Ejercicio 02 (Data Structures)
- ✅ Día 5-6: Ejercicio 03 (File Operations)

### Semana 2: Pandas y ETL
- ✅ Día 1-3: Ejercicio 04 (Pandas Fundamentals)
- ✅ Día 4-6: Ejercicio 05 (Data Transformation)

### Semana 3: Production
- ✅ Día 1-2: Ejercicio 06 (Error Handling)
- ✅ Día 3-5: Proyecto final (combinar todo)

---

## Tips para el Éxito

### 🎯 Antes de Empezar

1. **Lee el README completo** del ejercicio
2. **Mira los tests** para entender qué se espera
3. **Experimenta en notebook** antes de escribir código
4. **Usa los datos reales** de `data/raw/`

### 💡 Durante el Ejercicio

1. **No copies-pegues** solution - aprende escribiendo
2. **Ejecuta tests frecuentemente** (cada función)
3. **Usa print()** liberalmente para debugging
4. **Consulta documentación** (pandas, Python docs)
5. **Pregunta en comunidades** si te atoras

### ✅ Después de Completar

1. **Compara tu código** con solution
2. **Identifica diferencias** en approach
3. **Aprende patrones** usados en solution
4. **Refactoriza** tu código si es necesario
5. **Experimenta con examples/** para profundizar

---

## Recursos Adicionales

### Documentación Oficial
- [Python Tutorial](https://docs.python.org/3/tutorial/)
- [Pandas User Guide](https://pandas.pydata.org/docs/user_guide/)
- [pytest Documentation](https://docs.pytest.org/)

### Teoría del Módulo
- `theory/concepts.md` - Fundamentos de Python
- `theory/architecture.md` - Patrones de diseño
- `theory/resources.md` - 200+ recursos externos

### Datos de Práctica
- `data/README.md` - Documentación completa de datasets
- `data/schemas/` - Schemas JSON con validaciones

---

## Troubleshooting

### Tests no pasan

```bash
# Ver error detallado
pytest exercises/01-python-basics/tests/ -v -s

# Ver qué línea falla exactamente
pytest exercises/01-python-basics/tests/ --tb=long
```

### Import errors

```bash
# Asegurarte de estar en la raíz del módulo
cd /path/to/module-04-python-for-data

# O ajustar PYTHONPATH
export PYTHONPATH="${PYTHONPATH}:$(pwd)"
```

### Datos no encontrados

```bash
# Verificar que los datos existen
ls -lh data/raw/

# Regenerar si es necesario
cd data && python3 generate_all_datasets.py
```

### Pandas no instalado

```bash
# Si usas Docker (recomendado)
docker-compose up -d jupyter
# Acceder a http://localhost:8888

# Si usas venv local
pip install -r requirements.txt
```

---

## Evaluación

### Criterios de Éxito por Ejercicio

| Ejercicio | Tests Passing | Tiempo Estimado | Comprensión |
|-----------|---------------|-----------------|-------------|
| 01 - Python Basics | 15/15 ✅ | 1-2h | Sintaxis básica |
| 02 - Data Structures | 20/20 ✅ | 2-3h | Estructuras core |
| 03 - File Operations | 18/18 ✅ | 2-3h | I/O multi-formato |
| 04 - Pandas Fundamentals | 25/25 ✅ | 3-4h | DataFrames |
| 05 - Data Transformation | 22/22 ✅ | 3-4h | ETL completo |
| 06 - Error Handling | 20/20 ✅ | 2-3h | Production code |

**Total**: 120 tests, ~14-16 horas

### Auto-Evaluación

Después de cada ejercicio, pregúntate:

1. ✅ ¿Entiendo **por qué** funciona mi código?
2. ✅ ¿Podría explicárselo a otra persona?
3. ✅ ¿Podría resolver un problema similar sin ayuda?
4. ✅ ¿Conozco alternativas al approach que usé?
5. ✅ ¿Mi código es legible y está bien documentado?

---

## Proyecto Final (Opcional)

Después de completar los 6 ejercicios, construye un **pipeline ETL completo**:

**Objetivo**: Procesar todos los datasets y generar un reporte de negocio

**Requerimientos**:
1. Leer los 5 datasets (CSV, JSON)
2. Limpiar datos (duplicados, nulls, inconsistencias)
3. Integrar con joins (customers ← orders ← transactions)
4. Calcular métricas:
   - Revenue total y por país
   - Top 10 productos más vendidos
   - Customer lifetime value
   - Conversion rate del funnel
5. Exportar resultados a CSV y JSON
6. Logging completo de cada paso
7. Tests unitarios (>80% coverage)

**Tiempo estimado**: 8-10 horas

---

## Siguiente Paso

Después de completar estos ejercicios:

➡️ **Paso 6: Validation** - Tests automatizados integrados  
➡️ **Paso 7: Assets** - Cheatsheets y diagramas de referencia  
➡️ **Paso 8: Scripts & Docs** - Automatización y troubleshooting  

---

**¡Feliz coding! 🐍🐼**

¿Dudas? Revisa `theory/` o consulta los `examples/` en cada ejercicio.
