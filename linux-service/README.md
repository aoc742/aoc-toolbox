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
Run the following commands to enable the linux service.

```
sudo cp <your service>.service /usr/lib/systemd/user/
systemctl daemon-reload
systemctl --user enable <your service>.service
systemctl --user start <your service>.service
systemctl --user status <your service>.service
```

The service is now started and will auto-start upon computer reboot.
