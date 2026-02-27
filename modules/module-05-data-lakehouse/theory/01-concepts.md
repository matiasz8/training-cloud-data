# Conceptos Fundamentales de Data Lakehouse

## 📚 Tabla de Contenidos

1. [Introducción](#introducción)
2. [Evolución de las Arquitecturas de Datos](#evolución-de-las-arquitecturas-de-datos)
3. [Data Lake: El Primer Paradigma](#data-lake-el-primer-paradigma)
4. [Data Warehouse: El Paradigma Tradicional](#data-warehouse-el-paradigma-tradicional)
5. [Data Lakehouse: Lo Mejor de Ambos Mundos](#data-lakehouse-lo-mejor-de-ambos-mundos)
6. [Formatos de Tabla en Lakehouse](#formatos-de-tabla-en-lakehouse)
7. [ACID en Sistemas Distribuidos](#acid-en-sistemas-distribuidos)
8. [Casos de Uso y Cuándo Usar Cada Arquitectura](#casos-de-uso-y-cuándo-usar-cada-arquitectura)

---

## Introducción

El **Data Lakehouse** representa la evolución más reciente en arquitecturas de almacenamiento y procesamiento de datos. Combina la **flexibilidad y bajo costo** de los Data Lakes con la **confiabilidad y rendimiento** de los Data Warehouses, creando una plataforma unificada para analytics, business intelligence y machine learning.

### ¿Por qué surgió el Data Lakehouse?

Durante la última década, las organizaciones enfrentaron un dilema:

- **Data Lakes**: Económicos y flexibles, pero sin garantías de calidad ni transaccionalidad
- **Data Warehouses**: Confiables y rápidos, pero costosos y rígidos

Este dilema llevó a arquitecturas complejas donde los datos se movían entre múltiples sistemas:

```
Sources → Data Lake → ETL → Data Warehouse → BI Tools
                   ↓
                  ML/AI Tools
```

**Problemas de esta arquitectura**:
- 🔴 Datos duplicados en múltiples sistemas
- 🔴 Sincronización compleja y costosa
- 🔴 Inconsistencias entre sistemas
- 🔴 Altos costos de almacenamiento y transferencia
- 🔴 Latencia en la disponibilidad de datos

El **Data Lakehouse** elimina esta complejidad:

```
Sources → Data Lakehouse → BI Tools + ML/AI Tools
          (Single Source of Truth)
```

---

## Evolución de las Arquitecturas de Datos

### 📊 Timeline de Evolución

```
1990s: Data Warehouses
   ↓   (Teradata, Oracle, SQL Server)
   ↓   ✅ ACID, performance
   ↓   ❌ Costoso, rígido
   ↓
2010s: Data Lakes
   ↓   (Hadoop, S3, Azure Data Lake)
   ↓   ✅ Bajo costo, flexible
   ↓   ❌ Sin ACID, "data swamp"
   ↓
2015+: Lambda Architecture
   ↓   (Batch + Stream layers)
   ↓   ✅ Real-time + batch
   ↓   ❌ Complejidad operacional
   ↓
2020+: Data Lakehouse
       (Delta Lake, Iceberg, Hudi)
       ✅ ACID + flexibilidad + bajo costo
       ✅ Unified batch + streaming
```

### 🎯 Factores que Impulsaron el Cambio

1. **Cloud Storage**: S3, Azure Blob, GCS ofrecen almacenamiento extremadamente económico
2. **Open Formats**: Parquet y ORC permiten lecturas eficientes
3. **Metadata Layers**: Delta Lake, Iceberg agregaron ACID sobre object storage
4. **Compute Separation**: Motores como Spark, Presto pueden leer el mismo storage
5. **ML Workloads**: Necesidad de acceso directo a datos raw sin ETL

---

## Data Lake: El Primer Paradigma

### 🌊 Definición

Un **Data Lake** es un repositorio centralizado que almacena **todos los datos** de una organización en su formato nativo (estructurado, semi-estructurado, no estructurado).

### Arquitectura Típica

```
┌─────────────────────────────────────────────┐
│              Data Lake (S3/HDFS)            │
│  ┌────────┐  ┌────────┐  ┌─────────┐      │
│  │  CSV   │  │  JSON  │  │ Parquet │      │
│  │ Files  │  │ Files  │  │  Files  │      │
│  └────────┘  └────────┘  └─────────┘      │
│                                             │
│  /raw/         /processed/    /curated/    │
└─────────────────────────────────────────────┘
         ↓              ↓              ↓
    Spark/Hive    Presto/Athena   Redshift
```

### ✅ Ventajas

1. **Bajo costo**: ~$23/TB/mes en S3 Standard
2. **Flexibilidad**: Cualquier formato de datos
3. **Escalabilidad**: Petabytes sin problemas
4. **Schema-on-read**: No necesitas definir schema al escribir
5. **ML-friendly**: Acceso directo para Python/Spark
6. **Decoupling**: Storage separado de compute

### ❌ Desventajas

1. **Sin ACID**: No hay transacciones atómicas
   ```python
   # Problema: Lecturas inconsistentes
   # Proceso 1 está escribiendo 100 archivos
   # Proceso 2 lee mientras se escribe → datos parciales ❌
   ```

2. **Sin Time Travel**: No puedes volver a versiones anteriores
   ```bash
   # Si sobreescribes datos, se pierden para siempre
   $ aws s3 cp new_data.parquet s3://bucket/path/data.parquet
   # ❌ Los datos anteriores se perdieron
   ```

3. **Sin Schema Enforcement**: Puedes escribir basura
   ```python
   # Día 1: Schema correcto
   df1 = pd.DataFrame({"id": [1, 2], "amount": [100.0, 200.0]})
   
   # Día 2: Alguien cambia el schema (sin querer)
   df2 = pd.DataFrame({"id": ["a", "b"], "amount": ["100", "200"]})
   # ❌ Ahora tienes types inconsistentes
   ```

4. **Metadata Pesada**: Leer 10,000 archivos es lento
   ```python
   # Spark necesita list todos los archivos
   spark.read.parquet("s3://bucket/partitioned-table/*/*/*/")
   # ⏱️ 30+ segundos solo listando archivos
   ```

5. **"Data Swamp"**: Sin governance, se vuelve caótico
   - ¿Qué datos son actuales?
   - ¿Quién es dueño de este dataset?
   - ¿Qué significa esta columna?

### 🎯 Caso de Uso Ideal

- **Archiving**: Almacenar logs históricos
- **Data Science**: Exploración ad-hoc
- **Raw Data**: Almacenar datos tal como llegan

---

## Data Warehouse: El Paradigma Tradicional

### 🏢 Definición

Un **Data Warehouse** es una base de datos **optimizada para análisis** con schema pre-definido, queries complejas y alta concurrencia.

### Arquitectura Típica

```
┌────────────────────────────────────────────┐
│       Data Warehouse (Redshift/Snowflake)  │
│                                            │
│  ┌──────────────────────────────────────┐ │
│  │      Columnar Storage Engine         │ │
│  │  ┌─────────┐  ┌──────────┐          │ │
│  │  │ Fact    │  │ Dimension│          │ │
│  │  │ Tables  │  │ Tables   │          │ │
│  │  └─────────┘  └──────────┘          │ │
│  └──────────────────────────────────────┘ │
│                                            │
│  Features:                                 │
│  • ACID Transactions                       │
│  • Indexes & Materialized Views            │
│  • Query Optimizer                         │
│  • Compression                             │
└────────────────────────────────────────────┘
```

### ✅ Ventajas

1. **ACID Completo**: Garantías transaccionales
   ```sql
   BEGIN TRANSACTION;
   UPDATE accounts SET balance = balance - 100 WHERE id = 1;
   UPDATE accounts SET balance = balance + 100 WHERE id = 2;
   COMMIT;
   -- ✅ O ambas suceden, o ninguna (atomicidad)
   ```

2. **Performance BI**: Optimizado para queries complejas
   ```sql
   -- Queries con múltiples joins son rápidos
   SELECT
       d.year, d.month,
       p.category,
       SUM(f.revenue) as total_revenue
   FROM fact_sales f
   JOIN dim_date d ON f.date_id = d.id
   JOIN dim_product p ON f.product_id = p.id
   GROUP BY 1, 2, 3;
   -- ⚡ Segundos, no minutos
   ```

3. **Schema Enforcement**: Validación automática
   ```sql
   -- El warehouse valida tipos y constraints
   INSERT INTO users (id, email, age)
   VALUES (1, 'invalid-email', -5);
   -- ❌ Error: email format invalid, age < 0
   ```

4. **Concurrencia**: Miles de usuarios simultáneos
   - MVCC (Multi-Version Concurrency Control)
   - Query queuing y priorización

5. **Governance**: Auditoría, permisos, linaje

### ❌ Desventajas

1. **Costo Alto**: $3,000-$10,000+/TB/año
   ```
   Redshift: $0.25/hora × 24 × 365 = $2,190/año (mínimo)
   Snowflake: ~$40/TB/mes storage + $2-$4/credit compute
   ```

2. **Schema Rígido**: Difícil cambiar schema
   ```sql
   -- Agregar columna puede tomar horas en tablas grandes
   ALTER TABLE events ADD COLUMN user_segment VARCHAR(50);
   -- ⏱️ 4 horas en tabla de 10B filas
   ```

3. **Solo Structured Data**: No soporta JSON anidado, XML, imágenes
   ```sql
   -- ❌ No puedes hacer esto eficientemente:
   SELECT json_extract(event_data, '$.user.preferences.notifications')
   FROM events;
   ```

4. **No ML-Friendly**: Difícil acceso para Python/Spark
   ```python
   # Necesitas exportar datos primero
   # Redshift → S3 → Spark → Train model
   # ⏱️ Latencia y costos de transferencia
   ```

5. **Vendor Lock-in**: Formato propietario
   - No puedes mover fácilmente entre Snowflake ↔ Redshift
   - Dependencia del proveedor

### 🎯 Caso de Uso Ideal

- **BI/Dashboards**: Queries complejas, baja latencia
- **Financial Reporting**: ACID crítico
- **High Concurrency**: Cientos de usuarios simultáneos

---

## Data Lakehouse: Lo Mejor de Ambos Mundos

### 🏛️ Definición

Un **Data Lakehouse** es una arquitectura que implementa estructuras y características de data warehouses **directamente sobre data lakes** utilizando formatos de tabla open-source.

### Arquitectura del Lakehouse

```
┌───────────────────────────────────────────────────────┐
│                   DATA LAKEHOUSE                       │
│                                                        │
│  ┌──────────────────────────────────────────────┐    │
│  │         Table Format Layer                    │    │
│  │    (Delta Lake / Iceberg / Hudi)              │    │
│  │  • Transaction Log                            │    │
│  │  • Metadata Management                        │    │
│  │  • ACID Guarantees                            │    │
│  │  • Time Travel                                │    │
│  │  • Schema Evolution                           │    │
│  └──────────────────────────────────────────────┘    │
│                     ↓                                  │
│  ┌──────────────────────────────────────────────┐    │
│  │         Data Files (Parquet/ORC)              │    │
│  │  s3://bucket/table/                           │    │
│  │    ├── part-00000.parquet                     │    │
│  │    ├── part-00001.parquet                     │    │
│  │    └── part-00002.parquet                     │    │
│  └──────────────────────────────────────────────┘    │
│                     ↓                                  │
│  ┌──────────────────────────────────────────────┐    │
│  │      Object Storage (S3/ADLS/GCS)             │    │
│  │  Bajo costo, escalable, durable               │    │
│  └──────────────────────────────────────────────┘    │
│                                                        │
│  Query Engines (Multi-Engine Support):                │
│  ├─ Spark (Batch Processing)                          │
│  ├─ Presto/Trino (Interactive SQL)                    │
│  ├─ Flink (Streaming)                                 │
│  └─ Pandas/Dask (Data Science)                        │
└───────────────────────────────────────────────────────┘
```

### 🎯 Principios Clave del Lakehouse

#### 1. ACID Transactions

Garantías ACID sobre object storage (S3, ADLS, GCS):

```python
# Delta Lake example
from delta.tables import DeltaTable

# ✅ ACID Write - todo o nada
df.write.format("delta").mode("overwrite").save("/path/to/table")

# ✅ ACID Update - transacción atómica
deltaTable = DeltaTable.forPath(spark, "/path/to/table")
deltaTable.update(
    condition="status = 'pending'",
    set={"status": "'processed'", "updated_at": "current_timestamp()"}
)
```

**Cómo funciona**:
- Transaction log (`_delta_log/`) rastrea todas las operaciones
- Commit atómico: o todo el batch se escribe, o nada
- Isolation: lectores ven snapshot consistente

#### 2. Time Travel (Data Versioning)

Acceso a versiones históricas:

```python
# Leer versión 10 minutos atrás
df = spark.read.format("delta") \
    .option("timestampAsOf", "2024-02-12 10:00:00") \
    .load("/path/to/table")

# Leer versión específica
df = spark.read.format("delta") \
    .option("versionAsOf", 5) \
    .load("/path/to/table")

# Ver historial completo
deltaTable.history().show()
```

**Casos de uso**:
- Auditoría y compliance
- Rollback después de errores
- Reproducibilidad en ML (entrenar con mismos datos)

#### 3. Schema Evolution

Evolucionar schema sin romper pipelines:

```python
# Agregar columna automáticamente
df_with_new_col.write.format("delta") \
    .option("mergeSchema", "true") \
    .mode("append") \
    .save("/path/to/table")

# El schema anterior sigue siendo válido
# Nuevas columnas aparecen como NULL en registros anteriores
```

#### 4. Unified Batch + Streaming

Misma tabla para ambos workloads:

```python
# Batch write
df_batch.write.format("delta").save("/path/to/table")

# Streaming write a la misma tabla
df_stream.writeStream \
    .format("delta") \
    .outputMode("append") \
    .option("checkpointLocation", "/checkpoints/") \
    .start("/path/to/table")

# Streaming read
df_stream_read = spark.readStream.format("delta").load("/path/to/table")
```

#### 5. Open Format

No vendor lock-in, múltiples engines:

```python
# Spark
df = spark.read.format("delta").load("s3://bucket/table")

# Presto/Trino
# SELECT * FROM delta.default.table

# Pandas (via deltalake library)
from deltalake import DeltaTable
dt = DeltaTable("s3://bucket/table")
df = dt.to_pandas()
```

### ✅ Ventajas del Lakehouse

| Aspecto | Data Lake | Data Warehouse | Data Lakehouse |
|---------|-----------|----------------|----------------|
| **Costo** | 💰 $23/TB/mes | 💰💰💰 $250+/TB/mes | 💰💰 $40/TB/mes |
| **ACID** | ❌ No | ✅ Sí | ✅ Sí |
| **Performance** | ⚠️ Lento | ✅ Rápido | ✅ Rápido |
| **Flexibilidad** | ✅ Todos los formatos | ❌ Solo structured | ✅ Todos los formatos |
| **Time Travel** | ❌ No | ⚠️ Limitado | ✅ Sí (completo) |
| **ML Support** | ✅ Excelente | ❌ Limitado | ✅ Excelente |
| **Schema Evolution** | ⚠️ Manual | ❌ Difícil | ✅ Automático |
| **Streaming** | ⚠️ Complejo | ❌ No soportado | ✅ Nativo |
| **Open Format** | ✅ Sí | ❌ Propietario | ✅ Sí |

### ❌ Desventajas/Limitaciones

1. **Complejidad Inicial**: Curva de aprendizaje
2. **Overhead de Metadata**: Transaction log puede crecer
3. **Requiere Tuning**: Compaction, partitioning, etc.
4. **Madurez**: Menos maduro que warehouses tradicionales (pero evolucionando rápido)

### 🎯 Caso de Uso Ideal

- **Todo**: BI, ML, Real-time analytics en una plataforma
- **Reducir costos** manteniendo confiabilidad
- **Unificar arquitectura** (eliminar silos)

---

## Formatos de Tabla en Lakehouse

Existen tres formatos principales de tabla open-source:

### 1. Delta Lake (Databricks)

**Características**:
- Transaction log en JSON (`_delta_log/`)
- Optimistic concurrency control
- ACID via log único
- Mejor integración con Spark

**Strengths**:
- ✅ Madurez y estabilidad
- ✅ Performance en Spark
- ✅ Documentación y comunidad
- ✅ Upserts eficientes (MERGE)

**Weaknesses**:
- ⚠️ Optimizado para Spark (otros engines con limitaciones)
- ⚠️ Log puede crecer en tablas con muchas actualizaciones

**Cuándo usar**:
- Pipelines batch pesados en Spark
- Necesitas MERGE/UPSERT frecuente
- Ecosistema Databricks

### 2. Apache Iceberg (Netflix → Apache)

**Características**:
- Metadata en Avro/Parquet
- Hidden partitioning (particiones transparentes)
- Partition evolution (cambiar estrategia sin reescribir)
- Multi-engine desde diseño

**Strengths**:
- ✅ Multi-engine (Spark, Flink, Presto, Trino)
- ✅ Partition evolution
- ✅ Hidden partitioning (más fácil para usuarios)
- ✅ Snapshots eficientes

**Weaknesses**:
- ⚠️ Menos maduro que Delta
- ⚠️ Metadata complexity en tablas grandes

**Cuándo usar**:
- Múltiples query engines
- Streaming con Flink
- Necesitas partition evolution

### 3. Apache Hudi (Uber → Apache)

**Características**:
- Copy-on-Write y Merge-on-Read
- Incremental processing
- Record-level updates

**Strengths**:
- ✅ Updates incrementales eficientes
- ✅ CDC (Change Data Capture) nativo
- ✅ Retención de datos configurablefacilmente

**Weaknesses**:
- ⚠️ Complejidad en tuning
- ⚠️ Menos adoption que Delta/Iceberg

**Cuándo usar**:
- CDC pipelines
- Updates frecuentes row-level
- Ecosistema AWS (EMR tiene soporte nativo)

### Comparación Directa

| Característica | Delta Lake | Iceberg | Hudi |
|----------------|------------|---------|------|
| **ACID** | ✅ Sí | ✅ Sí | ✅ Sí |
| **Time Travel** | ✅ Sí | ✅ Sí | ✅ Sí |
| **Schema Evolution** | ✅ Sí | ✅ Sí | ✅ Sí |
| **Partition Evolution** | ❌ No | ✅ Sí | ❌ No |
| **Hidden Partitioning** | ❌ No | ✅ Sí | ❌ No |
| **Multi-Engine** | ⚠️ Limitado | ✅ Excelente | ⚠️ Limitado |
| **Streaming** | ✅ Spark Streaming | ✅ Flink, Spark | ✅ Spark Streaming |
| **Upserts** | ✅ MERGE | ⚠️ Overwrite | ✅ Upsert (MoR) |
| **Madurez** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Comunidad** | Grande | Grande | Mediana |

---

## ACID en Sistemas Distribuidos

### ¿Qué es ACID?

ACID son garantías fundamentales en bases de datos:

- **A**tomicity: Todo o nada
- **C**onsistency: Reglas de negocio siempre válidas
- **I**solation: Transacciones concurrentes no interfieren
- **D**urability: Datos committed no se pierden

### El Desafío en Object Storage

Object storage (S3, ADLS, GCS) **NO** provee ACID nativamente:

```python
# ❌ Problema: No es atómico
for file in files:
    s3.put_object(Bucket='mybucket', Key=file, Body=data)
    # Si falla en el archivo 50 de 100, ¿qué pasa?
    # Tienes datos parciales ❌
```

### Cómo Delta Lake Implementa ACID

Delta Lake usa un **transaction log** para coordinar escrituras:

```
s3://bucket/table/
├── _delta_log/
│   ├── 00000000000000000000.json  # Versión 0
│   ├── 00000000000000000001.json  # Versión 1
│   ├── 00000000000000000002.json  # Versión 2
│   └── 00000000000000000010.checkpoint.parquet
├── part-00000-abc123.snappy.parquet
├── part-00001-def456.snappy.parquet
└── part-00002-ghi789.snappy.parquet
```

#### Transaction Log

Cada commit genera un archivo JSON en `_delta_log/`:

```json
{
  "commitInfo": {
    "timestamp": 1707724800000,
    "operation": "WRITE",
    "operationMetrics": {"numFiles": "3", "numOutputRows": "1000000"}
  },
  "add": {
    "path": "part-00000-abc123.snappy.parquet",
    "size": 10485760,
    "modificationTime": 1707724800000,
    "dataChange": true,
    "stats": "{\"numRecords\": 500000, \"minValues\": {...}, \"maxValues\": {...}}"
  }
}
```

#### Atomicidad

1. Escritor escribe archivos Parquet
2. Escritor crea archivo JSON en `_delta_log/`
3. **Rename atómico** (garantizado por S3)
4. Si falla antes del rename → transacción no sucedió
5. Si rename exitoso → transacción committed

```python
# Delta Lake garantiza atomicidad
df.write.format("delta").mode("append").save("/path/to/table")
# O todos los registros se escriben, o ninguno ✅
```

#### Isolation

- **Optimistic Concurrency Control** (OCC)
- Múltiples escritores pueden trabajar simultáneamente
- En commit, se valida que no haya conflictos
- Si conflicto → retry automático

```python
# Writer 1 y Writer 2 escriben en paralelo
# Delta Lake detecta conflicto y hace retry automático
# Ambos commits son serializables ✅
```

#### Consistency & Durability

- **Consistency**: Schema enforcement + CHECK constraints
- **Durability**: Una vez committed, el log garantiza no-pérdida

---

## Casos de Uso y Cuándo Usar Cada Arquitectura

### Data Lake

**Usa cuando**:
- Archiving de datos históricos (logs, eventos)
- Exploración ad-hoc sin schema definido
- Presupuesto limitado
- No necesitas ACID

**Ejemplos**:
- Logs de aplicaciones (30 días de retención)
- Archivos raw de IoT devices
- Data science exploration

### Data Warehouse

**Usa cuando**:
- BI crítico con SLAs estrictos (<1s)
- High concurrency (100+ usuarios)
- Queries extremadamente complejas
- Presupuesto no es limitación

**Ejemplos**:
- Dashboards ejecutivos
- Financial reporting
- Sales analytics con miles de usuarios

### Data Lakehouse

**Usa cuando**:
- Quieres unificar BI + ML en una plataforma
- Necesitas ACID + bajo costo
- Tienes workloads batch + streaming
- Quieres evitar silos de datos

**Ejemplos**:
- Plataforma de analytics moderna
- ML feature stores
- Real-time + historical analytics
- Reducir costos manteniendo calidad

### Tabla de Decisión Rápida

| Pregunta | Lake | Warehouse | Lakehouse |
|----------|------|-----------|-----------|
| ¿Necesitas ACID? | ❌ | ✅ | ✅ |
| ¿Presupuesto limitado? | ✅ | ❌ | ✅ |
| ¿ML workloads? | ✅ | ❌ | ✅ |
| ¿BI crítico (<1s)? | ❌ | ✅ | ⚠️ |
| ¿100+ usuarios concurrentes? | ❌ | ✅ | ⚠️ |
| ¿Streaming + batch? | ⚠️ | ❌ | ✅ |
| ¿Schema flexible? | ✅ | ❌ | ✅ |
| ¿Time travel necesario? | ❌ | ⚠️ | ✅ |

---

## Resumen

### Key Takeaways

1. **Data Lakehouse** = Data Lake + Data Warehouse features
2. **Formatos de tabla** (Delta, Iceberg, Hudi) agregan ACID sobre object storage
3. **ACID en distributed systems** requiere transaction log y coordination
4. **Delta Lake** es el formato más maduro (70% de este módulo)
5. **Apache Iceberg** destaca en multi-engine y partition evolution (30% de este módulo)
6. La elección depende de tus requisitos específicos (cost, performance, features)

### Próximos Pasos

Ahora que comprendes los conceptos fundamentales, continuaremos con:

1. **Arquitectura** ([02-architecture.md](02-architecture.md)): Patrones como Medallion, optimizaciones
2. **Recursos** ([03-resources.md](03-resources.md)): Documentación oficial, papers, guías
3. **Ejercicios prácticos**: Implementar lo aprendido con Delta Lake y Iceberg

---

**Última actualización**: Febrero 2026  
**Tiempo de lectura**: ~45 minutos  
**Nivel**: Intermedio-Avanzado
