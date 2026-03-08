# Data Generation for Module 07

Este directorio contiene esquemas y scripts para generar datos de batch processing.

## 📦 Datasets Disponibles

### 1. Transactions (10M+ records)
Transacciones de e-commerce con:
- Timestamps distribuidos en 90 días
- Múltiples categorías de productos
- Diferentes métodos de pago
- Países diversos
- Particionado por fecha (year/month/day)

### 2. Users (1M records)
Perfiles de usuarios con:
- Diferentes tiers (bronze, silver, gold, platinum)
- Distribución geográfica
- Niveles de actividad
- Timestamps de creación

### 3. Products (100K records)
Catálogo deproductos con:
- 8 categorías diferentes
- Marcas populares
- Ratings y reviews
- Niveles de stock

## 🚀 Generación de Datos

### Requisitos

```bash
pip install pandas pyarrow tqdm
```

### Generar Transacciones

```bash
# Default: 10M transactions, 90 days, Parquet format, date partitioned
python data/scripts/generate_transactions.py

# Custom configuration
python data/scripts/generate_transactions.py \
  --total-records 5000000 \
  --days 60 \
  --start-date 2024-01-01 \
  --format parquet \
  --partition-by date \
  --output-dir data/raw/transactions
```

**Opciones**:
- `--total-records`: Número total de transacciones (default: 10M)
- `--days`: Número de días a generar (default: 90)
- `--start-date`: Fecha de inicio YYYY-MM-DD (default: 2024-01-01)
- `--format`: parquet, csv, json (default: parquet)
- `--partition-by`: date o none (default: date)
- `--output-dir`: Directorio de salida

**Output structure** (con `--partition-by date`):
```
data/raw/transactions/
├── year=2024/
│   ├── month=01/
│   │   ├── day=01/
│   │   │   └── transactions.parquet
│   │   ├── day=02/
│   │   └── ...
│   ├── month=02/
│   └── ...
```

**Tamaño estimado**:
- 10M records: ~500 MB (Parquet snappy)
- 1M records: ~50 MB
- CSV es ~5x más grande

### Generar Usuarios

```bash
# Default: 1M users
python data/scripts/generate_users.py

# Custom configuration
python data/scripts/generate_users.py \
  --num-users 500000 \
  --format parquet \
  --output-path data/raw/users.parquet
```

**Tamaño**: ~50 MB para 1M users (Parquet)

### Generar Productos

```bash
# Default: 100K products
python data/scripts/generate_products.py

# Custom configuration
python data/scripts/generate_products.py \
  --num-products 50000 \
  --format parquet \
  --output-path data/raw/products.parquet
```

**Tamaño**: ~10 MB para 100K products (Parquet)

## 📊 Schemas

Los schemas JSON en `schemas/` definen la estructura de cada dataset:

- `transactions.json`: Schema de transacciones
- `users.json`: Schema de usuarios
- `products.json`: Schema de productos

Úsalos para validación con tools como `jsonschema` o `pydantic`.

## 💡 Tips

### Generar Dataset Pequeño (Testing)

```bash
# 100K transactions para testing rápido
python data/scripts/generate_transactions.py \
  --total-records 100000 \
  --days 7 \
  --output-dir data/raw/transactions_small
```

### Generar Dataset Grande (Performance Testing)

```bash
# 50M transactions para performance testing
python data/scripts/generate_transactions.py \
  --total-records 50000000 \
  --days 180 \
  --output-dir data/raw/transactions_large
```

**Nota**: 50M records = ~2.5 GB Parquet, toma ~30 minutos generar

### Formato Recomendado

✅ **Parquet**: Formato columnar, comprimido, rápido
- Usa `--format parquet` (default)
- Compression automática (snappy)
- Mejor para batch processing

❌ **CSV**: Solo para exports pequeños
- 5x más grande que Parquet
- 10x más lento para leer
- No recomendado para > 1M records

## 🎯 Uso en Ejercicios

### Exercise 01: Batch Basics
Usa dataset pequeño (100K records)

### Exercise 02-03: Partitioning & PySpark
Usa dataset mediano (1M-5M records)

### Exercise 04-06: Pipelines & Optimization
Usa dataset grande (10M-50M records)

## 🔍 Data Quality

Los scripts generan datos realistas con:

- ✅ Distribuciones ponderadas (más "completed" que "failed")
- ✅ Correlaciones (tier alto → mayor gasto)
- ✅ Timestamps realistas (más actividad en horario laboral)
- ✅ Data integrity (foreign keys válidos)
- ✅ Edge cases (algunas transacciones failed, users inactivos)

## 📁 Estructura de Archivos

```
data/
├── schemas/
│   ├── transactions.json     # Transaction schema
│   ├── users.json            # User schema
│   └── products.json         # Product schema
│
├── scripts/
│   ├── generate_transactions.py  # Genera transacciones
│   ├── generate_users.py         # Genera usuarios
│   └── generate_products.py      # Genera productos
│
└── raw/                      # Data generada (git ignored)
    ├── transactions/         # Transacciones particionadas
    ├── users.parquet         # 1M usuarios
    └── products.parquet      # 100K productos
```

## ⚠️ Notas

1. **Data es git ignored**: Los archivos en `data/raw/` no se suben a git
2. **Generación toma tiempo**: 10M records = ~10 minutos
3. **Espacio en disco**: 10M records = ~500 MB
4. **Memoria**: Scripts usan batching, safe para RAM limitado

## 🚀 Quick Start

```bash
# Generar todos los datasets con defaults
python data/scripts/generate_transactions.py
python data/scripts/generate_users.py
python data/scripts/generate_products.py

# Verificar
ls -lh data/raw/
```

Total: ~560 MB de data de entrenamiento
