# Модуль `vm` (Yandex Compute)

Переиспользуемый Terraform-модуль: виртуальная машина в Yandex Cloud с загрузочным диском, **отдельным подключаемым диском** и сетевым интерфейсом в указанной подсети. Доступ по **SSH** через публичный ключ в `metadata`.

Внутри модуля **нет** захардкоженных имён окружений (`dev` / `stage` / `prod`) — все значения задаются переменными; различия окружений задаются в корне (`envs/*/terraform.tfvars`).

## Параметры (обязательные по заданию)

| Переменная | Описание |
|------------|----------|
| `cores` | Количество ядер (vCPU) |
| `memory_gb` | Объём RAM (ГБ) |
| `disk_size_gb` | Размер **подключаемого** диска (ГБ) |
| `subnet_id` | Идентификатор подсети |
| `ssh_public_key` | Содержимое публичного SSH-ключа |

## Дополнительные параметры

| Переменная | Описание | По умолчанию |
|------------|----------|--------------|
| `name` | Имя ВМ и префикс имени диска | — |
| `zone` | Зона доступности | — |
| `image_id` | ID образа ОС для загрузочного диска | — |
| `boot_disk_size_gb` | Размер загрузочного диска (ГБ) | `20` |
| `platform_id` | Платформа CPU | `standard-v3` |
| `enable_nat` | Публичный IP (NAT) | `true` |
| `ssh_user` | Пользователь в `ssh-keys` | `ubuntu` |
| `labels` | Метки ресурсов | `{}` |

## Выходные значения

| Output | Описание |
|--------|----------|
| `vm_id` | ID виртуальной машины |
| `vm_name` | Имя ВМ |
| `internal_ip` | Внутренний IP в VPC |
| `external_ip` | Публичный IP (если NAT включён) |
| `boot_disk_id` | ID загрузочного диска |
| `attached_disk_id` | ID подключаемого диска |
| `attached_disk_name` | Имя подключаемого диска |
| `fqdn` | FQDN ВМ |

## Запуск по окружениям

Провайдер Yandex Cloud настраивается в каталоге окружения (`cloud_id`, `folder_id`, `zone`). Из корня репозитория:

```bash
# Dev
cd Task1/envs/dev
terraform init
terraform plan  -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars

# Stage
cd ../stage
terraform init
terraform plan  -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars

# Prod
cd ../prod
terraform init
terraform plan  -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Перед применением подставьте в каждый `terraform.tfvars` реальные `cloud_id`, `folder_id`, `subnet_id`, `image_id` и свой `ssh_public_key`.

## Требования

- Terraform `>= 1.3.0`
- Провайдер [`yandex-cloud/yandex`](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) `>= 0.100.0`
