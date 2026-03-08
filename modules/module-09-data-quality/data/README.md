# Data Quality Module - Sample Data

Este directorio contiene datos de muestra con problemas de calidad intencionales para practicar técnicas de validación y limpieza.

## 📁 Estructura

```
data/
├── schemas/              # JSON schemas para validación
├── scripts/
│   └── generate_data.py  # Script para generar datos
└── samples/              # Datos generados (CSV y Parquet)
    ├── customers_poor.csv
    ├── customers_medium.csv
    ├── customers_clean.csv
    ├── transactions_poor.csv
    ├── transactions_medium.csv
    ├── transactions_clean.csv
    ├── products_poor.csv
    ├── products_medium.csv
    └── products_clean.csv
```

## 🎯 Datasets

### 1. Customers (10,000 registros)

**Columnas:**
- `customer_id` (int): ID único del cliente
- `first_name` (string): Nombre
- `last_name` (string): Apellido
- `email` (string): Email
- `phone` (string): Teléfono
- `date_of_birth` (date): Fecha de nacimiento
- `registration_date` (date): Fecha de registro
- `country` (string): Código de país
- `city` (string): Ciudad
- `zipcode` (string): Código postal
- `account_status` (string): Estado de cuenta

**Problemas de calidad inyectados:**
- ❌ Missing values (5-15% según quality level)
- ❌ Empty strings en nombres y ciudad
- ❌ Duplicados exactos (2-8%)
- ❌ Emails inválidos (ej: `john@@example.com`, `john.example`)
- ❌ Teléfonos demasiado cortos
- ❌ Fechas de nacimiento en el futuro
- ❌ Fechas de registro antes del nacimiento
- ❌ Status inválidos (ej: `ACTIVE` en vez de `active`)

### 2. Transactions (50,000 registros)

**Columnas:**
- `transaction_id` (int): ID único de transacción
- `customer_id` (int): Customer ID (foreign key)
- `product_id` (int): Product ID (foreign key)
- `amount` (float): Monto unitario
- `quantity` (int): Cantidad
- `total` (float): Total (amount * quantity)
- `transaction_date` (datetime): Fecha de transacción
- `payment_method` (string): Método de pago
- `status` (string): Estado
- `currency` (string): Moneda

**Problemas de calidad inyectados:**
- ❌ Missing values en campos críticos (3-10%)
- ❌ Orphan foreign keys (customer_id que no existe: 5-15%)
- ❌ Amounts negativos (2%)
- ❌ Outliers extremos (muy altos o muy bajos)
- ❌ Status inválidos
- ❌ Inconsistencia lógica: `total != amount * quantity` (3%)
- ❌ Fechas futuras (1%)
- ❌ Duplicados (5%)

### 3. Products (1,000 registros)

**Columnas:**
- `product_id` (int): ID único de producto
- `product_name` (string): Nombre del producto
- `category` (string): Categoría
- `price` (float): Precio de venta
- `cost` (float): Costo
- `stock_quantity` (int): Cantidad en stock
- `weight_kg` (float): Peso en kg
- `supplier_id` (int): ID del proveedor
- `is_active` (bool): Producto activo

**Problemas de calidad inyectados:**
- ❌ Missing values (5-12%)
- ❌ Precios negativos (2%)
- ❌ Costo mayor que precio (8%)
- ❌ Stock negativo (1%)
- ❌ Duplicados (3%)
- ❌ Categorías inconsistentes (mayúsculas, vacíos)

## 🚀 Generar Datos

### Instalación de dependencias

```bash
pip install pandas numpy faker pyarrow
```

### Generar datasets

```bash
# Generar con calidad "poor" (muchos problemas)
python data/scripts/generate_data.py --quality poor

# Generar con calidad "medium" (problemas moderados)
python data/scripts/generate_data.py --quality medium

# Generar con calidad "clean" (sin problemas)
python data/scripts/generate_data.py --quality clean

# Especificar directorio de salida
python data/scripts/generate_data.py --quality poor --output data/samples
```

### Output

El script genera:
- Archivos CSV para facilidad de lectura
- Archivos Parquet para mejor performance
- Summary de problemas de calidad encontrados

## 📊 Niveles de Calidad

### Clean (Sin problemas)
- ✅ 0% missing values
- ✅ 0% duplicates
- ✅ 100% valid formats
- ✅ 100% logical consistency

### Medium (Problemas moderados)
- ⚠️ 5% missing values
- ⚠️ 2% duplicates
- ⚠️ 3% invalid formats
- ⚠️ 5% orphan foreign keys

### Poor (Muchos problemas)
- ❌ 10-15% missing values
- ❌ 5-8% duplicates
- ❌ 10% invalid formats
- ❌ 15% orphan foreign keys
- ❌ Outliers, inconsistencias lógicas, etc.

## 💻 Uso en Ejercicios

### Ejercicio 01: Data Profiling

```python
import pandas as pd

# Cargar datos
df = pd.read_csv('data/samples/customers_poor.csv')

# Analizar calidad
print(f"Total registros: {len(df)}")
print(f"Nulls por columna:\n{df.isnull().sum()}")
print(f"Duplicados: {df.duplicated().sum()}")
```

### Ejercicio 02: Validation Rules

```python
# Validar reglas básicas
assert df['customer_id'].notna().all(), "customer_id no puede ser null"
assert (df['amount'] >= 0).all(), "amount debe ser positivo"
```

### Ejercicio 03: Great Expectations

```python
import great_expectations as gx

context = gx.get_context()
validator = context.sources.add_pandas("my_datasource").read_csv(
    'data/samples/transactions_poor.csv'
)

validator.expect_column_values_to_not_be_null("transaction_id")
validator.expect_column_values_to_be_between("amount", min_value=0)
```

## 🔍 Explorando los Datos

### Pandas

```python
import pandas as pd

# Cargar
df = pd.read_parquet('data/samples/transactions_poor.parquet')

# Info básica
print(df.info())
print(df.describe())

# Problemas de calidad
print(f"\nNulls:\n{df.isnull().sum()}")
print(f"\nDuplicados: {df.duplicated().sum()}")
print(f"\nAmounts negativos: {(df['amount'] < 0).sum()}")
```

### DuckDB

```bash
duckdb -c "
SELECT 
    COUNT(*) as total,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) as null_customer_id
FROM 'data/samples/transactions_poor.parquet'
"
```

### Data Profiling

```python
from ydata_profiling import ProfileReport

df = pd.read_csv('data/samples/customers_poor.csv')
profile = ProfileReport(df, title="Customer Data Quality Report")
profile.to_file("customers_profile.html")
```

## 📝 Esquemas Esperados

Ver `data/schemas/` para los JSON schemas que definen:
- Columnas requeridas
- Tipos de datos
- Rangos válidos
- Formatos esperados
- Reglas de negocio

## ⚠️ Nota sobre Datos Sintéticos

Todos los datos son **sintéticos** generados con Faker:
- Nombres, emails, direcciones son ficticios
- No contienen información real o sensible
- Diseñados exclusivamente para training

## 🎓 Recursos Adicionales

- **theory/01-concepts.md**: Dimensiones de data quality
- **theory/02-architecture.md**: Frameworks (Great Expectations, PyDeequ)
- **exercises/**: Prácticas hands-on con estos datos

---

**Happy Data Quality Testing!** 🔍✨
