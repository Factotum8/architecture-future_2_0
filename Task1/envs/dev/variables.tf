variable "cloud_id" {
  description = "Идентификатор облака Yandex Cloud"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор каталога Yandex Cloud"
  type        = string
}

variable "zone" {
  description = "Зона по умолчанию для провайдера и ресурсов"
  type        = string
}

variable "vm_name" {
  description = "Имя виртуальной машины"
  type        = string
}

variable "cores" {
  description = "Количество ядер (vCPU)"
  type        = number
}

variable "memory_gb" {
  description = "Объём RAM (ГБ)"
  type        = number
}

variable "disk_size_gb" {
  description = "Размер подключаемого диска (ГБ)"
  type        = number
}

variable "subnet_id" {
  description = "Идентификатор подсети"
  type        = string
}

variable "ssh_public_key" {
  description = "Публичный SSH-ключ"
  type        = string
  sensitive   = true
}

variable "image_id" {
  description = "Идентификатор образа ОС"
  type        = string
}

variable "boot_disk_size_gb" {
  description = "Размер загрузочного диска (ГБ)"
  type        = number
  default     = 20
}

variable "platform_id" {
  description = "Платформа CPU"
  type        = string
  default     = "standard-v3"
}

variable "enable_nat" {
  description = "Публичный IP (NAT)"
  type        = bool
  default     = true
}

variable "ssh_user" {
  description = "Пользователь для SSH в metadata"
  type        = string
  default     = "ubuntu"
}

variable "labels" {
  description = "Метки ресурсов"
  type        = map(string)
  default     = {}
}
