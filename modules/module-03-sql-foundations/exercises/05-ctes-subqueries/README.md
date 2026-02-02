# Exercise 05: CTEs & Subqueries

## 🎯 Objetivos

- Crear Common Table Expressions (WITH clause)
- Usar subqueries en SELECT, FROM y WHERE
- Encadenar múltiples CTEs
- Decidir entre CTE y subquery según el caso

## 📚 Conceptos

### CTE Básico
```sql
WITH high_value_orders AS (
    SELECT * FROM orders WHERE total_amount > 500
)
SELECT 
    u.first_name,
    hvo.order_id,
    hvo.total_amount
FROM high_value_orders hvo
INNER JOIN users u ON hvo.user_id = u.user_id;
```

### Múltiples CTEs
```sql
WITH 
user_stats AS (
    SELECT user_id, COUNT(*) AS num_orders
    FROM orders GROUP BY user_id
),
top_users AS (
    SELECT * FROM user_stats WHERE num_orders > 5
)
SELECT u.*, tu.num_orders
FROM users u
INNER JOIN top_users tu ON u.user_id = tu.user_id;
```

### Subquery en WHERE
```sql
-- Productos más caros que el promedio
SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products);
```

## 🎓 Ejercicios

Ver starter/ para ejercicios con CTEs recursivos, subqueries correlacionadas, y más.

## ⏱️ Tiempo Estimado: ~100 minutos
