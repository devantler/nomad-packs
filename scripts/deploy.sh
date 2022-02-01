docker stack deploy -c <(docker-compose -f ../stacks/container-management/portainer.yml config) portainer
docker stack deploy -c <(docker-compose -f ../stacks/reverse-proxy/traefik.yml config) traefik
docker stack deploy -c <(docker-compose -f ../stacks/high-availability/keepalived.yml config) keepalived
docker stack deploy -c <(docker-compose -f ../stacks/vpn/wireguard.yml config) wireguard