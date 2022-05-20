job "cloudflare-ddns" {
  datacenters = ["dc1"]
  group "cloudflare-ddns" {
    task "cloudflare-ddns" {
      driver = "docker"
      config {
        image = "oznu/cloudflare-ddns:latest"
      }
      env {
        API_KEY = [[ .my.cloudflare_api_key | quote ]]
        ZONE    = [[ .my.domain | quote ]]
        PROXIED = true
      }
    }
  }
}
