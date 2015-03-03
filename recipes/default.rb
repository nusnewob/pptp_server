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

template "/etc/pptpd.conf" do
  source "pptpd.conf.erb"
  owner "root"
  group "root"
  variables :localip => node[:pptpd][:localip], :remoteip => node[:pptpd][:remoteip]
  mode "0664"
end

template "/etc/ppp/pptpd-options" do
  not_if "grep ^ms-dns\  /etc/ppp/pptpd-options"
  source "pptpd-options.erb"
  variables :first_dns => node[:pptpd][:first_dns], :second_dns => node[:pptpd][:second_dns]
  owner "root"
  group "root"
  mode "0600"
end


template "/etc/ppp/chap-secrets" do
  source "chap-secrets.erb"
  not_if "grep pptpd /etc/ppp/chap-secrets"
  owner "root"
  group "root"
  mode "0600"
end

# let pptp client can use network
execute 'echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf' do
  not_if "grep ^net.ipv4.ip_forward= /etc/sysctl.conf"
end

execute "service pptpd restart"


execute "restart service" do
  command "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && iptables-save && sysctl -p"
end

execute 'echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf' do
  not_if "grep ^net.ipv4.ip_forward= /etc/sysctl.conf"
end

# presist it
# TODO: it will break rc.local
template "/etc/rc.local" do
  source "rc.local.erb"
  owner "root"
  group "root"
  mode "0755"
  not_if "grep '^iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE' /etc/rc.local"
end


# fix mtu issue
execute 'echo "mtu #{node[:pptpd][:mtu]}" >> /etc/ppp/options' do
  not_if "grep ^mtu /etc/ppp/options"
end


