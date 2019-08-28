#!/bin/bash
# vim: set ts=4 sw=4 sts=4 et :

# 04_install_qubes.sh
#
# Prepare chroot instance as a Qubes template.

echo "--> Gentoo 04_install_qubes.sh"

source "$SCRIPTSDIR/common.sh"

set -e

echo "  --> Setting up user accounts..."
geni chroot exec -- usermod -p '' root
geni chroot exec -- groupadd --force --system --gid 98 qubes
geni chroot exec -- useradd \
    --user-group \
    --groups qubes \
    --create-home \
    --shell /bin/bash \
    user

echo "  --> Creating /lib/modules..."
geni chroot exec -- mkdir /lib/modules
geni chroot exec -- touch /lib/modules/.keep

echo "  --> Updating config files..."
geni manage install-tree "$SCRIPTSDIR/config"

echo "  --> Getting Qubes VM ebuilds..."
geni chroot exec -- layman -S
geni chroot exec -- layman -a aidecoe
geni chroot exec -- bash -c 'cd /var/lib/layman/aidecoe && git checkout qubes && git pull'

echo "  --> Installing Qubes packages..."
geni manage emerge qubes-vm/qubes-vm-meta

echo "  --> Merging configuration changes in /etc..."
geni chroot exec -- etc-update --preen

echo "  --> Enabling downloading through proxy for Portage..."
sed -r -e 's@#DISABLED0001#@@g' -i "$INSTALLDIR"/etc/portage/make.conf

echo "  --> Updating env..."
geni chroot exec -- env-update

echo "  --> Enabling services..."
geni chroot exec systemctl preset-all

echo "  --> Updating eix database..."
geni chroot exec -- eix-update
