name "gridcentric-compute"
description "Designates vms-enabled openstack host."

run_list(
    "recipe[vms::compute]",
    "recipe[canary::host]"
)
