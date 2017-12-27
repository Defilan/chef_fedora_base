name 'chef_fedora_base'
maintainer 'Christopher Maher'
maintainer_email 'defilan@gmail.com'
license 'MIT'
description 'Installs/Configures chef_fedora_base'
long_description 'Installs/Configures chef_fedora_base'
version '0.1.1'
chef_version '>= 12.1' if respond_to?(:chef_version)
depends 'habitat', '~> 0.50.3'
depends 'chef-ingredient', '~> 2.1.11'

supports 'fedora'

issues_url 'https://github.com/defilan/chef_fedora_base/issues'
source_url 'https://github.com/defilan/chef_fedora_base'
