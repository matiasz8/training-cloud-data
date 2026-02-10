# Módulo 04: Python para Ingeniería de Datos

Domina Python y sus bibliotecas esenciales para construir pipelines de datos robustos, procesar grandes volúmenes de información y automatizar flujos de trabajo de ingeniería de datos.

## Descripción General

Este módulo te enseña Python desde la perspectiva de ingeniería de datos, enfocándose en las habilidades prácticas necesarias para manipular datos, construir ETL pipelines y trabajar con formatos modernos de datos. Aprenderás desde fundamentos de Python hasta técnicas avanzadas con pandas, trabajando con datos reales en múltiples formatos.

**Duración**: 14-16 horas  
**Dificultad**: Principiante a Intermedio  
**Prerequisitos**: 
- Módulo 03: SQL Foundations (recomendado)
- Conocimientos básicos de programación (cualquier lenguaje)

## Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

1. **Escribir código Python idiomático** siguiendo mejores prácticas para ingeniería de datos
2. **Manipular estructuras de datos complejas** usando listas, diccionarios, sets y comprehensions
3. **Trabajar con archivos en múltiples formatos** (CSV, JSON, Parquet, Excel)
4. **Dominar pandas para análisis de datos** incluyendo DataFrames, Series y operaciones grupales
5. **Realizar transformaciones de datos complejas** con merge, join, pivot y reshape
6. **Implementar data quality checks** usando validaciones y data profiling
7. **Manejar errores y logging** para pipelines de datos robustos
8. **Optimizar rendimiento** con técnicas de procesamiento eficiente
9. **Trabajar con APIs y web scraping** para ingesta de datos
10. **Usar virtual environments** y gestionar dependencias correctamente
11. **Escribir código testeable** con pruebas unitarias usando pytest
12. **Aplicar patterns de ingeniería de datos** como Factory, Builder y Pipeline

## Prerequisitos

### Conocimientos Requeridos
- Comprensión básica de programación (variables, loops, condicionales)
- Familiaridad con línea de comandos
- Módulo 03 completado (recomendado pero no obligatorio)

### Software Requerido
- Python 3.11+
- Docker y Docker Compose
- pip y venv
- Editor de código (VS Code recomendado)
- 3GB de espacio libre en disco

### Recomendado pero Opcional
- Jupyter Lab/Notebook
- Git para control de versiones
- Conocimientos básicos de SQL
- Familiaridad con conceptos de ETL

## Estructura del Módulo

```
module-04-python-for-data/
├── README.md                    # Este archivo
├── STATUS.md                    # Seguimiento de progreso
├── requirements.txt             # Dependencias Python
├── .gitignore                   # Archivos a ignorar
│
├── theory/                      # 📚 Documentación conceptual
│   ├── concepts.md             # Fundamentos de Python para datos
│   ├── architecture.md         # Patrones y arquitecturas
│   └── resources.md            # Recursos adicionales
│
├── infrastructure/              # 🐳 Configuración de entorno
│   ├── docker-compose.yml      # Jupyter Lab + Python
│   ├── Dockerfile              # Imagen personalizada
│   ├── .env.example            # Variables de entorno
│   └── README.md               # Guía de setup
│
├── data/                        # 📊 Datasets de práctica
│   ├── raw/                    # Datos sin procesar
│   ├── processed/              # Datos procesados
│   ├── schemas/                # Esquemas de datos
│   └── README.md               # Diccionario de datos
│
├── exercises/                   # 💻 Ejercicios prácticos
│   ├── 01-python-basics/       # Fundamentos de Python
│   ├── 02-data-structures/     # Listas, dicts, comprehensions
│   ├── 03-file-operations/     # CSV, JSON, Parquet
│   ├── 04-pandas-fundamentals/ # DataFrames y Series
│   ├── 05-data-transformation/ # Limpieza y transformación
│   └── 06-error-handling/      # Logging y excepciones
│
├── validation/                  # ✅ Tests automatizados
│   ├── conftest.py             # Configuración pytest
│   ├── test_exercise_*.py      # Tests por ejercicio
│   ├── helpers.py              # Utilidades de testing
│   └── README.md               # Guía de testing
│
├── assets/                      # 📋 Recursos de aprendizaje
│   ├── cheatsheets/            # Referencias rápidas
│   ├── diagrams/               # Diagramas visuales
│   └── README.md               # Catálogo de assets
│
└── scripts/                     # 🔧 Scripts de automatización
    ├── setup.sh                # Configuración inicial
    ├── validate.sh             # Ejecutar tests
    ├── reset_env.sh            # Reset de entorno
    └── run_jupyter.sh          # Iniciar Jupyter Lab
```

