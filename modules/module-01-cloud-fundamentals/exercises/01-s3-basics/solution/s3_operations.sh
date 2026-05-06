#!/bin/bash

################################################################################
# S3 Operations Script - SOLUTION
#
# Purpose: Automate basic S3 operations for data lake
# Author: Training Cloud Data
# Date: 2024
#
# Usage: ./s3_operations.sh
################################################################################

set -e  # Exit on error

# Output colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ENDPOINT_URL="http://localhost:4566"
REGION="us-east-1"
RAW_BUCKET="my-data-lake-raw"
PROCESSED_BUCKET="my-data-lake-processed"

# Test data directory
TEST_DATA_DIR="./test_data"
DOWNLOAD_DIR="./downloads"

# Helper functions for printing messages
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
# FUNCTION 1: Create Bucket
################################################################################
create_bucket() {
    local bucket_name=$1

    log_info "Creating bucket: $bucket_name"

    aws s3 mb "s3://$bucket_name" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION" 2>/dev/null

    if [ $? -eq 0 ]; then
        log_success "Bucket created: $bucket_name"
        return 0
    else
        # Bucket might already exist
        if bucket_exists "$bucket_name"; then
            log_warning "Bucket already exists: $bucket_name"
            return 0
        else
            log_error "Failed to create bucket: $bucket_name"
            return 1
        fi
    fi
}

################################################################################
# FUNCTION 2: Check if Bucket Exists
################################################################################
bucket_exists() {
    local bucket_name=$1

    aws s3 ls "s3://$bucket_name" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION" &>/dev/null

    return $?
}

################################################################################
# FUNCTION 3: Upload File to S3
################################################################################
upload_file() {
    local local_file=$1
    local bucket=$2
    local s3_key=$3

    if [ ! -f "$local_file" ]; then
        log_error "Local file not found: $local_file"
        return 1
    fi

    log_info "Uploading: $local_file → s3://$bucket/$s3_key"

    aws s3 cp "$local_file" "s3://$bucket/$s3_key" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION" \
        --no-progress

    if [ $? -eq 0 ]; then
        log_success "Uploaded: $(basename "$local_file")"
        return 0
    else
        log_error "Failed to upload: $local_file"
        return 1
    fi
}

################################################################################
# FUNCTION 4: List Objects in Bucket
################################################################################
list_objects() {
    local bucket=$1
    local prefix=$2

    if [ -z "$prefix" ]; then
        log_info "Listing all objects in s3://$bucket/"
        aws s3 ls "s3://$bucket/" \
            --endpoint-url="$ENDPOINT_URL" \
            --recursive
    else
        log_info "Listing objects in s3://$bucket/ with prefix: '$prefix'"
        aws s3 ls "s3://$bucket/$prefix" \
            --endpoint-url="$ENDPOINT_URL" \
            --recursive
    fi
}

################################################################################
# FUNCTION 5: Download File from S3
################################################################################
download_file() {
    local bucket=$1
    local s3_key=$2
    local local_dest=$3

    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$local_dest")"

    log_info "Downloading: s3://$bucket/$s3_key → $local_dest"

    aws s3 cp "s3://$bucket/$s3_key" "$local_dest" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION" \
        --no-progress

    if [ $? -eq 0 ]; then
        log_success "Downloaded: $(basename "$local_dest")"
        return 0
    else
        log_error "Failed to download: $s3_key"
        return 1
    fi
}

################################################################################
# FUNCTION 6: Copy Object between Buckets
################################################################################
copy_object() {
    local source_bucket=$1
    local source_key=$2
    local dest_bucket=$3
    local dest_key=$4

    log_info "Copying: s3://$source_bucket/$source_key → s3://$dest_bucket/$dest_key"

    aws s3 cp "s3://$source_bucket/$source_key" "s3://$dest_bucket/$dest_key" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION" \
        --no-progress

    if [ $? -eq 0 ]; then
        log_success "Copied object successfully"
        return 0
    else
        log_error "Failed to copy object"
        return 1
    fi
}

################################################################################
# FUNCTION 7: Get Object Metadata
################################################################################
get_object_metadata() {
    local bucket=$1
    local key=$2

    log_info "Getting metadata for: s3://$bucket/$key"

    aws s3api head-object \
        --bucket "$bucket" \
        --key "$key" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION" \
        2>/dev/null | jq '.'

    if [ $? -ne 0 ]; then
        log_warning "Failed to get metadata (object might not exist or jq not installed)"
        # Fallback without jq
        aws s3api head-object \
            --bucket "$bucket" \
            --key "$key" \
            --endpoint-url="$ENDPOINT_URL" \
            --region="$REGION"
    fi
}

################################################################################
# FUNCTION 8: Delete All Objects from a Bucket
################################################################################
delete_all_objects() {
    local bucket=$1

    log_warning "Deleting all objects from: $bucket"

    aws s3 rm "s3://$bucket/" \
        --endpoint-url="$ENDPOINT_URL" \
        --recursive \
        --quiet

    if [ $? -eq 0 ]; then
        log_success "Deleted all objects from: $bucket"
        return 0
    else
        log_error "Failed to delete objects from: $bucket"
        return 1
    fi
}

