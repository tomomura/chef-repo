#
# Cookbook Name:: porg
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/tmp/#{node[:porg][:arch_file_name]}" do
  source node[:porg][:url]
  action :create
  notifies :run, 'execute[Install porg from source]', :immediately
end

execute "Install porg from source" do
  action :nothing
  not_if "which porg"
  prefix = node['porg']['prefix'] ? "--prefix=#{node['porg']['prefix']}" : nil
  command <<-COMMAND
    cd /tmp
    tar zxvf #{node[:porg][:arch_file_name]}
    cd #{::File.basename(node[:porg][:arch_file_name], '.tar.gz')}
    ./configure #{"--disable-grop" if !node[:porg][:grop]} #{prefix}
    make
    sudo make install
    sudo make logme
  COMMAND
end
