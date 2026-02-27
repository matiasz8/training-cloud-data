# 💡 Hints - Ejercicio 01: Delta Basics

Este archivo contiene pistas progresivas para ayudarte a completar el ejercicio. **Intenta resolver cada tarea sin mirar las pistas primero**. Si te atascas, revela las pistas gradualmente.

---

## 🎯 Tarea 1: Crear Tabla Delta

### Hint 1: Configurar SparkSession con Delta

<details>
<summary>Click para revelar Hint 1</summary>

Para configurar Spark con Delta Lake, necesitas:
```python
from delta import configure_spark_with_delta_pip

builder = SparkSession.builder \
    .appName("Mi App") \
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")

spark = configure_spark_with_delta_pip(builder).getOrCreate()
```
</details>

### Hint 2: Leer JSON con límite

<details>
<summary>Click para revelar Hint 2</summary>

Para leer solo las primeras 10,000 filas:
```python
df = spark.read.json("path/to/file.json").limit(10000)
```
</details>

### Hint 3: Convertir timestamp

<details>
<summary>Click para revelar Hint 3</summary>

El campo timestamp viene como string. Conviértelo:
```python
from pyspark.sql.functions import to_timestamp

df = df.withColumn("timestamp", to_timestamp(col("timestamp")))
```

O si usas formato específico:
```python
df = df.withColumn("timestamp", to_timestamp(col("timestamp"), "yyyy-MM-dd HH:mm:ss"))
```
</details>

### Hint 4: Agregar fecha de ingestión

<details>
<summary>Click para revelar Hint 4</summary>

Usa `current_date()` para agregar la fecha actual:
```python
from pyspark.sql.functions import current_date

df = df.withColumn("ingestion_date", current_date())
```
</details>

### Hint 5: Guardar como Delta particionado

<details>
<summary>Click para revelar Hint 5</summary>

Para guardar como Delta con particionamiento:
```python
df.write \
    .format("delta") \
    .mode("overwrite") \
    .partitionBy("country") \
    .save("s3a://bronze/transactions_delta")
```

Asegúrate de usar:
- `.format("delta")` - especifica formato Delta
- `.mode("overwrite")` - sobrescribe si existe (primera vez)
- `.partitionBy("country")` - crea particiones por país
- `.save()` - guarda en la ruta especificada
</details>

---

## 🎯 Tarea 2: Append Data

### Hint 1: Leer filas específicas

<details>
<summary>Click para revelar Hint 1</summary>

Puedes leer las siguientes 5,000 filas de dos formas:

**Opción A - Usando SQL con OFFSET**:
```python
df_all = spark.read.json("path/to/file.json")
df_all.createOrReplaceTempView("all_tx")
df_new = spark.sql("SELECT * FROM all_tx LIMIT 5000 OFFSET 10000")
```

**Opción B - Usando window function**:
```python
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number

df_all = spark.read.json("path/to/file.json")
window = Window.orderBy("transaction_id")
df_numbered = df_all.withColumn("row_num", row_number().over(window))
df_new = df_numbered.filter((col("row_num") > 10000) & (col("row_num") <= 15000)) \
    .drop("row_num")
```

**Opción C - Simple (para este caso)**:
```python
df_all = spark.read.json("path/to/file.json")
df_new = df_all.limit(15000).subtract(df_all.limit(10000))
```
</details>

### Hint 2: Modo append

<details>
<summary>Click para revelar Hint 2</summary>

Para agregar datos sin sobrescribir:
```python
df.write \
    .format("delta") \
    .mode("append") \
    .partitionBy("country") \
    .save("s3a://bronze/transactions_delta")
```

**Importante**: El esquema y particionamiento deben coincidir con la tabla existente.
</details>

---

## 🎯 Tarea 3: Overwrite Partition

### Hint 1: Modificar campo condicionalmente

<details>
<summary>Click para revelar Hint 1</summary>

Para cambiar valores condicionalmente, usa `when()`:
```python
from pyspark.sql.functions import when

df_modified = df.withColumn(
    "status",
    when(col("status") == "pending", "expired")
    .otherwise(col("status"))
)
```
</details>

### Hint 2: replaceWhere option

<details>
<summary>Click para revelar Hint 2</summary>

Para sobrescribir solo una partición específica:
```python
df.write \
    .format("delta") \
    .mode("overwrite") \
    .option("replaceWhere", "country = 'USA'") \
    .save("s3a://bronze/transactions_delta")
```

**Clave**: `replaceWhere` indica qué particiones sobrescribir. Esto es MUY diferente a `.mode("overwrite")` solo, que sobrescribiría TODA la tabla.
</details>

### Hint 3: Verificar cambios

<details>
<summary>Click para revelar Hint 3</summary>

