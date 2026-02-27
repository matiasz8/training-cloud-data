# Módulo 05: Arquitectura Data Lakehouse ✅ 100% COMPLETO

## 📋 Descripción

Bienvenido al Módulo 05 del bootcamp de Data Engineering. En este módulo profundizaremos en la **arquitectura Data Lakehouse**, la evolución más reciente en el almacenamiento y procesamiento de datos a gran escala que combina lo mejor de los Data Lakes y Data Warehouses.

**🎉 Estado: COMPLETADO - 68 archivos, 6 ejercicios, 26 tests, 614,500 registros sintéticos**

### 🎯 Objetivos de Aprendizaje

Al completar este módulo, serás capaz de:

- ✅ Comprender la arquitectura y principios del Data Lakehouse
- ✅ Diferenciar entre Data Lake, Data Warehouse y Data Lakehouse
- ✅ Implementar tablas Delta Lake con transacciones ACID
- ✅ Trabajar con Apache Iceberg y comparar formatos de tabla
- ✅ Diseñar e implementar la arquitectura Medallion (Bronze/Silver/Gold)
- ✅ Utilizar Time Travel para auditoría y recuperación de datos
- ✅ Gestionar Schema Evolution sin romper pipelines
- ✅ Optimizar el rendimiento con particionamiento y Z-ordering
- ✅ Implementar pipelines de datos escalables y confiables

### 🏗️ Arquitectura Data Lakehouse

El **Data Lakehouse** es un paradigma moderno que combina:

- **Flexibilidad de Data Lakes**: Almacenamiento de datos estructurados, semi-estructurados y no estructurados
- **Confiabilidad de Data Warehouses**: Transacciones ACID, versionado, schema enforcement
- **Rendimiento optimizado**: Indexación, caching, optimización de queries
- **Governance**: Auditoría, linaje de datos, control de acceso

```
┌─────────────────────────────────────────────────────────────┐
│                    DATA LAKEHOUSE                            │
│  ┌────────────┐  ┌──────────────┐  ┌──────────────────┐    │
│  │  Storage   │  │   Metadata   │  │  Query Engine    │    │
│  │  (S3/MinIO)│  │  (Delta/Ice) │  │  (Spark/Presto)  │    │
│  └────────────┘  └──────────────┘  └──────────────────┘    │
│                                                               │
│  Features:                                                    │
│  ✓ ACID Transactions    ✓ Time Travel                       │
│  ✓ Schema Evolution     ✓ Data Versioning                   │
│  ✓ Unified Batch+Stream ✓ BI + ML Workloads                 │
└─────────────────────────────────────────────────────────────┘
```

### 🌊 Arquitectura Medallion

Implementaremos la **arquitectura Medallion**, un patrón de diseño que organiza los datos en tres capas:

#### 🥉 Bronze Layer (Raw Data)
- Datos crudos tal como llegan de las fuentes
- Mínima transformación (solo ingesta)
- Append-only, inmutable
- Preserva el linaje completo

#### 🥈 Silver Layer (Refined Data)
- Datos limpios y validados
- Deduplicación y normalización
- Tipos de datos correctos
- Business rules aplicadas

#### 🥇 Gold Layer (Business-Level Aggregates)
- Datos optimizados para consumo
- Agregaciones y métricas de negocio
- Modelos dimensionales o de features
- Listos para BI/Analytics/ML

```
Sources → [Bronze] → [Silver] → [Gold] → Analytics/ML
          (Raw)      (Cleaned)  (Aggregated)
```

### 🔧 Tecnologías Principales

#### Delta Lake (70% del módulo)

**Delta Lake** es un formato de tabla open-source desarrollado por Databricks que agrega:

- ✅ **ACID Transactions**: Escrituras atómicas, consistentes, aisladas y durables
- ✅ **Time Travel**: Acceso a versiones históricas de datos
- ✅ **Schema Enforcement**: Validación automática de esquemas
- ✅ **Schema Evolution**: Añadir/modificar columnas sin romper pipelines
- ✅ **Unified Streaming + Batch**: Misma tabla para ambos workloads
- ✅ **Scalable Metadata**: Manejo eficiente de millones de archivos
- ✅ **Data Versioning**: Rollback, audit trails completos

**Caso de uso ideal**: Pipelines de datos empresariales que requieren alta confiabilidad

#### Apache Iceberg (30% del módulo)

**Apache Iceberg** es un formato de tabla open-source de Netflix/Apache con:

- ✅ **Snapshot Isolation**: Consistencia a nivel de snapshot
- ✅ **Hidden Partitioning**: Particionamiento automático transparente
- ✅ **Time Travel**: Queries sobre snapshots históricos
- ✅ **Schema Evolution**: Evolución segura del esquema
- ✅ **Partition Evolution**: Cambiar estrategia de particionamiento sin reescribir
- ✅ **Multi-Engine Support**: Compatible con Spark, Flink, Presto, Trino

**Caso de uso ideal**: Entornos multi-engine con requerimientos de flexibilidad

### 🏛️ Comparación: Lake vs Warehouse vs Lakehouse

