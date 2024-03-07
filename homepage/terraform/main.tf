locals {
  disable = false
  root_path_tmp = "/${replace(abspath(path.root), ":", "")}"
  root_path     = "${replace(local.root_path_tmp, "////", "/")}"
}

module "homepage_docker_volume" {
  source = "../terraform/modules/docker_volume"
  volume_name = "homepage"
}

module "homepage_docker_container" {
  source = "../terraform/modules/docker_container"

  container_name = "homepage"
  container_image = "ghcr.io/gethomepage/homepage:v0.8.8"

  port_mappings = [
    {
      internal = 3000
      external = 3000
    }
  ]

  volume_mappings = [
    {
      volume_name = module.homepage_docker_volume.volume_name
      container_path = "/app/config"
    },
    {
      container_path = "/var/run/docker.sock"
      host_path = "/var/run/docker.sock"
      read_only = true
    }
  ]

  copy_files = [
    {
      file = "/app/config/settings.yaml"
      source = "${ local.root_path }/settings.yml"
    }
  ]

  network_configurations = [
    {
      name = "proxy"
    }
  ]
}