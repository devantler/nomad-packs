job "timemachine" {
  type = "service"
  group "timemachine" {
    network {
      port "smb" {
        to = 445
      }
      port "udp1" {
        to = 137/udp
      }
      port "udp2" {
        to = 138/udp
      }
      port "http" {
        to = 139
      }
    }
    service {
      port = "http"
      check {
        name     = "alive"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }
    task "server" {
      driver = "docker"

      config {
        image = "mbentley/timemachine"
        ports = ["smb", "udp1", "udp2", "http"]
      }

      env {
        ADVERTISED_HOSTNAME="timemachine.local"
      }
    }
  }
}
