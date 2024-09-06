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

function svn-co-port() {
    url="https://svn.FreeBSD.org/ports/head/$1"
    cmd="svn co ${url}"
    echo $cmd
    eval $cmd
}

alias svn-diff-port="svn diff > ../`make -VPKGNAME`.diff"

alias pkg-msg="pkg info -D"
alias pkg-fresh='pkg version -vl "<"'

alias port-init='portsnap fetch extract'
alias port-sync='portsnap fetch update'
alias port-rebuild='portmaster -d'
alias port-update='portmaster -w -D -a'
alias port-clean='portmaster --clean-distfiles -y'
alias port-notice='$PAGER /usr/ports/UPDATING'
alias port-dep="\
echo '$fg_bold[white]build-depends-list:$reset_color' && make build-depends-list | sort && \
echo '$fg_bold[white]run-depends-list:$reset_color' && make run-depends-list | sort && \
echo '$fg_bold[red]missing:$reset_color' && make missing | sort"

alias minstall="make install clean"

OPEN_COMMAND=xdg-open
