# Conceptos Fundamentales de ETL

## 📚 ¿Qué es ETL?

**ETL** significa **Extract, Transform, Load** - el proceso fundamental en ingeniería de datos para mover y transformar datos entre sistemas.

### Las Tres Fases

#### 1. Extract (Extracción)
Extraer datos desde fuentes origen:
- **Bases de datos**: PostgreSQL, MySQL, Oracle
- **Archivos**: CSV, JSON, Excel, Parquet
- **APIs**: REST, GraphQL, SOAP
- **Logs**: Application logs, system logs
- **Streaming**: Kafka, Kinesis, Pub/Sub
- **Web scraping**: HTML parsing

#### 2. Transform (Transformación)
Procesar y limpiar datos:
- **Limpieza**: Eliminar nulls, duplicados, outliers
- **Validación**: Schema validation, data types
- **Enriquecimiento**: Joins, lookups, APIs externas
- **Agregación**: Group by, pivots, rollups
- **Normalización**: Formato consistente
- **Derivación**: Calcular nuevos campos

#### 3. Load (Carga)
Escribir datos a destino:
- **Data Warehouse**: Snowflake, Redshift, BigQuery
- **Data Lake**: S3, ADLS, GCS
- **Databases**: PostgreSQL, MongoDB
- **Cache**: Redis, Memcached
- **Search**: Elasticsearch, Solr
- **BI Tools**: Tableau, PowerBI

---

## 🆚 ETL vs ELT

### ETL (Extract-Transform-Load)

**Transformación ANTES de cargar**

```
Source → Extract → Transform → Load → Warehouse
```

**Ventajas**:
- ✅ Datos ya limpios en warehouse
- ✅ Menos carga en warehouse
- ✅ Schema validado anticipadamente
- ✅ Compliance y seguridad más fácil

**Desventajas**:
- ❌ Requiere servidor ETL potente
- ❌ Schema rígido
- ❌ Transformaciones complejas lentas

**Casos de uso**:
- Data Warehouses tradicionales (Oracle, SQL Server)
- Datos estructurados y schema fijo
- Transformaciones complejas
- Legacy systems

### ELT (Extract-Load-Transform)

**Transformación DESPUÉS de cargar**

```
Source → Extract → Load → Data Lake → Transform
```

**Ventajas**:
- ✅ Carga rápida (raw data)
- ✅ Schema flexible (schema-on-read)
- ✅ Aprovecha poder del warehouse moderno
- ✅ Datos raw disponibles para análisis

**Desventajas**:
- ❌ Requiere warehouse potente
- ❌ Costos de storage más altos
- ❌ Datos raw pueden tener calidad baja

**Casos de uso**:
- Cloud Data Warehouses (Snowflake, BigQuery)
- Data Lakes (S3, Azure Data Lake)
- Big Data y datos no estructurados
- Análisis exploratorio

---

## 🔄 Batch vs Streaming ETL

### Batch ETL

**Procesa datos en lotes periódicos**

```python
# Ejemplo: ETL diario
while True:
    data = extract_yesterday_data()  # 1 día de datos
    transformed = transform(data)
    load(transformed)
    time.sleep(86400)  # Esperar 24 horas
```

**Características**:
- ⏰ **Latencia**: Alta (horas/días)
- 📊 **Throughput**: Alto (procesa mucho a la vez)
- 💰 **Costo**: Menor (recursos bajo demanda)
- 🔧 **Complejidad**: Baja

**Casos de uso**:
- Reportes diarios/semanales
- Data warehouse nightly loads
- Historical analysis
- Machine learning training

### Streaming ETL

**Procesa datos en tiempo real**

```python
# Ejemplo: ETL en tiempo real
def process_event(event):
    transformed = transform(event)
    load(transformed)

consumer.subscribe('events')
for event in consumer:
    process_event(event)  # Procesa cada evento
```

**Características**:
- ⏰ **Latencia**: Baja (segundos/milisegundos)
- 📊 **Throughput**: Variable
- 💰 **Costo**: Mayor (recursos 24/7)
- 🔧 **Complejidad**: Alta

**Casos de uso**:
- Real-time dashboards
- Fraud detection
- IoT data processing
- Live recommendations

### Mini-Batch (Micro-Batch)

