# Exercise 01: AWS CLI & S3 Basics

**Dificultad:** ⭐ Básico  
**Tiempo estimado:** 45-60 minutos  
**Prerequisitos:** AWS CLI instalado, LocalStack corriendo

---

## 🎯 Objetivo

Familiarizarte con AWS CLI y operaciones básicas de S3: crear buckets, subir/descargar archivos, listar objetos y configurar storage classes. Este es el fundamento de TODAS las operaciones con AWS.

## 📋 Qué Vas a Aprender

Al finalizar este ejercicio sabrás:

1. ✅ Configurar AWS CLI para trabajar con LocalStack
2. ✅ Crear y eliminar buckets S3
3. ✅ Subir archivos (PutObject) y descargar (GetObject)
4. ✅ Listar objetos con filtros y prefixes
5. ✅ Copiar objetos entre buckets
6. ✅ Configurar storage classes (Standard, Standard-IA)
7. ✅ Ver metadata de objetos

## 🛤️ Ruta Clara a Seguir

### Step 1: Entender el Problema (5 min)

Lee el archivo `starter/scenario.md` que describe un caso real:

> *"Eres data engineer en una startup. Necesitas crear un sistema de almacenamiento para datos raw que llegan de diferentes fuentes (CSV, JSON, logs). Los datos deben organizarse por fecha y fuente."*

### Step 2: Revisar Starter Code (10 min)

Abre `starter/s3_operations.sh`. Verás:

```bash
#!/bin/bash
# S3 Operations Script
# TODO: Completa las funciones marcadas

# Función 1: Crear bucket
create_bucket() {
    # TODO: Usa aws s3 mb para crear bucket
    # Nombre del bucket: $1 (primer argumento)
    echo "Creating bucket: $1"
    # TU CÓDIGO AQUÍ
}

# TODO: Implementa otras funciones...
```

**Archivos en starter/:**
- `s3_operations.sh` - Script principal (50% completo, tienes TODOs)
- `test_data/` - Datos de ejemplo para subir
- `.env.example` - Variables de entorno necesarias

### Step 3: Copiar a my_solution/ (2 min)

```bash
# Desde el directorio del ejercicio
cp -r starter/* my_solution/
cd my_solution/
```

**⚠️ IMPORTANTE:** Trabaja SOLO en `my_solution/`. No modifiques `starter/` ni `solution/`.

### Step 4: Implementar Solución (30 min)

**Camino recomendado:**

1. **Configura entorno (5 min)**
   ```bash
   cp .env.example .env
   # Edita .env con tu configuración LocalStack
   source .env
   ```

2. **Implementa función por función (20 min)**
   - Empieza con `create_bucket()`
   - Luego `upload_file()`
   - Continúa en orden: list, download, copy, delete
   - **Prueba cada función antes de continuar a la siguiente**

3. **Ejecuta script completo (5 min)**
   ```bash
   chmod +x s3_operations.sh
   ./s3_operations.sh
   ```

### Step 5: Validar (5 min)

```bash
# Desde el directorio del módulo
cd ../..  # Vuelve a module-01-cloud-fundamentals/
../../scripts/validate-module.sh 01
```

**Output esperado:**
```
✅ All tests passed!
✅ Bucket creation works
✅ File upload successful
✅ Object listing correct
...
```

### Step 6: Si Te Atascas (10-15 min)

1. **Lee hints.md** - Tiene 3 niveles de ayuda progresiva
2. **Consulta AWS CLI docs**: `aws s3 help`
3. **Revisa tu configuración LocalStack**
4. **Solo como último recurso:** Compara con `solution/s3_operations.sh`

---

## 📝 Requisitos de la Solución

Tu implementación debe cumplir:

### Funcional
- ✅ Crear bucket `my-data-lake-raw`
- ✅ Subir 3 archivos a paths con particiones: `source=app-logs/year=2024/month=01/`
- ✅ Listar objetos con prefix `source=app-logs`
- ✅ Copiar archivo a otro bucket `my-data-lake-processed`
- ✅ Descargar archivo localmente
- ✅ Verificar metadata (content-type, storage class)

### Calidad de Código
- ✅ Script debe manejar errores (exit code != 0 si falla)
- ✅ Output legible con echo de cada operación
- ✅ Variables para nombres de buckets (no hardcodear)
- ✅ Comentarios explicativos en secciones clave

---

## 🎓 Conceptos Clave del Ejercicio

### 1. AWS CLI Endpoint Configuration

Para trabajar con LocalStack en lugar de AWS real:

```bash
# LocalStack endpoint
export AWS_ENDPOINT_URL=http://localhost:4566

# Credenciales dummy (LocalStack no las valida)
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1

# Ahora todos los comandos aws van a LocalStack
aws s3 ls  # Lista buckets en LocalStack, no AWS
```

### 2. S3 Path Structure

S3 NO tiene carpetas reales, usa "prefixes" que simulan estructura:

