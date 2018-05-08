export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="$PATH:/Library/TeX/texbin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:$HOME/myapp/lib"
export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:/usr/local/lib"

alias ldd='otool -L'

alias pbcopy-pwd='pwd | pbcopy'
function pbcopy-file() {
    pbcopy < $*
}

alias cd-pbpaste='cd "`pbpaste`"'
alias cd-include='cd /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include'
