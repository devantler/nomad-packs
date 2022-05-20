variable "cluster_id" {
  description = "The ID of the ceph cluster to add the node to."
  type = string
}

variable "monitors" {
    description = "The IP addresses of the monitors in your ceph cluster."
    type = list(string)
}