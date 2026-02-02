# Hints - Exercise 02: Joins

## INNER JOIN (01)

**Query 1 - Órdenes con usuario**
- 💡 La foreign key en orders es `user_id`
- 💡 Sintaxis: `FROM orders o INNER JOIN users u ON o.user_id = u.user_id`
- 💡 Usa alias (o, u) para mejor legibilidad

**Query 2 - Items con productos**
- 💡 La relación es order_items.product_id = products.product_id
- 💡 Selecciona columnas de ambas tablas

## LEFT JOIN (02)

**Query 1 - Conteo con LEFT JOIN**
- 💡 LEFT JOIN users con orders para incluir usuarios sin órdenes
- 💡 Usa COUNT(o.order_id) no COUNT(*) - cuenta solo órdenes reales
- 💡 Necesitas GROUP BY en las columnas de usuario

**Query 2 - Encontrar registros sin match**
- 💡 LEFT JOIN retorna NULL en columnas de la tabla derecha cuando no hay match
- 💡 Filtra con `WHERE order_id IS NULL`
- 💡 Verifica columnas de la tabla derecha (orders), no de la izquierda (users)

**Query 3 - COALESCE para valores NULL**
- 💡 `COALESCE(SUM(column), 0)` retorna 0 si SUM es NULL
- 💡 NULL aparece cuando no hay registros para agregar

## Multiple JOINs (03)

**Query 1 - Cadena de JOINs**
- 💡 Orden: orders → users, orders → order_items, order_items → products
- 💡 Cada JOIN usa la foreign key apropiada
- 💡 Puedes encadenar JOINs: FROM tabla1 JOIN tabla2 ON... JOIN tabla3 ON...

**Query 2 - STRING_AGG**
- 💡 `STRING_AGG(column, ', ')` concatena valores en una string
- 💡 Útil para mostrar múltiples valores en una fila

## Tips Generales

- Siempre usa alias de tabla
- INNER JOIN cuando necesitas solo coincidencias
- LEFT JOIN cuando necesitas todos de la izquierda
- GROUP BY todas las columnas que no están en funciones de agregación
- COUNT(columna) vs COUNT(*) - usa columna específica después de LEFT JOIN
