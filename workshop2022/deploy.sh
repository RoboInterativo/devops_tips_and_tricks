#!/bin/bash
ansible-playbook   --become -u sshuser -vv -i inventories/dev/inventory ping.yml
