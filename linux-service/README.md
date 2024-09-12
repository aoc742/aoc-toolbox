# Creating a Linux Service
This folder includes instructions for creating a linux service that runs on startup, thus eliminating the need to rerun some commands every time your computer is rebooted.

# Setup
1. Create .sh script or application to be executed on Linux startup.
2. Create a .service file that defines the service configuration and script to be started as a service
3. Run commands to enable the linux service.

## 1. Create Custom .sh script or application
This is your custom script or application that will be executed by the service when the Linux computer is started.

## 2. Create .service Service file
This is the file that defines your custom service. It includes the details on running the file you create from step 1. 

## 3. Running as a Service
How do you want your service to run?
a. Individual user (the service activates when a specific user session is active)
b. Global user (the service activates when any user session is active)
c. System wide (the service activates when the system starts, before any user sessions are active)

Refer to the corresponding sub-section (a/b/c) below.

For more information on the difference between the 3 types of services, see "Where to put your service file" section further below.

### a. Individual user service
```
sudo cp <your service>.service /usr/lib/systemd/user/
systemctl daemon-reload
systemctl --user enable <your service>.service
systemctl --user start <your service>.service
systemctl --user status <your service>.service
```
The service is now started and will auto-start upon computer reboot.

### b. Global user service
```
sudo cp <your service>.service /etc/systemd/user/
systemctl daemon-reload
systemctl --global enable <your service>.service
systemctl --global start <your service>.service
systemctl --global status <your service>.service
```

### c. System wide service
```
sudo cp <your service>.service /etc/systemd/system/
systemctl daemon-reload
systemctl --system enable <your service>.service
systemctl --system start <your service>.service
systemctl --system status <your service>.service
```

## Where to put your service file
The `systemctl daemon-reload` command will reload service files from all viable locations. You can this full list of locations by running the following:

```
systemd-analyze --user unit-paths
systemd-analyze --global unit-paths
systemd-analyze --system unit-paths
```

* `--user`: List of locations where you can put your *per-user* configs
* `--global`: Admin users can put services in the following locations, which will affect *all* users
* `--system`: These locations are meant for installed services from a package manager. These services affect the *entire system* as a whole. 

NOTE: user services ONLY run while a user session is active

Recommended location to put your service file:
* Individual user service: `/usr/lib/systemd/user/`
* Global user service: `/etc/systemd/user/`
* System service: `/etc/systemd/system/`

## Enabling sudo or admin privileges
