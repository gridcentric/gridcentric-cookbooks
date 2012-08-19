name "gridcentric-api"
description "Role for a vms api client."

run_list(
    "recipe[vms::api]"
)
