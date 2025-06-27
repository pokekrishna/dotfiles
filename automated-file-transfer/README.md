
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
For each directory you want to sync, create a copy of the [file-transfer](./file-transfer.sh).

Change the `DIR` variable and `--exclude` option

  Note: Use `--exclude` to exclude sub dir to sync. **Remeber**: Path is relative

```sh
./generic.sh vm1 /Users/krishnagupta/Documents/git-repos/repo-one
```
