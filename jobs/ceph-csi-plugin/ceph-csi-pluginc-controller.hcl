job "ceph-csi-plugin-controller" {
  datacenters = ["dc1"]
  group "ceph-csi-plugin" {
    network {
      port "metrics" {}
    }
    task "ceph-controller" {
      template {
        data = <<EOF
        [{
            "clusterID": "${ cluster_id }",
            "monitors": "${monitors }"
        }]
        EOF
        destination = "local/config.json"
        change_mode = "restart"
      }
      driver = "docker"
      config {
        image = "quay.io/cephcsi/cephcsi:v3.6.2"
        volumes = [
          "./local/config.json:/etc/ceph-csi-config/config.json"
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
          "--controllerserver=true",
          "--drivername=cephfs.csi.ceph.com",
          "--endpoint=unix://csi/csi.sock",
          "--nodeid=${node.unique.name}",
          "--instanceid=${node.unique.name}}-controller",
          "--pidlimit=-1",
          "--logtostderr=true",
          "--v=5",
          "--metricsport=$${NOMAD_PORT_metrics}"
        ]
      }
      resources {
        cpu    = 500
        memory = 256
      }
      service {
        name = "ceph-csi-controller"
        port = "metrics"
        tags = [ "prometheus" ]
      }
      csi_plugin {
        id        = "ceph-csi"
        type      = "controller"
        mount_dir = "/csi"
      }
    }
  }
}