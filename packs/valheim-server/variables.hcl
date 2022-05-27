variable "server_name" {
    description = "The name of the server"
    type = string
}

variable "server_pass" {
    description = "The password to use to login to the server"
    type = string
    default = ""
}

variable "world_name" {
    description = "The name of the world file"
    type = string
}