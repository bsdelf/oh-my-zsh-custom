######## history ########
HISTSIZE=999999
SAVEHIST=999999
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

######## locale ########
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

######## path ########
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin/"
export PATH="$PATH:$HOME/Library/Python/2.7/bin/"
if type go > /dev/null; then
    export PATH="$HOME/go/bin/:$PATH"
fi

######## pager ########
function cond_export() {
    if type $3 > /dev/null; then
        export $1=$3
    else
        export $1=$2
    fi
}
cond_export PAGER less vimpager
cond_export EDITOR vi vim

alias edit-zshrc="$EDITOR ~/.zshrc"
alias reload-zshrc="source ~/.zshrc"
alias edit-ascii="$EDITOR /usr/share/misc/ascii"

alias dh='df -h'
alias ds='du -shc'

alias zu='su -l'

alias llt='ls -lht'
alias lt='tree -N -C'
alias ltt='tree -N -C --sort=mtime'
alias l2='tree -N -C -L 2'
alias l3='tree -N -C -L 3'
alias l4='tree -N -C -L 4'
alias l5='tree -N -C -L 5'
alias l6='tree -N -C -L 6'
alias ls-dot='ls -tlcd .*'
alias ls-ssh='ls -tl ~/.ssh'
alias R='R --save'

alias date-stamp='date +"%Y.%m.%d-%H:%M:%S"'

alias cal3='cal -A 1 -B 1'
alias ncal3='ncal -A 1 -B 1 -M'

function mkcd() {
    nocorrect mkdir -p "$1" && cd "$1"
}

function scp-files-to-dir() {
    if [ $# -le 1 ]; then
        echo "[files] [dest...]"
        return
    fi
    idx=1
    args=("$@")
    dest="${@: -1}/"
    while [ "$idx" -lt $# ]; do
        file="$args[$idx]"
        echo $file '=>' $dest"`basename $file`"
        scp $file $dest"`basename $file`"
        idx=`echo $idx+1|bc`
    done
}

#===============================
# curl
#===============================
alias curl-json='curl -H "Content-Type:application/json"'

#===============================
# ssh 
#===============================
function ssh-keygen-rsa() {
    ssh-keygen -t rsa -b 4096 -C "$1"
}

#===============================
# rsync 
#===============================
# rsync-if-exist src/ dest/
alias rsync-if-exist="rsync -rPhzc --existing" 
# rsync-skip-dot src/ dest/
alias rsync-skip-dot="rsync -avc --exclude='.*'"
# rsync-mirror src/ dest/
alias rsync-mirror="rsync -avc --delete"
# rsync-list list src/ dest/
alias rsync-list="rsync -avc --delete --files-from"

#===============================
# screen
#===============================
alias screen-attach='screen -r'
alias screen-serial='screen  /dev/cu.usbserial 57600,cs8,-cstopb,-parity,-crtscts'
alias screen-tiva='screen /dev/cu.usbmodem* 115200,cs8'

#===============================
# tmux
#===============================
alias t='tmux'
alias ta='tmux attach'
alias tat="tmux attach -t"
alias td='tmux detach'
alias tl="tmux list-sessions"
alias tmux-reload="tmux source-file /usr/local/etc/tmux.conf && tmux source-file ~/.tmux.conf"

#===============================
# version control 
#===============================
alias gits='git status'
alias gits-uno='git status -uno'
alias git-diff='git diff --color=always'
alias git-log="git log --fllow -p"
function git-stash-show() {
    #re='^[0-9]+$'
    #if ! [[ $1 =~ $re ]]; then
    #    echo "Usage: git-stash-show <num>"
    #    return
    #fi
    if [[ $# -lt 1 ]]; then
        git stash list
        return
    fi
    params=''
    if [[ $# -gt 1 ]]; then
        params=$2
    fi
    stash="stash@{$1}"
    echo "$stash:"
    git stash show $params $stash
}
function up() {
    if [ -d ".git" ]; then
        echo "git pull origin $*"
        git pull origin $*
    elif [ -d ".svn" ]; then
        echo "svn up"
        svn up
    elif [ -d ".hg" ]; then
        echo "hg pull"
        hg pull
        echo "hg update"
        hg update
    else
        echo "bad repository!"
    fi
}

#===============================
# vim 
#===============================
alias vp="vimpager"
alias v='vim'
alias vse="vim -S"
function vdir() {
    vim `find $* -not -path '*/\.*' -type f `
}
function vex() {
    vim `lsex -l $*`
}

#===============================
# find 
#===============================
alias find-name="find . -name"
alias find-file="find . -not -path '*/\.*' -type f -name "
alias touch-all="find . -exec touch -- {} +"

function prepend-file-to() {
    if [ $# -le 1 ]; then
        echo "[template file] [target files...]"
        return
    fi
    for origfile in "${@:2}"; do
        tempfile="$1".`uuid`.tmp
        cat "$1" "$origfile" > "$tempfile" && mv "$tempfile" "$origfile"
    done
}

#===============================
# nodejs 
#===============================
alias npm-install-taobao='npm install --registry=https://registry.npm.taobao.org'

##########
# docker #
##########

function docker-clean() {
    filter=""
    for i in $(seq 1 255); do
        filter="$filter -f exited=$i"
    done
    ids=$(docker ps -a $(printf "$filter") -q | sort | uniq | paste -s -d" ")
    if [ ! -z "$ids" ]; then
        printf "Remove aborted containers:\n$ids\n"
        docker rm $(printf "$ids")
    fi
    ids=$(docker images -f dangling=true -q | sort | uniq | paste -s -d" ")
    if [ ! -z "$ids" ]; then
        printf "Remove dangling images:\n$ids\n"
        docker rmi $(printf "$ids")
    fi
}

