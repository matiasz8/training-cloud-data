# Data Directory

Este directorio contiene esquemas de base de datos, datos de muestra y scripts de migración para el módulo de SQL Foundations.

## 📁 Estructura

```
data/
├── schemas/              # Definiciones DDL de tablas
│   ├── 01_users.sql
│   ├── 02_products.sql
│   ├── 03_orders.sql
│   ├── 04_order_items.sql
│   └── 05_user_activity.sql
├── seeds/                # Datos de muestra en CSV
│   ├── users.csv
│   └── products.csv
├── migrations/           # Scripts de cambios de esquema
│   ├── 001_add_user_preferences.sql
│   ├── 002_add_product_ratings.sql
│   └── 003_add_order_tracking.sql
└── README.md            # Este archivo
```

## 🗄️ Schemas

Los archivos en `schemas/` contienen las definiciones DDL (Data Definition Language) de cada tabla:

### 01_users.sql
**Tabla**: `users`  
**Descripción**: Información de cuentas de usuario  
**Columnas clave**: user_id (PK), email (unique), country, loyalty_points  
**Índices**: email, country, registration_date, is_active

### 02_products.sql
**Tabla**: `products`  
**Descripción**: Catálogo de productos con precios e inventario  
**Columnas clave**: product_id (PK), product_name, category, price, stock_quantity  
**Índices**: category, price, product_name (trigram para búsqueda fuzzy)

### 03_orders.sql
**Tabla**: `orders`  
**Descripción**: Órdenes de clientes con estado y totales  
**Columnas clave**: order_id (PK), user_id (FK), order_date, total_amount, status  
**Índices**: user_id, order_date, status, composite (user_id, order_date)

### 04_order_items.sql
**Tabla**: `order_items`  
**Descripción**: Líneas de productos en cada orden (tabla de unión)  
**Columnas clave**: order_item_id (PK), order_id (FK), product_id (FK), quantity, subtotal  
**Índices**: order_id, product_id  
**Constraint único**: (order_id, product_id) para prevenir duplicados

### 05_user_activity.sql
**Tabla**: `user_activity`  
**Descripción**: Log de eventos de usuario para analytics  
**Columnas clave**: activity_id (PK), user_id (FK), activity_type, details (JSONB)  
**Índices**: user_id, activity_timestamp, activity_type, details (GIN)

## 📊 Seeds (Datos de Muestra)

Los archivos CSV en `seeds/` contienen datos de muestra para testing y desarrollo:

### users.csv
- **Registros**: 10 usuarios de muestra
- **Uso**: Testing de consultas básicas, joins
- **Formato**: CSV con headers

### products.csv
- **Registros**: 10 productos de muestra
- **Categorías**: Electronics, Books, Furniture, Sports
- **Uso**: Testing de agregaciones, filtros por categoría

### Cargar Seeds

```bash
# Cargar usuarios
psql -h localhost -U dataengineer -d ecommerce -c "\COPY users FROM 'data/seeds/users.csv' CSV HEADER"

# Cargar productos
psql -h localhost -U dataengineer -d ecommerce -c "\COPY products FROM 'data/seeds/products.csv' CSV HEADER"
```

O usando Python:

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://dataengineer:training123@localhost:5432/ecommerce')

# Cargar usuarios
df_users = pd.read_csv('data/seeds/users.csv')
df_users.to_sql('users', engine, if_exists='append', index=False)

# Cargar productos
df_products = pd.read_csv('data/seeds/products.csv')
df_products.to_sql('products', engine, if_exists='append', index=False)
```

## 🔄 Migrations

Los scripts en `migrations/` documentan cambios incrementales al esquema:

### 001_add_user_preferences.sql
**Propósito**: Agregar columna JSONB para preferencias de usuario  
**Cambios**:
- Agrega columna `preferences` (JSONB)
- Crea índice GIN para búsquedas eficientes
**Uso**: Almacenar configuraciones personalizadas (tema, notificaciones, etc.)

### 002_add_product_ratings.sql
**Propósito**: Agregar sistema de calificaciones de productos  
**Cambios**:
- Agrega columna `average_rating` (DECIMAL 3,2)
- Agrega columna `review_count` (INTEGER)
- Constraints de rango (0-5.00)
- Índice para filtrado por rating
**Uso**: Mostrar productos mejor calificados, filtros de búsqueda

### 003_add_order_tracking.sql
**Propósito**: Agregar seguimiento de envíos  
**Cambios**:
- Agrega `tracking_number` (VARCHAR 100)
- Agrega `estimated_delivery` (DATE)
- Agrega `shipped_date` (TIMESTAMP)
- Índices para lookups de tracking
**Uso**: Rastreo de órdenes, notificaciones de entrega

### Aplicar Migrations

```bash
# Aplicar migración individual
psql -h localhost -U dataengineer -d ecommerce -f data/migrations/001_add_user_preferences.sql

