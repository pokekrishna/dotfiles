# Aarch 64 VM on M1
## Roadmap
- [x] Change host<>guest networking using vmnet and remove documentation related to tuntaposx
  - [Apple VMNet.Framework](https://developer.apple.com/documentation/vmnet)
  - [QEMU 7.1 has built in support for VMNET](https://github.com/lima-vm/socket_vmnet#how-is-socket_vmnet-related-to-qemu-builtin-vmnet-support)
  - [An example that makes use of QEMU+VMNet](https://gist.github.com/max-i-mil/f44e8e6f2416d88055fc2d0f36c6173b)

## Usage
### 1. Get ISO
VM from installation ISO on Apple Silicon.

Download ISO from: https://ubuntu.com/download/server/arm and rename is as `ubuntu-live-server-arm64.iso`

Tested on:
  - Ubuntu Server 22.04 LTS. - Works ✅
  - Ubuntu Server 22.04 LTS. - Doesn't work
  - Ubuntu Server 20.04 LTS. - Works ✅


### 2. Run the <a href="from-iso.sh">Script</a>
In the first time usage, you would want to install the OS on a virtual disk (qcow2), so **make sure to uncomment the lines** in the script which have the comment `#Only during OS install`
```sh
cd ~/Documents/virtual-machines/ubuntuaarch64
sudo /PATH/TO/THIS/REPO/qemu-aarch64/from-iso.sh
```

### 3. Copy networking files to /etc/netplan/ using `serial` mode
IMPORTANT: NOT REQUIRED IF YOU ARE NOT USING VMNET SHARED DEVICE
- [02-configure-guest-network.yaml](02-configure-guest-network.yaml)
```sh
sudo netplan apply
```

### 4. Sharing Directory between Host and Guest
```sh
grep host_machine /etc/hosts || echo  "192.168.64.1 host_machine" >> /etc/hosts
```
To Use Rsync (**recommended**): Follow the [instructions from automated-file-transfer](../automated-file-transfer/README.md#guest)

To Use Samba: Then follow the [instructions from smbd](../smbd/README.md#mount-on-linux-guest) section

### 6. Edit Sudoers
`sudo visudo` to enable NOPASSWD for the sudo group 
```
# Allow members of group sudo to execute any command
%sudo	ALL=(ALL:ALL) NOPASSWD: ALL
```



## Troubleshooting 
### 1. Guest Networking

#### 1.1 Refresh networking from within guest
```sh
sudo netplan apply
```

#### 1.2 Add more VPN routes
This routes will have affect until restart
```sh
ip r add 10.10/16 via 192.168.254.2 dev enp0s4 metric 90
```


## Status
- [x] boot and install
- [x] shutdown and starts
- [x] ssh from host (using tap device)
- [x] host dir share
- [x] access vpn routing 
- [x] automount dir share
- [] get vm ip automatically and use while mounting nfs drive, ssh_config
- [ ] move back redirecting monitor to stdio, instead of serial
- [ ] deny installation of kernel extensions by user using Mac OS _Recovery Mode_
- [ ] Vendor the TunnelBlick repo in this repo

