#!/bin/bash

# Retrieve a list of firewall rules that have the comment 'github-actions' in them and extract the rule numbers using `awk` in reversed order
numbers=$(ufw status numbered | grep 'github-actions' | awk -F'[][]' '{print $2}' | tac)

# Iterate over each rule number in the `numbers` variable and delete the corresponding firewall rule using `ufw`.
for n in $numbers
do
    ufw --force delete $n
done

# Reload the firewall to ensure that the newly added rules take effect.
ufw reload
