#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :

# 02_install_groups.sh
#
# Install specified additional packages into chroot.

echo "--> Gentoo 02_install_groups.sh"

source "$SCRIPTSDIR/common.sh"

pkg_list_file=${SCRIPTSDIR}/packages.list

set -e

unless_done 20 geni manage emerge $(read_list_from_file "$pkg_list_file")
