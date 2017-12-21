# Vagrant
default['chef_fedora_base']['vagrant_version'] = '2.0.1'
default['chef_fedora_base']['vagrant_url'] = "https://releases.hashicorp.com/vagrant/#{node['chef_fedora_base']['vagrant_version']}/vagrant_#{node['chef_fedora_base']['vagrant_version']}_x86_64.rpm"

# Docker
default['chef_fedora_base']['docker_url'] = 'https://download.docker.com/linux/fedora/26/x86_64/stable/Packages/docker-ce-17.09.0.ce-1.fc26.x86_64.rpm'
