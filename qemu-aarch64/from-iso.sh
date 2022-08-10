#qemu-img create -f qcow2 ubuntu.qcow2 40G #Only during OS install

efi_firm="$(dirname $(which qemu-img))/../share/qemu/edk2-aarch64-code.fd"
#dd if=/dev/zero conv=sync bs=1m count=64 of=ubuntu_ovmf_vars.fd #Only during OS install
 
host_dir="/Users/krishnagupta/Documents/git-repos/"

qemu-system-aarch64 \
  -monitor stdio `#This line enables qemu monitor on command line` \
  -serial file:/tmp/vm1.sr `#This line directs serial port to a file` \
  -parallel file:/tmp/vm1.pr `#This line directs parallel port a file` \
  -M virt,highmem=on \
  -accel hvf \
  -cpu host \
  -smp 4 \
  -m 6G \
  `#-device virtio-gpu-pci` `#Add GUI`  \
  -bios ${efi_firm} \
  -display default,show-cursor=on \
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-tablet \
  -device intel-hda \
  -device hda-duplex \
  -drive file=ubuntu_ovmf_vars.fd,if=pflash,index=1,format=raw \
  -drive file=ubuntu.qcow2,if=virtio,cache=writethrough \
  -netdev user,id=n0,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=n0 \
  -virtfs local,path=${host_dir},mount_tag=host0,security_model=mapped,id=host0 \
#  -cdrom ../focal-desktop-arm64.iso #Only during OS install
