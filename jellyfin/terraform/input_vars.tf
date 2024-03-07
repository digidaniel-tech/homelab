variable "SSH_USER" {
  description = "The SSH user that is used to connect to docker vm"
  type = string
}

variable "SSH_IP" {
  description = "The SSH ip that is used to connect to docker vm"
  type = string
}

variable "SSH_PORT" {
  description = "The SSH port that is used to connect to docker vm"
  type = number
  default = 22
}