################################################################################
# FUNCTION 9: Delete Bucket
################################################################################
delete_bucket() {
    local bucket=$1

    log_warning "Deleting bucket: $bucket"

    # First try to delete (must be empty)
    aws s3 rb "s3://$bucket/" \
        --endpoint-url="$ENDPOINT_URL" \
        2>/dev/null

    if [ $? -eq 0 ]; then
        log_success "Deleted bucket: $bucket"
        return 0
    else
        log_error "Failed to delete bucket: $bucket (might not be empty or not exist)"
        return 1
    fi
}

################################################################################
# FUNCTION 10: Count Objects in Bucket
################################################################################
count_objects() {
    local bucket=$1
    local prefix=$2

    if [ -z "$prefix" ]; then
        local count=$(aws s3 ls "s3://$bucket/" \
            --endpoint-url="$ENDPOINT_URL" \
            --recursive 2>/dev/null | wc -l | tr -d ' ')
    else
        local count=$(aws s3 ls "s3://$bucket/$prefix" \
            --endpoint-url="$ENDPOINT_URL" \
            --recursive 2>/dev/null | wc -l | tr -d ' ')
    fi

    echo "$count"
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

    # Check that LocalStack is running
    log_info "Checking LocalStack connection..."
    if ! curl -s "$ENDPOINT_URL" > /dev/null 2>&1; then
        log_error "Cannot connect to LocalStack at $ENDPOINT_URL"
        log_error "Make sure LocalStack is running: docker ps | grep localstack"
        log_error "Or start it with: make up (from project root)"
        exit 1
    fi
    log_success "LocalStack is running"
    echo ""

    # Create downloads directory if it doesn't exist
    mkdir -p "$DOWNLOAD_DIR"

    # ========================================
    # STEP 1: Create Buckets
    # ========================================
    echo "📦 Step 1: Creating buckets..."
    create_bucket "$RAW_BUCKET"
    create_bucket "$PROCESSED_BUCKET"
    echo ""

    # ========================================
    # STEP 2: Upload Files with Partitioning
    # ========================================
    echo "📤 Step 2: Uploading files with partitioning..."

    # App logs for day 15
    upload_file \
        "$TEST_DATA_DIR/app-logs-2024-01-15.json" \
        "$RAW_BUCKET" \
        "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json"

    # App logs for day 16
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

    # ========================================
    # STEP 3: List Objects with Prefix
    # ========================================
    echo "📋 Step 3: Listing objects with specific prefix..."

    # List only app-logs
    list_objects "$RAW_BUCKET" "source=app-logs"

    # Count objects
    object_count=$(count_objects "$RAW_BUCKET" "source=app-logs")
    echo ""
    log_info "Total objects with prefix 'source=app-logs': $object_count"

    echo ""

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
    # STEP 5: Copy between Buckets (Raw → Processed)
    # ========================================
    echo "🔄 Step 5: Copying file from raw to processed bucket..."

    copy_object \
        "$RAW_BUCKET" \
        "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json" \
        "$PROCESSED_BUCKET" \
        "processed/app-logs/2024-01-15.json"

    echo ""

    # ========================================
    # STEP 6: Get Metadata
    # ========================================
    echo "🔍 Step 6: Getting object metadata..."

    get_object_metadata \
        "$RAW_BUCKET" \
        "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json"

    echo ""

    # ========================================
    # STEP 7: Summary
    # ========================================
    echo "📊 Step 7: Summary..."
    total_raw=$(count_objects "$RAW_BUCKET")
    total_processed=$(count_objects "$PROCESSED_BUCKET")

    log_info "Objects in RAW bucket: $total_raw"
    log_info "Objects in PROCESSED bucket: $total_processed"

    echo ""

    # ========================================
    # STEP 8: Cleanup (Optional)
    # ========================================
    echo "🗑️  Step 8: Cleanup..."
    read -p "Do you want to delete all buckets and data? (y/N) " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        delete_all_objects "$RAW_BUCKET"
        delete_all_objects "$PROCESSED_BUCKET"
        delete_bucket "$RAW_BUCKET"
        delete_bucket "$PROCESSED_BUCKET"
        log_success "Cleanup completed"
    else
        log_info "Skipping cleanup. Buckets and data remain in LocalStack."
        log_info "To clean manually later, run:"
        log_info "  aws --endpoint-url=$ENDPOINT_URL s3 rb s3://$RAW_BUCKET --force"
        log_info "  aws --endpoint-url=$ENDPOINT_URL s3 rb s3://$PROCESSED_BUCKET --force"
    fi

    echo ""
    echo "✨ =========================================="
    echo "✨   S3 Operations Demo Completed!"
    echo "✨ =========================================="
    echo ""
    echo "📚 What you learned:"
    echo "  ✅ Creating and managing S3 buckets"
    echo "  ✅ Uploading files with partitioned structure"
    echo "  ✅ Listing objects with prefix filters"
    echo "  ✅ Downloading files from S3"
    echo "  ✅ Copying objects between buckets"
    echo "  ✅ Retrieving object metadata"
    echo ""
    echo "🚀 Next steps:"
    echo "  - Continue to Exercise 02: IAM Policies"
    echo "  - Experiment with different partitioning schemes"
    echo "  - Try aws s3 sync for batch uploads"
    echo ""
}

# Run main
main

exit 0
