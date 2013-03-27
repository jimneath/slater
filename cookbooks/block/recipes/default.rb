#
# Cookbook Name:: block
# Recipe:: default
#

# block ips
block do
  ip "128.23.83.192"
  ip "243.123.123.123", :ports => [22, 80, 443]
end

# install fail2ban
package "net-analyzer/fail2ban" do
  action :install
end