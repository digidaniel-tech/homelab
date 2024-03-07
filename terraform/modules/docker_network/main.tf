resource "docker_network" "network" {
  name = var.network_name
  check_duplicate = true
  internal = var.network_interal
}