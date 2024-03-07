locals {
  disable = false
  root_path_tmp = "/${replace(abspath(path.root), ":", "")}"
  root_path     = "${replace(local.root_path_tmp, "////", "/")}"
}

module "docker_image" {
  source = "../terraform/modules/docker_image"
  image_name = "traefik:v2.11.0"
}

module "docker_volume" {
  source = "../terraform/modules/docker_volume"
  volume_name = "traefik_letsencrypt"
}

module "docker_container" {
  source = "../terraform/modules/docker_container"

  container_disabled = local.disable
  container_image = module.docker_image.image_id
  container_name = "traefik"

  security_opts = [
    "no-new-privileges=true"
  ]

  port_mappings = [
    {
      internal = 80
      external = 80
    },
    {
      internal = 443
      external = 443
    }
  ]

  volume_mappings = [
    {
      volume_name = module.docker_volume.volume_name
      container_path = "/letsencrypt"
    },
    {
      host_path = "/etc/localtime"
      container_path = "/etc/localtime"
      read_only = true
    },
    {
      host_path = "/var/run/docker.sock"
      container_path = "/var/run/docker.sock"
      read_only = true
    }
  ]

  copy_files = [ 
    {
      file = "/traefik.yml"
      source = "${local.root_path}/configs/traefik.yml"
    },
    {
      file = "/config.yml"
      source = "${local.root_path}/configs/config.yml"
    }
   ]

  container_env = [
    "CF_DNS_API_TOKEN=${var.CLOUDFLARE_API_KEY}"
  ]

  network_configurations = [
    {
      name = "proxy"
    }
  ]

  label_mappings = {
    "traefik.enable" = "true"
    "traefik.http.routers.traefik.entrypoints" = "http"
    "traefik.http.routers.traefik.rule" = "Host(`traefik-dashboard.home.wollbro.se`)"
    "traefik.http.middlewares.traefik-auth.basicauth.users" = "admin:$$2y$$05$$IfOD7nSBWLlx14WNNDUN6eAfda.GaMF9/EdvqbfcVhGCuJ3ddEilS"
    "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme" = "https"
    "traefik.http.middlewares.sslheader.headers.customrequestheaders.X-Forwarded-Proto" = "https"
    "traefik.http.routers.traefik.middlewares" = "traefik-https-redirect"
    "traefik.http.routers.traefik-secure.entrypoints" = "https"
    "traefik.http.routers.traefik-secure.rule" = "Host(`traefik-dashboard.home.wollbro.se`)"
    "traefik.http.routers.traefik-secure.middlewares" = "traefik-auth"
    "traefik.http.routers.traefik-secure.tls" = "true"
    "traefik.http.routers.traefik-secure.tls.certresolver" = "cloudflare"
    "traefik.http.routers.traefik-secure.tls.domains[0].main" = "wollbro.se"
    "traefik.http.routers.traefik-secure.tls.domains[0].sans" = "*.wollbro.se"
    "traefik.http.routers.traefik-secure.tls.domains[1].main" = "home.wollbro.se"
    "traefik.http.routers.traefik-secure.tls.domains[1].sans" = "*.home.wollbro.se"
    "traefik.http.routers.traefik-secure.tls.domains[2].main" = "s3.wollbro.se"
    "traefik.http.routers.traefik-secure.tls.domains[2].sans" = "*.s3.wollbro.se"
    "traefik.http.routers.traefik-secure.service" = "api@internal"
  }

  container_commands = [
    "traefik"
  ]
}