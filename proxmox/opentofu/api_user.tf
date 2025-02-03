variable "host" {
  type = string
}

variable "username" {
  type = string
  default = "apiuser"
}

variable "ssh_user" {
  type = string
  default = "root"
}

variable "ssh_private_key" {
  type = string
  default = "~/.ssh/id_rsa"
}

resource "terraform_data" "apiuser" {
  input = {
    username = var.username
    host = var.host
    ssh_user = var.ssh_user
    ssh_private_key = var.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      # Create API-user
      "pveum useradd ${self.input.username}@pve --comment 'API user for OpenTofu' || exit 1",
      # Create API-token for the api user
      "secret=$(pveum user token add ${self.input.username}@pve terraform-token --comment 'Token for OpenTofu' | grep -Eo '[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}') && echo \"Token Secret: $${secret}\" || exit 1",
      # Adds role to user
      "pveum acl modify / --users ${self.input.username}@pve --roles PVEAdmin || exit 1"
    ]

    connection {
      type        = "ssh"
      host        = self.input.host
      user        = self.input.ssh_user
      private_key = file(self.input.ssh_private_key)
    }
  }

  provisioner "remote-exec" {
    when    = destroy
    inline  = [
      "pveum user delete ${self.input.username}@pve"
    ]
    connection {
      type        = "ssh"
      host        = self.input.host
      user        = self.input.ssh_user
      private_key = file(self.input.ssh_private_key)
    }
  }
}
