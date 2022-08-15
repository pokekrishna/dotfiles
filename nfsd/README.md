# NFS Daemon Setup Instructions

## MacOS Host
Enable full disk access to `nfsd` using `Security & Privacy`

<img  width="400" src="allow-disk-access-nfsd.png">

```sh
PATH_TO_THIS_REPO=/Users/krishnagupta/Documents/git-repos/dotfiles

sudo nfsd -F ${PATH_TO_THIS_REPO}/nfsd/exports checkexports && \
sudo cp ${PATH_TO_THIS_REPO}/nfsd/exports /etc/exports && \
sudo nfsd checkexports && \
sudo nfsd restart
```

## VM Client
```sh
HOST_MACHINE_ETH0_ADDRESS=192.168.1.12
apt install nfs-common #installs mount.nfs command
sudo mount.nfs -v ${HOST_MACHINE_ETH0_ADDRESS}:/Users/krishnagupta/Documents/git-repos /mnt -o vers=3
```