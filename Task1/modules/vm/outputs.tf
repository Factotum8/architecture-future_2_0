output "vm_id" {
  description = "Идентификатор виртуальной машины"
  value       = yandex_compute_instance.this.id
}

output "vm_name" {
  description = "Имя виртуальной машины"
  value       = yandex_compute_instance.this.name
}

output "internal_ip" {
  description = "Внутренний IP-адрес"
  value       = yandex_compute_instance.this.network_interface[0].ip_address
}

output "external_ip" {
  description = "Публичный IP (NAT), если включён enable_nat"
  value       = yandex_compute_instance.this.network_interface[0].nat_ip_address
}

output "boot_disk_id" {
  description = "Идентификатор загрузочного диска"
  value       = yandex_compute_instance.this.boot_disk[0].disk_id
}

output "attached_disk_id" {
  description = "Идентификатор подключаемого диска"
  value       = yandex_compute_disk.attached.id
}

output "attached_disk_name" {
  description = "Имя подключаемого диска"
  value       = yandex_compute_disk.attached.name
}

output "fqdn" {
  description = "FQDN виртуальной машины"
  value       = yandex_compute_instance.this.fqdn
}
