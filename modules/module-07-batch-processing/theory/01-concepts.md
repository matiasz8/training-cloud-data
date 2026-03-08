# Conceptos de Batch Processing

## 📚 ¿Qué es Batch Processing?

**Batch Processing** es el procesamiento de grandes volúmenes de datos en **lotes discretos**, generalmente en ventanas de tiempo programadas (diaria, semanal, mensual).

### Características Clave

✅ **Alto throughput**: Procesa millones de registros eficientemente  
✅ **Latencia alta**: Minutes a horas entre ejecución  
✅ **Eficiencia de recursos**: Optimizado para costos  
✅ **Procesamiento offline**: No requiere respuesta inmediata  

---

## 🆚 Batch vs Stream Processing

### Batch Processing

```
[1M records] → Process → [Output]
     ↓          (1 hour)      ↓
  Collect                  Results
```

**Características**:
- ⏰ **Latencia**: Alta (horas/días)
- 📊 **Volume**: Muy alto (GB-TB)
- 💰 **Costo**: Bajo (recursos bajo demanda)
- 🔧 **Complejidad**: Baja/Media

**Casos de uso**:
- Reportes diarios/semanales
- Data warehouse loads
- ML training pipelines
- Historical analysis
- ETL jobs nocturnos

### Stream Processing

```
[Event] → Process → [Output]
  ↓       (ms)        ↓
Real-time         Immediate
```

**Características**:
- ⏰ **Latencia**: Baja (ms-segundos)
- 📊 **Volume**: Continuo
- 💰 **Costo**: Alto (24/7)
- 🔧 **Complejidad**: Alta

**Casos de uso**:
- Real-time analytics
- Fraud detection
- IoT processing
- Live dashboards

### Micro-Batch (Híbrido)

```
[100 events] → Process → [Output]
     ↓         (seconds)     ↓
  Every 5s              Results
```

**Balance entre batch y streaming**:
- Latencia media (segundos-minutos)
- Usa infraestructura batch
- Más simple que streaming puro
- Usado por Spark Structured Streaming

---

## 🔄 Patrones de Batch Processing

### 1. Full Load (Carga Completa)

Procesar **todos los datos** cada vez:

```python
# Example: Daily full load
def daily_batch():
    # Read all historical data
    df = read_all_data()  # 100M records
    
    # Process everything
    result = transform(df)
    
    # Replace existing data
    write(result, mode='overwrite')
```

**Pros**:
- ✅ Simple de implementar
- ✅ Siempre consistente
- ✅ No state management

**Cons**:
- ❌ Lento para datasets grandes
- ❌ Desperdicia recursos (reprocesa datos sin cambios)
- ❌ No escalable

**Cuándo usar**:
- Datasets pequeños (< 10M records)
- Data que cambia completamente
- Cuando simplicidad > eficiencia

### 2. Incremental Load (Carga Incremental)

Procesar solo **datos nuevos o modificados**:

```python
# Example: Incremental batch
def incremental_batch():
    # Get last processed timestamp
    last_run = get_watermark()  # 2024-03-06 00:00:00
    
    # Read only new data
    df = read_data_since(last_run)  # 100K new records
    
    # Process only new data
    result = transform(df)
    
    # Append to existing data
    write(result, mode='append')
    
    # Update watermark
    set_watermark(now())
```

**Pros**:
- ✅ Rápido (procesa menos datos)
- ✅ Eficiente en recursos
- ✅ Escalable

**Cons**:
- ❌ Requiere watermark tracking
- ❌ Más complejo
- ❌ Puede perder deletes

**Cuándo usar**:
- Datos con timestamps
- Alto volumen de nuevos registros
- Cuando eficiencia importa

### 3. Change Data Capture (CDC)

Capturar y procesar **cambios** (inserts, updates, deletes):

```python
# Example: CDC batch processing
def cdc_batch():
    # Read change log desde último batch
    changes = read_cdc_log(since=last_run)
    
    for change in changes:
        if change.operation == 'INSERT':
            insert_record(change.new_values)
        elif change.operation == 'UPDATE':
            update_record(change.key, change.new_values)
        elif change.operation == 'DELETE':
            delete_record(change.key)
```

**Pros**:
- ✅ Captura todos los cambios
- ✅ Incluye updates y deletes
- ✅ Mantiene historial

**Cons**:
- ❌ Requiere CDC infrastructure
- ❌ Más complejo de implementar
- ❌ Necesita source system support

**Herramientas CDC**:
- Debezium (Kafka Connect)
- AWS DMS (Database Migration Service)
- Airbyte
- Fivetran

---

## 📊 Particionamiento de Datos

### ¿Por qué Particionar?

1. **Performance**: Leer solo particiones necesarias
2. **Paralelización**: Procesar particiones en paralelo
3. **Mantenibilidad**: Eliminar particiones antiguas fácilmente
4. **Costos**: Reducir data scanned

### Estrategias de Particionamiento

#### 1. Particionamiento por Fecha

```
data/
  ├── year=2024/
  │   ├── month=01/
  │   │   ├── day=01/
  │   │   │   └── data.parquet
  │   │   ├── day=02/
  │   │   └── day=03/
  │   └── month=02/
  └── year=2025/
```

```python
# Write partitioned data
df.write.partitionBy('year', 'month', 'day').parquet('data/')

# Read specific partition
df = spark.read.parquet('data/year=2024/month=03/day=07')
```

**Ventajas**:
- ✅ Natural para time-series data
- ✅ Fácil de entender
- ✅ Eliminar datos antiguos simple

**Consideraciones**:
- ⚠️ Evitar muchas particiones pequeñas
- ⚠️ Balance entre granularidad y overhead

