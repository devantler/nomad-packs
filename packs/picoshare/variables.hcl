variable "domain" {
    description = "The domain to use for the website"
    type = string
}

variable "password" {
    description = "The password to use for the website"
    type = string
    default = ""
}