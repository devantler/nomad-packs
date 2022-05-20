variable "domain" {
    description = "The domain to use for the website"
    type = string
}

variable "user" {
    description = "The guest username"
    type = string
    default = "user"
}

variable "user_hashed_password" {
    description = "A hashed guest password (defaults to guest_1234)"
    type = string
    default = "$2y$10$y7FgVfsJBJtnlSjNW.iQxuaXoCdRCgG3vYvAD8BE5f1lMacyEYCtq"
}