## Ruta de Aprendizaje

### Fase 1: Fundamentos (4-5 horas)
1. **Teoría**: Lee `theory/concepts.md` para entender fundamentos
2. **Setup**: Ejecuta `./scripts/setup.sh` para configurar entorno
3. **Ejercicio 01**: Python Basics - Sintaxis, tipos, operadores
4. **Ejercicio 02**: Data Structures - Listas, dicts, sets, comprehensions

### Fase 2: Trabajo con Archivos (3-4 horas)
5. **Ejercicio 03**: File Operations - CSV, JSON, Parquet, Excel
6. **Práctica**: Carga y explora los datasets en `data/raw/`

### Fase 3: Pandas y Transformaciones (5-6 horas)
7. **Ejercicio 04**: Pandas Fundamentals - DataFrames, Series, indexing
8. **Ejercicio 05**: Data Transformation - Merge, group, pivot, reshape
9. **Proyecto Mini**: Construye un pipeline de transformación completo

### Fase 4: Producción (2-3 horas)
10. **Ejercicio 06**: Error Handling - Try/except, logging, debugging
11. **Validación**: Ejecuta `./scripts/validate.sh` para verificar aprendizaje
12. **Revisión**: Estudia `assets/cheatsheets/` para repasar conceptos

## Ejercicios Detallados

### Ejercicio 01: Python Basics (60 min)
**Objetivos**:
- Sintaxis básica de Python
- Tipos de datos (int, float, str, bool)
- Operadores y expresiones
- Control de flujo (if/elif/else, loops)
- Funciones básicas

**Archivos**:
- `starter/basics.py` - Ejercicios con TODO
- `solution/basics.py` - Soluciones completas
- `README.md` - Teoría y ejemplos

---

### Ejercicio 02: Data Structures (90 min)
**Objetivos**:
- Listas y operaciones (append, slice, sort)
- Diccionarios y métodos (keys, values, items)
- Sets y operaciones de conjunto
- Tuples e inmutabilidad
- List/Dict/Set comprehensions
- Nested structures

**Archivos**:
- `starter/data_structures.py` - Ejercicios
- `solution/data_structures.py` - Soluciones
- `examples/comprehensions.py` - Ejemplos avanzados
- `README.md` - Guía detallada

---

### Ejercicio 03: File Operations (120 min)
**Objetivos**:
- Lectura/escritura de CSV con `csv` module
- Trabajo con JSON (load, dump, nested data)
- Parquet files con `pyarrow`/`fastparquet`
- Excel files con `openpyxl`
- Context managers (`with` statement)
- Error handling en I/O

**Archivos**:
- `starter/file_io.py` - Ejercicios
- `solution/file_io.py` - Soluciones
- `data/` - Archivos de ejemplo
- `README.md` - Guía de formatos

---

### Ejercicio 04: Pandas Fundamentals (150 min)
**Objetivos**:
- Crear DataFrames y Series
- Indexing y selection (loc, iloc, at, iat)
- Filtering y querying
- Column operations
- Basic statistics (describe, mean, median)
- Sorting y ranking
- Missing data (isna, fillna, dropna)

**Archivos**:
- `starter/pandas_basics.py` - Ejercicios
- `solution/pandas_basics.py` - Soluciones
- `notebooks/pandas_tutorial.ipynb` - Jupyter notebook
- `README.md` - Guía completa

---

### Ejercicio 05: Data Transformation (180 min)
**Objetivos**:
- Merge y join operations
- Concatenate DataFrames
- GroupBy y aggregations
- Pivot tables
- Reshape (melt, stack, unstack)
- Apply y map functions
- String operations
- Date/time handling

