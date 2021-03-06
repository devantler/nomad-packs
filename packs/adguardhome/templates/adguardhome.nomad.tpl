job "adguardhome" {
  datacenters = ["dc1"]
  group "adguardhome" {
    network {
      mode = "bridge"
      port "tcp/dns" {
        to = 53
      }
    }
    service {
      name = "adguardhome"
      port = 3000
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.adguardhome.entrypoints=websecure",
        "traefik.http.routers.adguardhome.tls.certresolver=letsencrypt",
        "traefik.http.routers.adguardhome.middlewares=adguardhome-auth",
        "traefik.http.middlewares.adguardhome-auth.forwardauth.address=http://cloudflare-auth.devantler.com/auth/[[ .my.cloudflare_auth_aud ]]",
      ]
      connect {
        sidecar_service {}
      }
    }
    task "adguardhome" {
      driver = "docker"
      config {
        image = "adguard/adguardhome:v0.107.6"
      }
      volume_mount {
        volume      = "adguardhome-volume"
        destination = "/opt/adguardhome/work"
      }
      volume_mount {
        volume      = "adguardhome-volume"
        destination = "/opt/adguardhome/conf"
      }
    }
    volume "adguardhome-volume" {
      type            = "csi"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
      source          = "adguardhome-volume"
    }
  }
}
