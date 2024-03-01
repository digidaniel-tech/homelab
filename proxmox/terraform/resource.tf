resource "proxmox_vm_qemu" "proxmox_vm_resource" {
  # This is to make it possible to update existing VM's
  vmid = var.PRX_VM_ID
  count = var.PRX_VM_COUNT

  name = "${var.PRX_VM_NAME}-${count.index + 1}"
  desc = "Generated vm by terraform"
  agent = 1
  tags = var.PRX_VM_TAGS

  qemu_os = "l26"  # default other
  iso = var.PRX_ISO_NAME
  target_node = var.PRX_HOST

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
      disk,
      vm_state,
      network,
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ssh",
      "cat ${var.ssh_private_key_path} >> ~/.ssh/authorized_keys",
      "chmod 700 ~/.ssh",
      "chmod 600 ~/.ssh/authorized_keys"
    ]

    connection {
      type        = "ssh"
      user        = "daniel"
      password    = "${ var.ssh_default_password }"
      host        = self.default_ipv4_address
      timeout     = "2m"
    }
  }
}
