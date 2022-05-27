job "valheim-server" {
  datacenters = "dc1"
  group "app" {
    service {
      name = "valheim-server"
      port = 2456
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.valheim-server.entrypoints=websecure",
        "traefik.http.routers.valheim-server.tls.certresolver=letsencrypt"
      ]
    }
    task "valheim-server" {
      driver = "docker"

      config {
        image   = "ghcr.io/lloesche/valheim-server"
        cap_add = ["sys_nice"]
      }
      env {
        SERVER_NAME = [[ .my.server_name | quote ]]
        WORLD_NAME  = [[ .my.world_name | quote ]]
        SERVER_PASS = [[ .my.server_pass | quote ]]
      }
      volume_mount {
        volume      = "valheim-server-volume"
        destination = "/opt/valheim"
      }
      volume_mount {
        volume      = "valheim-server-volume"
        destination = "/config"
      }
    }
    volume "valheim-sever-volume" {
      type            = "csi"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
      source          = "valheim-server-volume"
    }
  }
}