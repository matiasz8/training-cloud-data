# Hints Progresivos - Exercise 01

**Instrucciones:** Lee solo el nivel de hint que necesites. Intenta resolver con Nivel 1 primero. Si sigues atascado, avanza al siguiente nivel.

---

## 🟢 NIVEL 1: Hints Conceptuales (Empieza aquí)

### Hint 1.1: Configuración Inicial

¿No se conecta a LocalStack?

**Verifica:**
```bash
# ¿LocalStack está corriendo?
docker ps | grep localstack

# ¿Puedes alcanzar el endpoint?
curl http://localhost:4566

# ¿Tienes credenciales configuradas?
aws configure list
```

**Problema común:**  
Si ves "Unable to locate credentials", configura credentials dummy:
```bash
aws configure
# Access Key: test
# Secret Key: test
# Region: us-east-1
```

### Hint 1.2: Crear Bucket

Piensa en la estructura del comando:

```
aws s3 mb s3://[NOMBRE_DEL_BUCKET] --endpoint-url=[ENDPOINT]
```

- `mb` = Make Bucket
- Necesitas pasar el endpoint de LocalStack
- El bucket name debe coincidir con las variables definidas arriba

### Hint 1.3: Subir Archivos

Estructura del comando:

```
aws s3 cp [ARCHIVO_LOCAL] s3://[BUCKET]/[KEY] --endpoint-url=[ENDPOINT]
```

**Recuerda:** El KEY es el path COMPLETO del objeto en S3, incluyendo "carpetas":

```
source=app-logs/year=2024/month=01/day=15/filename.json
```

### Hint 1.4: Listar con Prefix

Para listar objetos, tienes dos opciones:

```bash
# Opción 1: Listar como "carpetas"
aws s3 ls s3://bucket/prefix/

# Opción 2: Listar recursivamente (muestra todos los archivos)
aws s3 ls s3://bucket/prefix/ --recursive
```

Para filtrar solo app-logs, usa el prefix correcto: `source=app-logs`

---

## 🟡 NIVEL 2: Hints Técnicos (Si Nivel 1 no fue suficiente)

### Hint 2.1: Función create_bucket Completa

```bash
create_bucket() {
    local bucket_name=$1
    
    log_info "Creating bucket: $bucket_name"
    
    aws s3 mb "s3://$bucket_name" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION"
    
    # ... resto del código
}
```

**Nota:** Las comillas en `"$bucket_name"` son importantes para manejar espacios (aunque no deberían haber espacios en nombres de buckets).

### Hint 2.2: Función upload_file con Metadata

```bash
upload_file() {
    local local_file=$1
    local bucket=$2
    local s3_key=$3
    
    log_info "Uploading: $local_file → s3://$bucket/$s3_key"
    
    # Detectar content-type automáticamente
    aws s3 cp "$local_file" "s3://$bucket/$s3_key" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION"
    
    # ... resto del código
}
```

### Hint 2.3: Función list_objects

```bash
list_objects() {
    local bucket=$1
    local prefix=$2
    
    log_info "Listing objects in s3://$bucket/ with prefix: '$prefix'"
    
    if [ -z "$prefix" ]; then
        # Sin prefix: lista todo
        aws s3 ls "s3://$bucket/" \
            --endpoint-url="$ENDPOINT_URL" \
            --recursive
    else
        # Con prefix: lista solo ese "directorio"
        aws s3 ls "s3://$bucket/$prefix" \
            --endpoint-url="$ENDPOINT_URL" \
            --recursive
    fi
}
```

### Hint 2.4: Función copy_object

```bash
copy_object() {
    local source_bucket=$1
    local source_key=$2
    local dest_bucket=$3
    local dest_key=$4
    
    log_info "Copying: s3://$source_bucket/$source_key → s3://$dest_bucket/$dest_key"
    
    aws s3 cp "s3://$source_bucket/$source_key" "s3://$dest_bucket/$dest_key" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION"
    
    # ... resto del código
}
```

**Nota:** `aws s3 cp` funciona para local→S3, S3→local, y S3→S3.

### Hint 2.5: Función get_object_metadata

Para metadata, necesitas usar `s3api` (no `s3`):

```bash
get_object_metadata() {
    local bucket=$1
    local key=$2
    
    log_info "Getting metadata for: s3://$bucket/$key"
    
    aws s3api head-object \
        --bucket "$bucket" \
        --key "$key" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION"
}
```

**Diferencia importante:**
- `aws s3`: Comandos de alto nivel (cp, ls, rm, sync)
- `aws s3api`: API de bajo nivel con más opciones (head-object, put-object, get-bucket-policy, etc.)

---

## 🔴 NIVEL 3: Solución Parcial (Último recurso)

### Hint 3.1: Main Function - Step 2 Completo

```bash
# ========================================
# STEP 2: Subir Archivos con Particionamiento
# ========================================
echo "📤 Step 2: Uploading files with partitioning..."

# App logs del día 15
upload_file \
    "$TEST_DATA_DIR/app-logs-2024-01-15.json" \
    "$RAW_BUCKET" \
    "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json"

# App logs del día 16
upload_file \
    "$TEST_DATA_DIR/app-logs-2024-01-16.json" \
    "$RAW_BUCKET" \
    "source=app-logs/year=2024/month=01/day=16/app-logs-2024-01-16.json"

# Transactions
upload_file \
    "$TEST_DATA_DIR/transactions-2024-01-15.csv" \
    "$RAW_BUCKET" \
    "source=transactions/year=2024/month=01/day=15/transactions-2024-01-15.csv"

echo ""
```

### Hint 3.2: Main Function - Step 3 Completo

