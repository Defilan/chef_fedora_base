#
# Cookbook:: chef_fedora_base
# Recipe:: default
#
# Copyright:: 2017, Christopher Maher, MIT

remote_file 'vagrant_file' do
  path "#{Chef::Config['file_cache_path']}/vagrant_#{node['chef_fedora_base']['vagrant_version']}_x86_64.rpm"
  source node['chef_fedora_base']['vagrant_url']
  action :create_if_missing
end

package 'vagrant' do
  package_name "vagrant-#{node['chef_fedora_base']['vagrant-version']}-1.x86_64"
  source "#{Chef::Config['file_cache_path']}/vagrant_#{node['chef_fedora_base']['vagrant_version']}_x86_64.rpm"
end
