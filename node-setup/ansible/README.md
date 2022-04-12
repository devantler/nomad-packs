# How To

You need to first install Ansible and then run the following:

- `ansible-galaxy install geerlingguy.git`
- `ansible-galaxy install geerlingguy.pip`
- `ansible-galaxy install geerlingguy.docker_arm`
- `ansible-galaxy install xanmanning.k3s`
- `ansible-galaxy install jnv.unattended-upgrades`

Next, you can run the `setup.yml` playbook to initialize new nodes with Git, Docker, Docker Compose and unattended-upgrades.

- `ansible-playbook setup.yml`