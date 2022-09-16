
## Dependencies

1. [FSWatch](https://github.com/emcrisostomo/fswatch)

## Guest
### 1. Directory to sync
```sh
DIR=/Users/krishnagupta/Documents/git-repos/
mkdir -p $DIR
chown $USER.$USER $DIR
```

## Host
### 1. Install fswatch
```sh
brew install fswatch
```

### 2. Sync
For each directory you want to sync, execute the followind in separate terminals

  Note: Use `--exclude` to exclude sub dir to sync. **Remeber**: Path is relative
```sh
DIR=/Users/krishnagupta/Documents/git-repos/lambda ## NOTE; should not end with slash '/'

mkdir $HOME/.ssh/ctl

ssh -nNf -T -o Compression=no -x -c aes128-gcm@openssh.com -o ControlMaster=auto -o ControlPath="$HOME/.ssh/ctl/%L-%r@%h:%p" vm1
function run_rsync() { rsync --exclude tmp --exclude log --delete -a -P -e "ssh -T -o Compression=no -x -c aes128-gcm@openssh.com -o 'ControlPath=$HOME/.ssh/ctl/%L-%r@%h:%p' " $DIR/ vm1:$DIR } ;


run_rsync; fswatch -o $DIR | while read f; do run_rsync; done
```
