job "traefik" {
  datacenters = ["dc1"]
  group "traefik" {
    count = 3
    constraint {
      distinct_hosts = true
    }
    constraint {
      attribute = "${attr.unique.hostname}"
      operator  = "set_contains_any"
      value     = "rpi1,rpi2,rpi3"
    }
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
        CF_API_EMAIL     = "${email}"
        CF_DNS_API_TOKEN = "${cloudflare_dns_api_key}"
      }
      config {
        image = "traefik:v2.7"
        args = [
          "--entrypoints.web.address=:80",
          "--entrypoints.websecure.address=:443",
          "--entrypoints.dns-tcp.address=:53/tcp",
          "--entrypoints.dns-udp.address=:53/udp",

          "--providers.consulcatalog.connectAware=true",
          "--providers.consulcatalog.connectbydefault=true",
          "--providers.consulcatalog.exposedbydefault=false",
          "--providers.consulcatalog.defaultRule=Host(`{{ .Name }}.${domain}`)",

          "--certificatesresolvers.letsencrypt.acme.dnschallenge=true",
          "--certificatesresolvers.letsencrypt.acme.dnschallenge.provider=cloudflare",
          "--certificatesresolvers.letsencrypt.acme.email=${email}",
          "--certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json"
        ]
      }
      volume_mount {
        volume      = "letsencrypt-volume"
        destination = "/letsencrypt"
      }
    }

    volume "letsencrypt-volume" {
      type            = "csi"
      access_mode     = "multi-node-multi-writer"
      attachment_mode = "file-system"
      source          = "letsencrypt-volume"
    }
  }
}