if [[ -z "$ZSH_THEME" ]]; then
    ZSH_THEME="sterotype"
fi

function try_source() {
    file="$1"
    if [ -f "$file" ]; then
        source "$file"
    fi
}

try_source "$ZSH_CUSTOM/os/generic.pre.zsh"
try_source "$ZSH_CUSTOM/os/$(uname -s | tr '[:upper:]' '[:lower:]').zsh"
try_source "$ZSH_CUSTOM/os/generic.after.zsh"
try_source "$HOME/.zshrc.local"
try_source "$HOME/.zshrc.private"
