# The next line binds a shortcut to bashlike. `control+u` will remove line before the cursor UNLIKE THE DEFAULT 'remove the entire line'
bindkey \^U backward-kill-line


# STARTS aliases 
alias us="/Users/krishnagupta/opt/lubuntu-vm-ops/lubuntu-vm-start-and-ssh.sh"
alias ustop="/Users/krishnagupta/opt/lubuntu-vm-ops/lubuntu-vm-stop-savestate.sh"
alias rst='cd $(mktemp -d); clear'
alias hisl='history|less'
alias kcx='kubectx'
alias kns='kubens'
alias kcxs='CL=`kubectx -c`; (( START = ${#CL}-20 )); echo ${CL:$START}'
alias enable-kcx-prompt='PROMPT=\`kcxs\`⎈$PROMPT'
alias disable-kcx-prompt='source ~/.zshrc'
# END alases