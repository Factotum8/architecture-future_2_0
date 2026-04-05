output "vm_id" {
  description = "Идентификатор ВМ"
  value       = module.vm_module.vm_id
}

output "vm_name" {
  description = "Имя ВМ"
  value       = module.vm_module.vm_name
}

output "internal_ip" {
  description = "Внутренний IP"
  value       = module.vm_module.internal_ip
}

output "external_ip" {
  description = "Публичный IP (NAT)"
  value       = module.vm_module.external_ip
}

output "attached_disk_id" {
  description = "ID подключаемого диска"
  value       = module.vm_module.attached_disk_id
}

output "boot_disk_id" {
  description = "ID загрузочного диска"
  value       = module.vm_module.boot_disk_id
}
