# Medallion Architecture

## 📊 Diagrama

```
┌─────────────────────────────────────────────────────────────┐
│                     DATA SOURCES                            │
│   JSON Files │ APIs │ Databases │ Streams │ CSV Files      │
└──────┬──────────────────────────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│                    BRONZE LAYER                             │
│              (Raw, Append-Only, No Quality)                 │
│                                                             │
│  • Ingesta raw sin transformación                           │
│  • Append-only (nunca delete/update)                        │
│  • Metadata: ingestion_timestamp, source_file               │
│  • Partition: ingestion_date                                │
│  • Formato: Delta Lake                                      │
│                                                             │
│  Path: s3a://bronze/transactions_raw                        │
└──────┬──────────────────────────────────────────────────────┘
       │
       │ Transformations:
       │ • Deduplicación
       │ • Validaciones
       │ • Normalización
       │ • Type casting
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│                    SILVER LAYER                             │
│         (Cleaned, Validated, Business-Ready)                │
│                                                             │
│  • Deduplicado por clave primaria                           │
│  • Validado (no nulls, no negativos)                        │
│  • Normalizado (mayúsculas, formatos)                       │
│  • Tipos correctos (Decimal, Date, Timestamp)               │
│  • Columnas derivadas (date, is_valid)                      │
│  • Partition: country, date                                 │
│                                                             │
│  Path: s3a://silver/transactions_clean                      │
└──────┬──────────────────────────────────────────────────────┘
       │
       │ Aggregations:
       │ • Group by dimensions
       │ • Cálculos de métricas
       │ • KPIs de negocio
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│                     GOLD LAYER                              │
│           (Aggregated, Business Metrics, BI-Ready)          │
│                                                             │
│  • Agregaciones por date, country                           │
│  • Métricas: total_transactions, total_amount               │
│  • KPIs: avg_amount, completion_rate                        │
│  • Percentiles: p50, p90, p99                               │
│  • Dimensiones de negocio                                   │
│  • Optimizado para BI tools                                 │
│                                                             │
│  Path: s3a://gold/transactions_aggregated                   │
└──────┬──────────────────────────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│                   CONSUMPTION                               │
│   Tableau │ Power BI │ Jupyter │ Dashboards │ ML Models    │
└─────────────────────────────────────────────────────────────┘
```

## 🎯 Características de Cada Layer

### Bronze (Raw Zone)

| Aspecto | Característica |
|---------|---------------|
| **Propósito** | Preservar datos originales |
| **Calidad** | Sin validación |
| **Operaciones** | Solo append |
| **Schema** | Schema original + metadata |
| **Retention** | Largo plazo (años) |
| **Usuarios** | Data Engineers |

### Silver (Curated Zone)

| Aspecto | Característica |
|---------|---------------|
| **Propósito** | Datos limpios y validados |
| **Calidad** | Validaciones aplicadas |
| **Operaciones** | Append + Updates (por dedup) |
| **Schema** | Normalizado y tipado |
| **Retention** | Medio plazo (meses) |
| **Usuarios** | Data Engineers + Analysts |

### Gold (Business Zone)

| Aspecto | Característica |
|---------|---------------|
| **Propósito** | Métricas de negocio |
| **Calidad** | Agregaciones precisas |
| **Operaciones** | Overwrite diario/horario |
| **Schema** | Dimensiones + Métricas |
| **Retention** | Corto plazo (semanas) |
| **Usuarios** | Business Analysts + BI Tools |

## 💡 Best Practices

1. **Bronze**: Nunca borres datos, usa Time Travel si necesitas auditoría
2. **Silver**: Aplica validaciones estrictas, documenta reglas de negocio
3. **Gold**: Optimiza con OPTIMIZE y Z-ORDER para queries rápidos
4. **Partitions**: Bronze por ingestion_date, Silver por business dimensions
5. **Idempotencia**: Diseña pipelines que puedan re-ejecutarse sin duplicados

## 🔄 Pipeline Incremental

```python
# Bronze: Incremental append
new_data.write.format("delta").mode("append").save(bronze_path)

# Silver: Merge para deduplicar
from delta.tables import DeltaTable
silver_table = DeltaTable.forPath(spark, silver_path)
silver_table.alias("target").merge(
    new_data_clean.alias("source"),
    "target.transaction_id = source.transaction_id"
).whenNotMatchedInsertAll().execute()

# Gold: Overwrite diario
aggregated_data.write.format("delta") \
    .mode("overwrite") \
    .option("replaceWhere", "date = '2024-01-15'") \
    .save(gold_path)
```

## 📈 Métricas Clave

- **Bronze → Silver**: Data Quality Rate (% registros válidos)
- **Silver → Gold**: Transformation Time (latencia)
- **Gold**: Query Performance (tiempo promedio de BI queries)