**Híbrido: Lotes pequeños frecuentes**

```python
# Ejemplo: Procesar cada 5 minutos
while True:
    data = extract_last_5_minutes()
    transformed = transform(data)
    load(transformed)
    time.sleep(300)  # 5 minutos
```

**Características**:
- ⏰ **Latencia**: Media (minutos)
- 📊 **Throughput**: Alto
- 💰 **Costo**: Medio
- 🔧 **Complejidad**: Media

**Casos de uso**:
- Near real-time dashboards
- Data lake ingestion
- Spark Structured Streaming
- Balance entre batch y streaming

---

## 🎯 Tipos de Cargas

### Full Load (Carga Completa)

Cargar **todos los datos** cada vez:

```python
# Full load
df = extract_all_data()  # TODO
load(df, mode='replace')  # Reemplaza todo
```

**Ventajas**:
- ✅ Simple de implementar
- ✅ Siempre consistente
- ✅ No requiere tracking

**Desventajas**:
- ❌ Lento para tablas grandes
- ❌ Alto uso de recursos
- ❌ No escalable

**Cuándo usar**:
- Tablas pequeñas (< 1M rows)
- Datos que cambian completamente
- Dimension tables estáticas

### Incremental Load (Carga Incremental)

Cargar solo **datos nuevos o modificados**:

```python
# Incremental load
last_run = get_last_watermark()  # 2024-03-06
df = extract_data_since(last_run)  # Solo nuevos
load(df, mode='append')
update_watermark(now())
```

**Ventajas**:
- ✅ Rápido
- ✅ Eficiente en recursos
- ✅ Escalable

**Desventajas**:
- ❌ Más complejo
- ❌ Requiere watermark/timestamp
- ❌ Puede perder deletes

**Cuándo usar**:
- Tablas grandes
- Alto volumen de inserts
- Event logs, transacciones

### Change Data Capture (CDC)

Capturar **cambios** (inserts, updates, deletes):

```python
# CDC
changes = extract_changes()  # Log de cambios
for change in changes:
    if change.type == 'INSERT':
        insert(change.data)
    elif change.type == 'UPDATE':
        update(change.data)
    elif change.type == 'DELETE':
        delete(change.key)
```

**Ventajas**:
- ✅ Captura todos los cambios
- ✅ Incluye deletes
- ✅ Near real-time
- ✅ Bajo impacto en source

**Desventajas**:
- ❌ Requiere soporte CDC en source
- ❌ Complejo de implementar
- ❌ Requiere infraestructura adicional

**Herramientas CDC**:
- Debezium (open source)
- AWS DMS
- Fivetran
- Airbyte

---

## 🔑 Conceptos Clave

### Idempotencia

Un proceso es **idempotente** si ejecutarlo múltiples veces produce el mismo resultado:

```python
# ❌ NO idempotente
df.to_sql('table', con, if_exists='append')
# Segunda ejecución → duplicados

# ✅ Idempotente
df.to_sql('table', con, if_exists='replace')
# Segunda ejecución → mismo resultado
```

**Por qué es importante**:
- Permite re-runs sin side effects
- Facilita recovery de errores
- Simplifica debugging

**Cómo lograr idempotencia**:
- Usar `replace` en lugar de `append`
- Implementar UPSERT (update or insert)
- Usar transaction IDs únicos
- Limpiar staging antes de cargar

### Data Lineage (Linaje de Datos)

**Tracking de origen y transformaciones** de los datos:

```
Source DB → Extract → Transform (join) → Load → Warehouse
   ↓           ↓            ↓               ↓         ↓
 Table A    Raw CSV    Enriched CSV     Staging   Final Table
```

**Por qué es importante**:
- 🔍 Debugging: Rastrear errores a origen
- 📊 Impact analysis: Qué afecta un cambio
- 🔒 Compliance: Auditoría de datos
- 📈 Optimization: Identificar cuellos de botella

**Herramientas**:
- Apache Atlas
- Amundsen
- DataHub
- dbt docs

### Schema Evolution

**Cambios en estructura de datos** sin romper pipelines:

```python
# Schema V1
{'id': int, 'name': str, 'email': str}

# Schema V2 (nuevo campo)
{'id': int, 'name': str, 'email': str, 'phone': str}

# Pipeline debe manejar ambos
df['phone'] = df.get('phone', None)  # Default si no existe
```

