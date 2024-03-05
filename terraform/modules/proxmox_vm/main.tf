terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

resource "proxmox_vm_qemu" "proxmox_vm_module" {
  count = var.vm_count

  vmid = var.vm_id
  name = var.vm_name
  desc = var.vm_desc
  agent = 1
  tags = var.vm_tags
  bios = var.vm_bios
  machine = "q35"

  qemu_os = "l26"
  iso = var.vm_iso
  target_node = var.vm_host

  full_clone = false

  onboot = true
  automatic_reboot = false

  sockets = 1
  cores = var.vm_cores
  memory = var.vm_ram

  scsihw = "virtio-scsi-single"

  dynamic "efidisk" {
    for_each = var.vm_bios == "ovmf" ? [1] : []

    content {
      efitype = "4m"
      storage = var.vm_disk_storage
    }
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size = var.vm_disk_size
          storage = var.vm_disk_storage
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
