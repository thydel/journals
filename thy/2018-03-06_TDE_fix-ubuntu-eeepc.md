# Fixes graphic problem on eeepc-1000he with ubuntu-1710

Apply [Bug in Kernel 4.13 : Intel Mobile Graphics 945 shows 80 % black screen][] proposed workaround

First reboot with a working kernel (4.10), then

```
echo "GRUB_GFXPAYLOAD_LINUX=text" | sudo tee /etc/default/grub
sudo update-grub
sudo shutdown -r now
```

[Bug in Kernel 4.13 : Intel Mobile Graphics 945 shows 80 % black screen]:
	https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1724639 "bugs.launchpad.net"
