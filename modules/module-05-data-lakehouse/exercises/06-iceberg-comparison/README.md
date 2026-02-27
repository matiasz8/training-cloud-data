# Ejercicio 06: Apache Iceberg Comparison

## 🎯 Objetivo
Comparar Delta Lake vs Apache Iceberg con ejemplos prácticos.

**Dificultad**: ⭐⭐⭐⭐ Avanzado | **Tiempo**: 45 minutos

## 📋 Tareas

1. Crear misma tabla en Delta y Iceberg
2. Comparar operaciones: append, update, time travel
3. Comparar performance
4. Comparar metadata storage

## ✅ Comandos Iceberg

```python
# Write Iceberg
df.writeTo("catalog.db.table").using("iceberg").create()

# Read Iceberg
spark.read.format("iceberg").load("catalog.db.table")

# Time Travel Iceberg
spark.read.format("iceberg") \
    .option("snapshot-id", snapshot_id) \
    .load("catalog.db.table")
```

## 🎓 Comparación

| Feature | Delta Lake | Apache Iceberg |
|---------|-----------|----------------|
| ACID | ✅ | ✅ |
| Time Travel | ✅ versionAsOf | ✅ snapshot-id |
| Schema Evolution | ✅ mergeSchema | ✅ schema evolution |
| Z-Ordering | ✅ OPTIMIZE | ❌ (usa sorting) |
| Partition Evolution | ⚠️ limitado | ✅ hidden partitioning |
| Ecosystem| Databricks, Spark | Spark, Trino, Presto, Flink |
| Metadata | Transaction log (_delta_log) | Metadata JSON |

## 💡 Cuándo Usar Cada Uno

**Delta Lake**:
- Ecosystem Databricks
- Optimize write habilitado
- Z-Ordering crítico
- Integración Spark/Python fuerte

**Apache Iceberg**:
- Multi-engine (Trino, Presto, Flink)
- Partition evolution frecuente  
- Open governance (Apache Foundation)
- Análisis cross-platform