```
Bucket: my-data-lake-raw

Object Key (path completo):
source=app-logs/year=2024/month=01/day=15/file1.json

Prefix (simula carpeta):
source=app-logs/year=2024/month=01/

En realidad S3 solo ve:
- Bucket name: my-data-lake-raw
- Object key: source=app-logs/year=2024/month=01/day=15/file1.json
```

**Por qué es importante:**
- Listar con prefixes es MÁS RÁPIDO que listar todo
- Particionamiento permite queries eficientes en Athena/Glue
- Borrar con prefix = borrar "carpeta" entera

### 3. Storage Classes

```
Standard (default):
- Acceso frecuente
- $0.023/GB/mes
- 99.99% availability

Standard-IA (Infrequent Access):
- Acceso <1 vez/mes
- $0.0125/GB/mes (46% más barato)
- Cobra por retrieval

Cuándo cambiar:
- Datos raw → Standard (se procesan pronto)
- Datos procesados old → Standard-IA (solo auditoría)
```

---

## 🔍 Debugging Tips

### Problema: "aws: command not found"
```bash
# Solución
pip install awscli
# o
brew install awscli  # macOS
```

### Problema: "Unable to locate credentials"
```bash
# Configura credenciales dummy
aws configure
# AWS Access Key ID: test
# AWS Secret Access Key: test
# Default region: us-east-1
```

### Problema: "Unable to connect to endpoint"
```bash
# Verifica LocalStack esté corriendo
docker ps | grep localstack

# Si no está corriendo
cd ../../..  # Vuelve a raíz del proyecto
make up
```

### Problema: "Bucket already exists"
```bash
# Lista buckets existentes
aws --endpoint-url=http://localhost:4566 s3 ls

# Elimina bucket viejo
aws --endpoint-url=http://localhost:4566 s3 rb s3://my-data-lake-raw --force
```

---

## ✅ Checklist de Completitud

Antes de considerar el ejercicio completo:

- [ ] `my_solution/s3_operations.sh` implementado completamente
- [ ] Script ejecuta sin errores: `./s3_operations.sh`
- [ ] Validación pasa: `../../scripts/validate-module.sh 01`
- [ ] Puedes explicar qué hace cada comando aws s3
- [ ] Entiendes diferencia entre bucket y object key
- [ ] Conoces al menos 2 storage classes de S3

---

## 📊 Expected Output

Cuando ejecutes `./s3_operations.sh` correctamente, deberías ver:

```
🚀 Starting S3 Operations Demo...

📦 Step 1: Creating buckets...
✅ Created bucket: my-data-lake-raw
✅ Created bucket: my-data-lake-processed

📤 Step 2: Uploading files...
✅ Uploaded: test_data/app-logs-2024-01-15.json → source=app-logs/year=2024/month=01/day=15/
✅ Uploaded: test_data/app-logs-2024-01-16.json → source=app-logs/year=2024/month=01/day=16/
✅ Uploaded: test_data/transactions-2024-01-15.csv → source=transactions/year=2024/month=01/day=15/

📋 Step 3: Listing objects with prefix 'source=app-logs'...
2024-01-15 10:30:45       1024 source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json
2024-01-16 10:30:46       1156 source=app-logs/year=2024/month=01/day=16/app-logs-2024-01-16.json

📋 Total objects with prefix 'source=app-logs': 2

📥 Step 4: Downloading file...
✅ Downloaded: source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json → downloads/

🔄 Step 5: Copying file between buckets...
✅ Copied: my-data-lake-raw/source=app-logs/... → my-data-lake-processed/processed/...

🔍 Step 6: Getting object metadata...
{
    "ContentType": "application/json",
    "ContentLength": 1024,
    "StorageClass": "STANDARD",
    "LastModified": "2024-01-15T10:30:45+00:00"
}

🗑️  Step 7: Cleanup (optional)...
✅ Deleted all objects from buckets
✅ Deleted buckets

✨ S3 Operations completed successfully!
```

---

## 🚀 Next Steps

Después de completar este ejercicio:

1. **Entiendes S3 CLI** → Ejercicio 02 te introduce a IAM policies
2. **Experimenta más:**
   - Crea tu propia estructura de carpetas
   - Prueba subir archivos de diferentes tipos
   - Usa `aws s3 sync` para sincronizar directorios

3. **Reflexiona:**
   - ¿Por qué usamos prefixes en lugar de carpetas?
   - ¿Cuándo cambiarías a Standard-IA storage class?
   - ¿Cómo automatizarías esto en un pipeline real?

---

## 📚 Referencias

- AWS CLI S3 Commands: `aws s3 help`
- S3 API Reference: https://docs.aws.amazon.com/cli/latest/reference/s3/
- LocalStack S3 Docs: https://docs.localstack.cloud/user-guide/aws/s3/

**¡Éxito con el ejercicio!** 🎉

Recuerda: El objetivo NO es completarlo lo más rápido posible, sino **entender cada comando** que ejecutas.
