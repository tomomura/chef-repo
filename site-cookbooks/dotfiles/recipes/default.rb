#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "/home/vagrant/dotfiles" do
  repository "https://github.com/tomomura/dotfiles.git"
  reference "master"
  action :checkout
  user "vagrant"
  group "vagrant"
end

execute "set zsh as default shell" do
  command "chsh -s $(which zsh) vagrant"
end
