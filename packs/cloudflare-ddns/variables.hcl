variable "domain" {
    description = "The DNS Domain to update the A record for."
    type = string
}

variable "cloudflare_api_key" {
    description = "An API key with access to the Cloudflare accounts domain."
    type = string
}