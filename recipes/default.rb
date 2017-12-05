#
# Cookbook:: chef_fedora_base
# Recipe:: default
#
# Copyright:: 2017, Christopher Maher, MIT

# Development tools
%w(sudo util-linux-user git make automake gcc gcc-c++ kernel-devel).each do |temppackage|
  package temppackage
end

# Install Vagrant and VirtualBox for local cookbook development
remote_file 'vagrant_file' do
  path "#{Chef::Config['file_cache_path']}/vagrant_#{node['chef_fedora_base']['vagrant_version']}_x86_64.rpm"
  source node['chef_fedora_base']['vagrant_url']
  action :create_if_missing
end

package 'vagrant' do
  package_name "vagrant-#{node['chef_fedora_base']['vagrant-version']}-1.x86_64"
  source "#{Chef::Config['file_cache_path']}/vagrant_#{node['chef_fedora_base']['vagrant_version']}_x86_64.rpm"
end

template '/etc/yum.repos.d/virtualbox.repo' do
  source 'virtualbox.repo.erb'
end

package 'VirtualBox-5.2'

# Install ChefDK via chef-ingredient cookbook
chef_ingredient 'chefdk'

# User Specific Tweaks (NVIM, dotfiles, etc)
%w(zsh zsh-syntax-highlighting neovim tmux).each do |temppackage|
  package temppackage
end

package 'docker' do
  action :install
  notifies :create, 'group[docker]', :immediately
end

group 'docker' do
  action :nothing
end

hab_install 'install habitat'

node['etc']['passwd'].each do |user, data|
  next unless data['gid'].to_i >= 1000

  group 'docker' do
    action :modify
    members user
    append true
  end

  git "#{data['dir']}/.oh-my-zsh" do
    repository 'https://github.com/robbyrussell/oh-my-zsh.git'
    action :sync
    user user
    group data['gid']
  end

  template "#{data['dir']}/.zshrc" do
    action :create_if_missing
    source 'zshrc.erb'
    user user
    group data['gid']
    variables(
      user: user
    )
  end

  user 'user modify' do
    shell '/bin/zsh'
    username user
    action :modify
  end

  git "#{data['dir']}/.dotfiles" do
    repository 'https://github.com/defilan/dotfiles'
    action :sync
    user user
    group data['gid']
  end
end

# Making sure docker is enabled and running
service 'docker' do
  action [:enable, :start]
end
