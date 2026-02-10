# Ejercicio 04: Pandas Fundamentals

## Objetivos

✅ Operaciones básicas con DataFrames  
✅ Filtrado y selección de datos  
✅ Limpieza de datos (nulls, duplicados)  
✅ Groupby y agregaciones  
✅ Merges y joins  

## Conceptos Clave

### Selección de Datos

```python
# Por columna
df['nombre']
df[['nombre', 'edad']]

# Por fila (loc/iloc)
df.loc[0]  # Por índice
df.iloc[0]  # Por posición

# Filtrado
df[df['edad'] > 25]
df[(df['edad'] > 25) & (df['pais'] == 'USA')]
```

### Limpieza

```python
# Nulls
df.isna().sum()
df.dropna()
df.fillna(0)

# Duplicados
df.duplicated().sum()
df.drop_duplicates()
```

### Groupby

```python
df.groupby('categoria')['precio'].mean()
df.groupby(['pais', 'ciudad']).size()
```

## Ejercicios

Usa `data/raw/customers.csv` y `data/raw/transactions.csv`.

1. **cargar_y_explorar**(ruta) → dict con info básica
2. **filtrar_por_pais**(df, pais) → DataFrame filtrado
3. **limpiar_datos**(df) → DataFrame sin nulls ni duplicados
4. **calcular_estadisticas**(df, columna) → dict con mean/median/std
5. **agrupar_por_columna**(df, columna) → DataFrame agrupado
6. **top_n_registros**(df, columna, n) → Top N valores
7. **detectar_outliers**(df, columna) → DataFrame con outliers
8. **merge_datasets**(df1, df2, on) → DataFrame merged
9. **crear_columna_calculada**(df, formula) → DataFrame con nueva columna
10. **resumen_completo**(df) → dict con análisis completo

## Ejecución

```bash
pytest exercises/04-pandas-fundamentals/tests/ -v
```

➡️ **Siguiente**: Ejercicio 05
