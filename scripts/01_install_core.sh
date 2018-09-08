#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :

# 01_install_core.sh
#
# Bootstrap Gentoo system in chroot (download stage3 tarball, extract it),
# configure, and upgrade.

echo "--> Gentoo 01_install_core.sh"

source "$SCRIPTSDIR/common.sh"

set -e

echo "  --> Downloading and unpacking base system..."
unless_done 10 geni manage bootstrap

echo "  --> Configuring system for Qubes..."
geni manage install-tree "$SCRIPTSDIR/config"
unless_done 11a geni manage configure \
    --locale=en_US.UTF-8
if ! [[ -e $INSTALLDIR/etc/udev/rules.d/80-net-name-slot.rules ]]; then
    unless_done 11b geni manage configure \
        --net-simple-names
fi

echo "  --> Syncing repository..."
unless_done 12 geni manage sync-repo

echo "  --> Setting system profile..."
unless_done 13 geni manage configure \
    --portage-profile=default/linux/amd64/17.0/desktop

echo "  --> Upgrading system..."
unless_done 14 geni manage upgrade
