# Progressive Hints - Exercise 01

**Instructions:** Only read the hint level you need. Try to solve it with Level 1 first. If you're still stuck, move on to the next level.

---

## 🟢 LEVEL 1: Conceptual Hints (Start here)

### Hint 1.1: Initial Setup

Can't connect to LocalStack?

**Check:**
```bash
# Is LocalStack running?
docker ps | grep localstack

# Can you reach the endpoint?
curl http://localhost:4566

# Do you have credentials configured?
aws configure list
```

**Common issue:**
If you see "Unable to locate credentials", configure dummy credentials:
```bash
aws configure
# Access Key: test
# Secret Key: test
# Region: us-east-1
```

### Hint 1.2: Create Bucket

Think about the command structure:

```
aws s3 mb s3://[BUCKET_NAME] --endpoint-url=[ENDPOINT]
```

- `mb` = Make Bucket
- You need to pass the LocalStack endpoint
- The bucket name must match the variables defined above

### Hint 1.3: Upload Files

Command structure:

```
aws s3 cp [LOCAL_FILE] s3://[BUCKET]/[KEY] --endpoint-url=[ENDPOINT]
```

**Remember:** The KEY is the FULL path of the object in S3, including "folders":

```
source=app-logs/year=2024/month=01/day=15/filename.json
```

### Hint 1.4: List with Prefix

To list objects, you have two options:

```bash
# Option 1: List as "folders"
aws s3 ls s3://bucket/prefix/

# Option 2: List recursively (shows all files)
aws s3 ls s3://bucket/prefix/ --recursive
```

To filter only app-logs, use the correct prefix: `source=app-logs`

---

## 🟡 LEVEL 2: Technical Hints (If Level 1 wasn't enough)

### Hint 2.1: Complete create_bucket Function

```bash
create_bucket() {
    local bucket_name=$1

    log_info "Creating bucket: $bucket_name"

    aws s3 mb "s3://$bucket_name" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION"

    # ... rest of the code
}
```

**Note:** The quotes around `"$bucket_name"` are important to handle spaces (although there shouldn't be spaces in bucket names).

### Hint 2.2: upload_file Function with Metadata

```bash
upload_file() {
    local local_file=$1
    local bucket=$2
    local s3_key=$3

    log_info "Uploading: $local_file → s3://$bucket/$s3_key"

    # Automatically detect content-type
    aws s3 cp "$local_file" "s3://$bucket/$s3_key" \
        --endpoint-url="$ENDPOINT_URL" \
        --region="$REGION"

    # ... rest of the code
}
```

### Hint 2.3: list_objects Function

```bash
list_objects() {
    local bucket=$1
    local prefix=$2

    log_info "Listing objects in s3://$bucket/ with prefix: '$prefix'"

    if [ -z "$prefix" ]; then
        # No prefix: list everything
        aws s3 ls "s3://$bucket/" \
            --endpoint-url="$ENDPOINT_URL" \
            --recursive
    else
        # With prefix: list only that "directory"
        aws s3 ls "s3://$bucket/$prefix" \
            --endpoint-url="$ENDPOINT_URL" \
            --recursive
    fi
}
```

### Hint 2.4: copy_object Function

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

    # ... rest of the code
}
```

**Note:** `aws s3 cp` works for local→S3, S3→local, and S3→S3.

### Hint 2.5: get_object_metadata Function

For metadata, you need to use `s3api` (not `s3`):

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

**Important difference:**
- `aws s3`: High-level commands (cp, ls, rm, sync)
- `aws s3api`: Low-level API with more options (head-object, put-object, get-bucket-policy, etc.)

---

## 🔴 LEVEL 3: Partial Solution (Last resort)

### Hint 3.1: Main Function - Complete Step 2

```bash
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
```

### Hint 3.2: Main Function - Complete Step 3

```bash
# ========================================
# STEP 3: List Objects with Prefix
# ========================================
echo "📋 Step 3: Listing objects with specific prefix..."

# List only app-logs
list_objects "$RAW_BUCKET" "source=app-logs"

# Count objects
object_count=$(count_objects "$RAW_BUCKET" "source=app-logs")
log_info "Total objects with prefix 'source=app-logs': $object_count"

echo ""
```

### Hint 3.3: Main Function - Complete Steps 4 and 5

```bash
# ========================================
# STEP 4: Download File
# ========================================
echo "📥 Step 4: Downloading file for local analysis..."

