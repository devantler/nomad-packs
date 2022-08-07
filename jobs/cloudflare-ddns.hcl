variable "domain" {
    description = "The DNS Domain to update the A record for."
    type = string
}

variable "cloudflare_api_key" {
    description = "An API key with access to the Cloudflare accounts domain."
    type = string
}

job "cloudflare-ddns" {
  datacenters = ["dc1"]
  group "cloudflare-ddns" {
    task "cloudflare-ddns" {
      driver = "docker"
      config {
        image = "oznu/cloudflare-ddns:latest"
      }
      env {
        API_KEY = "${ cloudflare_api_key }"
        ZONE    = "${ domain }"
        PROXIED = true
      }
    }
  }
}
