#!/bin/bash

# This script finds the PID of the process currently using a TCP/UDP port
# You can then use that PID to kill the process: sudo kill -9 <PID>
# Example: ./portdetector.sh <PORT>

# Check if a port number is provided as an argument
if [ $# -eq 0 ]; then
  echo "Error: Please provide a port number as an argument."
  exit 1
fi

# Get the port number from the first argument
port="$1"

# Use ss command to find process information (modern systems)
# Add -t for TCP connections, -n for numeric output, 
# -p for process information, and 'sport = :$port' to filter by port
process_info=$(sudo ss -tlnp "sport = :$port")

# Check if ss command is not available, use netstat as fallback
if [ -z "$process_info" ]; then
  # Use netstat with similar flags, grep for TCP connections and the port number
  process_info=$(sudo netstat -nlp | grep ":${port} " | grep tcp)
fi

# Check if any process information was found
if [ -z "$process_info" ]; then
  echo "No process found using port $port."
else
  # Extract PID and potentially process name from the output
  # May require modification depending on the used command (ss or netstat)
  pid=$(echo "$process_info" | awk '{print $NF}' | cut -d "/" -f1)
  process_name=$(echo "$process_info" | awk '{print $NF}' | cut -d "/" -f2-)
  
  # Display the found information
  if [ -z "$process_name" ]; then
    echo "PID: $pid (process name unavailable)"
  else
    echo "Process: $process_name (PID: $pid)"
  fi
fi

