# devantler-cluster

This repo contains all my stacks for my devantler-cluster

PreUp = iptables -t nat -A POSTROUTING -j MASQUERADE -o eth0
PreDown = iptables -t nat -D POSTROUTING -j MASQUERADE -o eth0