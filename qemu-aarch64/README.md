# QEMU
## _from-iso.sh_
VM from installation ISO on Apple Silicon.

ISO from: https://cdimage.ubuntu.com/focal/daily-live/current/ 

### Usage
In the first time usage, you would want to install the OS on a virtual disk (qcow2), so **make sure to uncomment the lines** in the script which have the comment `#Only during OS install`

### Status
- [x] boot and install
- [x] shutdown and starts
- [x] ssh from host
- [x] host dir share

### Mounting host shared directory
Inside Guest OS:
```sh
sudo mount -t 9p -o trans=virtio host0 /mnt -oversion=9p2000.u
```
