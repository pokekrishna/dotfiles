# .zshrc
## Install
- Append the following line to your .zshrc after installing ohmyzsh
```sh
source /PATH/TO/THIS/REPO/myzsh.sh
``` 

- Edit the list of plugins to enable in the ~/.zshrc
```sh
plugins=(
  git
  golang
  kubectl
)
```

- Mod the _robbyrussell_ theme
```sh
cd ~/.oh-my-zsh/themes
rm robbyrussell.zsh-theme
ln -s /PATH/TO/THIS/REPO/robbyrussell.zsh-theme
```
# .vimrc
## Install
```sh
cd; 
ln -s /PATH/TO/THIS/REPO/.vimrc .vimrc
```

# ssh config
## Install
```sh
cd ~/.ssh;
ln -s /PATH/TO/THIS/REPO/ssh_config config
```
