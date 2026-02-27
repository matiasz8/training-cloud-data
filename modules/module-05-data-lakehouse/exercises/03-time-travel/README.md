# Ejercicio 03: Time Travel y Versionado

## 🎯 Objetivo

Dominar Delta Lake Time Travel para:
- Consultar versiones históricas
-Rollback a versiones anteriores
- Auditoría y compliance
- Reproducibilidad en ML

**Dificultad**: ⭐⭐⭐ Intermedio  
**Tiempo**: 45-60 minutos

---

## 📋 Tareas

### Tarea 1: Crear y Modificar Tabla con Versiones
**Script**: `01_create_versions.py`

Crea una tabla con múltiples versiones:
1. V0: Crear tabla inicial (10K registros)
2. V1: Append 5K registros
3. V2: Update status='expired' para transacciones antiguas
4. V3: Delete registros con error
5. Verificar historial con `.history()`

### Tarea 2: Time Travel Queries
**Script**: `02_time_travel_queries.py`

1. Query versión específica: `versionAsOf(1)`
2. Query por timestamp: `timestampAsOf("2024-01-01")`
3. Comparar V0 vs V3 (qué cambió)
4. Restaurar archivo borrado por error

### Tarea 3: Auditoría y Rollback
**Script**: `03_audit_rollback.py`

1. Ver historial completo de operaciones
2. Identificar operación problemática
3. Rollback a versión anterior
4. Verificar integridad después del rollback

---

## ✅ Criterios de Éxito

- [ ] Tabla con 4+ versiones
- [ ] Queries time travel exitosos
- [ ] Rollback funcional
- [ ] Documentación de cambios por versión

---

## 🎓 Conceptos

### Time Travel Syntax

```python
# Por versión
df = spark.read.format("delta").option("versionAsOf", 0).load(path)

# Por timestamp
df = spark.read.format("delta").option("timestampAsOf", "2024-01-01").load(path)

# SQL
spark.sql("SELECT * FROM table VERSION AS OF 2")
spark.sql("SELECT * FROM table TIMESTAMP AS OF '2024-01-01'")
```

### Use Cases

- **Auditoría**: ¿Qué datos había el 31/12/2023?
- **Rollback**: Deshacer cambio erróneo
- **ML Reproducibility**: Entrenar con mismos datos
- **A/B Testing**: Comparar métricas entre versiones
