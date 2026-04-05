# Обязательный интерфейс модуля (без привязки к окружению)

variable "cores" {
  description = "Количество ядер (vCPU)"
  type        = number
}

variable "memory_gb" {
  description = "Объём RAM в гигабайтах"
  type        = number
}

variable "disk_size_gb" {
  description = "Размер подключаемого диска в гигабайтах"
  type        = number
}

variable "subnet_id" {
  description = "Идентификатор подсети для сетевого интерфейса ВМ"
  type        = string
}

variable "ssh_public_key" {
  description = "Публичный SSH-ключ для доступа к ВМ"
  type        = string
  sensitive   = true
}

# Дополнительные параметры инфраструктуры (не «окружение», а технические идентификаторы)

variable "name" {
  description = "Имя виртуальной машины и префикс имени диска"
  type        = string
}

variable "zone" {
  description = "Зона доступности (должна соответствовать зоне подсети)"
  type        = string
}

variable "image_id" {
  description = "Идентификатор образа ОС для загрузочного диска"
  type        = string
}

variable "boot_disk_size_gb" {
  description = "Размер загрузочного диска в гигабайтах"
  type        = number
  default     = 20
}

variable "platform_id" {
  description = "Платформа вычислительных ресурсов"
  type        = string
  default     = "standard-v3"
}

variable "enable_nat" {
  description = "Назначить публичный IPv4 (NAT)"
  type        = bool
  default     = true
}

variable "ssh_user" {
  description = "Имя пользователя в metadata ssh-keys"
  type        = string
  default     = "ubuntu"
}

variable "labels" {
  description = "Метки для ВМ и диска (передаются из корня окружения)"
  type        = map(string)
  default     = {}
}