**Archivos**:
- `starter/transformation.py` - Ejercicios
- `solution/transformation.py` - Soluciones
- `examples/etl_pipeline.py` - Pipeline completo
- `README.md` - Patrones de transformación

---

### Ejercicio 06: Error Handling & Logging (90 min)
**Objetivos**:
- Try/except/finally blocks
- Exception types
- Custom exceptions
- Logging module (info, warning, error)
- Log configuration
- Debugging techniques
- Best practices para producción

**Archivos**:
- `starter/error_handling.py` - Ejercicios
- `solution/error_handling.py` - Soluciones
- `examples/production_pipeline.py` - Pipeline robusto
- `README.md` - Guía de errores comunes

---

## Dataset de Práctica

El módulo incluye un dataset realista de e-commerce con múltiples formatos:

### Archivos Disponibles
- `customers.csv` (10,000 registros) - Datos de clientes
- `orders.json` (50,000 registros) - Órdenes con nested data
- `products.parquet` (5,000 registros) - Catálogo de productos
- `transactions.csv` (100,000 registros) - Transacciones detalladas
- `user_activity.json` (200,000 registros) - Logs de actividad

### Características
- Datos realistas con casos edge (nulls, duplicados)
- Múltiples formatos para práctica
- Relaciones entre tablas para joins
- Timestamps para análisis temporal
- Datos sucios para data cleaning

## Validación y Testing

### Ejecutar Todos los Tests
```bash
cd modules/module-04-python-for-data
./scripts/validate.sh
```

### Tests por Ejercicio
```bash
./scripts/validate.sh --exercise 01  # Solo ejercicio 01
./scripts/validate.sh --exercise 04  # Solo pandas
```

### Tests con Coverage
```bash
./scripts/validate.sh --coverage
```

### Tests Rápidos (sin lentos)
```bash
./scripts/validate.sh --fast
```

## Entorno de Desarrollo

### Opción 1: Docker (Recomendado)
```bash
# Setup automático
./scripts/setup.sh

# Iniciar Jupyter Lab
./scripts/run_jupyter.sh

# Acceder a: http://localhost:8888
```

### Opción 2: Virtual Environment Local
```bash
# Crear venv
python3 -m venv venv
source venv/bin/activate  # Linux/Mac
# venv\Scripts\activate   # Windows

# Instalar dependencias
pip install -r requirements.txt

# Verificar instalación
python -c "import pandas; print(pandas.__version__)"
```

### Opción 3: Poetry (Avanzado)
```bash
# Instalar Poetry
curl -sSL https://install.python-poetry.org | python3 -

# Setup proyecto
poetry install

# Activar shell
poetry shell
```

## Recursos Adicionales

### Cheatsheets Incluidos
- `assets/cheatsheets/python-basics.md` - Sintaxis fundamental
- `assets/cheatsheets/pandas-reference.md` - Operaciones pandas
- `assets/cheatsheets/data-cleaning.md` - Técnicas de limpieza
- `assets/cheatsheets/file-formats.md` - CSV/JSON/Parquet

