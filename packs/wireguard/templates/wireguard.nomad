job "wireguard" {
  datacenters = ["dc1"]
  group "vpn" {
    task "wireguard" {
      driver = "docker"
      env {
        WG_HOST = "vpn.${var.domain}"
        WG_DEFAULT_DNS = var.default_dns
        PASSWORD = var.password
        WG_PERSISTENT_KEEPALIVE = 15
      }
      cap_add = ["net_admin", "sys_module"]
      config {
        image = "weejewel/wg-easy:5"
        sysctl = {
            "net.ipv4.conf.all.src_valid_mark" = 1
        }
        args = [
            "--traefik.enable=true"
            "--traefik.http.routers.wireguard.service=wireguard"
            "--traefik.http.routers.wireguard.rule=Host(`wireguard.${var.domain}}`)"
            "--traefik.http.routers.wireguard.entrypoints=websecure"
            "--traefik.http.routers.wireguard.tls.certresolver=letsencrypt" #Maybe can remove
            "--traefik.http.routers.wireguard.middlewares=wireguard-auth"
            "--traefik.http.middlewares.wireguard-auth.forwardauth.address=http://cloudflare-auth:8080/auth/${var.cloudflare_auth_aud}"
            "--traefik.http.services.wireguard.loadbalancer.server.port=51821"
        ]
      }
      volume_mount {
        volume      = "wireguard-volume"
        destination = "/etc/wireguard"
        read_only   = false
      }
    }
    volume "wireguard-volume" {
      type            = "csi"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
      read_only       = false
      source          = "wireguard-volume"
    }
    network {
      port "wireguard" {
        static = 51820/udp
      }
    }
    service {
      check {
        name     = "alive"
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }
  }
}

        
