# Fedora Base Cookbook

[![Build Status](https://travis-ci.org/Defilan/chef_fedora_base.svg?branch=master)](https://travis-ci.org/Defilan/chef_fedora_base) [![Cookbook Version](https://img.shields.io/badge/cookbook-0.1.2-blue.svg)](https://supermarket.chef.io/cookbooks/chef_fedora_base) [![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://choosealicense.com/licenses/mit)

This is a Chef cookbook that helps configure Fedora based Chef/Ruby developer boxes

## Scope

This cookbook installs a set of applications and tools that are used by Christopher Maher (Defilan) as a developer
config. This includes tools such as Habitat, Neovim, Docker, ChefDK, Vagrant, VirtualBox, etc.

## Requirements

- Chef 13 or later
- Network access for package and git repo downloads

## Platform Support

- Fedora 26
- Fedora 27

## Cookbook Dependencies

This cookbook is dependant on the habitat and chef-ingredient cookbooks.

## Contributing

Please submit pull requests with fixes or ideas for improvement. FOSS is all about collaboration, so please join in!

## Maintainers

- Christopher Maher ([chris@mahercode.io](mailto:chris@mahercode.io))

## License

MIT License

Copyright (c) 2017 Christopher Maher

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
