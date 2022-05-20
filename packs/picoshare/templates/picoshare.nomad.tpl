job "picoshare" {
  datacenters = ["dc1"]
  group "picoshare" {
    network {
      port  "http" {
        to = 3001
      }
    }
    service {
      name = "picoshare"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.picoshare.entrypoints=websecure",
        "traefik.http.routers.picoshare.tls.certresolver=letsencrypt",
      ]
      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }
    task "picoshare" {
      driver = "docker"
      config {
        image = "mtlynch/picoshare:1.1.3"
        ports = ["http"]
      }
      env {
        PORT = 3001
        PS_SHARED_SECRET = [[ .my.password | quote ]]
      }
      volume_mount {
          volume      = "picoshare-volume"
          destination = "/data"
      }
    }
    volume "picoshare-volume" {
      type            = "csi"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
      source          = "picoshare-volume"
    }
  }
}
