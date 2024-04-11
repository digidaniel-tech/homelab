module "jellyfin_config_volume" {
  source = "../../terraform/modules/docker_volume"
  volume_name = "jellyfin_config"
}

module "jellyfin_cache_volume" {
  source = "../../terraform/modules/docker_volume"
  volume_name = "jellyfin_config"
}

module "jellyfin_container" {
  source = "../../terraform/modules/docker_container"

  container_name = "jellyfin"
  container_image = "jellyfin/jellyfin:2024040805"

  container_env = [
    "JELLYFIN_PublishedServerUrl=https://media.wollbro.se"
  ]

  port_mappings = [
    {
      internal = 8096
      external = 8096
    },
    {
      internal = 8920
      external = 8920
    }
  ]

  volume_mappings = [
    {
      volume_name = module.jellyfin_config_volume.volume_name
      container_path = "/config"
    },
    {
      volume_name = module.jellyfin_cache_volume.volume_name
      container_path = "/cache"
    },
    {
      container_path = "/media"
      host_path = "/mnt/media"
    }
  ]

  network_configurations = [
    {
      name = "proxy"
    }
  ]
}
