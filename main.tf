# Resource group module
module "rgroup-n01580452" {
  source = "./modules/rgroup-N01580452"

  tags = local.common_tags

  rg-n01580452-info = {
    name     = "n01580452-RG"
    location = "centralindia"
  }
}

# Network module
module "network-n01580452" {
  source = "./modules/network-n01580452"

  tags = local.common_tags

  VNET-n01580452-info = {
    name                = "n01580452-VNET"
    resource_group_name = module.rgroup-n01580452.rg-n01580452-info.name
    location            = module.rgroup-n01580452.rg-n01580452-info.location
  }
  VNET-n01580452-address_space = ["10.0.0.0/16"]

  SUBNET-n01580452-info = {
    name = "n01580452-SUBNET"
  }
  SUBNET-n01580452-address_prefixes = ["10.0.0.0/24"]
}

 # Common module
 module "common-n01580452" {
   source = "./modules/common-n01580452"
   tags = local.common_tags
   rg-info = {
     name     = module.rgroup-n01580452.rg-n01580452-info.name
     location = module.rgroup-n01580452.rg-n01580452-info.location
   }
   log_analytics_workspace-info = {
     name              = "n01580452-log-analytics-workspace"
     sku               = "PerGB2018"
     retention_in_days = 30
   }
   recovery_services_vault-info = {
     name             = "n01580452-recovery-services-vault"
     sku              = "Standard"
     soft_delete_mode = true
   }
   storage_account-info = {
     name                     = "n01580452storageaccount"
     account_tier             = "Standard"
     account_replication_type = "LRS"
   }
 }

# Linux VM module
module "vmlinux-n01580452" {
  source = "./modules/vmlinux-n01580452"

  tags = local.common_tags

  rg-info = {
    name     = module.rgroup-n01580452.rg-n01580452-info.name
    location = module.rgroup-n01580452.rg-n01580452-info.location
  }

  instance_count = 3

