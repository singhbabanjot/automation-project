 # Resource group
 output "rg-n01580452-name" {
   value = module.rgroup-n01580452.rg-n01580452-info.name
 }
 # Network resources
 output "n01580452-VNET-name" {
   value = module.network-n01580452.n01580452-VNET-name
 }
 output "n01580452-SUBNET" {
   value = module.network-n01580452.n01580452-SUBNET
 }
 # Common resources
 output "log_analytics_workspace-name" {
   value = module.common-n01580452.log_analytics_workspace-name
 }
 output "recovery_services_vault-name" {
   value = module.common-n01580452.recovery_services_vault-name
 }
 output "storage_account-name" {
   value = module.common-n01580452.storage_account-name
 }
 # Virtual Machine: Linux resources
 output "n01580452-vmlinux-hostname" {
   value = module.vmlinux-n01580452.n01580452-vmlinux
 }
 output "n01580452-vmlinux-FQDN" {
   value = module.vmlinux-n01580452.n01580452-vmlinux-FQDN
 }
 output "n01580452-vmlinux-private-ip" {
   value = module.vmlinux-n01580452.n01580452-vmlinux-private-ip
 }
 output "n01580452-vmlinux-public-ip" {
   value = module.vmlinux-n01580452.n01580452-vmlinux-public-ip
 }
 # Virtual Machine: Windows resources
 output "n01580452-vmwindows-hostname" {
   value = module.vmwindows-n01580452.n01580452-vmwindows
 }
 output "n01580452-vmwindows-FQDN" {
   value = module.vmwindows-n01580452.n01580452-vmwindows-FQDN
 }
 output "n01580452-vmwindows-private-ip" {
   value = module.vmwindows-n01580452.n01580452-vmwindows-private-ip
 }
 output "n01580452-vmwindows-public-ip" {
   value = module.vmwindows-n01580452.n01580452-vmwindows-public-ip
 }
 # loadbalancer
 output "n01580452-loadbalancer-name" {
   value = module.loadbalancer-n01580452.n01580452-loadbalancer-name
 }
 # Database
 output "n01580452-database" {
   value = module.database-n01580452.n01580452-database-name
 }