# Escenario Real: Startup Data Lake

## Contexto de Negocio

Trabajas como **Data Engineer** en **QuickMart**, una startup de e-commerce que está creciendo rápidamente.

### El Problema

QuickMart tiene múltiples fuentes de datos:
- **Application Logs:** JSON logs de la aplicación web (errores, eventos de usuario)
- **Transactional Data:** CSV exports diarios de la base de datos de ventas
- **External APIs:** Datos de third-party services (inventario, shipping)

Actualmente estos datos están:
- ❌ En diferentes servidores sin estructura
- ❌ Sin versionamiento
- ❌ Difíciles de acceder para el equipo de analytics
- ❌ No hay backup sistemático

### Tu Misión

El CTO te pidió crear un **sistema centralizado de almacenamiento** usando S3 como base del futuro Data Lake.

### Requisitos Específicos

1. **Estructura Organizada**
   ```
   my-data-lake-raw/
   ├── source=app-logs/
   │   └── year=2024/month=01/day=15/
   │       └── app-logs-2024-01-15.json
   ├── source=transactions/
   │   └── year=2024/month=01/day=15/
   │       └── transactions-2024-01-15.csv
   └── source=external-apis/
       └── year=2024/month=01/day=15/
           └── inventory-2024-01-15.json
   ```

   **Por qué esta estructura:**
   - `source=X`: Permite filtrar por origen de datos
   - `year=YYYY/month=MM/day=DD`: Particionamiento para queries eficientes
   - Formato Hive-style: Compatible con Athena, Glue, Spark

2. **Dos Buckets**
   - `my-data-lake-raw`: Datos originales, inmutables
   - `my-data-lake-processed`: Datos limpios después de ETL

3. **Operaciones Necesarias**
   - Subir archivos diariamente
   - Listar archivos de una fuente específica
   - Copiar archivos entre raw → processed
   - Descargar archivos para análisis local
   - Verificar metadata (tamaño, tipo, fecha)

### Datos de Ejemplo

El equipo te proporcionó data de ejemplo en `test_data/`:

**app-logs-2024-01-15.json**
```json
{
  "timestamp": "2024-01-15T10:30:45Z",
  "level": "INFO",
  "service": "checkout",
  "message": "Payment processed successfully",
  "user_id": "user_12345",
  "order_id": "ord_67890",
  "amount": 129.99
}
```

**transactions-2024-01-15.csv**
```csv
order_id,customer_id,product_id,quantity,amount,timestamp
ord_67890,cust_123,prod_456,2,129.99,2024-01-15T10:30:45Z
ord_67891,cust_124,prod_457,1,49.99,2024-01-15T11:15:20Z
```

### Entregables

Al final de este ejercicio, deberás tener:

1. **Script automatizado** (`s3_operations.sh`) que:
   - Crea los buckets necesarios
   - Sube archivos con estructura correcta
   - Lista objetos con filtros
   - Copia entre buckets
   - Descarga para verificación

2. **Documentación** de comandos usados

3. **Validación** de que todo funciona correctamente

### Métricas de Éxito

- ✅ Buckets creados y accesibles
- ✅ Archivos subidos con paths correctos (particionados)
- ✅ Puedes listar solo logs de aplicación (sin ver transacciones)
- ✅ Archivos copiados a bucket processed mantienen metadata
- ✅ El equipo de analytics puede descargar archivos fácilmente

### Restricciones

- 💰 **Costo:** Usa LocalStack (gratis) para desarrollo
- 🔒 **Seguridad:** Por ahora solo tú tienes acceso (IAM en siguiente ejercicio)
- ⏱️ **Tiempo:** Implementación debe tomar <1 hora

---

## Tu Tarea

Implementa `s3_operations.sh` en `my_solution/` que automatice todas estas operaciones.

**Pista inicial:** Empieza por crear un bucket, luego sube un archivo simple, y expande de ahí.

**Recuerda:** En un ambiente real, este script sería parte de un pipeline que corre automáticamente cada noche. Por ahora, lo ejecutarás manualmente para entender cada paso.

---

## Reflexión

Después de implementar, pregúntate:

1. ¿Qué pasa si subo el mismo archivo dos veces al mismo path?
2. ¿Cómo evitarías sobrescribir archivos accidentalmente?
3. ¿Qué pasaría si necesito procesar solo los logs de enero sin descargar TODO el bucket?

Estas preguntas las responderás en ejercicios futuros (versioning, lifecycle policies, Athena queries).

**¡Adelante!** 🚀
