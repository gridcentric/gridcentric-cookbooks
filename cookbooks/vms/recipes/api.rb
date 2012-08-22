#
# Cookbook Name:: vms
# Recipe:: api
#
# Copyright 2012, Gridcentric Inc.
#

if not platform?("ubuntu")
  raise "Unsupported platform: #{node["platform"]}"
end

repo_data = data_bag_item("gridcentric", "repos")

apt_repository "gridcentric-essex" do
  uri "http://downloads.gridcentriclabs.com/packages/#{repo_data["private_key"]}/essex/ubuntu/"
  components ["gridcentric", "multiverse"]
  key "http://downloads.gridcentriclabs.com/packages/gridcentric.key"
  notifies :run, resources(:execute => "apt-get update"), :immediately
  only_if { platform?("ubuntu") }
end

package "nova-api-gridcentric" do
  action :install
  options "-o APT::Install-Recommends=0"
end
