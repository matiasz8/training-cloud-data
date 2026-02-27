# Ejercicio 02: Medallion Architecture (Bronze → Silver → Gold)

## 🎯 Objetivo

Implementar la arquitectura Medallion completa, el patrón fundamental de Data Lakehouse:

- **Bronze Layer** (Raw): Ingestión cruda, append-only, datos tal cual llegan
- **Silver Layer** (Cleaned): Limpieza, validación, deduplicación, tipos correctos
- **Gold Layer** (Aggregated): Métricas de negocio, agregaciones, reportes

**Dificultad**: ⭐⭐⭐ Intermedio  
**Tiempo Estimado**: 90-120 minutos  
**Prerequisitos**: Ejercicio 01 completado

---

## 📋 Descripción del Ejercicio

Tu equipo necesita construir un pipeline de datos end-to-end para procesar transacciones de e-commerce. El objetivo es transformar datos crudos en insights de negocio siguiendo el patrón Medallion.

### Flujo de Datos

```
RAW JSON FILES
     ↓
🥉 BRONZE (s3a://bronze/transactions)
  - Datos tal cual llegan
  - Sin validaciones
  - Append-only
  - Incluye duplicados y errores
     ↓
🥈 SILVER (s3a://silver/transactions_clean)
  - Limpieza aplicada
  - Duplicados removidos
  - Nulls manejados
  - Tipos correctos
  - Schema enforcement
     ↓
🥇 GOLD (s3a://gold/transactions_metrics)
  - Agregaciones por país
  - Métricas diarias
  - KPIs de negocio
  - Listo para BI tools
```

---

## 🗂️ Estructura del Ejercicio

```
02-medallion-architecture/
├── README.md (este archivo)
├── hints.md
├── starter/
│   ├── 01_bronze_ingestion.py       # Ingestar a Bronze
│   ├── 02_silver_cleaning.py        # Limpiar para Silver
│   ├── 03_gold_aggregation.py       # Agregar para Gold
│   ├── 04_full_pipeline.py          # Pipeline completo
│   └── requirements.txt
├── solution/
│   ├── 01_bronze_ingestion.py
│   ├── 02_silver_cleaning.py
│   ├── 03_gold_aggregation.py
│   ├── 04_full_pipeline.py
│   └── README.md
└── tests/
    └── test_medallion.py
```

---

## 🚀 Setup

```bash
# 1. Asegúrate de que la infraestructura está corriendo
cd ../../infrastructure
docker-compose up -d

# 2. Ver logs de Spark
docker-compose logs -f spark-master

# 3. Acceder a Jupyter (opcional)
# http://localhost:8888

# 4. UI de Spark para monitorear jobs
# http://localhost:8080 (Spark Master)
# http://localhost:4040 (Spark Application UI, cuando esté corriendo)
```

---

## 📝 Tareas

### Tarea 1: Bronze Layer - Ingestión Cruda

**Archivo**: `starter/01_bronze_ingestion.py`

**Objetivo**: Ingestar datos crudos desde JSON a tabla Delta Bronze.

**Requisitos**:
1. Leer `data/raw/transactions.json` (TODOS los registros)
2. Agregar metadata de ingestión:
   - `ingestion_timestamp` (timestamp de carga)
   - `source_file` (nombre del archivo)
3. NO aplicar limpieza ni validaciones
4. Guardar en `s3a://bronze/transactions` como Delta
5. Particionar por `ingestion_date` (derivado de ingestion_timestamp)

**Características Bronze**:
- ✅ Append-only (nunca sobrescribir)
- ✅ Inmutable (preservar datos tal cual)
- ✅ Full lineage (metadata de origen)
- ✅ Incluir TODOS los datos (incluso errores)

**Expectativas**:
- ~614K registros en Bronze
- Todos los registros originales presentes
- Metadata de ingestión agregada
- Sin pérdida de información

---

### Tarea 2: Silver Layer - Limpieza y Validación

**Archivo**: `starter/02_silver_cleaning.py`

**Objetivo**: Transformar datos Bronze en datos Silver limpios y confiables.

**Requisitos**:
1. Leer tabla Bronze
2. Aplicar limpieza:
   - Remover duplicados basados en `transaction_id`
   - Filtrar registros con `amount` NULL o negativo
   - Filtrar transacciones con `timestamp` NULL
   - Normalizar `status` (lowercase, trimmed)
   - Convertir `currency` a uppercase3. Agregar columna de validación:
   - `is_valid` (boolean)
   - `validation_errors` (array de strings con errores encontrados)
4. Convertir tipos:
   - `amount` → DecimalType(10,2)
   - `timestamp` → TimestampType
5. Guardar en `s3a://silver/transactions_clean`
6. Particionar por `country` y `date` (del timestamp)

**Características Silver**:
- ✅ Deduplicated
- ✅ Validated
- ✅ Strongly typed
- ✅ Quality flags
- ✅ Suitable for analytics

**Expectativas**:
- ~540K registros en Silver (después de filtrar ~12% con issues)
- Sin duplicados
- Sin nulls en campos críticos
- Tipos de datos correctos

---

### Tarea 3: Gold Layer - Agregaciones de Negocio

**Archivo**: `starter/03_gold_aggregation.py`

**Objetivo**: Crear métricas de negocio agregadas para dashboards.

**Requisitos**:
1. Leer tabla Silver
2. Agregar métricas diarias por país:
   ```python
   - date
   - country
   - total_transactions
   - total_amount
   - avg_amount
   - num_completed
   - num_failed
   - num_pending
   - completion_rate (%)
   - unique_users
   - unique_products
   ```
