# Optimization Checklist

## ✅ Checklist de Optimización Delta Lake

### 1. File Size Optimization

- [ ] **Problema**: Demasiados archivos pequeños (<128MB)
  - **Síntoma**: Queries lentos, alto overhead
  - **Solución**: `OPTIMIZE` para compactar
  ```python
  delta_table.optimize().executeCompaction()
  ```

- [ ] **Problema**: Archivos muy grandes (>1GB)
  - **Síntoma**: Lentitud en operaciones paralelas
  - **Solución**: Repartition antes de escribir
  ```python
  df.repartition(100).write.format("delta").save(path)
  ```

### 2. Partitioning Strategy

- [ ] **Verificar**: ¿Cardinalidad media? (100-10,000 valores únicos)
  - ✅ Bueno: country, date, category
  - ❌ Malo: user_id (millones), is_active (2 valores)

- [ ] **Partition Pruning**: Asegurar que queries filtren por partición
  ```python
  # ✅ Bueno: Usa partición
  df.filter("date = '2024-01-15' AND country = 'USA'")
  
  # ❌ Malo: No usa partición
  df.filter("amount > 1000")
  ```

- [ ] **Evitar**: > 10,000 particiones por tabla

### 3. Z-Ordering (Data Skipping)

- [ ] **Aplicar a**: Columnas de filtros frecuentes (no particiones)
  ```python
  delta_table.optimize().executeZOrderBy("user_id", "product_id")
  ```

- [ ] **No aplicar a**: 
  - Columnas de alta cardinalidad (>100M valores)
  - Columnas que nunca se filtran

- [ ] **Reejecución**: Cada N días o después de writes masivos

### 4. Data Skipping

- [ ] **Habilitar**: Statistics collection (habilitado por default)
- [ ] **Verificar**: Stats en _delta_log
  ```python
  delta_table.detail().select("numFiles", "sizeInBytes", "numRecords").show()
  ```

### 5. Vacuum

- [ ] **Antes de VACUUM**: Confirmar retention apropiado
  ```python
  # Retener 7 días (168 horas)
  delta_table.vacuum(168)
  ```

- [ ] **Considerar**: Time Travel necesario
  - ⚠️ VACUUM elimina versiones antiguas

### 6. Caching

- [ ] **Para tablas pequeñas**: Cache en memoria
  ```python
  df.cache()
  df.count()  # Materialize cache
  ```

- [ ] **Desalojar cache**: Después de uso
  ```python
  df.unpersist()
  ```

### 7. Schema Optimization

- [ ] **Usar tipos precisos**:
  - DecimalType en lugar de Double para dinero
  - DateType en lugar de StringType para fechas
  - IntegerType en lugar de LongType cuando sea suficiente

- [ ] **Normalizar**: Columnas con muchos nulls en tablas separadas

### 8. Write Optimization

- [ ] **Batch size**: 10,000-100,000 registros por write ideal
- [ ] **Auto Optimize** (Databricks):
  ```sql
  ALTER TABLE events SET TBLPROPERTIES (
    delta.autoOptimize.optimizeWrite = true,
    delta.autoOptimize.autoCompact = true
  )
  ```

### 9. Query Optimization

- [ ] **Pushdown filters**: Filtrar antes de joins
- [ ] **Select specific columns**: Evitar `SELECT *`
- [ ] **Broadcast small tables**: Para joins
  ```python
  from pyspark.sql.functions import broadcast
  large_df.join(broadcast(small_df), "id")
  ```

### 10. Monitoring

- [ ] **Metrics a trackear**:
  - Query execution time
  - Data skipping ratio
  - Number of files per table
  - Average file size
  - Partition count

  ```python
  # Ver estadísticas
  delta_table.detail().select(
      "numFiles", 
      "sizeInBytes", 
      "numRecords"
  ).show()
  
  # Ver historial de optimization
  delta_table.history().filter("operation = 'OPTIMIZE'").show()
  ```

## 🎯 Performance Targets

| Métrica | Target |
|---------|--------|
| File size promedio | 128MB - 512MB |
| Particiones | 100 - 5,000 |
| Files por partition | < 100 |
| Query latency (simple) | < 5s |
| Query latency (complex) | < 30s |
| Data skipping % | > 80% |

## 🔍 Troubleshooting

### Query lento?
1. Check si usa partition pruning
2. Check number of files (ejecutar OPTIMIZE?)
3. Check si Z-ORDER ayudaría
4. Check execution plan con `.explain()`

### Writes lentos?
1. Check batch size (muy pequeño?)
2. Check número de partitions de write
3. Check si hay Z-ORDER automático activo
4. Consider disabling merge schema si no necesario

### Storage creciendo rápido?
1. Ejecutar VACUUM
2. Check retention policy
3. Check si hay duplicate data
4. Consider archiving old partitions
