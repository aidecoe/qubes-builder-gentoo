#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :

# 00_prepare.sh
#
# Install prerequisites:
# - geni - Gentoo chroot management app which can be used also as installer

echo
echo "CACHEDIR=$CACHEDIR"
echo "INSTALLDIR=$INSTALLDIR"
echo

echo "--> Gentoo 00_prepare.sh"

source "$SCRIPTSDIR/common.sh"

set -e

ensure_geni_is_installed
ensure_geni_is_up_to_date
