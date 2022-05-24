job "traefik" {
  datacenters = ["dc1"]
  type        = "system"
  group "traefik" {
    network {
      mode = "bridge"
      port "http" {
        static = 80
      }
      port "https" {
        static = 443
      }
      port "dns" {
        static = 53
      }
    }
    service {
      name = "traefik"
      port = "http"
      connect {
        native = true
      }
    }
    task "traefik" {
      driver = "docker"
      env {
        CF_API_EMAIL     = [[ .my.email | quote ]]
        CF_DNS_API_TOKEN = [[ .my.cloudflare_dns_api_key | quote ]]
      }
      config {
        image = "traefik:v2.7"
        args = [
          "--entrypoints.web.address=:80",
          "--entrypoints.websecure.address=:443",
          "--entrypoints.dns-tcp.address=:53/tcp",
          "--entrypoints.dns-udp.address=:53/udp",

          "--providers.consulcatalog=true",
          "--providers.consulcatalog.endpoint.scheme=http",
          "--providers.consulcatalog.defaultRule=Host(`{{ .Name }}.[[ .my.domain ]]`)",
          "--providers.consulcatalog.exposedbydefault=false",
          "--providers.consulcatalog.connectAware=true",

          "--certificatesresolvers.letsencrypt.acme.dnschallenge=true",
          "--certificatesresolvers.letsencrypt.acme.dnschallenge.provider=cloudflare",
          "--certificatesresolvers.letsencrypt.acme.email=[[ .my.email ]]",
          "--certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json",

          "--entrypoints.web.http.redirections.entrypoint.to=websecure",
          "--entrypoints.web.http.redirections.entrypoint.scheme=https"
        ]
      }
      volume_mount {
        volume      = "letsencrypt-volume"
        destination = "${NOMAD_ALLOC_DIR}/letsencrypt"
      }
    }

    volume "letsencrypt-volume" {
      type            = "csi"
      access_mode     = "multi-node-multi-writer"
      attachment_mode = "file-system"
      per_alloc       = true
      source          = "letsencrypt-volume"
    }
  }
}