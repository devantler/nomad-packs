docker stack deploy -c <(docker-compose -f ../stacks/portainer.yml config) portainer
docker stack deploy -c <(docker-compose -f ../stacks/traefik.yml config) traefik
# TODO: Migrate to Portainer stacks when supported
docker stack deploy -c <(docker-compose -f ../stacks/keepalived.yml config) keepalived
docker stack deploy -c <(docker-compose -f ../stacks/wireguard.yml config) wireguard