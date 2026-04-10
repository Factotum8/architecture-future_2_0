#!/usr/bin/env bash
# Генерирует /tmp/backend.hcl для terraform init (MinIO.

set -euo pipefail

OUT="${BACKEND_HCL_PATH:-/tmp/backend.hcl}"
ENDPOINT="${MINIO_ENDPOINT:-http://127.0.0.1:9000}"
BUCKET="${TERRAFORM_STATE_BUCKET:-terraform-state}"
KEY="${TERRAFORM_STATE_KEY:-task2/terraform.tfstate}"

cat > "${OUT}" <<EOF
bucket = "${BUCKET}"
key    = "${KEY}"
region = "us-east-1"

endpoint = "${ENDPOINT}"

skip_credentials_validation = true
skip_region_validation      = true
skip_requesting_account_id  = true
skip_metadata_api_check     = true
use_path_style              = true
EOF

echo "Записан backend-конфиг: ${OUT}"
