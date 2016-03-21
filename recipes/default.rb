#
# Cookbook Name:: pptp_server
# Recipe:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
#

package "pptpd" do
  action :install
end

service 'pptpd' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

template "/etc/pptpd.conf" do
  source "pptpd.conf.erb"
  owner "root"
  group "root"
  variables({
    :localip => node['pptpd']['localip'],
    :remoteip => node['pptpd']['remoteip']
  })
  mode "0664"
  notifies :restart, 'service[pptpd]', :delayed
end

template "/etc/ppp/pptpd-options" do
  not_if "grep ^ms-dns\  /etc/ppp/pptpd-options"
  source "pptpd-options.erb"
  variables({
    :first_dns => node['pptpd']['first_dns'],
    :second_dns => node['pptpd']['second_dns']
  })
  owner "root"
  group "root"
  mode "0600"
  notifies :restart, 'service[pptpd]', :delayed
end

template "/etc/ppp/chap-secrets" do
  source "chap-secrets.erb"
  not_if "grep pptpd /etc/ppp/chap-secrets"
  owner "root"
  group "root"
  mode "0600"
  variables({
    :users => node['pptpd']['users']
  })
  notifies :restart, 'service[pptpd]', :delayed
end

include_recipe 'sysctl::default'
sysctl_param 'net.ipv4.ip_forward' do
  value 1
  action :apply
end

iptables_rule 'POSTROUTING' do
  action :enable
end

modules 'ppp_mppe' do
  action :load
end
