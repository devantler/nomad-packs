job "cloudflare-auth" {
  datacenters = ["dc1"]
  group "cloudflare-auth" {
    network {
      mode = "bridge"
    }
    service {
      name = "cloudflare-auth"
      port = 9123

      connect {
        sidecar_service {}
      }
    }
    task "cloudflare-auth" {
      driver = "docker"
      config {
        image = "akohlbecker/traefik-auth-cloudflare:2.0"
        args = [
            "--auth-domain", "https://[[ .my.domain_name ]].cloudflareaccess.com"
        ]
      }
    }
  }
}