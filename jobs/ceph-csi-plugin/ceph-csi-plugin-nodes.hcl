variable "cluster_id" {
  description = "The ID of the ceph cluster to add the node to."
  type = string
}

variable "monitors" {
    description = "The IP addresses of the monitors in your ceph cluster."
    type = list(string)
}

job "ceph-csi-plugin-nodes" {
  datacenters = ["dc1"]
  type        = "system"
  group "ceph-csi-plugin" {
    network {
      port "metrics" {}
    }
    task "ceph-node" {
      driver = "docker"
      template {
        data        = <<EOF
        [{
            "clusterID": "${ cluster_id }",
            "monitors": "${ monitors }"
        }]
        EOF
        destination = "local/config.json"
        change_mode = "restart"
      }
      config {
        image = "quay.io/cephcsi/cephcsi:v3.6.2"
        volumes = [
          "./local/config.json:/etc/ceph-csi-config/config.json",
          "/lib/modules:/lib/modules"
        ]
        mounts = [
          {
            type     = "tmpfs"
            target   = "/tmp/csi/keys"
            readonly = false
            tmpfs_options = {
              size = 1000000
            }
          }
        ]
        args = [
          "--type=cephfs",
          "--drivername=cephfs.csi.ceph.com",
          "--nodeserver=true",
          "--endpoint=unix://csi/csi.sock",
          "--nodeid=${node.unique.name}",
          "--instanceid=${node.unique.name}-nodes",
          "--pidlimit=-1",
          "--logtostderr=true",
          "--v=5",
          "--metricsport=$${NOMAD_PORT_metrics}"
        ]
        privileged = true
      }
      resources {
        cpu    = 500
        memory = 256
      }
      service {
        name = "ceph-csi-nodes"
        port = "metrics"
        tags = ["prometheus"]
      }
      csi_plugin {
        id        = "ceph-csi"
        type      = "node"
        mount_dir = "/csi"
      }
    }
  }
}
