resource "docker_container" "container" {
  count = var.container_disabled ? 0 : 1
  image = var.container_image
  name  = var.container_name
  restart = var.container_restart

  security_opts = var.security_opts

  env = var.container_env

  dynamic "ports" {
    for_each = var.port_mappings

    content {
      internal = ports.value.internal
      external = ports.value.external
      ip = ports.value.ip
      protocol = ports.value.protocol
    }
  }

  dynamic "volumes" {
    for_each = var.volume_mappings

    content {
      container_path = volumes.value.container_path
      host_path = volumes.value.host_path
      read_only = volumes.value.read_only
      volume_name = volumes.value.volume_name
      from_container = volumes.value.from_container
    }
  }

  dynamic "networks_advanced" {
    for_each = var.network_configurations

    content {
      name = networks_advanced.value.name
    }
  }

  dynamic "labels" {
    for_each = var.label_mappings

    content {
      label = labels.key
      value = labels.value
    }
  }

  dynamic "upload" {
    for_each = var.copy_files

    content {
      file = upload.value.file
      source = upload.value.source
    }
  }
  
  command = var.container_commands
}