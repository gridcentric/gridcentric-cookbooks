Description
===========

This repository contains chef cookbooks for deploying various
Gridcentric technologies. These cookbooks are typically used with the
opensource Chef server.

Data Bags
=========

The `data_bags` directory contains templates for chef data bags used
by the cookbooks. These should be modified with data pertaining to
your deployment scenario and imported into your chef server prior to
using the Gridcentric cookbooks.

Roles
=====

The `roles` directory contains chef roles.

Usage
=====

These cookbooks were tested on chef 0.10.12. Install and configure
your chef server and client. These instructions are assumed to be
performed from a developer workstation with properly configured knife
client for accessing your chef server.

Installation
------------

Issue the following commands from the root of this git repository:

    cd gridcentric-cookbooks

Upload the gridcentric cookbooks into your chef server:
    
    knife cookbook upload -o cookbooks --all
    
Modify the repos.json data bag template with your private key. Then
upload the gridcentric data bag to your chef server:

    knife data bag from file gridcentric data_bags/gridcentric/*.json
    
Finally, upload the roles to your chef server:

    knife role from file roles/*.rb

Using the Cookbooks
-------------------

Once your nodes are registered with your chef server, simply assign
the appropriate roles to your nodes. Note that the nodes must be
running the appropriate components of openstack prior to installing
the gridcentric components. If chef is being used to configure
openstack as well, openstack roles must appear earlier in the node's
run list than the gridcentric roles.

For an all-in-one openstack cluster with a single node:

    knife node run_list add <node-name> "role[gridcentric-compute]"
    knife node run_list add <node-name> "role[gridcentric-api]"

Openstack compute nodes:

    knife node run_list add <node-name> "role[gridcentric-compute]"
    
Openstack api nodes:

    knife node run_list add <node-name> "role[gridcentric-api]"
    
External machines which will send VMS requests your VMS-enabled
cluster:

    knife node run_list add <node-name> "role[gridcentric-client]"
    
Openstack instances which will be used as VMS masters:

    knife node run_list add <node-name> "role[vms-guest]"

License
=======

Copyright 2012, Gridcentric Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
