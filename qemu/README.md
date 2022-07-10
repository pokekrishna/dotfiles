# DESCRIPTION
## _from-iso.sh_
VM from installation ISO on Apple Silicon.

ISO from: https://cdimage.ubuntu.com/focal/daily-live/current/ 

### Status
- [x] boot and install
- [x] shutdown and starts
- [x] ssh from host
- [x] host dir share

### Mounting host shared directory
Inside Guest OS
```sh

sudo mount -t 9p -o trans=virtio host0 /mnt -oversion=9p2000.L
```

