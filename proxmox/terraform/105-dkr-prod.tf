resource "proxmox_vm_qemu" "_105_dkr_prod_resource" {
  count = 1
  
  name = "Docker"
  desc = "Docker instance to run containers from"
  agent = 1
  tags = "docker, proxy"
  bios = "seabios"
  machine = "pc"

  qemu_os = "l26"
  iso = "local:iso/debian-12-unattended.iso"
  target_node = var.PRX_HOST

  full_clone = false

  onboot = true
  automatic_reboot = false

  sockets = 1
  cores = 2
  memory = 2048

  scsihw = "virtio-scsi-single"

  disks {
    scsi {
      scsi0 {
        disk {
          size = 50
          storage = var.PRX_STORAGE_NAME
        }
      }
    }
  }
  
  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      disks,
      vm_state,
      network,
    ]
  }
}