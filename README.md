# Vagrant box bootstrapping

Base role for [Dalee/ubuntu](https://atlas.hashicorp.com/Dalee/boxes/ubuntu) Vagrant box.

Role will uninstall some crap (like command-not-found) and
install some mandatory software and some useful commands:

 * `pavlik-enable` [Comrade Pavlik](https://github.com/Dalee/comrade-pavlik) helper script
 * `docker-cleanup` Docker images/containers cleanup script
 * `avahi` daemon to advertise hostname
 * `avahi-cname-aliases` [script](https://github.com/Dalee/avahi-cname-aliases) to advertise cname aliases for host via avahi 
 * `nginx` daemon
 * `~/.environment.rc` — loader for role-based environment variables
 (make sure to add this file to `.bash_profile`)

## Mandatory parameters

Vagrantfile and ansible provision script should define two variables:
 * `project_root` - vagrant path, usually `/home/web/project`
 * `project_name` - hostname, will be used for `<project_name>.local` domain

Vagrantfile example:
```
config.vm.provision "shell", path: "build/ansible.sh",
    env: {
        "PROJECT_ROOT": "/home/web/project",
        "PROJECT_NAME": "sample-project",
    }
```
`ansible.sh` example:
```
/usr/bin/ansible-playbook \
	-e "project_root"=${PROJECT_ROOT} \
	-e "project_name"=${PROJECT_NAME} \
	-i "${PROJECT_ROOT}/build/inventory.ini" \
	"${PROJECT_ROOT}/build/vagrant.yml"
```
