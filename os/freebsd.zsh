export PATH="$PATH:/usr/games:/usr/local/bin:/usr/local/sbin"

alias zfs-eff="zfs-stats -ED"
alias zpool-io="zpool iostat 1"

alias xsel-pwd="pwd | tr -d '\n' | xsel -b"
alias cd-xsel='cd `xsel -b`'
function xsel-b() {
    if [ $# -ne 0 ]; then
        echo $* | tr -d '\n' | xsel -b
    else
        xsel -b
    fi
}

