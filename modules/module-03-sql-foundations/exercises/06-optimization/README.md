# Exercise 06: Query Optimization

## 🎯 Objetivos

- Analizar query plans con EXPLAIN
- Identificar problemas de performance
- Crear y usar índices efectivamente
- Optimizar JOINs y subqueries
- Entender query costs y timing

## 📚 Conceptos

### EXPLAIN
```sql
EXPLAIN SELECT * FROM orders WHERE user_id = 1;

EXPLAIN ANALYZE SELECT * FROM orders 
WHERE user_id = 1 
ORDER BY order_date DESC;
```

### Índices
```sql
-- Crear índice
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Índice compuesto
CREATE INDEX idx_orders_user_date ON orders(user_id, order_date);

-- Ver índices existentes
\di+ orders
```

### Optimización
- Evitar SELECT *
- Usar LIMIT apropiadamente
- Filtrar antes de JOIN cuando sea posible
- Considerar materializar CTEs complejos
- Usar EXISTS en lugar de IN para grandes datasets

## 🎓 Ejercicios

Ver starter/ para ejercicios de análisis de performance, creación de índices, y comparación de queries.

## ⏱️ Tiempo Estimado: ~90 minutos
