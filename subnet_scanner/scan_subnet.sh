#!/bin/bash

# This script pings all IP addresses on a subnet
# and returns back a list of all responses
# Example: ./scan_subnet.sh 192.168.1.0/24
# will scan 192.168.1.0 - 192.168.1.255 
# BTW this code was taken straight from a Google Gemini prompt

# Check if a subnet is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <subnet>"
  echo "Example: $0 192.168.1.0/24"
  exit 1
fi

subnet="$1"

# Extract the base IP address and CIDR mask
base_ip=$(echo "$subnet" | cut -d '/' -f 1)
cidr=$(echo "$subnet" | cut -d '/' -f 2)

# Calculate the number of hosts in the subnet
num_hosts=$(( 2**(32 - cidr) - 2 )) # Subtract network and broadcast addresses

echo "Scanning subnet: $subnet"
echo "Number of potential hosts: $num_hosts"
echo "-----------------------------------"

# Loop through all possible host IPs in the subnet
for i in $(seq 1 "$num_hosts"); do
  # Calculate the last octet of the IP address
  last_octet=$(( $(echo "$base_ip" | cut -d '.' -f 4) + i ))

  # Construct the target IP address
  target_ip=$(echo "$base_ip" | cut -d '.' -f 1-3)."$last_octet"

  # Ping the target IP address with a timeout of 1 second and only send 1 packet
  ping -c 1 -W 1 "$target_ip" > /dev/null 2>&1

  # Check the exit status of the ping command
  if [ $? -eq 0 ]; then
    echo "Host $target_ip is up"
  fi
done

echo "-----------------------------------"
echo "Scan complete."