  n01580452-vmlinux-info = {
    name          = "n01580452-linux"
    computer_name = "n01580452-computer_name"
    size          = "Standard_B1s"

    storage_account_uri = module.common-n01580452.storage_account-primary_blob_endpoint

    admin_ssh_key = {
      admin_username = "n01580452-BabanjotSingh"
      public_key     = "~/.ssh/id_rsa.pub"
    }

    private_key = "~/.ssh/id_rsa"

    os_disk = {
      storage_account_type = "Standard_LRS"
      disk_size_gb         = "32"
      caching              = "ReadWrite"
    }

    source_image_reference = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_2"
      version   = "latest"
    }
  }

  n01580452-vmlinux-avs-info = {
    name                         = "n01580452-linux-avs"
    platform_update_domain_count = "4"
    platform_fault_domain_count  = "2"
  }

  n01580452-vmlinux-nic = {
    ip_configuration = {
      subnet_id                     = module.network-n01580452.n01580452-SUBNET.id
      private_ip_address_allocation = "Dynamic"
    }
  }

  n01580452-vmlinux-pip = {
    allocation_method       = "Dynamic"
    idle_timeout_in_minutes = "30"
  }

  n01580452-vmlinux-network-watcher = {
    publisher                  = "Microsoft.Azure.NetworkWatcher"
    type                       = "NetworkWatcherAgentLinux"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
        {}
    SETTINGS
  }

  n01580452-vmlinux-network-monitor = {
    publisher                  = "Microsoft.Azure.Monitor"
    type                       = "AzureMonitorLinuxAgent"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
      {}
  SETTINGS

  }
}


 # Windows VM module
 module "vmwindows-n01580452" {
   source = "./modules/vmwindows-n01580452"
   tags = local.common_tags
   rg-info = {
     name     = module.rgroup-n01580452.rg-n01580452-info.name
     location = module.rgroup-n01580452.rg-n01580452-info.location
   }
   instance_count = 1
   n01580452-vmwindows-info = {
     name           = "n01580452-win"
     computer_name  = "n01580452"
     size           = "Standard_B1s"
     admin_username = "n01580452-babanjot"
     admin_password = "admin@123"
     winrm_listener_protocol = "Http"
     storage_account_uri = module.common-n01580452.storage_account-primary_blob_endpoint
     os_disk = {
       storage_account_type = "StandardSSD_LRS"
       disk_size_gb         = "128"
       caching              = "ReadWrite"
     }
     source_image_reference = {
       publisher = "MicrosoftWindowsServer"
       offer     = "WindowsServer"
       sku       = "2016-Datacenter"
       version   = "latest"
     }
   }
   n01580452-vmwindows-avs-info = {
     platform_update_domain_count = 1
     platform_fault_domain_count  = 1
   }
   n01580452-vmwindows-nic = {
     ip_configuration = {
       subnet_id                     = module.network-n01580452.n01580452-SUBNET.id
       private_ip_address_allocation = "Dynamic"
     }
   }
   n01580452-vmwindows-pip = {
     allocation_method       = "Dynamic"
     idle_timeout_in_minutes = 30
   }
   n01580452-vmwindows-antimalware = {
     publisher                  = "Microsoft.Azure.Security"
     type                       = "IaaSAntimalware"
     type_handler_version       = "1.3"
     auto_upgrade_minor_version = "true"
     settings = <<SETTINGS
         {}
     SETTINGS
   }
 }
 # Datadisks for VMs
 module "datadisk-n01580452" {
   source = "./modules/datadisk-n01580452"
   tags = local.common_tags
   rg-info = {
     name     = module.rgroup-n01580452.rg-n01580452-info.name
     location = module.rgroup-n01580452.rg-n01580452-info.location
   }
   n01580452-vmlinux-datadisk-info = {
     n01580452-vmlinux-names = module.vmlinux-n01580452.n01580452-vmlinux.hostnames
     total-vms               = 3
     storage_account_type    = "Standard_LRS"
     create_option           = "Empty"
     disk_size_gb            = 10
   }
   n01580452-vmlinux-datadisk-attachment-info = {
     virtual_machine_ids = module.vmlinux-n01580452.n01580452-vmlinux.ids
     lun                 = "0"
     caching             = "ReadWrite"
   }
   n01580452-vmwindows-datadisk-info = {
     n01580452-vmwindows-names = module.vmwindows-n01580452.n01580452-vmwindows.hostnames
     total-vms                 = 1
     storage_account_type      = "Standard_LRS"
     create_option             = "Empty"
     disk_size_gb              = 10
   }
   n01580452-vmwindows-datadisk-attachment-info = {
     virtual_machine_ids = module.vmwindows-n01580452.n01580452-vmwindows.ids
     lun                 = "0"
     caching             = "ReadWrite"
   }
 }
 # Loadbalancer module
 module "loadbalancer-n01580452" {
   source = "./modules/loadbalancer-n01580452"
   tags = local.common_tags
   rg-info = {
     name     = module.rgroup-n01580452.rg-n01580452-info.name
     location = module.rgroup-n01580452.rg-n01580452-info.location
   }
   n01580452-loadbalancer-name = "n01580452-loadbalancer"
   allocation_method           = "Dynamic"
   n01580452-loadbalancer-nic-backend_pool_association-info = {
     count     = 3
     hostnames = module.vmlinux-n01580452.n01580452-vmlinux.hostnames
     nic_ids   = module.vmlinux-n01580452.nic_id
   }
   n01580452-loadbalancer-rules = {
     name                           = "n01580452-loadbalancer-rules"
     protocol                       = "Tcp"
     frontend_port                  = "22"
     backend_port                   = "22"
     frontend_ip_configuration_name = "PublicIPAddress"
   }
 }
 # Database module
 module "database-n01580452" {
   source = "./modules/database-n01580452"
   rg-info = {
     name     = module.rgroup-n01580452.rg-n01580452-info.name
     location = module.rgroup-n01580452.rg-n01580452-info.location
   }
   n01580452-database-server-info = {
     sku_name = "B_Gen5_2"
     storage_mb                   = "5120"
     backup_retention_days        = "7"
     geo_redundant_backup_enabled = "false"
     auto_grow_enabled            = "true"
     administrator_login          = "psqladmin"
     administrator_login_password = "n01580452PSQL@"
     version                      = "9.5"
     ssl_enforcement_enabled      = "true"
   }
   n01580452-database-info = {
     name      = "n01580452-database"
     charset   = "UTF8"
     collation = "English_United States.1252"
   }
 }