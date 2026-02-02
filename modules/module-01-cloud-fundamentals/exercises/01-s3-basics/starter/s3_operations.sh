#!/bin/bash

################################################################################
# S3 Operations Script - Starter Template
# 
# Propósito: Automatizar operaciones básicas de S3 para data lake
# Autor: [TU NOMBRE]
# Fecha: [FECHA]
#
# Uso: ./s3_operations.sh
################################################################################

set -e  # Exit on error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración
# TODO: Configura estas variables según tu entorno
ENDPOINT_URL="http://localhost:4566"  # LocalStack endpoint
REGION="us-east-1"
RAW_BUCKET="my-data-lake-raw"
PROCESSED_BUCKET="my-data-lake-processed"

# Directorio de datos de prueba
TEST_DATA_DIR="./test_data"
DOWNLOAD_DIR="./downloads"

# Helper function para imprimir mensajes
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

################################################################################
# FUNCIÓN 1: Crear Bucket
################################################################################
create_bucket() {
    local bucket_name=$1
    
    log_info "Creating bucket: $bucket_name"
    
    # TODO: Implementa la creación de bucket con aws s3 mb
    # Pista: aws s3 mb s3://BUCKET_NAME --endpoint-url=...
    
    # TU CÓDIGO AQUÍ
    
    
    if [ $? -eq 0 ]; then
        log_success "Bucket created: $bucket_name"
        return 0
    else
        log_error "Failed to create bucket: $bucket_name"
        return 1
    fi
}

################################################################################
# FUNCIÓN 2: Verificar si Bucket Existe
################################################################################
bucket_exists() {
    local bucket_name=$1
    
    # TODO: Verifica si el bucket existe
    # Pista: aws s3 ls s3://BUCKET_NAME --endpoint-url=...
    # Si existe, devuelve 0 (success), si no existe devuelve 1 (failure)
    
    # TU CÓDIGO AQUÍ
    
    
    return $?
}

################################################################################
# FUNCIÓN 3: Subir Archivo a S3
################################################################################
upload_file() {
    local local_file=$1
    local bucket=$2
    local s3_key=$3  # Path completo en S3 (ej: source=app-logs/year=2024/...)
    
    log_info "Uploading: $local_file → s3://$bucket/$s3_key"
    
    # TODO: Sube el archivo a S3
    # Pista: aws s3 cp LOCAL_FILE s3://BUCKET/KEY --endpoint-url=...
    
    # TU CÓDIGO AQUÍ
    
    
    if [ $? -eq 0 ]; then
        log_success "Uploaded: $local_file"
        return 0
    else
        log_error "Failed to upload: $local_file"
        return 1
    fi
}

################################################################################
# FUNCIÓN 4: Listar Objetos en Bucket
################################################################################
list_objects() {
    local bucket=$1
    local prefix=$2  # Opcional: filtrar por prefix
    
    log_info "Listing objects in s3://$bucket/ with prefix: '$prefix'"
    
    # TODO: Lista objetos en el bucket (con prefix si se proporciona)
    # Pista: aws s3 ls s3://BUCKET/PREFIX --endpoint-url=... --recursive
    
    # TU CÓDIGO AQUÍ
    
    
}

################################################################################
# FUNCIÓN 5: Descargar Archivo de S3
################################################################################
download_file() {
    local bucket=$1
    local s3_key=$2
    local local_dest=$3
    
    log_info "Downloading: s3://$bucket/$s3_key → $local_dest"
    
    # TODO: Descarga el archivo de S3
    # Pista: aws s3 cp s3://BUCKET/KEY LOCAL_DEST --endpoint-url=...
    
    # TU CÓDIGO AQUÍ
    
    
    if [ $? -eq 0 ]; then
        log_success "Downloaded: $s3_key"
        return 0
    else
        log_error "Failed to download: $s3_key"
        return 1
    fi
}

################################################################################
# FUNCIÓN 6: Copiar Objeto entre Buckets
################################################################################
copy_object() {
    local source_bucket=$1
    local source_key=$2
    local dest_bucket=$3
    local dest_key=$4
    
    log_info "Copying: s3://$source_bucket/$source_key → s3://$dest_bucket/$dest_key"
    
    # TODO: Copia el objeto entre buckets
    # Pista: aws s3 cp s3://SOURCE_BUCKET/SOURCE_KEY s3://DEST_BUCKET/DEST_KEY --endpoint-url=...
    
    # TU CÓDIGO AQUÍ
    
    
    if [ $? -eq 0 ]; then
        log_success "Copied object"
        return 0
    else
        log_error "Failed to copy object"
        return 1
    fi
}

################################################################################
# FUNCIÓN 7: Obtener Metadata de Objeto
################################################################################
get_object_metadata() {
    local bucket=$1
    local key=$2
    
    log_info "Getting metadata for: s3://$bucket/$key"
    
    # TODO: Obtén metadata del objeto
    # Pista: aws s3api head-object --bucket BUCKET --key KEY --endpoint-url=...
    
    # TU CÓDIGO AQUÍ
    
    
}

