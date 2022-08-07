variable "virtual_ips" {
    description = "The virtual IPs to assign to nodes."
    type = string
    default = "10.10.10.0"
}

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
        KEEPALIVED_VIRTUAL_IPS = "${ virtual_ips }"
      }
    }
  }
}