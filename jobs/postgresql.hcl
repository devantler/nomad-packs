job "postgres" {
  datacenters = ["dc1"]
  type = "service"

  group "postgres" {
    count = 1

    task "postgres" {
      driver = "docker"
      config {
        image = "postgres"
        network_mode = "host"
        port_map {
          db = 5432
        }

      }
      env {
          POSTGRES_USER="root",
          POSTGRES_PASSWORD="rootpassword"
      }

      logs {
        max_files     = 5
        max_file_size = 15
      }

      service {
        name = "postgres"
        tags = ["postgres for vault"]
        port = "db"

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