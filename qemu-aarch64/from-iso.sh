####

# useful read: https://github.com/ghik/kubernetes-the-harder-way/blob/main/docs/01_Learning_How_to_Run_VMs_with_QEMU.md#uefi

####

# qemu-img create -f raw -o preallocation=full ubuntu-server.img 60G #Only during OS install

efi_firm="$(dirname $(which qemu-img))/../share/qemu/edk2-aarch64-code.fd"

# dd if=/dev/zero conv=sync bs=1m count=64 of=ubuntu_ovmf_vars.fd #Only during OS install
 

qemu-system-aarch64 \
  `# Order of the devices in this command alters the device (or interface) number in guest `\
  `# Toggle commenting between following two lines to use monitor mode or serial mode `\
  `# -monitor stdio #This line enables qemu monitor on command line` \
  -serial stdio `#This line enables serial mode on command line` \
  -serial file:/tmp/vm1.sr `#This line directs serial port to a file` \
  -parallel file:/tmp/vm1.pr `#This line directs parallel port a file` \
  -machine virt,highmem=on \
  -accel hvf \
  -cpu host \
  -smp cpus=5 \
  -m 8G \
  `#-device virtio-gpu-pci` `#Add GUI`  \
  -bios ${efi_firm} \
  -display default,show-cursor=on \
  -drive file=ubuntu_ovmf_vars.fd,if=pflash,index=1,format=raw \
  -object iothread,id=io1 \
  -device virtio-blk-pci,drive=disk0,iothread=io1 \
  -drive if=none,id=disk0,cache=unsafe,format=raw,aio=threads,file=ubuntu-server.img \
  \
  -netdev vmnet-bridged,id=net0,ifname=en0 `# networking device (present in the host)` \
  -device virtio-net-pci,netdev=net0 `# networking driver (present in the guest). enp0s2` \
  -netdev vmnet-host,id=net1,start-address=192.168.64.1,end-address=192.168.64.20,subnet-mask=255.255.255.0 `# isolated network for ssh only` \
  -device virtio-net-pci,netdev=net1 `# networking driver (present in the guest). enp0s3` \
  \
  `#-device qemu-xhci` `#USB 3.0 controller device. Only during OS install or GUI` \
  `#-device usb-kbd` `#USB keyboard device. Only during OS install or GUI` \
  `#-device usb-tablet` `#USB tablet (mouse) device. Only during OS install or GUI` \
  `#-device intel-hda` `#Intel HD Audio controller. Only during OS install or GUI` \
  `#-device hda-duplex` `#HDA duplex audio codec. Only during OS install or GUI` \
  \
  -d guest_errors,int \
  # -cdrom ubuntu-live-server-arm64.iso #Only during OS install


# Tried and tested Networking Backends
# Working (also safe for offic wifi)
#   -netdev user,id=net0,hostfwd=tcp::2222-:22 `# networking device (present in the host)` \

# Working (MAY NOT work with offic wifi)
# -netdev vmnet-bridged,id=net0,ifname=en0 `# networking device (present in the host)` \

# NOT Working / crashing
# -netdev vmnet-shared,id=net0 `# networking device (present in the host)` \