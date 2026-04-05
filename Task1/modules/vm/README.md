# Terraform: ВМ в Yandex Cloud

- **`main.tf`** — диск + виртуалка + сеть.
- **`variables.tf`** — всё, что подаётся из `envs/*/terraform.tfvars` (в т.ч. ядра, RAM, второй диск, `subnet_id`, SSH, `cloud_id` / `folder_id` для провайдера).
- **`outputs.tf`** — id, IP, диски, fqdn.
- **`provider.tf`**, **`versions.tf`**.

Окружения (`dev` / `stage` / `prod`)

## Как запускать на примере DEV

```bash
cd Task1/modules/vm
terraform init
terraform plan  -var-file=../envs/dev/terraform.tfvars    -state=terraform-dev.tfstate
terraform apply -var-file=../envs/dev/terraform.tfvars    -state=terraform-dev.tfstate
```

Для stage/prod — другой `-var-file` и свой `-state=...`, чтобы не смешивать state.