### Documentación Externa
- [Python Docs](https://docs.python.org/3/) - Documentación oficial
- [Pandas Docs](https://pandas.pydata.org/docs/) - Guía pandas
- [Real Python](https://realpython.com/) - Tutoriales prácticos
- [Python for Data Analysis](https://wesmckinney.com/book/) - Libro de Wes McKinney

### Comunidad
- Stack Overflow - Preguntas técnicas
- r/datascience - Reddit community
- PyData - Conferencias y meetups

## Checklist de Progreso

### Fundamentos
- [ ] Leído `theory/concepts.md`
- [ ] Leído `theory/architecture.md`
- [ ] Setup completado (`./scripts/setup.sh`)
- [ ] Jupyter Lab funcionando

### Ejercicios
- [ ] ✅ Ejercicio 01: Python Basics (tests pasando)
- [ ] ✅ Ejercicio 02: Data Structures (tests pasando)
- [ ] ✅ Ejercicio 03: File Operations (tests pasando)
- [ ] ✅ Ejercicio 04: Pandas Fundamentals (tests pasando)
- [ ] ✅ Ejercicio 05: Data Transformation (tests pasando)
- [ ] ✅ Ejercicio 06: Error Handling (tests pasando)

### Validación
- [ ] Todos los tests pasando (`./scripts/validate.sh`)
- [ ] Coverage > 80%
- [ ] Revisado cheatsheets en `assets/`

### Proyecto Final
- [ ] Pipeline ETL completo implementado
- [ ] Data quality checks incluidos
- [ ] Error handling robusto
- [ ] Logging configurado
- [ ] Código documentado

## Próximos Pasos

Después de completar este módulo, estarás listo para:

- **Módulo 05**: Data Lakehouse Architecture - Aplicar Python en arquitecturas modernas
- **Módulo 06**: ETL Fundamentals - Construir pipelines completos
- **Módulo 07**: Batch Processing - Procesar grandes volúmenes con PySpark
- **Módulo 08**: Streaming Basics - Real-time data processing

## Tiempo Estimado por Sección

| Sección | Tiempo Estimado | Prioridad |
|---------|----------------|-----------|
| Theory (concepts + architecture) | 2-3 horas | Alta |
| Setup (infrastructure) | 30 min | Alta |
| Ejercicio 01 (Python Basics) | 1 hora | Alta |
| Ejercicio 02 (Data Structures) | 1.5 horas | Alta |
| Ejercicio 03 (File Operations) | 2 horas | Alta |
| Ejercicio 04 (Pandas Fundamentals) | 2.5 horas | Crítica |
| Ejercicio 05 (Data Transformation) | 3 horas | Crítica |
| Ejercicio 06 (Error Handling) | 1.5 horas | Alta |
| Assets & Cheatsheets | 1 hora | Media |
| Proyecto Final | 2 horas | Media |
| **TOTAL** | **14-16 horas** | - |

## Comandos Rápidos

```bash
# Setup inicial
./scripts/setup.sh

# Jupyter Lab
./scripts/run_jupyter.sh

# Validar todo
./scripts/validate.sh

# Validar ejercicio específico
./scripts/validate.sh --exercise 04

# Reset entorno
./scripts/reset_env.sh

# Ver logs
docker-compose -f infrastructure/docker-compose.yml logs -f
```

## Solución de Problemas

### Error: "Module not found"
```bash
# Verificar instalación
pip list | grep pandas

# Reinstalar dependencias
pip install -r requirements.txt --force-reinstall
```

### Jupyter Lab no inicia
```bash
# Verificar puerto 8888 libre
lsof -i :8888

# Reiniciar container
docker-compose -f infrastructure/docker-compose.yml restart
```

### Tests fallan
```bash
# Ver detalles
./scripts/validate.sh --verbose

# Limpiar cache pytest
find . -type d -name __pycache__ -exec rm -rf {} +
find . -type d -name .pytest_cache -exec rm -rf {} +
```

Ver guía completa en `docs/troubleshooting.md`

## Contribuciones

Este módulo es parte del curso **Training Cloud Data**. Para reportar errores o sugerir mejoras:

1. Revisar `STATUS.md` para ver progreso actual
2. Verificar que el issue no exista
3. Incluir detalles del problema
4. Proporcionar ejemplos reproducibles

## Notas Importantes

- 🐍 **Python 3.11+** requerido (usa features modernas)
- 📊 **pandas 2.0+** para mejor rendimiento
- 🐳 **Docker recomendado** para consistencia
- 📝 **Jupyter notebooks** incluidos para exploración
- ✅ **Tests obligatorios** antes de avanzar
- 🔧 **Code style**: Seguimos PEP 8
- 📚 **Documentación**: Todos los ejercicios tienen README detallado

## Licencia

Este material es parte del curso Training Cloud Data.

---

**¿Listo para comenzar?** 🚀

```bash
cd modules/module-04-python-for-data
./scripts/setup.sh
```

¡Éxito en tu aprendizaje de Python para Ingeniería de Datos!
