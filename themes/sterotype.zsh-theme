# /* vim: set filetype=zsh : */ 

if [ "$USER" = "root" ]; then
    local sep="#"
else
    local sep="%%"
fi

local ret_status="%(?:%{$fg_bold[green]%}$HOST:%{$fg_bold[red]%}$HOST)"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)$sep '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
