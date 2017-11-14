#
# Cookbook:: chef_fedora_base
# Recipe:: default
#
# Copyright:: 2017, Christopher Maher, MIT

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

# Development tools
%w(util-linux-user git make automake gcc gcc-c++ kernel-devel).each do |temppackage|
  package temppackage
end

# User Specific Tweaks (NVIM, dotfiles, etc)
%w(zsh zsh-syntax-highlighting neovim tmux).each do |temppackage|
  package temppackage
end

node['etc']['passwd'].each do |user, data|
  next unless data['gid'].to_i >= 1000
  git "#{data['dir']}/.oh-my-zsh" do
    repository 'git://github.com/robbyrussell/oh-my-zsh.git'
    action :sync
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