**Tipos de cambios**:
- ✅ **Additive**: Agregar columnas (safe)
- ⚠️ **Modification**: Cambiar tipos (risky)
- ❌ **Removal**: Eliminar columnas (breaking)

**Best practices**:
- Siempre agregar, nunca remover
- Usar valores por defecto
- Versionar schemas
- Validar en runtime

### Data Quality

**Asegurar que datos sean correctos y útiles**:

**Dimensiones de calidad**:
1. **Completeness**: Sin nulls donde no deben estar
2. **Accuracy**: Valores correctos (email válido)
3. **Consistency**: Formato consistente
4. **Timeliness**: Datos frescos y actuales
5. **Uniqueness**: Sin duplicados
6. **Validity**: Cumple reglas de negocio

```python
# Data quality checks
assert df['email'].notnull().all(), "Nulls in email"
assert df['age'].between(0, 120).all(), "Invalid age"
assert ~df.duplicated('id').any(), "Duplicate IDs"
```

---

## 🏗️ Arquitectura de Pipeline ETL

### Componentes

```
┌─────────────────────────────────────────────────────┐
│                 ETL ARCHITECTURE                     │
│                                                       │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐     │
│  │ SOURCES  │ → │  STAGED  │ → │  TARGET  │     │
│  └──────────┘    └──────────┘    └──────────┘     │
│       ↓               ↓               ↓             │
│                                                       │
│  ┌──────────────────────────────────────────────┐  │
│  │         CROSS-CUTTING CONCERNS                │  │
│  ├──────────────────────────────────────────────┤  │
│  │ • Logging & Monitoring                        │  │
│  │ • Error Handling & Retry                      │  │
│  │ • Data Quality Checks                         │  │
│  │ • Metadata Management                         │  │
│  │ • Security & Compliance                       │  │
│  └──────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
```

### Layers

1. **Staging Layer**:
   - Datos raw sin transformar
   - Temporal (puede borrarse)
   - Para debugging y reprocessing

2. **Processing Layer**:
   - Transformaciones aplicadas
   - Business logic
   - Data quality checks

3. **Serving Layer**:
   - Datos listos para consumo
   - Optimizados para queries
   - High availability

---

## 📊 Métricas de ETL

### Performance Metrics

- **Throughput**: Registros/segundo procesados
- **Latency**: Tiempo desde extract hasta load
- **Duration**: Tiempo total del pipeline
- **Resource Usage**: CPU, memory, network

### Quality Metrics

- **Success Rate**: % de runs exitosos
- **Data Freshness**: Edad de los datos
- **Completeness**: % de campos poblados
- **Accuracy**: % de registros válidos

### Business Metrics

- **SLA Compliance**: % de deadlines cumplidos
- **Cost per Record**: $ por registro procesado
- **Time to Insight**: Tiempo desde evento hasta dashboard

---

## ✅ Best Practices

### 1. Design for Failure

```python
try:
    data = extract()
    transformed = transform(data)
    load(transformed)
except Exception as e:
    log_error(e)
    alert_team()
    raise  # Re-raise para que orchestrator lo maneje
```

### 2. Make it Idempotent

```python
# Usar upsert en lugar de insert
def upsert(df, table):
    # Delete existing
    conn.execute(f"DELETE FROM {table} WHERE id IN ({df['id']})")
    # Insert new
    df.to_sql(table, conn, if_exists='append')
```

### 3. Log Everything

```python
import logging

logger.info(f"Extracting from {source}")
logger.info(f"Extracted {len(df)} records")
logger.info(f"Transformed {len(transformed)} records")
logger.info(f"Loaded to {destination}")
```

### 4. Validate Early

```python
# Validate después de extract
assert len(df) > 0, "No data extracted"
assert df['key'].notnull().all(), "Nulls in key column"
```

### 5. Monitor Actively

```python
# Enviar métricas
metrics.gauge('etl.records_processed', len(df))
metrics.timing('etl.duration', duration)
metrics.increment('etl.success')
```

---

Este documento cubre los conceptos fundamentales. Continúa con [02-patterns.md](./02-patterns.md) para patrones de implementación.
