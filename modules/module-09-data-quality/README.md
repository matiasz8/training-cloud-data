# Module 09: Data Quality

⏱️ **Duración estimada:** 15-20 horas  
🎯 **Nivel:** Intermedio-Avanzado  
📊 **Estado:** ✅ Completado

## 📋 Descripción

Módulo completo sobre calidad de datos que cubre las 6 dimensiones de calidad, frameworks empresariales (Great Expectations, Pandera, PyDeequ), detección de anomalías, monitoreo continuo y quality gates en producción.

## 🎯 Objetivos de Aprendizaje

Al completar este módulo, serás capaz de:

- ✅ Entender y aplicar las **6 dimensiones de calidad** de datos
- ✅ Implementar **data profiling** manual y automático
- ✅ Crear **reglas de validación** personalizadas
- ✅ Dominar **Great Expectations** para validaciones empresariales
- ✅ Detectar **anomalías** usando métodos estadísticos y ML
- ✅ Implementar **monitoreo continuo** de calidad
- ✅ Configurar **quality gates** en pipelines de producción
- ✅ Gestionar **quarantine zones** y rollback automático

## 📚 Contenido

### Theory (45,000 palabras)

- **01-concepts.md** - 6 Dimensiones de calidad, profiling, métricas
- **02-architecture.md** - Great Expectations, Pandera, PyDeequ, patrones de arquitectura
- **03-resources.md** - Herramientas, cloud services, recursos de aprendizaje

### Exercises (6 ejercicios progresivos)

1. **Data Profiling** - Profiling manual y automático, detección de outliers
2. **Validation Rules** - Reglas personalizadas, framework de validación
3. **Great Expectations** - Setup, expectation suites, checkpoints, Data Docs
4. **Anomaly Detection** - Métodos estadísticos y ML, series temporales
5. **Quality Monitoring** - Métricas continuas, quality drift, alertas
6. **Production Quality Gates** - Integración con Airflow, circuit breakers, versioning

### Data

- **generate_data.py** - Script para generar datasets con calidad configurable
- **Schemas** - JSON schemas con qualityRules para 3 tablas
- **3 quality levels** - clean, medium, poor

### Validation

- **50+ tests** - Pytest suite completa
- **Markers** - smoke, profiling, validation, great_expectations, anomaly_detection, monitoring
- **Coverage** - HTML coverage reports

## 🚀 Quick Start

```bash
# 1. Setup
./scripts/setup.sh

# 2. Activate environment
source venv/bin/activate

# 3. Generate sample data
python data/scripts/generate_data.py --quality clean --output data/generated/

# 4. Start with exercises
# See exercises/01-data-profiling/README.md

# 5. Validate completion
./scripts/validate.sh
```

## 🛠️ Technologies

### Core Frameworks
- **Great Expectations** 0.18+ - Validaciones empresariales
- **Pandera** 0.17+ - Schema-based validation
- **PyDeequ** 1.1+ - Big data quality (Spark)

### Profiling & Analysis
- **ydata-profiling** 4.5+ - Automatic profiling
- **scipy** 1.11+ - Statistical methods

### Anomaly Detection
- **PyOD** 1.1+ - Outlier detection algorithms
- **scikit-learn** 1.3+ - Isolation Forest, LOF

### Testing
- **pytest** 7.4+ - Testing framework
- **pytest-cov** 4.1+ - Coverage reports

## 📖 Prerequisites

- ✅ Module 04: Python for Data (100%)
- ✅ Module 06: ETL Fundamentals (100%)
- Python 3.9+
- Conocimiento de Pandas, NumPy

## ✅ Validation

```bash
# Run all tests
pytest validation/ -v

# Run specific categories
pytest validation/ -m smoke
pytest validation/ -m profiling
pytest validation/ -m validation
pytest validation/ -m anomaly_detection

# Generate coverage
pytest validation/ --cov=. --cov-report=html

# Full validation

./scripts/validate.sh
```

## 📊 Module Metrics

- **Files**: 30+ archivos
- **Documentation**: ~45,000 palabras
- **Code**: ~2,000 líneas Python
- **Tests**: 50+ tests
- **Exercises**: 6 ejercicios progresivos

## 🔗 Resources

- [Great Expectations Docs](https://docs.greatexpectations.io/)
- [Pandera Documentation](https://pandera.readthedocs.io/)
- [PyOD Documentation](https://pyod.readthedocs.io/)

## ➡️ Next Modules

- **Module 10: Workflow Orchestration**
- **Module 11: Infrastructure as Code**

---

**Status**: ✅ Completado 100%  
**Last Updated**: 2024
