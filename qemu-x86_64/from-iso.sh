qemu-img create -f qcow2 ubuntux86_64.qcow2 40G #Only during OS install

efi_firm="$(dirname $(which qemu-img))/../share/qemu/edk2-x86_64-code.fd"

efi_firm_vars="$(dirname $(which qemu-img))/../share/qemu/edk2-i386-vars.fd"

cp -v ${efi_firm_vars} ubuntux86_64_ovmf_vars.fd #Only during OS install
 
host_dir="/Users/krishnagupta/Documents/git-repos/"

qemu-system-x86_64 \
  -serial stdio \
  -M pc \
  -cpu qemu64 \
  -accel tcg,thread=multi \
  -smp 4 \
  -m 2G \
  -drive file=ubuntux86_64.qcow2,if=virtio,cache=writethrough \
  -netdev user,id=n0,hostfwd=tcp::3333-:22 -device virtio-net-pci,netdev=n0 \
  -virtfs local,path=${host_dir},mount_tag=host0,security_model=mapped,id=host0 \
  -device virtio-gpu-pci \
  -display default,show-cursor=on \
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-tablet \
  -device intel-hda \
  -device hda-duplex \
  -cdrom /tmp/ubuntu-22.04-live-server-amd64.iso #Only during OS install
  # -bios ${efi_firm} \
  # -drive file=ubuntux86_64_ovmf_vars.fd,if=pflash,index=0,format=raw \
  

### Graveyard notes
# try: better machine
# try: better cpu
###################