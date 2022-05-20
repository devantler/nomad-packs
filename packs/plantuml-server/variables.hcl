variable "domain" {
    description = "The domain to use for the website"
    type = string
}

variable "admin" {
    description = "The admin username"
    type = string
    default = "admin"
}

variable "admin_hashed_password" {
    description = "A hashed admin password"
    type = string
}

variable "guest" {
    description = "The guest username"
    type = string
    default = "guest"
}

variable "guest_hashed_password" {
    description = "A hashed guest password (defaults to guest_1234)"
    type = string
    default = "$2y$10$y7FgVfsJBJtnlSjNW.iQxuaXoCdRCgG3vYvAD8BE5f1lMacyEYCtq"
}
