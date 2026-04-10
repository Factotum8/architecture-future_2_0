"""
Создаёт bucket в S3-совместимом MinIO, если его ещё нет.
"""

import os

import boto3
from botocore.exceptions import ClientError


def main() -> int:
    endpoint = os.environ.get("MINIO_ENDPOINT", "http://127.0.0.1:9000").rstrip("/")
    access = os.environ.get("MINIO_ACCESS_KEY", "minioadmin")
    secret = os.environ.get("MINIO_SECRET_KEY", "minioadmin")
    bucket = os.environ.get("TERRAFORM_STATE_BUCKET", "terraform-state")

    client = boto3.client(
        "s3",
        endpoint_url=endpoint,
        aws_access_key_id=access,
        aws_secret_access_key=secret,
        region_name="us-east-1",
    )

    try:
        client.head_bucket(Bucket=bucket)
        print(f"Bucket {bucket!r} уже есть.")
        return 0
    except ClientError as e:
        code = e.response.get("Error", {}).get("Code", "")
        if code not in ("404", "NoSuchBucket", "NotFound"):
            raise

    print(f"Создаю bucket {bucket!r} на {endpoint} …")
    client.create_bucket(Bucket=bucket)
    print("Готово.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
