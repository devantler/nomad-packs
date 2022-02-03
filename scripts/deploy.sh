docker stack deploy -c <(docker-compose -f ../stacks/portainer.yml config) portainer
docker stack deploy -c <(docker-compose -f ../stacks/traefik.yml config) traefik
docker stack deploy -c <(docker-compose -f ../stacks/keepalived.yml config) keepalived