# devantler-cluster

This repo contains all my stacks for my devantler-cluster

## Getting started

To deploy this cluster the following is required:

- A host machine with Docker
- Port 80 should be forwarded on the router
- The stacks in self-managed should be manually deployed on the host
- The stacks in portainer-stacks should be setup to auto deploy on changes with GitHub Webhooks provided by Portainer.

## Services in the cluster

### Portainer

Portainer is a centralized service delivery platform for containerized apps, that basically allows self-hosting docker applications in fully managed environments with either Docker Swarm or K8.

This service manages all other stacks in the cluster, and is capable of:

- Auto deploying stacks from GitHub, when they change.
- Running multiple environments for e.g. development web apps or production web apps.
- Manage all stuff Docker related

### Nginx Proxy Manager

Nginx Proxy Manager is a web UI for Nginx that wraps the most common use cases for Nginx, and allow its users to easily:

- Create Proxy Hosts
- Create Redirection Hosts
- Create Streams
- Create 404 Hosts
- Add SSL to sites
- Authorize incoming requests with access lists. Can block IP's or require HTTP authentication.

This is used as a reverse proxy for any communication against the cluster.

### PiHole

PiHole is a network-wide ad blocking service, that blocks an impressive amount of adds. The stack is set up to direct all traffic through PiHole from local clients, or clients connected through a VPN.

### Wireguard

Wireguard is a highly secure and performant VPN.

## Keepalived

Keepalived is used to set an virtual ip for each manager node, such that connecting to the virtual IP will ensure a manager is reached in case of system failure.

<https://hub.docker.com/r/lolhens/keepalived-swarm>