| Característica | Data Lake | Data Warehouse | Data Lakehouse |
|----------------|-----------|----------------|----------------|
| **Datos soportados** | Todos (struct/semi/no-struct) | Solo estructurados | Todos |
| **Formato** | Parquet, CSV, JSON | Propietario (columnar) | Delta/Iceberg |
| **Schema** | Schema-on-read | Schema-on-write | Flexible (ambos) |
| **Transacciones ACID** | ❌ No | ✅ Sí | ✅ Sí |
| **Performance BI** | ⚠️ Lento | ✅ Rápido | ✅ Rápido |
| **Costo** | 💰 Bajo | 💰💰💰 Alto | 💰💰 Medio |
| **ML Support** | ✅ Excelente | ⚠️ Limitado | ✅ Excelente |
| **Escalabilidad** | ✅ Petabytes+ | ⚠️ Terabytes | ✅ Petabytes+ |
| **Governance** | ⚠️ Complejo | ✅ Robusto | ✅ Robusto |
| **Time Travel** | ❌ No | ⚠️ Limitado | ✅ Sí |

### 📦 Prerequisitos

Antes de comenzar este módulo, debes haber completado:

- ✅ **Módulo 02**: Storage Basics (S3/MinIO, Parquet, particionamiento)
- ⚠️ **Módulo 03**: SQL Foundations (queries, joins, window functions) - Recomendado
- ⚠️ **Módulo 04**: Python for Data (pandas, testing, pipelines) - Recomendado

**Conocimientos necesarios**:
- Comandos básicos de Linux/Bash
- Conceptos de bases de datos relacionales
- Python intermedio (funciones, clases, manejo de errores)
- PySpark básico (aprenderemos en el módulo)

**Software requerido**:
- Docker y Docker Compose
- Python 3.8+
- 8GB RAM mínimo (16GB recomendado)
- 10GB espacio en disco

### 📂 Estructura del Módulo

```
module-05-data-lakehouse/
├── README.md                          # Este archivo
├── requirements.txt                   # Dependencias Python
├── STATUS.md                          # Tracking de progreso
├── .gitignore                         # Archivos ignorados
│
├── theory/                            # Material teórico
│   ├── 01-concepts.md                 # Conceptos fundamentales
│   ├── 02-architecture.md             # Arquitectura y patrones
│   └── 03-resources.md                # Recursos adicionales
│
├── infrastructure/                    # Infraestructura Docker
│   ├── docker-compose.yml             # Servicios: Spark, MinIO, Jupyter
│   ├── spark/                         # Configuración Spark
│   ├── minio/                         # Configuración MinIO (S3)
│   └── init-scripts/                  # Scripts de inicialización
│
├── data/                              # Datasets
│   ├── raw/                           # Datos crudos (Bronze layer)
│   ├── schemas/                       # Esquemas JSON
│   └── scripts/                       # Scripts generación de datos
│
├── exercises/                         # 6 ejercicios prácticos
│   ├── 01-delta-basics/               # ⭐ Fundamentos Delta Lake
│   ├── 02-medallion-architecture/     # ⭐⭐⭐ Implementar Bronze/Silver/Gold
│   ├── 03-time-travel/                # ⭐⭐⭐ Time Travel y versionado
│   ├── 04-schema-evolution/           # ⭐⭐⭐⭐ Evolución de esquemas
│   ├── 05-optimization/               # ⭐⭐⭐⭐ Optimización y tuning
│   └── 06-iceberg-comparison/         # ⭐⭐⭐⭐⭐ Delta vs Iceberg
│
├── validation/                        # Tests automáticos
│   ├── conftest.py                    # Fixtures compartidos
│   ├── test_integration.py            # Tests de integración
│   ├── test_data_quality.py           # Tests de calidad de datos
│   └── test_module_completeness.py    # Tests de completitud
│
├── assets/                            # Recursos de apoyo
│   ├── cheatsheets/                   # Guías rápidas
│   │   ├── delta-commands.md          # Comandos Delta Lake
│   │   ├── medallion-patterns.md      # Patrones Medallion
│   │   ├── table-formats.md           # Comparación formatos
│   │   └── spark-optimization.md      # Optimización Spark
│   └── diagrams/                      # Diagramas arquitectura
│       ├── medallion-flow.md          # Flujo Medallion
│       ├── delta-architecture.md      # Arquitectura Delta
│       └── partitioning.md            # Estrategias particionamiento
│
├── scripts/                           # Automatización
│   ├── setup.sh                       # Setup completo del entorno
│   ├── validate.sh                    # Ejecutar todos los tests
│   ├── run_spark.sh                   # Spark shell interactivo
│   └── run_jupyter.sh                 # Jupyter Lab
│
└── docs/                              # Documentación adicional
    ├── troubleshooting-spark.md       # Solución de problemas
    └── lakehouse-guide.md             # Guía de mejores prácticas
```

### 🚀 Quick Start

#### 1. Setup del Entorno

```bash
# Clonar el repositorio (si aún no lo has hecho)
cd training-cloud-data/modules/module-05-data-lakehouse

# Instalar dependencias
./scripts/setup.sh

# Levantar infraestructura Docker
docker-compose up -d

# Verificar que todo está corriendo
docker-compose ps
```

