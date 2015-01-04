if [[ -n $SSH_CONNECTION ]]; then  
  PROMPT='[%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}] %{$fg[cyan]%}»%{$reset_color%} '
else
  PROMPT='[%{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}] %{$fg[cyan]%}»%{$reset_color%} '
fi

RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_DIRTY=") %{$fg[red]%}±"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=") %{$fg[green]%}○"