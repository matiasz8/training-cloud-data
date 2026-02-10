# Ejercicio 03: File Operations

## Objetivos de Aprendizaje

Después de completar este ejercicio, serás capaz de:

1. ✅ Leer y escribir archivos **CSV** con pandas
2. ✅ Manipular archivos **JSON** (simple y anidado)
3. ✅ Trabajar con formato **Parquet** (columnar)
4. ✅ Usar **context managers** (`with` statement)
5. ✅ Manejar errores de I/O correctamente

---

## Conceptos Clave

### Context Managers (with statement)

```python
# ❌ Sin context manager (mal)
archivo = open("datos.txt", "r")
contenido = archivo.read()
archivo.close()  # Fácil de olvidar

# ✅ Con context manager (bien)
with open("datos.txt", "r") as archivo:
    contenido = archivo.read()
# Se cierra automáticamente
```

**Beneficios**:
- Cierra automáticamente el archivo
- Libera recursos incluso si hay error
- Código más limpio y seguro

### CSV con pandas

```python
import pandas as pd

# Leer CSV
df = pd.read_csv("datos.csv")

# Leer con opciones
df = pd.read_csv(
    "datos.csv",
    sep=",",           # Separador
    encoding="utf-8",  # Codificación
    na_values=["N/A", "null"],  # Valores nulos
    parse_dates=["fecha"]  # Parsear fechas
)

# Escribir CSV
df.to_csv("salida.csv", index=False)
```

### JSON

```python
import json

# Leer JSON
with open("datos.json", "r") as f:
    datos = json.load(f)

# Escribir JSON
with open("salida.json", "w") as f:
    json.dump(datos, f, indent=2, ensure_ascii=False)

# JSON con pandas
df = pd.read_json("datos.json")
df = pd.read_json("datos.json", orient="records")  # Lista de objetos
```

### Parquet

```python
import pandas as pd

# Leer Parquet
df = pd.read_parquet("datos.parquet")

# Escribir Parquet
df.to_parquet("salida.parquet", compression="snappy")
```

**Ventajas de Parquet**:
- Formato columnar (más eficiente)
- Compresión integrada
- Preserva tipos de datos
- Más rápido que CSV para lectura

### Manejo de Errores

```python
try:
    with open("archivo.txt", "r") as f:
        contenido = f.read()
except FileNotFoundError:
    print("Archivo no encontrado")
except PermissionError:
    print("Sin permisos para leer")
except Exception as e:
    print(f"Error inesperado: {e}")
```

---

## Ejercicios

Usa los datasets generados en `data/raw/`:
- `customers.csv` (10,000 registros)
- `orders.json` (50,000 registros, anidado)
- `products.csv` (500 registros)
- `transactions.csv` (100,000 registros)
- `user_activity.json` (20,000 registros, anidado)

### 1. leer_csv(ruta) ⭐

Lee un archivo CSV y retorna un DataFrame.

```python
df = leer_csv("data/raw/customers.csv")
assert len(df) == 10000
assert "customer_id" in df.columns
```

### 2. escribir_csv(df, ruta) ⭐

Escribe un DataFrame a CSV.

```python
df = pd.DataFrame({"a": [1, 2], "b": [3, 4]})
escribir_csv(df, "output.csv")
assert os.path.exists("output.csv")
```

### 3. leer_json(ruta) ⭐⭐

Lee un archivo JSON y retorna dict/list.

```python
datos = leer_json("data/raw/orders.json")
assert isinstance(datos, list)
assert len(datos) == 50000
```

### 4. escribir_json(datos, ruta) ⭐⭐

Escribe datos a JSON con formato legible.

```python
datos = {"nombre": "Ana", "edad": 25}
escribir_json(datos, "output.json")
```

### 5. csv_a_parquet(csv_path, parquet_path) ⭐⭐

Convierte CSV a Parquet.

```python
csv_a_parquet("data/raw/products.csv", "data/processed/products.parquet")
```

### 6. contar_registros(ruta) ⭐⭐

Cuenta registros en archivo CSV/JSON.

```python
assert contar_registros("data/raw/customers.csv") == 10000
assert contar_registros("data/raw/orders.json") == 50000
```

### 7. obtener_columnas_csv(ruta) ⭐

Obtiene nombres de columnas de un CSV.

```python
columnas = obtener_columnas_csv("data/raw/customers.csv")
assert "customer_id" in columnas
```

### 8. filtrar_csv(ruta_entrada, ruta_salida, condicion) ⭐⭐⭐

Filtra CSV según condición y guarda resultado.

```python
# Ejemplo: filtrar clientes de USA
filtrar_csv(
    "data/raw/customers.csv",
    "customers_usa.csv",
    lambda df: df[df["country"] == "USA"]
)
```

### 9. combinar_csvs(rutas, ruta_salida) ⭐⭐

Combina múltiples CSVs en uno solo.

```python
combinar_csvs(
    ["parte1.csv", "parte2.csv"],
    "completo.csv"
)
```

### 10. json_a_csv_plano(json_path, csv_path) ⭐⭐⭐

Convierte JSON anidado a CSV plano (flatten).

```python
# orders.json tiene estructura:
# {
#   "order_id": 1,
#   "items": [{"product": "A", "qty": 2}],
#   "customer": {"name": "Ana"}
# }
json_a_csv_plano("data/raw/orders.json", "orders_flat.csv")
```

---

## Ejecución

```bash
# Ejecutar tests
pytest exercises/03-file-operations/tests/ -v

# Con coverage
pytest exercises/03-file-operations/tests/ --cov

# Test específico
pytest exercises/03-file-operations/tests/test_file_io.py::test_leer_csv -v
```

---

## Tips

1. **Context managers**: Siempre usa `with` para archivos
2. **Encoding**: Especifica UTF-8 para evitar problemas
3. **Chunks**: Para archivos grandes, procesa por chunks
4. **Validación**: Verifica que el archivo existe antes de leer
5. **Cleanup**: Borra archivos temporales en tests

---

## Recursos

- [Pandas I/O](https://pandas.pydata.org/docs/user_guide/io.html)
- [JSON Module](https://docs.python.org/3/library/json.html)
- [Parquet Format](https://parquet.apache.org/docs/overview/)

---

## Siguiente Paso

Una vez completado: ➡️ **Ejercicio 04: Pandas Fundamentals**
