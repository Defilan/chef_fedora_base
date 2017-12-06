#
# Cookbook:: chef_fedora_base
# Spec:: default
#
# Copyright:: 2017, Christopher Maher, MIT

require 'spec_helper'

describe 'chef_fedora_base::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'install hab and chefdk' do
      expect(chef_run).to install_hab_install('install habitat')
      expect(chef_run).to install_chef_ingredient('chefdk')
    end
  end
end
