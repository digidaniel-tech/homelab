resource "proxmox_vm_qemu" "proxmox_vm_module" {
  count = var.vm_count

  vmid = var.vm_id
  name = var.vm_name
  desc = var.vm_desc
  agent = 1
  tags = var.vm_tags
  bios = "ovmf"
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

  efidisk {
    efitype = "4m"
    storage = "local-lvm"
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

  provisioner "remote-exec" {
    inline = var.ssh_pub_key != "" ? [
      "mkdir -p ~/.ssh",
      "echo ${var.ssh_pub_key} >> ~/.ssh/authorized_keys",
      "chmod 700 ~/.ssh",
      "chmod 600 ~/.ssh/authorized_keys"
    ] : []

    connection {
      type        = "ssh"
      user        = "daniel"
      password    = "${ var.ssh_default_password }"
      host        = self.default_ipv4_address
      timeout     = "2m"
    }
  }
}
