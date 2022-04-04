# HA Docker Swarm cluster with Traefik and Portainer

This repo contains deployable stacks for a secure and fully docker-managed cluster. It includes Portainer, Traefik, Wireguard and Keepalived. These tools together enable a high-availability cluster that you can easily deploy stacks to. Wireguard is a fast and secure VPN that allows you to gain access to your cluster remotely.

## Prerequisites

- One or more servers that support Docker, docker-compose, and Docker Swarm.
  - For HA you need a minimum of three servers to maintain a quorum of managers.
- Port 80/TCP forwarded to the Keepalived virtual IP
- Port 443/TCP forwarded to the Keepalived virtual IP
- Port 51820/UDP forwarded to the Keepalived virtual IP
- A domain set up with:
  - An A record to yourdomain.com
  - An A record on www
  - A CNAME on any public facing subdomain
- The needed credentials for DDNS updates and LetsEncrypt Acme DNS challenges:
  - I am using Cloudflare, a Docker image, and a Cloudflare API token to support DDNS updates. 
  - ![Cloudflare API token for DDNS updates](resources/images/ddns-api-token.png)

## Getting started 

1. Connect to a manager node (SSH, remote desktop etc.)
  - I recommend using VSCode Remote Explorer (SSH)
2. Run the `ìnit-node.sh` script to install dependencies (git, Docker, docker-compose, unattended-upgrades)
3. Run the `init-swarm.sh` script to initialize docker swarm and create required overlay networks.
  - Follow instructions to add your other nodes to the cluster.
4. Copy `.env.example` to a new file called `.env`
5. Set the environment variables in `.env`
6. Run the `deploy.sh` script to deploy Portainer in the cluster.
7. You can now open Portainer by going to `https://{keepalived-virtual-ip}:9443
  - The rest of the services in the repository can be deployed within portainer.

Additionally, you should know that:

- If you own a business, you can get the business edition for free <https://www.portainer.io/pricing/take5>

## Services in the cluster

### Traefik

### Portainer

Portainer is a centralized service delivery platform for containerized apps that allows self-hosting docker applications in fully managed environments with either Docker Swarm or K8.

This service manages all other stacks in the cluster and is capable of:

- Auto deploying stacks from GitHub when they change.
- Running multiple environments, e.g., development web apps or production web apps.
- Manage all stuff Docker related

### WireGuard

Wireguard is a highly secure and performant VPN.

### PiHole

PiHole is a network-wide ad-blocking service that blocks an impressive amount of ads. The stack is set to direct all traffic through PiHole from local clients or clients connected through a VPN.

## Keepalived

Keepalived is used to set a virtual IP for each manager node, such that connecting to the virtual IP will ensure a manager is reached in case of system failure.

<https://hub.docker.com/r/lolhens/keepalived-swarm>
