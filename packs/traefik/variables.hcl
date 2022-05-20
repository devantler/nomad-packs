variable "domain" {
    description = "The default domain to use for exposed services"
    type = string
}

variable "email" {
    description = "The email address you want to use for Letsencrypt and connecting with CloudFlare API"
    type = string
}

variable "cloudflare_dns_api_key" {
    description = "Your CloudFlare DNS API key"
    type = string
}