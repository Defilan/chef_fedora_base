#
# Cookbook:: chef_fedora_base
# Recipe:: default
#
# Copyright:: 2017, Christopher Maher, MIT

# Development tools
%w(sudo powertop gnupg util-linux-user git make automake gcc gcc-c++ kernel-devel).each do |temppackage|
  package temppackage
end

# OpenSSH Server and Service
package 'openssh-server'

service 'sshd' do
  action [:enable, :start]
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

  directory 'gnupg permissions' do
    path "#{data['dir']}/.gnupg"
    recursive true
    action :nothing
  end

  execute "rvm instal #{user}" do
    command '\curl -sSL https://get.rvm.io | bash'
    user user
    not_if { ::File.exist?("/home/#{user}/.rvm") }
    notifies :delete, 'directory[gnupg permissions]', :before
    notifies :run, 'execute[gpg keys]', :before
  end

  execute 'gpg keys' do
    command 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'
    environment 'HOME' => (data['dir']).to_s
    user user
    action :nothing
  end

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

  directory "#{data['dir']}/.tmux/plugins" do
    recursive true
    user user
    group data['gid']
  end

  git "#{data['dir']}/.tmux/plugins/tpm" do
    repository 'https://github.com/tmux-plugins/tpm'
    action :sync
    user user
    group data['gid']
  end
end
# Making sure docker is enabled and running
service 'docker' do
  action [:enable, :start]
end

# Configure GNOME to use x11 instead of wayland (for zoom.us)
template '/etc/gdm/custom.conf' do
  source 'custom.conf.erb'
  only_if { ::File.exist?('/etc/gdm/custom.conf') }
end
