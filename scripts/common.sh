GENTOO_PLUGIN_DIR=${GENTOO_PLUGIN_DIR:-${SCRIPTSDIR}/..}

export http_proxy="$REPO_PROXY"
export https_proxy="$REPO_PROXY"

if ! command -v geni >/dev/null; then
    source "$SCRIPTSDIR/geni.sh"
else
    echo "*" >&2
    echo "* geni command already exists: $(command -v geni)" >&2
    echo "*" >&2
fi

read_list_from_file() {
    sed -r -e 's@(^#.*$)|([[:space:]]+#.*$)@@' "$1"
}

unless_done() {
    local id="$1"; shift
    local hashed_command=$(sha256sum <<< "$id::$*")
    hashed_command=${hashed_command%%  -}
    local steps_dir=$CACHEDIR/steps

    if [[ $GENTOO_PLUGIN_CLEAN_START = 1 ]]; then
        rm -rf "$steps_dir"
    fi

    if [[ -f $steps_dir/$hashed_command ]]; then
        echo "Command already executed: $*" >&2
        echo "Marker exists: $steps_dir/$hashed_command" >&2
    else
        "$@"
        local rc=$?
        mkdir -p "$steps_dir"
        echo "$*" >"$steps_dir/$hashed_command"
        return $rc
    fi
}

(( VERBOSE >= 2 || DEBUG > 0 )) && set -x || true