```bash
# ========================================
# STEP 3: Listar Objetos con Prefix
# ========================================
echo "📋 Step 3: Listing objects with specific prefix..."

# Listar solo app-logs
list_objects "$RAW_BUCKET" "source=app-logs"

# Contar objetos
object_count=$(count_objects "$RAW_BUCKET" "source=app-logs")
log_info "Total objects with prefix 'source=app-logs': $object_count"

echo ""
```

### Hint 3.3: Main Function - Step 4 y 5 Completo

```bash
# ========================================
# STEP 4: Descargar Archivo
# ========================================
echo "📥 Step 4: Downloading file for local analysis..."

download_file \
    "$RAW_BUCKET" \
    "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json" \
    "$DOWNLOAD_DIR/app-logs-2024-01-15.json"

echo ""

# ========================================
# STEP 5: Copiar entre Buckets
# ========================================
echo "🔄 Step 5: Copying file from raw to processed bucket..."

copy_object \
    "$RAW_BUCKET" \
    "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json" \
    "$PROCESSED_BUCKET" \
    "processed/app-logs/2024-01-15.json"

echo ""
```

### Hint 3.4: Función count_objects

```bash
count_objects() {
    local bucket=$1
    local prefix=$2
    
    local count=$(aws s3 ls "s3://$bucket/$prefix" \
        --endpoint-url="$ENDPOINT_URL" \
        --recursive | wc -l)
    
    echo "$count"
}
```

**Explicación del pipe:**
- `aws s3 ls ... --recursive`: Lista todos los archivos
- `|`: Pasa output al siguiente comando
- `wc -l`: Cuenta líneas (cada archivo es una línea)

### Hint 3.5: Función delete_all_objects y delete_bucket

```bash
delete_all_objects() {
    local bucket=$1
    
    log_warning "Deleting all objects from: $bucket"
    
    aws s3 rm "s3://$bucket/" \
        --endpoint-url="$ENDPOINT_URL" \
        --recursive
    
    # ... resto del código
}

delete_bucket() {
    local bucket=$1
    
    log_warning "Deleting bucket: $bucket"
    
    # Opción 1: Bucket ya vacío
    aws s3 rb "s3://$bucket/" \
        --endpoint-url="$ENDPOINT_URL"
    
    # Opción 2: Forzar eliminación con objetos
    # aws s3 rb "s3://$bucket/" \
    #     --endpoint-url="$ENDPOINT_URL" \
    #     --force
    
    # ... resto del código
}
```

---

## 💡 Tips Adicionales

### Debug Mode

Si algo no funciona, activa debug:

```bash
# En tu script, al inicio
set -x  # Muestra cada comando antes de ejecutarlo

# O ejecuta así
bash -x s3_operations.sh
```

### Verificar Qué Existe en LocalStack

```bash
# Listar todos los buckets
aws --endpoint-url=http://localhost:4566 s3 ls

# Ver contenido completo de un bucket
aws --endpoint-url=http://localhost:4566 s3 ls s3://my-data-lake-raw --recursive

# Ver metadata
aws --endpoint-url=http://localhost:4566 s3api head-object \
    --bucket my-data-lake-raw \
    --key "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json"
```

### Limpiar Todo y Empezar de Cero

```bash
# Eliminar todos los buckets y sus contenidos
aws --endpoint-url=http://localhost:4566 s3 rb s3://my-data-lake-raw --force
aws --endpoint-url=http://localhost:4566 s3 rb s3://my-data-lake-processed --force

# O reinicia LocalStack
docker restart localstack_main
```

---

## 🎯 Checklist de Troubleshooting

Si tu script no funciona, verifica:

- [ ] LocalStack está corriendo: `docker ps`
- [ ] Endpoint correcto en script: `http://localhost:4566`
- [ ] AWS CLI configurado: `aws configure list`
- [ ] Variables de entorno cargadas: `echo $AWS_ENDPOINT_URL`
- [ ] Script tiene permisos de ejecución: `chmod +x s3_operations.sh`
- [ ] Paths a test_data correctos: `ls -la test_data/`
- [ ] No hay typos en nombres de buckets
- [ ] Comillas correctamente cerradas en comandos

---

## 🤔 Preguntas de Reflexión

Después de completar el ejercicio, responde:

1. **¿Qué pasa si ejecutas el script dos veces?**
   - ¿Falla al crear buckets que ya existen?
   - ¿Sobrescribe archivos en S3?
   - ¿Cómo lo harías idempotente?

2. **¿Cómo optimizarías para subir 1000 archivos?**
   - `aws s3 cp` en loop es lento
   - Investiga: `aws s3 sync`
   - O: Usa `--include` y `--exclude` patterns

3. **¿Por qué usamos particionamiento con year/month/day?**
   - Piensa en queries: "Dame datos de enero 2024"
   - Sin particiones: Escanea TODO
   - Con particiones: Solo lee carpeta `year=2024/month=01/`

4. **¿Cuándo usarías `s3api` en lugar de `s3`?**
   - `s3`: Operaciones simples (copy, move, delete)
   - `s3api`: Configuración avanzada (policies, lifecycle, versioning, metadata)

---

## 📚 Recursos Útiles Durante el Ejercicio

- **AWS CLI S3 Reference**: `aws s3 help`
- **AWS CLI S3API Reference**: `aws s3api help`
- **LocalStack S3 Docs**: https://docs.localstack.cloud/user-guide/aws/s3/
- **Bash Scripting Guide**: https://www.gnu.org/software/bash/manual/

---

**Recuerda:** El objetivo es **aprender**, no solo completar el ejercicio. Si necesitas mirar la solución completa, hazlo, pero asegúrate de entender cada línea.

¡Tú puedes! 💪