################################################################################
# FUNCIÓN 8: Eliminar Todos los Objetos de un Bucket
################################################################################
delete_all_objects() {
    local bucket=$1
    
    log_warning "Deleting all objects from: $bucket"
    
    # TODO: Elimina todos los objetos del bucket
    # Pista: aws s3 rm s3://BUCKET --recursive --endpoint-url=...
    
    # TU CÓDIGO AQUÍ
    
    
    if [ $? -eq 0 ]; then
        log_success "Deleted all objects from: $bucket"
        return 0
    else
        log_error "Failed to delete objects from: $bucket"
        return 1
    fi
}

################################################################################
# FUNCIÓN 9: Eliminar Bucket
################################################################################
delete_bucket() {
    local bucket=$1
    
    log_warning "Deleting bucket: $bucket"
    
    # TODO: Elimina el bucket (debe estar vacío)
    # Pista: aws s3 rb s3://BUCKET --endpoint-url=...
    
    # TU CÓDIGO AQUÍ
    
    
    if [ $? -eq 0 ]; then
        log_success "Deleted bucket: $bucket"
        return 0
    else
        log_error "Failed to delete bucket: $bucket"
        return 1
    fi
}

################################################################################
# FUNCIÓN 10: Contar Objetos en Bucket
################################################################################
count_objects() {
    local bucket=$1
    local prefix=$2
    
    # TODO: Cuenta objetos en el bucket con prefix específico
    # Pista: aws s3 ls s3://BUCKET/PREFIX --recursive | wc -l
    
    # TU CÓDIGO AQUÍ
    
    
}

################################################################################
# MAIN EXECUTION
################################################################################

main() {
    echo ""
    echo "🚀 =========================================="
    echo "🚀   S3 Operations Demo - QuickMart Data Lake"
    echo "🚀 =========================================="
    echo ""
    
    # Verificar que LocalStack esté corriendo
    log_info "Checking LocalStack connection..."
    if ! curl -s "$ENDPOINT_URL" > /dev/null; then
        log_error "Cannot connect to LocalStack at $ENDPOINT_URL"
        log_error "Make sure LocalStack is running: docker ps | grep localstack"
        exit 1
    fi
    log_success "LocalStack is running"
    echo ""
    
    # Crear directorio de descargas si no existe
    mkdir -p "$DOWNLOAD_DIR"
    
    # ========================================
    # STEP 1: Crear Buckets
    # ========================================
    echo "📦 Step 1: Creating buckets..."
    # TODO: Llama a create_bucket para RAW_BUCKET y PROCESSED_BUCKET
    
    # TU CÓDIGO AQUÍ
    
    
    echo ""
    
    # ========================================
    # STEP 2: Subir Archivos con Particionamiento
    # ========================================
    echo "📤 Step 2: Uploading files with partitioning..."
    
    # TODO: Sube los archivos de test_data/ con estructura correcta
    # Ejemplo de estructura: source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json
    
    # App logs (JSON)
    # TU CÓDIGO AQUÍ
    
    
    # Transactions (CSV)
    # TU CÓDIGO AQUÍ
    
    
    echo ""
    
    # ========================================
    # STEP 3: Listar Objetos con Prefix
    # ========================================
    echo "📋 Step 3: Listing objects with specific prefix..."
    
    # TODO: Lista solo los app-logs (source=app-logs)
    # TU CÓDIGO AQUÍ
    
    
    # TODO: Cuenta cuántos objetos hay con ese prefix
    # TU CÓDIGO AQUÍ
    
    
    echo ""
    
    # ========================================
    # STEP 4: Descargar Archivo
    # ========================================
    echo "📥 Step 4: Downloading file for local analysis..."
    
    # TODO: Descarga uno de los archivos subidos
    # TU CÓDIGO AQUÍ
    
    
    echo ""
    
    # ========================================
    # STEP 5: Copiar entre Buckets (Raw → Processed)
    # ========================================
    echo "🔄 Step 5: Copying file from raw to processed bucket..."
    
    # TODO: Copia un archivo de RAW_BUCKET a PROCESSED_BUCKET
    # En un pipeline real, aquí habría transformación de datos
    # TU CÓDIGO AQUÍ
    
    
    echo ""
    
    # ========================================
    # STEP 6: Obtener Metadata
    # ========================================
    echo "🔍 Step 6: Getting object metadata..."
    
    # TODO: Obtén metadata de uno de los objetos
    # TU CÓDIGO AQUÍ
    
    
    echo ""
    
    # ========================================
    # STEP 7: Cleanup (Opcional)
    # ========================================
    echo "🗑️  Step 7: Cleanup..."
    read -p "Do you want to delete all buckets and data? (y/N) " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # TODO: Elimina todos los objetos y buckets
        # TU CÓDIGO AQUÍ
        
        
        log_success "Cleanup completed"
    else
        log_info "Skipping cleanup. Buckets and data remain in LocalStack."
    fi
    
    echo ""
    echo "✨ =========================================="
    echo "✨   S3 Operations Demo Completed!"
    echo "✨ =========================================="
    echo ""
}

# Ejecutar main
main

exit 0
