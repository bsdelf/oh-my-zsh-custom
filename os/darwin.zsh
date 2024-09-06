export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="$PATH:/Library/TeX/texbin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:$HOME/myapp/lib"
export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:/usr/local/lib"
export CLOUD_DOCS_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

alias ldd='otool -L'

alias pbcopy-pwd='pwd | pbcopy'
function pbcopy-file() {
    pbcopy < $*
}

function paste-to-words() {
    word=$(echo -n $(pbpaste) | tr '[:upper:]' '[:lower:]')
    if grep -q $word "$CLOUD_DOCS_PATH/words.txt"; then
        printf 'word "%s" already exists\n' $word
        return
    fi
    echo $word >> "$CLOUD_DOCS_PATH/words.txt"
    tail -n 3 "$CLOUD_DOCS_PATH/words.txt"
}
alias cat-words='cat $CLOUD_DOCS_PATH/words.txt'

alias cd-pbpaste='cd "`pbpaste`"'
alias cd-include='cd /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include'
alias cd-cloud-docs='cd $CLOUD_DOCS_PATH'

# move word by word
bindkey "[D" backward-word
bindkey "[C" forward-word

OPEN_COMMAND=open
