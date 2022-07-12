job "postgres" {
  datacenters = ["dc1"]
  group "postgres" {
    network {
      port  "db"{
        static = 5432
      }
    }
    task "postgres" {
      driver = "docker"
      config {
        image = "postgres"
        ports = ["db"]
      }
      service {
        name = "postgres"
        port = "db"
        check {
          type     = "tcp"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}