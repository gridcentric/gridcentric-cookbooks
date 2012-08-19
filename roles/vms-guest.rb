name "vms-guest"
description "Role for a vms guest."

run_list(
    "recipe[vms::agent]"
)