download_file \
    "$RAW_BUCKET" \
    "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json" \
    "$DOWNLOAD_DIR/app-logs-2024-01-15.json"

echo ""

# ========================================
# STEP 5: Copy between Buckets
# ========================================
echo "🔄 Step 5: Copying file from raw to processed bucket..."

copy_object \
    "$RAW_BUCKET" \
    "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json" \
    "$PROCESSED_BUCKET" \
    "processed/app-logs/2024-01-15.json"

echo ""
```

### Hint 3.4: count_objects Function

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

**Pipe explanation:**
- `aws s3 ls ... --recursive`: Lists all files
- `|`: Passes output to the next command
- `wc -l`: Counts lines (each file is one line)

### Hint 3.5: delete_all_objects and delete_bucket Functions

```bash
delete_all_objects() {
    local bucket=$1

    log_warning "Deleting all objects from: $bucket"

    aws s3 rm "s3://$bucket/" \
        --endpoint-url="$ENDPOINT_URL" \
        --recursive

    # ... rest of the code
}

delete_bucket() {
    local bucket=$1

    log_warning "Deleting bucket: $bucket"

    # Option 1: Bucket already empty
    aws s3 rb "s3://$bucket/" \
        --endpoint-url="$ENDPOINT_URL"

    # Option 2: Force deletion with objects
    # aws s3 rb "s3://$bucket/" \
    #     --endpoint-url="$ENDPOINT_URL" \
    #     --force

    # ... rest of the code
}
```

---

## 💡 Additional Tips

### Debug Mode

If something isn't working, enable debug:

```bash
# At the beginning of your script
set -x  # Shows each command before executing it

# Or run like this
bash -x s3_operations.sh
```

### Check What Exists in LocalStack

```bash
# List all buckets
aws --endpoint-url=http://localhost:4566 s3 ls

# View full contents of a bucket
aws --endpoint-url=http://localhost:4566 s3 ls s3://my-data-lake-raw --recursive

# View metadata
aws --endpoint-url=http://localhost:4566 s3api head-object \
    --bucket my-data-lake-raw \
    --key "source=app-logs/year=2024/month=01/day=15/app-logs-2024-01-15.json"
```

### Reset Everything and Start Fresh

```bash
# Delete all buckets and their contents
aws --endpoint-url=http://localhost:4566 s3 rb s3://my-data-lake-raw --force
aws --endpoint-url=http://localhost:4566 s3 rb s3://my-data-lake-processed --force

# Or restart LocalStack
docker restart localstack_main
```

---

## 🎯 Troubleshooting Checklist

If your script doesn't work, check:

- [ ] LocalStack is running: `docker ps`
- [ ] Correct endpoint in script: `http://localhost:4566`
- [ ] AWS CLI configured: `aws configure list`
- [ ] Environment variables loaded: `echo $AWS_ENDPOINT_URL`
- [ ] Script has execution permissions: `chmod +x s3_operations.sh`
- [ ] Correct paths to test_data: `ls -la test_data/`
- [ ] No typos in bucket names
- [ ] Quotes properly closed in commands

---

## 🤔 Reflection Questions

After completing the exercise, answer:

1. **What happens if you run the script twice?**
   - Does it fail when creating buckets that already exist?
   - Does it overwrite files in S3?
   - How would you make it idempotent?

2. **How would you optimize uploading 1000 files?**
   - `aws s3 cp` in a loop is slow
   - Investigate: `aws s3 sync`
   - Or: Use `--include` and `--exclude` patterns

3. **Why do we use partitioning with year/month/day?**
   - Think about queries: "Give me data from January 2024"
   - Without partitions: Scans EVERYTHING
   - With partitions: Only reads folder `year=2024/month=01/`

4. **When would you use `s3api` instead of `s3`?**
   - `s3`: Simple operations (copy, move, delete)
   - `s3api`: Advanced configuration (policies, lifecycle, versioning, metadata)

---

## 📚 Useful Resources During the Exercise

- **AWS CLI S3 Reference**: `aws s3 help`
- **AWS CLI S3API Reference**: `aws s3api help`
- **LocalStack S3 Docs**: https://docs.localstack.cloud/user-guide/aws/s3/
- **Bash Scripting Guide**: https://www.gnu.org/software/bash/manual/

---

**Remember:** The goal is to **learn**, not just complete the exercise. If you need to look at the full solution, do it, but make sure you understand every line.

You've got this! 💪
