variable "host" {
  type = string
}

variable "ssh_user" {
  type = string
  default = "root"
}

variable "ssh_private_key" {
  type = string
  default = "~/.ssh/id_rsa"
}

resource "terraform_data" "root-token" {
  input = {
    host = var.host
    ssh_user = var.ssh_user
    ssh_private_key = var.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      # Create API-token for the api user
      "secret=$(pveum user token add root@pam api-token --comment 'API Token for OpenTofu' | grep -Eo '[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}') && echo \"Token Secret: $${secret}\" || exit 1",
      # Setup permissions for token
      "pveum acl modify / --roles PVEAdmin --tokens root@pam!api-token",
    ]

    connection {
      type        = "ssh"
      host        = self.input.host
      user        = self.input.ssh_user
      private_key = file(self.input.ssh_private_key)
    }
  }
}
