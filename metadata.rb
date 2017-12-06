name 'chef_fedora_base'
maintainer 'Christopher Maher'
maintainer_email 'defilan@gmail.com'
license 'MIT'
description 'Installs/Configures chef_fedora_base'
long_description 'Installs/Configures chef_fedora_base'
version '0.1.6'
chef_version '>= 12.1' if respond_to?(:chef_version)
depends 'habitat', '~> 0.39.0'
depends 'chef-ingredient', '~> 2.1.11'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/defilan/chef_fedora_base/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/defilan/chef_fedora_base'
