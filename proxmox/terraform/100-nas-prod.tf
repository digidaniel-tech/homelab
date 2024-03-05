module "_100_nas_prod_resource" {
  source = "../../terraform/modules/proxmox_vm"

  vm_id = 1000
  vm_name = "Truenas"
  vm_desc = "Handles network storage"
  vm_tags = "nas"
  vm_iso = "local:iso/TrueNAS-SCALE-23.10.1.3.iso"
  vm_host = var.PRX_HOST
  vm_bios = "ovmf"

  vm_ram = 6144
  vm_disk_size = 30
}