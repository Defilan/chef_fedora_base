# # encoding: utf-8

# Inspec test for recipe chef_fedora_base::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

%w(vagrant docker chefdk VirtualBox-5.2 util-linux-user git make automake gcc gcc-c++ kernel-devel zsh zsh-syntax-highlighting neovim tmux).each do |temppackage|
  describe package(temppackage) do
    it { should be_installed }
  end
end

describe group('docker') do
  it { should exist }
end

describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/bin/hab') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
end
