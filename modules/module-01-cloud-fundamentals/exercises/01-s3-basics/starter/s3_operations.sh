#!/bin/bash

################################################################################
# S3 Operations Script - Starter Template
#
# Purpose: Automate basic S3 operations for data lake
# Author: [YOUR NAME]
# Date: [DATE]
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
# TODO: Configure these variables according to your environment
ENDPOINT_URL="http://localhost:4566"  # LocalStack endpoint
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

    # TODO: Implement bucket creation with aws s3 mb
    # Hint: aws s3 mb s3://BUCKET_NAME --endpoint-url=...

    # YOUR CODE HERE


    if [ $? -eq 0 ]; then
        log_success "Bucket created: $bucket_name"
        return 0
    else
        log_error "Failed to create bucket: $bucket_name"
        return 1
    fi
}

################################################################################
# FUNCTION 2: Check if Bucket Exists
################################################################################
bucket_exists() {
    local bucket_name=$1

    # TODO: Check if the bucket exists
    # Hint: aws s3 ls s3://BUCKET_NAME --endpoint-url=...
    # If it exists, return 0 (success), if it doesn't exist return 1 (failure)

    # YOUR CODE HERE


    return $?
}

################################################################################
# FUNCTION 3: Upload File to S3
################################################################################
upload_file() {
    local local_file=$1
    local bucket=$2
    local s3_key=$3  # Full path in S3 (e.g.: source=app-logs/year=2024/...)

    log_info "Uploading: $local_file → s3://$bucket/$s3_key"

    # TODO: Upload the file to S3
    # Hint: aws s3 cp LOCAL_FILE s3://BUCKET/KEY --endpoint-url=...

    # YOUR CODE HERE


    if [ $? -eq 0 ]; then
        log_success "Uploaded: $local_file"
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
    local prefix=$2  # Optional: filter by prefix

    log_info "Listing objects in s3://$bucket/ with prefix: '$prefix'"

    # TODO: List objects in the bucket (with prefix if provided)
    # Hint: aws s3 ls s3://BUCKET/PREFIX --endpoint-url=... --recursive

    # YOUR CODE HERE


}

################################################################################
# FUNCTION 5: Download File from S3
################################################################################
download_file() {
    local bucket=$1
    local s3_key=$2
    local local_dest=$3

    log_info "Downloading: s3://$bucket/$s3_key → $local_dest"

    # TODO: Download the file from S3
    # Hint: aws s3 cp s3://BUCKET/KEY LOCAL_DEST --endpoint-url=...

    # YOUR CODE HERE


    if [ $? -eq 0 ]; then
        log_success "Downloaded: $s3_key"
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

    # TODO: Copy the object between buckets
    # Hint: aws s3 cp s3://SOURCE_BUCKET/SOURCE_KEY s3://DEST_BUCKET/DEST_KEY --endpoint-url=...

    # YOUR CODE HERE


    if [ $? -eq 0 ]; then
        log_success "Copied object"
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

    # TODO: Get object metadata
    # Hint: aws s3api head-object --bucket BUCKET --key KEY --endpoint-url=...

    # YOUR CODE HERE


}

################################################################################
# FUNCTION 8: Delete All Objects from a Bucket
################################################################################
delete_all_objects() {
    local bucket=$1

    log_warning "Deleting all objects from: $bucket"

    # TODO: Delete all objects from the bucket
    # Hint: aws s3 rm s3://BUCKET --recursive --endpoint-url=...

    # YOUR CODE HERE


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

    # TODO: Delete the bucket (must be empty)
    # Hint: aws s3 rb s3://BUCKET --endpoint-url=...

    # YOUR CODE HERE


    if [ $? -eq 0 ]; then
        log_success "Deleted bucket: $bucket"
        return 0
    else
        log_error "Failed to delete bucket: $bucket"
        return 1
    fi
}

################################################################################
# FUNCTION 10: Count Objects in Bucket
################################################################################
count_objects() {
    local bucket=$1
    local prefix=$2

    # TODO: Count objects in the bucket with specific prefix
    # Hint: aws s3 ls s3://BUCKET/PREFIX --recursive | wc -l

    # YOUR CODE HERE


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
    if ! curl -s "$ENDPOINT_URL" > /dev/null; then
        log_error "Cannot connect to LocalStack at $ENDPOINT_URL"
        log_error "Make sure LocalStack is running: docker ps | grep localstack"
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
    # TODO: Call create_bucket for RAW_BUCKET and PROCESSED_BUCKET

    # YOUR CODE HERE


    echo ""

    # ========================================
    # STEP 2: Upload Files with Partitioning
    # ========================================
    echo "📤 Step 2: Uploading files with partitioning..."

    # TODO: Upload the files from test_data/ with correct structure
    # Example structure: source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json

    # App logs (JSON)
    # YOUR CODE HERE


    # Transactions (CSV)
    # YOUR CODE HERE


    echo ""

    # ========================================
    # STEP 3: List Objects with Prefix
    # ========================================
    echo "📋 Step 3: Listing objects with specific prefix..."

    # TODO: List only app-logs (source=app-logs)
    # YOUR CODE HERE


    # TODO: Count how many objects have that prefix
    # YOUR CODE HERE


    echo ""

    # ========================================
    # STEP 4: Download File
    # ========================================
    echo "📥 Step 4: Downloading file for local analysis..."

    # TODO: Download one of the uploaded files
    # YOUR CODE HERE


    echo ""

    # ========================================
    # STEP 5: Copy between Buckets (Raw → Processed)
    # ========================================
    echo "🔄 Step 5: Copying file from raw to processed bucket..."

    # TODO: Copy a file from RAW_BUCKET to PROCESSED_BUCKET
    # In a real pipeline, there would be data transformation here
    # YOUR CODE HERE


    echo ""

    # ========================================
    # STEP 6: Get Metadata
    # ========================================
    echo "🔍 Step 6: Getting object metadata..."

    # TODO: Get metadata of one of the objects
    # YOUR CODE HERE


    echo ""

    # ========================================
    # STEP 7: Cleanup (Optional)
    # ========================================
    echo "🗑️  Step 7: Cleanup..."
    read -p "Do you want to delete all buckets and data? (y/N) " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # TODO: Delete all objects and buckets
        # YOUR CODE HERE


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

# Run main
main

exit 0
