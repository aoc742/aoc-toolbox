# Subnet Scanner

Did DHCP change the IP address of a headless computer, and now you don't know its IP address? This is for you!

Below is a list of ways to find that headless computer. Assuming it is on and visible on the network, select one of the following ways to find it.

# arp
This is a tool that lists all cached devices that have communicated with your computer since your computer has been
turned on and on the network. This is NOT an active network scan.

```
arp -a
```

# arp-scan
This is an active network scan that will identify all devices currently on a specified subnet.

First, install arp-scan:

```
sudo apt install arp-scan -y
```

Then you can scan all devices on a specific interface and subnet. Example:

Type `ip a` or `ifconfig` to get the interface name. Then type:

```
sudo arp-scan --interface=enp89s0 192.168.1.0/24
```

# scan_subnet.sh
This is a manual brute force method of pinging all devices on a specified subnet. It loops over pinging every IP
address on a subnet, waiting 1 second for a response, and then listing out the IP address of every device that responds.

```
./scan_subnet.sh 192.168.1.0/24
```