Para verificar que solo USA cambió:
```python
# Antes
df_before = spark.read.format("delta").load(path)
count_before_usa = df_before.filter(col("country") == "USA").count()
pending_before_usa = df_before.filter(
    (col("country") == "USA") & (col("status") == "pending")
).count()

# ... tu código de overwrite ...

# Después
df_after = spark.read.format("delta").load(path)
pending_after_usa = df_after.filter(
    (col("country") == "USA") & (col("status") == "pending")
).count()

# pending_after_usa debe ser 0
# Pero otros países deben tener pending intacto
```
</details>

---

## 🎯 Tarea 4: SQL Queries

### Hint 1: Registrar tabla temporal

<details>
<summary>Click para revelar Hint 1</summary>

Para poder usar SQL, registra la tabla:
```python
df = spark.read.format("delta").load("s3a://bronze/transactions_delta")
df.createOrReplaceTempView("transactions_delta")

# Ahora puedes usar SQL
result = spark.sql("SELECT * FROM transactions_delta LIMIT 10")
```
</details>

### Hint 2: Query 1 - Contar por país

<details>
<summary>Click para revelar Hint 2</summary>

```sql
SELECT 
    country, 
    COUNT(*) as total_transactions
FROM transactions_delta
GROUP BY country
ORDER BY total_transactions DESC
```
</details>

### Hint 3: Query 2 - Métricas por status

<details>
<summary>Click para revelar Hint 3</summary>

```sql
SELECT 
    status,
    COUNT(*) as count,
    ROUND(AVG(amount), 2) as avg_amount,
    ROUND(SUM(amount), 2) as total_amount,
    MIN(amount) as min_amount,
    MAX(amount) as max_amount
FROM transactions_delta
GROUP BY status
ORDER BY total_amount DESC
```
</details>

### Hint 4: Query 3 - Top 10 transacciones

<details>
<summary>Click para revelar Hint 4</summary>

```sql
SELECT 
    transaction_id,
    user_id,
    amount,
    currency,
    country,
    status
FROM transactions_delta
ORDER BY amount DESC
LIMIT 10
```
</details>

### Hint 5: Query 4 - Transacciones por mes

<details>
<summary>Click para revelar Hint 5</summary>

```sql
SELECT 
    DATE_TRUNC('month', timestamp) as month,
    COUNT(*) as num_transactions,
    ROUND(SUM(amount), 2) as total_amount,
    ROUND(AVG(amount), 2) as avg_amount
FROM transactions_delta
GROUP BY DATE_TRUNC('month', timestamp)
ORDER BY month DESC
```

**Alternativa** si DATE_TRUNC no funciona:
```sql
SELECT 
    YEAR(timestamp) as year,
    MONTH(timestamp) as month,
    COUNT(*) as num_transactions,
    ROUND(SUM(amount), 2) as total_amount
FROM transactions_delta
GROUP BY YEAR(timestamp), MONTH(timestamp)
ORDER BY year DESC, month DESC
```
</details>

---

## 🔧 Troubleshooting Común

### Error: "Table not found"

<details>
<summary>Solución</summary>

1. Verifica que MinIO está corriendo:
   ```bash
   docker ps | grep minio
   ```

2. Verifica la ruta:
   ```python
   # Debe ser s3a:// (no s3://)
   path = "s3a://bronze/transactions_delta"
   ```

3. Verifica configuración S3 en spark-defaults.conf
</details>

### Error: "AnalysisException: Path does not exist"

<details>
<summary>Solución</summary>

El archivo de datos no se encuentra. Verifica:
```python
# Ruta relativa correcta desde el ejercicio
path = "../../../data/raw/transactions.json"

# O ruta absoluta
path = "/opt/spark/work-dir/data/raw/transactions.json"
```
</details>

### Error: "Partitioning column not found"

<details>
<summary>Solución</summary>

Asegúrate de que la columna `country` existe en el DataFrame antes de particionar:
```python
# Verifica columnas
print(df.columns)

# Verifica que 'country' está presente
assert 'country' in df.columns, "Falta columna country"
```
</details>

### Queries muy lentas

<details>
<summary>Solución</summary>

1. **Usa filtros en columnas particionadas** (country) para aprovechar partition pruning
2. **Cachea** si vas a consultar múltiples veces:
   ```python
   df.cache()
   ```
3. **Aumenta recursos** en docker-compose.yml (más cores/memoria)
</details>

---

## 📚 Referencias

- [Delta Lake Python API](https://docs.delta.io/latest/api/python/index.html)
- [PySpark SQL Functions](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html)
- [Delta Lake Best Practices](https://docs.delta.io/latest/best-practices.html)

---

**¿Sigues atascado?** Revisa la carpeta `solution/` para ver la implementación completa. ¡Pero intenta resolver sin mirar primero!
