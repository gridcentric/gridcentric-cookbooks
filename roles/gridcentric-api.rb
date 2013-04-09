name "gridcentric-api"
description "Role for a vms api client."

run_list(
    "recipe[vms::api]",
    "recipe[canary::api]",
    "recipe[canary::horizon]"
)
