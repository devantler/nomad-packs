job "keepalived" {
  datacenters = ["dc1"]
  type = "system"
  group "keepalived" {
    task "keepalived" {
      driver = "docker"
      config {
        image = "lettore/keepalived:arm64v8-latest"
        network_mode = "host"
        privileged = true
        cap_add = ["net_admin"]
      }
      env {
        KEEPALIVED_VIRTUAL_IPS = [[ .my.virtual_ips | quote]]
      }
    }
  }
}