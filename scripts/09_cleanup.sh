#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :

# 09_cleanup.sh
#
# Clean up the new chroot prior to image finalisation.

echo "--> Gentoo 09_cleanup.sh"

source "$SCRIPTSDIR/common.sh"

set -e

echo "  --> Cleaning portage distfiles..."
geni manage clean-dist

echo "  --> Creating empty /etc/resolv.conf..."
>"$INSTALLDIR"/etc/resolv.conf

echo "  --> Done."
