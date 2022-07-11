# DevAntler's Nomad Packs

This repo contains Nomad Packs for services used in DevAntler's HomeLab.

The repo also contains regular nomad jobs. These will be maintained as long as Nomad Packs is under development and there is no viable GitOps workflow for nomad-packs.

## Prerequisites

- A Nomad and Consul cluster + CSI storage.
  - You need a minimum of three nodes to maintain a quorum of servers for high availability.
- Port 80/TCP forwarded to the Keepalived virtual IP
- Port 443/TCP forwarded to the Keepalived virtual IP
- Port 51820/UDP forwarded to the node that hosts Wireguard.
- Possibly one or more domains for public access to your sites.
