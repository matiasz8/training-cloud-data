# Ejercicio 05: Optimization (Z-Ordering, Compaction, Data Skipping)

## 🎯 Objetivo
Optimizar performance con técnicas avanzadas deoptimización.

**Dificultad**: ⭐⭐⭐⭐ Avanzado | **Tiempo**: 45 minutos

## 📋 Tareas

1. **OPTIMIZE**: Compactar archivos pequeños
2. **Z-ORDER**: Colocar datos juntos por columnas frecuentes
3. **Data Skipping**: Verificar mejora de performance
4. **VACUUM**: Limpiar archivos antiguos

## ✅ Comandos

```python
# Optimize + Z-Order
delta_table.optimize().executeZOrderBy("country", "date")

# Vacuum (retener 7 días)
delta_table.vacuum(168)  # horas

# Ver estadísticas
delta_table.detail().select("numFiles", "sizeInBytes").show()
```

## 🎓 Conceptos

- **Small files problem**: Muchos archivos pequeños = lento
- **Z-Ordering**: Co-locality para queries frecuentes
- **Data Skipping**: Skip archivos sin datos relevantes
- **Vacuum**: Borra versiones antiguas (cuidado con Time Travel)
