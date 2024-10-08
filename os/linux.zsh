alias code='code-oss'

alias sensors="sensors 2> /dev/null"

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

CACHE_TMP_FOLDER="/tmp/$(whoami).cache"
CACHE_HOME_FOLDER="$HOME/.cache"
mkdir -p "$CACHE_TMP_FOLDER"
if [[ ! -d "$CACHE_HOME_FOLDER" ]]; then
    ln -s "$CACHE_TMP_FOLDER" "$CACHE_HOME_FOLDER"
fi

function open() {
    xdg-open "$@" > /dev/null 2>&1
}

function watch-cpu-freq() {
  watch -n2 "grep 'cpu MHz' /proc/cpuinfo | sort -k4 -n -r"
}

OPEN_COMMAND=xdg-open
