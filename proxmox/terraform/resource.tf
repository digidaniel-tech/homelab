resource "proxmox_vm_qemu" "proxmox_vm_resource" {
  # just want 1 for now, set to 0 and apply to destroy VM
  count = 1

  name = "${var.vm_name}-${count.index + 1}"
  desc = "Generated vm by terraform"
  agent = 1
  tags = var.vm_tags

  qemu_os = "l26"  # default other
  iso = var.iso_name
  target_node = var.proxmox_host

  full_clone = false

  # -- boot process
  onboot = true
  automatic_reboot = false  # refuse auto-reboot when changing a setting

  sockets = 1
  cores = 2
  memory = 2048

  bootdisk = "scsi0"
  scsihw = "virtio-scsi-pci"

  disks {
    scsi {
      scsi0 {
        disk {
          size = 32
          storage = var.storage_name
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
      disk,
      vm_state,
      network,
    ]
  }
}