resource "proxmox_vm_qemu" "_101_ghr_prod_resource" {
  count = 1

  name = "github-runner"
  desc = "Responsible to run github workflows locally"
  agent = 1
  tags = "github"

  qemu_os = "l26"
  iso = "local:iso/debian-12-unattended.iso"
  target_node = var.PRX_HOST

  full_clone = false

  onboot = true
  automatic_reboot = false

  sockets = 1
  cores = 2
  memory = 2048

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
      "echo ${var.ssh_pub_key} >> ~/.ssh/authorized_keys",
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