#### 2. Particionamiento por Rango

```python
# Partition por rangos de valores
def range_partition(value):
    if value < 1000:
        return 'small'
    elif value < 10000:
        return 'medium'
    else:
        return 'large'

df['partition'] = df['amount'].apply(range_partition)
```

**Casos de uso**:
- Montos de transacciones
- Edades de usuarios
- Scores de productos

#### 3. Particionamiento por Hash

```python
# Partition por hash para distribución uniforme
df['partition'] = df['user_id'] % 10  # 10 partitions
```

**Ventajas**:
- ✅ Distribución uniforme
- ✅ Evita data skew
- ✅ Bueno para joins

#### 4. Particionamiento por Categoría

```
data/
  ├── country=USA/
  ├── country=UK/
  └── country=Canada/
```

**Casos de uso**:
- Por región geográfica
- Por tipo de cliente
- Por categoría de producto

---

## 🎯 Batch Processing Patterns

### Pattern 1: Batch Window

Procesar datos en ventanas de tiempo específicas:

```python
def process_daily_batch(date):
    """Process one day of data."""
    start = datetime(date.year, date.month, date.day)
    end = start + timedelta(days=1)
    
    df = read_data(start_date=start, end_date=end)
    transformed = transform(df)
    write_output(transformed, date=date)
```

**Uso**: Daily/hourly batch jobs

### Pattern 2: Backfill

Reprocesar datos históricos:

```python
def backfill(start_date, end_date):
    """Reprocess historical data."""
    date = start_date
    while date <= end_date:
        process_daily_batch(date)
        date += timedelta(days=1)
```

**Uso**: Fix bugs, apply new logic to historical data

### Pattern 3: Idempotent Batch

Batch seguro para re-ejecución:

```python
def idempotent_batch(date):
    """Safe to run multiple times."""
    # Delete existing output for this date
    delete_output(date)
    
    # Process and write
    df = read_data(date)
    transformed = transform(df)
    write_output(transformed, date=date)
```

**Garantía**: Múltiples ejecuciones = mismo resultado

### Pattern 4: Checkpoint

Guardar progreso para recovery:

```python
def batch_with_checkpoint():
    checkpoint = load_checkpoint()
    
    for partition in partitions[checkpoint:]:
        process(partition)
        checkpoint += 1
        save_checkpoint(checkpoint)
```

**Uso**: Batch jobs largos que pueden fallar

---

## 💾 Formatos de Archivo para Batch

### CSV

```python
df.to_csv('output.csv', index=False)
```

**Pros**: Simple, human-readable  
**Cons**: Lento, sin tipos, grande  
**Uso**: Pequeños datasets, exports

### JSON

```python
df.to_json('output.json', orient='records', lines=True)
```

**Pros**: Flexible schema, nested data  
**Cons**: Lento, verboso  
**Uso**: APIs, semi-structured data

### Parquet ⭐

```python
df.to_parquet('output.parquet', compression='snappy')
```

**Pros**:
- ✅ Columnar (fast queries)
- ✅ Compressed
- ✅ Schema embedded
- ✅ Predicate pushdown

**Cons**: Requiere librería  
**Uso**: Data lakes, analytics ⭐ RECOMENDADO

### Avro

```python
df.to_avro('output.avro')
```

**Pros**: Schema evolution, compact  
**Cons**: Menos adoption  
**Uso**: Streaming, Kafka

---

## 🔧 Chunking & Memory Management

### Problem: Dataset No Cabe en Memoria

```python
# ❌ Malo: Lee todo en memoria
df = pd.read_csv('huge_file.csv')  # 50GB - OOM!
```

### Solution: Chunking

```python
# ✅ Bueno: Procesa en chunks
chunk_size = 100000

for chunk in pd.read_csv('huge_file.csv', chunksize=chunk_size):
    # Procesa chunk (100K records cada vez)
    processed = transform(chunk)
    write_output(processed, mode='append')
```

### Memory-Efficient Operations

```python
# Usar dtypes específicos
dtypes = {
    'user_id': 'int32',  # en lugar de int64
    'amount': 'float32',  # en lugar de float64
    'status': 'category'  # en lugar de object
}

df = pd.read_csv('file.csv', dtype=dtypes)
```

---

## 📈 Best Practices

### 1. Particiona Inteligentemente

```python
# ✅ Bueno: Particiones balanceadas
df.write.partitionBy('year', 'month').parquet('data/')

# ❌ Malo: Demasiadas particiones pequeñas
df.write.partitionBy('year', 'month', 'day', 'hour').parquet('data/')
```

**Regla**: 100MB - 1GB por partition file

### 2. Usa Formatos Columnar

```python
# ✅ Parquet para analytics
df.to_parquet('data.parquet', compression='snappy')

# ❌ CSV para grandes volúmenes
df.to_csv('data.csv')  # Lento y grande
```

### 3. Procesa Incrementalmente

```python
# ✅ Solo datos nuevos
df = read_data_since(last_run)

# ❌ Reprocessa todo
df = read_all_data()
```

### 4. Implementa Idempotencia

```python
# ✅ Safe para re-runs
write(data, mode='overwrite', partition_key=date)

# ❌ Crea duplicados
write(data, mode='append')
```

### 5. Monitorea Performance

```python
import time

start = time.time()
result = process_batch(df)
duration = time.time() - start

logger.info(f"Batch completed in {duration:.2f}s")
logger.info(f"Records processed: {len(result)}")
logger.info(f"Throughput: {len(result)/duration:.2f} records/sec")
```

---

Continúa con [02-architecture.md](./02-architecture.md) para arquitecturas batch en la nube.
