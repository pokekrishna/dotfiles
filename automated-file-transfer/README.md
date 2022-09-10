
## Dependencies

1. [FSWatch](https://github.com/emcrisostomo/fswatch)

## Guest
### 1. Directory to sync
```mkdir -p /Users/krishnagupta/Documents/git-repos/```

## Host
### 1. Install fswatch
```sh
brew install fswatch
```

### 2. Sync
```sh
ssh -O exit -o ControlPath="$HOME/.ssh/ctl/%L-%r@%h:%p" vm1 # TERMINATE

mkdir $HOME/.ssh/ctl
ssh -nNf -T -o Compression=no -x -c aes128-gcm@openssh.com -o ControlMaster=auto -o ControlPath="$HOME/.ssh/ctl/%L-%r@%h:%p" vm1

DIR=/Users/krishnagupta/Documents/git-repos/lambda ## NOTE; should not end with slash '/'
function run_rsync() { rsync --delete -a -P -e "ssh -T -o Compression=no -x -c aes256-gcm@openssh.com -o 'ControlPath=$HOME/.ssh/ctl/%L-%r@%h:%p' " $DIR/ vm1:$DIR } ;

run_rsync; fswatch -o $DIR | while read f; do run_rsync; done

ssh -O exit -o ControlPath="$HOME/.ssh/ctl/%L-%r@%h:%p" vm1 # TERMINATE
```
<!-- ## Graveyard notes
ssh multiplexing 
    https://unix.stackexchange.com/questions/50508/reusing-ssh-session-for-repeated-rsync-commands

    mkdir $HOME/.ssh/ctl
    ssh -nNf -o ControlMaster=yes -o ControlPath="$HOME/.ssh/ctl/%L-%r@%h:%p" vm1


rsync 
    alias run_rsync='rsync -azP --exclude ".*/" --exclude ".*" --exclude "tmp/" ~/Documents/repos/my_repository username@host:~'
run_rsync; fswatch -o . | while read f; do run_rsync; done




DIR=/Users/krishnagupta/Documents/git-repos/lambda
alias run_rsync='rsync -a -P -e "ssh -T -c arcfour -o Compression=no -x" $DIR vm1:$DIR'
run_rsync; fswatch -o $DIR | while read f; do run_rsync; done
 -->

## TODO
[] sometimes control file keeps lingering, upon which the ssh multiplexing is disabled

