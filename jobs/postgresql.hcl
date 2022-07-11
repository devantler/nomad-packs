job "postgres" {
  datacenters = ["dc1"]
  group "postgres" {
    network {
      mode = "host"
      port "http" {
        static = 5432
      }
    }
    task "postgres" {
      driver = "docker"
      config {
        image = "postgres"
      }
      env {
          POSTGRES_USER="root"
          POSTGRES_PASSWORD="rootpassword"
      }
      service {
        name = "postgres"
        port = "http"

        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}