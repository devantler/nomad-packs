job "plantuml-server" {
  datacenters = ["dc1"]
  group "plantuml-server" {
    network {
      port  "http" {
        to = 8080
      }
    }
    service {
      name = "plantuml-server"
      port = "http" 
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.plantuml-server.entrypoints=websecure",
        "traefik.http.routers.plantuml-server.tls.certresolver=letsencrypt",
        "traefik.http.routers.plantuml-server.middlewares=plantuml-server-auth",
        "traefik.http.middlewares.plantuml-server-auth.basicauth.users=[[ .my.admin ]]:[[ .my.admin_hashed_password ]],[[ .my.guest ]]:[[ .my.guest_hashed_password ]]"
      ]
      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }
    task "plantuml-server" {
      driver = "docker"
      config {
        image = "plantuml/plantuml-server:v1.2022.4"
        ports = ["http"]
      }
    }
  }
}