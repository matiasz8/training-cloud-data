# ✅ Solución - Ejercicio 01: Delta Basics

Esta carpeta contiene las soluciones completas para el Ejercicio 01.

## 📁 Archivos

- `01_create_table.py` - Crear tabla Delta particionada
- `02_append_data.py` - Agregar datos con modo append
- `03_overwrite_partition.py` - Sobrescribir partición específica
- `04_query_table.py` - Consultas SQL sobre tabla Delta

## 🚀 Cómo Ejecutar

### Opción 1: Desde Jupyter

1. Abre Jupyter Lab: http://localhost:8888
2. Navega a `exercises/01-delta-basics/solution/`
3. Abre cada archivo `.py`
4. Ejecuta el código

### Opción 2: Desde Terminal del Contenedor

```bash
# Acceder al contenedor de Spark
docker exec -it module-05-spark-master bash

# Navegar al directorio
cd /opt/spark/work-dir/exercises/01-delta-basics/solution

# Ejecutar scripts en orden
spark-submit --master local[2] 01_create_table.py
spark-submit --master local[2] 02_append_data.py
spark-submit --master local[2] 03_overwrite_partition.py
spark-submit --master local[2] 04_query_table.py
```

### Opción 3: Todo en Secuencia

```bash
docker exec -it module-05-spark-master bash -c "
  cd /opt/spark/work-dir/exercises/01-delta-basics/solution && \
  for script in 01_*.py 02_*.py 03_*.py 04_*.py; do
    echo '======================================' && \
    echo \"Ejecutando \$script\" && \
    echo '======================================' && \
    spark-submit --master local[2] \$script && \
    echo
  done
"
```

## 📚 Conceptos Clave Implementados

### Script 01: Create Table

**Conceptos**:
- Configuración Delta Lake con Spark
- Lectura de JSON con PySpark
- Transformaciones básicas (to_timestamp, currentdate)
- Escritura Delta con particionamiento

**Código clave**:
```python
df.write \
    .format("delta") \
    .mode("overwrite") \
    .partitionBy("country") \
    .save("s3a://bronze/transactions_delta")
```

### Script 02: Append Data

**Conceptos**:
- Modo append vs overwrite
- Window functions para selección de filas
- Escritura incremental
- Verificación de historial con DeltaTable

**Código clave**:
```python
df.write \
    .format("delta") \
    .mode("append") \
    .save("s3a://bronze/transactions_delta")
```

### Script 03: Overwrite Partition

**Conceptos**:
- replaceWhere para sobrescritura selectiva
- Transformaciones condicionales con when()
- Verificación de integridad de datos
- Partition pruning

**Código clave**:
```python
df.write \
    .format("delta") \
    .mode("overwrite") \
    .option("replaceWhere", "country = 'USA'") \
    .save(path)
```

### Script 04: Query Table

**Conceptos**:
- Registro de tablas Delta como SQL tables
- Spark SQL queries (GROUP BY, agregaciones, window functions)
- Análisis de performance con partitioning
- DESCRIBE y metadata

**Código clave**:
```python
df.createOrReplaceTempView("transactions_delta")
result = spark.sql("SELECT country, COUNT(*) FROM transactions_delta GROUP BY country")
```

## 🎯 Resultados Esperados

### Después de ejecutar todos los scripts:

1. **Tabla Delta creada** en `s3a://bronze/transactions_delta`
   - 15,000 registros totales
   - Particionada por país
   - 3+ versiones en transaction log

2. **Estructura de archivos**:
   ```
   bronze/transactions_delta/
   ├── _delta_log/
   │   ├── 00000000000000000000.json  (create)
   │   ├── 00000000000000000001.json  (append)
   │   └── 00000000000000000002.json  (overwrite)
   ├── country=USA/
   │   └── part-*.parquet
   ├── country=GBR/
   │   └── part-*.parquet
   └── ...
   ```

3. **Verificaciones exitosas**:
   - Total de registros: 15,000
   - Países con particiones: 10-20
   - Status "pending" en USA: 0 (todos cambiados a "expired")
   - Otros países: intactos

## 🔍 Verificación Manual

Puedes verificar los resultados manualmente con:

```python
from pyspark.sql import SparkSession
from delta import configure_spark_with_delta_pip
from delta.tables import DeltaTable

builder = SparkSession.builder.appName("Verify")
spark = configure_spark_with_delta_pip(builder).getOrCreate()

# Leer tabla
df = spark.read.format("delta").load("s3a://bronze/transactions_delta")

# Verificaciones
print(f"Total: {df.count()}")
print(f"Countries: {df.select('country').distinct().count()}")

# Historial
delta_table = DeltaTable.forPath(spark, "s3a://bronze/transactions_delta")
delta_table.history().show(truncate=False)
```

## 📊 Métricas de Performance

Con los datos de este ejercicio (15K registros), deberías ver:

- **Query con partition pruning** (country='USA'): ~0.5-1s
- **Query sin partition pruning** (status='completed'): ~1-2s
- **Speedup**: ~2x más rápido con partitioning

En producción con millones de registros, el speedup puede ser **10-100x**.

## 🎓 Lo que Aprendiste

✅ Crear y configurar tablas Delta Lake  
✅ Operaciones ACID (append, overwrite)  
✅ Particionamiento para performance  
✅ replaceWhere para updates selectivos  
✅ Spark SQL sobre tablas Delta  
✅ Transaction log y versionado  
✅ Window functions y análisis avanzado  

## 🚀 Próximos Pasos

¡Felicitaciones! Has completado el primer ejercicio.

Ahora puedes:
1. Experimentar con tus propias queries
2. Probar diferentes tamaños de particiones
3. Continuar con **Ejercicio 02: Medallion Architecture**
4. Explorar Time Travel (próximo ejercicio)

---

**¿Preguntas?** Revisa el [README principal](../README.md) o consulta los [hints](../hints.md).
