# Módulo 06: Fundamentos de ETL (Extract, Transform, Load)

## 📋 Descripción

Bienvenido al Módulo 06 del bootcamp de Data Engineering. En este módulo aprenderás los fundamentos de **ETL (Extract, Transform, Load)**, el proceso core de la ingeniería de datos para mover y transformar datos entre sistemas.

⏱️ **Duración estimada**: 12-15 horas

## 🎯 Objetivos de Aprendizaje

Al completar este módulo, serás capaz de:

- ✅ Comprender los conceptos fundamentales de ETL
- ✅ Extraer datos de múltiples fuentes (CSV, JSON, APIs, bases de datos)
- ✅ Transformar datos usando pandas y Python
- ✅ Cargar datos a diferentes destinos
- ✅ Construir pipelines ETL completos y robustos
- ✅ Implementar manejo de errores y logging
- ✅ Validar calidad de datos y crear data quality checks

## 📦 Prerequisitos

Antes de comenzar este módulo, debes haber completado:

- ✅ **Módulo 02**: Storage Basics (lectura/escritura archivos)
- ✅ **Módulo 04**: Python for Data (pandas, testing)

**Conocimientos necesarios**:
- Python intermedio (funciones, clases, manejo de excepciones)
- pandas básico (DataFrame operations)
- SQL básico (queries, inserts)
- Conceptos de APIs REST

**Software requerido**:
- Python 3.8+
- pip y virtualenv
- SQLite (incluido en Python)

## 🏗️ Arquitectura ETL

```
┌─────────────────────────────────────────────────────────────┐
│                      ETL PIPELINE                            │
│                                                               │
│  ┌──────────┐      ┌──────────────┐      ┌──────────┐      │
│  │ EXTRACT  │  →   │  TRANSFORM   │  →   │   LOAD   │      │
│  └──────────┘      └──────────────┘      └──────────┘      │
│       ↓                    ↓                     ↓           │
│   Sources           Processing            Destinations       │
│   • CSV             • Clean               • Database         │
│   • JSON            • Filter              • Data Lake        │
│   • APIs            • Aggregate           • Data Warehouse   │
│   • Databases       • Join                • Files            │
│   • Logs            • Enrich              • APIs             │
│                                                               │
│  Cross-cutting Concerns:                                     │
│  ✓ Logging & Monitoring   ✓ Error Handling                  │
│  ✓ Data Quality           ✓ Performance                     │
│  ✓ Idempotency            ✓ Testing                         │
└─────────────────────────────────────────────────────────────┘
```

## 📂 Estructura del Módulo

```
module-06-etl-fundamentals/
├── README.md                          # Este archivo
├── STATUS.md                          # Estado de completitud
├── requirements.txt                   # Dependencias Python
│
├── theory/                            # Material teórico
│   ├── 01-concepts.md                 # Conceptos fundamentales ETL
│   ├── 02-patterns.md                 # Patrones y best practices
│   └── 03-resources.md                # Recursos adicionales
│
├── exercises/                         # 6 ejercicios prácticos
│   ├── 01-extract-basics/             # Extracción de datos
│   ├── 02-transform-basics/           # Transformaciones
│   ├── 03-load-basics/                # Carga de datos
│   ├── 04-full-pipeline/              # Pipeline ETL completo
│   ├── 05-error-handling/             # Errores y logging
│   └── 06-data-quality/               # Calidad de datos
│
├── data/                              # Datasets de ejemplo
│   ├── raw/                           # Datos crudos
│   ├── schemas/                       # Esquemas de datos
│   └── scripts/                       # Scripts generación datos
│
├── validation/                        # Tests automatizados
│   ├── conftest.py                    # Fixtures de pytest
│   └── test_*.py                      # Tests por ejercicio
│
├── scripts/                           # Scripts de automatización
│   ├── setup.sh                       # Setup del entorno
│   ├── validate.sh                    # Ejecutar tests
│   └── run_pipeline.sh                # Ejecutar pipeline ejemplo
│
└── assets/                            # Cheatsheets y referencia
    ├── etl-checklist.md
    └── pandas-transforms.md
```

## 🎓 Ejercicios

### Ejercicio 01: Extract Basics (⭐ Básico - 1.5h)
Extracción de datos de diferentes fuentes: CSV, JSON, APIs, SQLite

### Ejercicio 02: Transform Basics (⭐⭐ Intermedio - 2h)
Transformaciones comunes: limpieza, conversión de tipos, agregaciones

### Ejercicio 03: Load Basics (⭐⭐ Intermedio - 1.5h)
Carga de datos: CSV, JSON, SQLite con upsert

### Ejercicio 04: Full Pipeline (⭐⭐⭐ Avanzado - 3h)
Pipeline ETL end-to-end modular y configurable

### Ejercicio 05: Error Handling (⭐⭐⭐⭐ Avanzado - 2h)
Manejo robusto de errores, logging, retry logic

### Ejercicio 06: Data Quality (⭐⭐⭐⭐⭐ Experto - 2.5h)
Validación de calidad de datos y anomaly detection

## 📊 Progress Checklist

- [ ] Leer toda la teoría
- [ ] Completar Ejercicio 01
- [ ] Completar Ejercicio 02
- [ ] Completar Ejercicio 03
- [ ] Completar Ejercicio 04
- [ ] Completar Ejercicio 05
- [ ] Completar Ejercicio 06
- [ ] Todos los tests pasan

## ➡️ Próximos Pasos

- **Módulo 07**: Batch Processing (PySpark)
- **Módulo 08**: Streaming Basics (Kafka)
- **Módulo 10**: Workflow Orchestration (Airflow)
