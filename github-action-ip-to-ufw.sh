#!/bin/bash

# Retrieve the list of IP addresses used by GitHub Actions from the GitHub API and store it
ip_list=$(curl -s 'https://api.github.com/meta' | python3 -c "import sys, json; [print(x) for x in json.load(sys.stdin)['actions'] if '::' not in x]")


# Iterate over each IP address in the `ip_list` variable and create a firewall rule that allows incoming traffic from that IP address to connect to the SSH port (22) on the current machine.
for ip in $ip_list
do
    # Add the firewal rule
    ufw allow from "$ip" to any port 22 comment 'github-actions'
done

# Reload the firewall to ensure that the newly added rules take effect.
ufw reload
