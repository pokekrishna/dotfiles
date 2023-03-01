# qemu-img create -f raw -o preallocation=full ubuntu-server.img 60G #Only during OS install


efi_firm="$(dirname $(which qemu-img))/../share/qemu/edk2-aarch64-code.fd"
# dd if=/dev/zero conv=sync bs=1m count=64 of=ubuntu_ovmf_vars.fd #Only during OS install
 

qemu-system-aarch64 \
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
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-tablet \
  -device intel-hda \
  -device hda-duplex \
  -drive file=ubuntu_ovmf_vars.fd,if=pflash,index=1,format=raw \
  -object iothread,id=io1 \
  -device virtio-blk-pci,drive=disk0,iothread=io1 \
  -drive if=none,id=disk0,cache=unsafe,format=raw,aio=threads,file=ubuntu-server.img \
  -netdev tap,id=mytap0,ifname=tap0,script=/Users/krishnagupta/Documents/git-repos/dotfiles/qemu-aarch64/qemu-ifup.sh,downscript=/Users/krishnagupta/Documents/git-repos/dotfiles/qemu-aarch64/qemu-ifdown.sh -device e1000,netdev=mytap0,mac=52:55:00:d1:55:02 \
  -netdev user,id=myslirp0,net=192.168.254.0/24,dhcpstart=192.168.254.9 -device e1000,netdev=myslirp0 \
  # -cdrom ubuntu-20.04.5-live-server-arm64.iso #Only during OS install
