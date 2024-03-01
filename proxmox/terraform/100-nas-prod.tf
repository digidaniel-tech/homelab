resource "proxmox_vm_qemu" "_100_nas_prod_resource" {
  count = 1

  # vmid = 100
  name = "Truenas"
  desc = "Responsible to run github workflows locally"
  agent = 1
  tags = "nas"
  bios = "ovmf"
  machine = "q35"

  qemu_os = "l26"
  iso = "local:iso/TrueNAS-SCALE-23.10.1.3.iso"
  target_node = var.PRX_HOST

  full_clone = false

  onboot = true
  automatic_reboot = false

  sockets = 1
  cores = 2
  memory = 6144

  bootdisk = "scsi0"
  scsihw = "virtio-scsi-single"

  efidisk {
    efitype = "4m"
    storage = "local-lvm"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size = 30
          storage = "local-lvm"
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
