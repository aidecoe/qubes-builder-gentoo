#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :


GENI_VENV=geni
VENV_ROOT_DIR=${VENV_ROOT_DIR:-${CACHEDIR}/venv}


venv_activate() {
    source "$(venv_get_path "$1")/bin/activate"
}


venv_exists() {
    [[ -d $(venv_get_path "$1") ]]
}


venv_get_path() {
    echo "${VENV_ROOT_DIR}/$1"
}


venv_make() {
    python3 -m venv "$(venv_get_path "$1")" || return
    venv_upgrade_pip "$1"
}


venv_remove() {
    rm -r "$(venv_get_path "$1")"
}


venv_upgrade_pip() (
    venv_activate "$1" && pip install --upgrade pip
)


ensure_geni_is_installed() {
    [[ -x $(venv_get_path "$GENI_VENV")/bin/geni ]] && return 0

    venv_exists "$GENI_VENV" && venv_remove "$GENI_VENV"
    venv_make "$GENI_VENV" || return
    ( venv_activate "$GENI_VENV" && pip install geni; )
}


ensure_geni_is_up_to_date() {
    ( venv_activate "$GENI_VENV" && pip install --upgrade geni; )
}


geni() {
    [[ $CACHEDIR ]] || return 64
    [[ $INSTALLDIR ]] || return 64

    GENI_WORK_DIR=$CACHEDIR GENI_CHROOT_DIR=$INSTALLDIR \
        $(venv_get_path "$GENI_VENV")/bin/geni "$@"
}
