#
# Cookbook Name:: vms
# Recipe:: compute
#
# Copyright 2012, Gridcentric Inc.
#

include_recipe "apt"

if not platform?("ubuntu")
  raise "Unsupported platform: #{node["platform"]}"
end

repo_data = data_bag_item("gridcentric", "repos")

%w{ vms essex }.each do |repo|
  apt_repository "gridcentric-#{repo}" do
    uri "http://downloads.gridcentriclabs.com/packages/#{repo_data["private_key"]}/#{repo}/ubuntu/"
    components ["gridcentric", "multiverse"]
    key "http://downloads.gridcentriclabs.com/packages/gridcentric.key"
    notifies :run, resources(:execute => "apt-get update"), :immediately
    only_if { platform?("ubuntu") }
  end
end

package "linux-headers-#{node["kernel"]["release"]}" do
  action :install
end

package "nova-compute-gridcentric" do
  action :install
  options "-o APT::Install-Recommends=0"
end

template_variables = { }
["vms_shelf_path", "vms_shared_path", "vms_disk_url", "vms_memory_url", "vms_logs",
 "vms_single_log", "vms_cache", "vms_store", "vmsd_opts", "vms_debug", "vms_guest_params",
 "vms_ceph_conf", "vms_qemu_cpu_mod"].each do |config_var|
  template_variables[config_var] = node["vms"]["sysconfig"][config_var]
end

template "/etc/sysconfig/vms" do
  source "vms.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(template_variables)
end