3. Calcular percentiles:
   - `p50_amount` (mediana)
   - `p90_amount`
   - `p99_amount`
4. Guardar en `s3a://gold/transactions_metrics`
5. Particionar por `country`

**Características Gold**:
- ✅ Business-friendly (columnas con nombres claros)
- ✅ Denormalized (todo en una tabla)
- ✅ Pre-aggregated (consultas rápidas)
- ✅ BI-ready (conectar directamente a Tableau, PowerBI, etc.)

**Expectativas**:
- Filas reducidas a ~100-500 (por día-país)
- Queries instantáneas
- Listo para visualización

---

### Tarea 4: Pipeline Completo

**Archivo**: `starter/04_full_pipeline.py`

**Objetivo**: Orquestar el pipeline completo Bronze → Silver → Gold.

**Requisitos**:
1. Ejecutar ingestión Bronze
2. Ejecutar limpieza Silver
3. Ejecutar agregación Gold
4. Implementar checkpoints entre stages
5. Manejar errores y logging
6. Generar reporte de resumen:
   ```
   📊 PIPELINE EXECUTION SUMMARY
   =============================
   Bronze: 614,500 records ingested
   Silver: 540,000 records cleaned (88% valid)
   Gold: 480 metrics generated
   
   Quality Report:
   - Duplicates removed: 74,500 (12%)
   - Invalid amounts: 18,000 (3%)
   - Null timestamps: 5,000 (0.8%)
   
   Execution Time: 124.5s
   Status: ✅ SUCCESS
   ```

**Características Pipeline**:
- ✅ Idempotent (puede ejecutarse múltiples veces)
- ✅ Incremental (procesar solo nuevos datos)
- ✅ Monitored (métricas y logs)
- ✅ Error-tolerant (manejo de fallos)

---

## ✅ Criterios de Éxito

### Bronze Layer
- [ ] ~614K registros en `s3a://bronze/transactions`
- [ ] Metadata de ingestión (`ingestion_timestamp`, `source_file`)
- [ ] Particionado por `ingestion_date`
- [ ] Todos los datos originales preservados

### Silver Layer
- [ ] ~540K registros en `s3a://silver/transactions_clean` (88% del original)
- [ ] Sin duplicados
- [ ] Sin nulls en campos críticos
- [ ] Tipos correctos (DecimalType, TimestampType)
- [ ] Columnas de validación (`is_valid`, `validation_errors`)

### Gold Layer
- [ ] ~300-500 filas en `s3a://gold/transactions_metrics`
- [ ] Métricas agregadas por día-país
- [ ] Percentiles calculados
- [ ] Tasas de conversión/completitud

### Pipeline Completo
- [ ] Ejecuta end-to-end sin errores
- [ ] Genera reporte de resumen
- [ ] Tiempo de ejecución < 3 minutos
- [ ] Logs informativos en cada stage

---

## 🎓 Conceptos Clave

### Medallion Architecture

```
┌─────────────────────────────────────────────────────────────┐
│ 🥉 BRONZE - "Keep Everything"                               │
│                                                              │
│ Purpose: Long-term audit trail, reprocessing capability     │
│ Format: Raw, append-only, immutable                         │
│ Retention: Years (cheap object storage)                     │
│ Quality: As-is, no filtering                                  │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│ 🥈 SILVER - "Clean and Conformed"                           │
│                                                              │
│ Purpose: Trusted source for analytics, ML feature store     │
│ Format: Deduplicated, validated, typed                      │
│ Retention: Months to years                                  │
│ Quality: Enterprise-grade, SLA-backed                       │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│ 🥇 GOLD - "Business-Ready"                                  │
│                                                              │
│ Purpose: Dashboards, reports, KPIs                          │
│ Format: Aggregated, denormalized, optimized                 │
│ Retention: Weeks to months                                  │
│ Quality: Business-validated, domain-specific                │
└─────────────────────────────────────────────────────────────┘
```

### Cuándo Usar Cada Layer

**Bronze**:
- Data sources variadas (APIs, archivos, streams)
- Auditoría y compliance
- Reprocessing después de cambios en lógica
- ML feature engineering sobre datos crudos

**Silver**:
- Analytics ad-hoc
- ML training datasets
- Join entre múltiples sources
- Exploratory data analysis

**Gold**:
- Dashboards de C-level
- Reportes operacionales
- Alertas y monitoring
- Métricas de producto

---

## 📚 Recursos

- [Medallion Architecture - Databricks](https://www.databricks.com/glossary/medallion-architecture)
- [Delta Lake Best Practices](https://docs.delta.io/latest/best-practices.html)
- [PySpark Data Quality](https://spark.apache.org/docs/latest/sql-ref-functions.html)

---

## 🔍 Troubleshooting

### "Table already exists" en Bronze

Bronze es append-only. Usa `.mode("append")` siempre:
```python
df.write.format("delta").mode("append").save(path)
```

### Pipeline muy lento

1. **Aumenta paralelismo**: `.repartition(200)` antes de escribir
2. **Filtra temprano**: Aplica filtros antes de joins
3. **Cachea**: Si reutilizas un DataFrame, usa `.cache()`

### Métricas incorrectas en Gold

Verifica que Silver está correctamente limpio:
```python
silver_df = spark.read.format("delta").load("s3a://silver/transactions_clean")
silver_df.groupBy("is_valid").count().show()  # Debe ser 100% valid
```

---

## 🎯 Próximos Pasos

Una vez completado:
1. ✅ Continuar con **Ejercicio 03: Time Travel**
2. Explorar MERGE para updates incrementales
3. Implementar SCD Type 2 para slowly changing dimensions
4. Agregar Great Expectations para data quality

¡Buena suerte! 🚀