# Aplicar todas las migraciones
for f in data/migrations/*.sql; do
    echo "Aplicando $f..."
    psql -h localhost -U dataengineer -d ecommerce -f "$f"
done
```

### Rollback Migrations

Cada archivo de migración incluye comentarios con comandos de rollback al final:

```bash
# Ver comandos de rollback
tail -n 10 data/migrations/001_add_user_preferences.sql

# Ejecutar rollback manualmente
psql -h localhost -U dataengineer -d ecommerce -c "ALTER TABLE users DROP COLUMN IF EXISTS preferences;"
```

## 🔧 Uso Común

### Recrear Esquema desde Cero

```bash
# Opción 1: Usar init.sql en infrastructure/
cd infrastructure
docker-compose down -v
docker-compose up -d

# Opción 2: Aplicar schemas manualmente
psql -h localhost -U dataengineer -d ecommerce << EOF
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
EOF

# Aplicar todos los schemas
for f in data/schemas/*.sql; do
    psql -h localhost -U dataengineer -d ecommerce -f "$f"
done
```

### Verificar Estructura

```sql
-- Listar todas las tablas
\dt

-- Describir tabla específica
\d users
\d+ products  -- Incluye comentarios

-- Ver índices de una tabla
\di+ users

-- Ver constraints
SELECT conname, contype, pg_get_constraintdef(oid) 
FROM pg_constraint 
WHERE conrelid = 'users'::regclass;
```

### Exportar Datos

```bash
# Exportar tabla a CSV
psql -h localhost -U dataengineer -d ecommerce -c "\COPY users TO 'users_export.csv' CSV HEADER"

# Exportar con query personalizado
psql -h localhost -U dataengineer -d ecommerce -c "\COPY (SELECT * FROM users WHERE country = 'US') TO 'us_users.csv' CSV HEADER"
```

## 📈 Métricas de Datos

### Tamaños de Tablas

```sql
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size,
    pg_total_relation_size(schemaname||'.'||tablename) AS size_bytes
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY size_bytes DESC;
```

### Conteo de Registros

```sql
SELECT 
    'users' AS table_name, COUNT(*) AS row_count FROM users
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'user_activity', COUNT(*) FROM user_activity;
```

### Estadísticas de Índices

```sql
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan AS index_scans,
    idx_tup_read AS tuples_read,
    idx_tup_fetch AS tuples_fetched
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
ORDER BY idx_scan DESC;
```

## 🎯 Best Practices

### 1. Convenciones de Nomenclatura
- **Tablas**: plural, snake_case (users, order_items)
- **Columnas**: singular, snake_case (user_id, created_at)
- **Índices**: idx_{table}_{columns} (idx_users_email)
- **Constraints**: {table}_{column}_{type} (users_email_format)

### 2. Tipos de Datos
- **IDs**: SERIAL para auto-increment
- **Dinero**: DECIMAL(10,2) nunca FLOAT
- **Timestamps**: TIMESTAMP con timezone
- **Booleans**: BOOLEAN no VARCHAR
- **JSON**: JSONB no JSON (mejor rendimiento)

### 3. Índices
- Indexar todas las foreign keys
- Indexar columnas frecuentemente usadas en WHERE
- Índices compuestos para queries comunes
- GIN para JSONB y búsquedas de texto
- Revisar pg_stat_user_indexes regularmente

### 4. Constraints
- Siempre definir PRIMARY KEY
- Usar FOREIGN KEY con ON DELETE apropiado
- CHECK constraints para validación de datos
- UNIQUE constraints para valores únicos
- NOT NULL cuando corresponda

### 5. Migrations
- Nunca modificar archivos de migración aplicados
- Crear nueva migración para cambios
- Incluir Up y Down en comentarios
- Testear en desarrollo antes de producción
- Documentar propósito y cambios

## 🔍 Troubleshooting

### Error: Tabla ya existe
```sql
-- Usar IF NOT EXISTS en schemas
CREATE TABLE IF NOT EXISTS users (...);
```

### Error: Foreign key violation
```sql
-- Verificar orden de carga (padres antes de hijos)
-- 1. users, products (sin FKs)
-- 2. orders (FK a users)
-- 3. order_items (FK a orders, products)
-- 4. user_activity (FK a users, products)
```

### Error: CSV import fallido
```bash
# Verificar formato del CSV
head -n 2 data/seeds/users.csv

# Verificar encoding
file -i data/seeds/users.csv  # debe ser utf-8

# Usar opciones adicionales de COPY
\COPY users FROM 'data/seeds/users.csv' CSV HEADER DELIMITER ',' NULL 'NULL'
```

## 📚 Recursos Adicionales

- **PostgreSQL COPY**: https://www.postgresql.org/docs/current/sql-copy.html
- **Data Types**: https://www.postgresql.org/docs/current/datatype.html
- **Indexes**: https://www.postgresql.org/docs/current/indexes.html
- **Constraints**: https://www.postgresql.org/docs/current/ddl-constraints.html
- **Migrations Guide**: `../docs/migrations-guide.md`

---

**Última Actualización**: Febrero 2026  
**Mantenido por**: Equipo de Training Data Engineering
