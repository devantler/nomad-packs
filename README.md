# DevAntler's Nomad Packs

This repo contains my Nomad Packs for the services I use in my HomeLab. Nomad Pack is used to template jobs.

## Prerequisites

- A Nomad, Consul and Ceph Cluster.
  - For high availability, you need a minimum of three nodes to maintain a quorum of servers.
- Port 80/TCP forwarded to the Keepalived virtual IP
- Port 443/TCP forwarded to the Keepalived virtual IP
- Port 51820/UDP forwarded to the node that hosts Wireguard.
- Possibly one or more domains for public access to your sites.
