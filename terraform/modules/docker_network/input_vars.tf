variable "network_name" {
  description = "The name of the Docker network"
  type = string
}

variable "network_interal" {
  description = "Is the network of the Docker internal?"
  type = bool
  default = true
}