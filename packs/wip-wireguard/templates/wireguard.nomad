job "wireguard" {
  group "vpn" {
    network {
      mode = "bridge"
      port "http" {
        static = 51821
        to     = 51821
      }
      port "wireguard" {
        static = 51820 / udp
      }
    }
    service {
      name = "wireguard"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.consulcatalog.connect=true",
        "traefik.http.routers.wireguard.entrypoints=websecure",
        "traefik.http.routers.wireguard.tls.certresolver=letsencrypt",
        "traefik.http.routers.wireguard.middlewares=wireguard-auth",
        "traefik.http.middlewares.wireguard-auth.forwardauth.address=http://${NOMAD_UPSTREAM_ADDR_cloudflare_auth}/auth/[[ .my.cloudflare_auth_aud ]]",
      ]
      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "cloudflare-auth"
              local_bind_port  = 8080
            }
          }
        }
      }
    }
    task "wireguard" {
      driver = "docker"
      env {
        WG_HOST                 = "vpn.[[ .my.domain ]]"
        WG_DEFAULT_DNS          = [[ .my.default_dns ]]
        PASSWORD                = [[ .my.password ]]
        WG_PERSISTENT_KEEPALIVE = [[ .my.persistent_keepalive ]]
      }
      cap_add = ["net_admin", "sys_module"]
      config {
        image = "weejewel/wg-easy:5"
        sysctl = {
          "net.ipv4.conf.all.src_valid_mark" = 1
        }
      }
      volume_mount {
        volume      = "wireguard-volume"
        destination = "/etc/wireguard"
      }
    }
    volume "wireguard-volume" {
      type            = "csi"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
      source          = "wireguard-volume"
    }
  }
}


