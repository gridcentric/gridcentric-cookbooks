name "gridcentric-client"
description "Role for a vms api client."

run_list(
    "recipe[vms::client]",
    "recipe[canary::client]"
)
