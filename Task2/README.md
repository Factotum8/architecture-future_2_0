# Terraform + MinIO (S3 backend) + GitLab CI

Инфраструктурный код с **удалённым state** в **S3-совместимом MinIO**, локальный запуск через **Docker Compose**, вспомогательные **скрипты** и **`.gitlab-ci.yml`** для `terraform init` / `plan` / `apply` (apply — вручную).

---

## Структура каталога

| Путь                               | Назначение                                                                                      |
|------------------------------------|-------------------------------------------------------------------------------------------------|
| `terraform/`                       | Корень Terraform: ВМ в Yandex Cloud, блок `backend "s3" {}` (параметры через `-backend-config`) |
| `config/backend.local.hcl.example` | Пример файла для `terraform init -backend-config=...` под локальный MinIO                       |
| `envs/dev/terraform.tfvars`        | Переменные окружения (YC + параметры ВМ)                                                        |
| `docker-compose.yml`               | Подъём MinIO локально                                                                           |
| `scripts/`                         | Скрипты — см. раздел ниже                                                                       |
| `.gitlab-ci.yml`                   | Pipeline GitLab: validate → plan → ручной apply                                                 |
| `.gitignore`                       | Игнор state, локального `backend.local.hcl`, `.terraform/`                                      |

В **корне репозитория** лежит `.gitlab-ci.yml`, который подключает этот файл: `include: local: Task2/.gitlab-ci.yml`.

---

## Скрипты (`scripts/`)

### 1. `ensure_bucket.py`
Скрипт подключается к MinIO по **S3 API** (через `boto3`) и, если bucket ещё нет, создаёт его.

### 2. `write_backend_hcl.sh`

Скрипт **генерирует** HCL-файл (по умолчанию `/tmp/backend.hcl`), чтобы не править вручную endpoint и путь к state при каждом запуске

### `docker-compose.yml`

Сервис **MinIO** на портах **9000** (API) и **9001** (консоль). Учётные данные по умолчанию: `minioadmin` / `minioadmin` для локальных тестов

### Переменные для Terraform S3 backend (MinIO)

Terraform использует **AWS SDK** для backend `s3`. Для MinIO задают:

- `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` — те же значения, что логин/пароль MinIO (в CI в `.gitlab-ci.yml` привязаны к `MINIO_ROOT_USER` / `MINIO_ROOT_PASSWORD`).

---

## GitLab CI: как используются скрипты

| Джоб | Скрипты | Что происходит |
|------|---------|----------------|
| `terraform_validate` | Нет | `terraform init -backend=false` — без MinIO, только проверка кода |
| `terraform_plan` | `write_backend_hcl.sh` | Генерация `/tmp/backend.hcl`, `init` с backend, `plan` с `tfplan` |
| `terraform_apply` | `write_backend_hcl.sh` | Повторный `init` (артефакт плана), `apply tfplan` по кнопке **Play** |

`ensure_bucket.py` в пайплайне **не вызывается автоматически** — bucket в MinIO должен быть создан заранее (один раз на окружение: вручную, отдельным job или вне Kubernetes/GitLab). Скрипт документирован для локальной подготовки и повторения в других средах.

**Обязательные переменные в GitLab CI/CD:**

- `YC_TOKEN` — доступ к Yandex Cloud для провайдера (план/апплай инфраструктуры ВМ).
- `MINIO_ENDPOINT` — доступный из раннера URL MinIO.
- `MINIO_ROOT_USER` / `MINIO_ROOT_PASSWORD` — ключи MinIO (или дефолт `minioadmin`, если так настроено).

---

## Запуск

1. `docker compose up -d`
2. `pip install -r scripts/requirements.txt` → `python scripts/ensure_bucket.py`.
3. `cp config/backend.local.hcl.example config/backend.local.hcl`
4. `export YC_TOKEN=foo_bar`  
5. `export AWS_ACCESS_KEY_ID=minioadmin` 
6. `export AWS_SECRET_ACCESS_KEY=minioadmin`
5. `cd terraform && terraform init -backend-config=../config/backend.local.hcl`
6. `terraform plan -var-file=../envs/dev/terraform.tfvars`
7. `terraform apply -var-file=../envs/dev/terraform.tfvars`
