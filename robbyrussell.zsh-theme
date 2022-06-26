## THIS WAS THE ORIGINAL PROMPT - START ##
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
## THIS WAS THE ORIGINAL PROMPT - END ##

SHELL_HOSTNAME="MBP"
PROMPT="%(?:%{$fg_bold[green]%}${SHELL_HOSTNAME} :%{$fg_bold[red]%}${SHELL_HOSTNAME} )"
PROMPT+=' %{$fg[cyan]%}%5c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