#### 2. Explorar el Material Teórico

```bash
# Leer conceptos fundamentales
cat theory/01-concepts.md

# Estudiar arquitectura Medallion
cat theory/02-architecture.md
```

#### 3. Ejecutar Ejercicios

```bash
# Activar entorno virtual
source venv/bin/activate

# Ejercicio 1: Delta Lake Basics
cd exercises/01-delta-basics
pytest test_solution.py -v

# Jupyter Lab para desarrollo interactivo
./scripts/run_jupyter.sh
```

#### 4. Validar el Módulo Completo

```bash
# Ejecutar todos los tests
./scripts/validate.sh --all

# Con reporte de cobertura
./scripts/validate.sh --coverage
```

### 📊 Ejercicios y Dificultad

| Ejercicio | Dificultad | Tiempo | Temas Clave |
|-----------|------------|--------|-------------|
| **01-delta-basics** | ⭐ Básico | 1-2h | Create, Read, Write, Append, Overwrite |
| **02-medallion-architecture** | ⭐⭐⭐ Intermedio | 3-4h | Bronze→Silver→Gold, Data Quality, Transformations |
| **03-time-travel** | ⭐⭐⭐ Intermedio | 2-3h | Versioning, Rollback, Audit Trails |
| **04-schema-evolution** | ⭐⭐⭐⭐ Avanzado | 2-3h | Add/Drop Columns, Type Changes, Compatibility |
| **05-optimization** | ⭐⭐⭐⭐ Avanzado | 3-4h | Partitioning, Z-ordering, Compaction, Vacuum |
| **06-iceberg-comparison** | ⭐⭐⭐⭐⭐ Experto | 4-5h | Delta vs Iceberg, Migration, Trade-offs |

**Tiempo total estimado**: 15-21 horas

### 🎓 Learning Path

```
1. Theory (3-4h)
   └─ Concepts → Architecture → Resources

2. Infrastructure (1-2h)
   └─ Docker Setup → Spark Config → MinIO S3

3. Hands-on Exercises (12-15h)
   └─ Delta Basics → Medallion → Time Travel → Evolution → Optimization → Iceberg

4. Project (Optional, 4-6h)
   └─ End-to-End Lakehouse Pipeline
```

### 📚 Recursos Adicionales

- 📖 [Delta Lake Documentation](https://docs.delta.io/)
- 📖 [Apache Iceberg Documentation](https://iceberg.apache.org/)
- 📖 [Databricks Lakehouse Whitepaper](https://www.databricks.com/research/lakehouse-a-new-generation-of-open-platforms)
- 📖 [PySpark Documentation](https://spark.apache.org/docs/latest/api/python/)
- 🎥 [Medallion Architecture Explained](https://www.databricks.com/glossary/medallion-architecture)
- 📝 [Delta Lake vs Apache Iceberg Comparison](https://delta.io/blog/delta-lake-vs-iceberg/)

### 🆘 Troubleshooting

Si encuentras problemas durante el módulo:

1. **Consulta la documentación**: [docs/troubleshooting-spark.md](docs/troubleshooting-spark.md)
2. **Revisa los logs**: `docker-compose logs spark-master`
3. **Verifica la infraestructura**: `docker-compose ps` y `docker-compose logs`
4. **Ejecuta los tests de diagnóstico**: `./scripts/validate.sh --fast`

### 🤝 Contribuciones

Si encuentras errores o tienes sugerencias de mejora, por favor:

1. Abre un issue en el repositorio
2. Proporciona detalles específicos (error, contexto, pasos para reproducir)
3. Incluye logs relevantes si es posible

### 📝 Notas Importantes

- ⚠️ **Recursos de hardware**: Algunos ejercicios requieren procesamiento intensivo
- 💾 **Almacenamiento**: Los datasets generarán ~2GB de datos
- 🐳 **Docker**: Asegúrate de tener Docker corriendo antes de empezar
- 🔒 **Permisos**: Los scripts necesitan permisos de ejecución (`chmod +x scripts/*.sh`)

### 🎯 Próximos Pasos

Una vez completado este módulo, estarás preparado para:

- **Módulo 07**: Batch Processing con Apache Spark (procesa los lakehouses)
- **Módulo 14**: Data Governance & Security (gobernanza en lakehouses)
- **Checkpoint 01**: Proyecto integrador Tier 2

---

## 🚀 ¡Comencemos!

El Data Lakehouse representa el futuro del almacenamiento y procesamiento de datos. Combina la flexibilidad de los Data Lakes con la confiabilidad de los Data Warehouses, permitiendo workloads de BI y ML sobre la misma plataforma.

**¿Listo para construir tu primer Lakehouse?** 

Comienza leyendo [theory/01-concepts.md](theory/01-concepts.md) y luego ejecuta `./scripts/setup.sh` para configurar el entorno.

---

**Última actualización**: Febrero 2026  
**Versión del módulo**: 1.0.0  
**Estado**: En desarrollo 🚧
