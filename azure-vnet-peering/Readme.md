# Network virtual Appliance NVA

Login via ssh to vm2 and invoke:
```commandline
 sudo vim /etc/sysctl.conf
```

Uncoment that line:
```commandline
net.ipv4.ip_forward=1
```

Reboot:
```
sudo reboot
```