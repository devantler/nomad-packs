# High availability Docker Swarm cluster that is dev friendly!

This repo contains deployable stacks for a secure and fully Docker swarm-managed cluster. It includes Portainer (container management), Traefik (reverse proxy), Wireguard (VPN), and Keepalived (Virtual IP) to enable a high-availability cluster in which you can quickly deploy stacks.

## Prerequisites

- One or more servers that support Docker, docker-compose, and Docker Swarm.
  - For high availability, you need a minimum of three manager nodes to maintain a quorum of managers.
- Port 80/TCP forwarded to the Keepalived virtual IP
- Port 443/TCP forwarded to the Keepalived virtual IP
- Port 51820/UDP forwarded to the node that hosts Wireguard.
- Possibly domains for public access to your sites.

## Getting started

1. Connect to a manager node (SSH, remote desktop, etc.)
   - I recommend using VSCode Remote Explorer (SSH)
2. Install dependencies on each node (git, Docker, docker-compose)
   - You might be able to use the Ansible playbook to initialize nodes (configured for RaspberryPi 4b 64bit).
3. Initialize a docker swarm with all your nodes.
   - `docker swarm init`
   - `docker swarm join-token (worker|manager)`
   - `docker swarm join --token TOKEN IP:PORT`
4. Initialize needed overlay networks
   - `docker network create -d overlay NETWORK`
5. Deploy Portainer, Traefik, Wireguard, and Keepalived manually.
   - To deploy a stack, you can use this command to read in environment variables to the docker-compose file and then deploy it:
     - `docker stack deploy -c <(docker-compose -f STACK_PATH config) STACK_NAME`
   - Portainer can deploy Traefik, but it is easier to deploy it manually.
   - Wireguard and Keepalived need capabilities not supported by Portainer and thus will not work when deployed in Portainer.
6. You can now open Portainer by going to <https://{keepalived-virtual-ip}:9443>
7. Go nuts! You now have a functional cluster that you can manage from Portainer.

## Services in the cluster

### Portainer

Portainer is a centralized service delivery platform for containerized apps that allows self-hosting docker applications in fully managed environments with either Docker Swarm or K8.

This service manages all other stacks in the cluster and is capable of:

- Auto deploying stacks from GitHub when they change.
- Running multiple environments, e.g., development web apps or production web apps.
- Manage all stuff Docker related

<https://www.portainer.io>

### Traefik

Traefik is an open-source reverse proxy that is fast and easy to configure. It makes publishing your services a fun and quick experience, where you will have HTTPS working with automatically generated self-managed certificates in no time.

<https://doc.traefik.io/traefik/>

### WireGuard

Wireguard is a highly secure and performant VPN.

<https://www.wireguard.com>

### PiHole

PiHole is a network-wide ad-blocking service that blocks an impressive amount of ads. The stack is set to direct all traffic through PiHole from local clients or clients connected through a VPN.

<https://pi-hole.net>

### Keepalived

Keepalived is used to set a virtual IP for each manager node, such that connecting to the virtual IP will ensure a manager is reached in case of system failure.

<https://keepalived.readthedocs.io/en/latest/introduction.html>
