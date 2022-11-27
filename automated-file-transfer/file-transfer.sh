# /bin/bash

# Use `--exclude` to exclude sub dir to sync. **Remeber**: Path is relative

DIR=/Users/krishnagupta/Documents/git-repos/lambda ## NOTE; should not end with slash '/'

mkdir $HOME/.ssh/ctl

ssh -nNf -T -o Compression=no -x -c aes128-gcm@openssh.com -o ControlMaster=auto -o ControlPath="$HOME/.ssh/ctl/%L-%r@%h:%p" vm1

function run_rsync() { 
    rsync --exclude .bundle --exclude tmp --exclude log --exclude Gemfile.lock --delete -a -P -e "ssh -T -o Compression=no -x -c aes128-gcm@openssh.com -o 'ControlPath=$HOME/.ssh/ctl/%L-%r@%h:%p' " $DIR/ vm1:$DIR 
};

run_rsync; fswatch -o $DIR | while read f; do run_rsync; done