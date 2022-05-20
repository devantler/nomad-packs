job "minecraft-server" {
  datacenters = ["dc1"]
  group "minecraft-server" {
    network {
      port  "http" {
        to = 25565
      }
    }
    service {
      name = "minecraft-server"
      port = "http" 
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.minecraft-server.entrypoints=websecure",
        "traefik.http.routers.minecraft-server.tls.certresolver=letsencrypt",
        "traefik.http.routers.minecraft-server.middlewares=minecraft-server-auth",
        "traefik.http.middlewares.minecraft-server-auth.basicauth.users=[[ .my.user ]]:[[ .my.user_hashed_password ]]"
      ]
      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }
    task "minecraft-server" {
      driver = "docker"
      config {
        image = "itzg/docker-minecraft-server:2022.6.0"
        ports = ["http"]
      }
      env {
        EULA = true
      }
      volume_mount {
          volume      = "minecraft-server-volume"
          destination = "/data"
      }
    }
    volume "minecraft-server-volume" {
      type            = "csi"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
      source          = "minecraft-server-volume"
    }
  }
}