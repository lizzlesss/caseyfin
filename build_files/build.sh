#!/bin/bash

set -ouex pipefail

# remove stock kernel
for pkg in kernel kernel-core kernel-modules kernel-modules-core; do
  rpm --erase $pkg --nodeps
done

# disable initramfs generation by the kernel
ln -sf /usr/bin/true /usr/lib/kernel/install.d/05-rpmostree.install
ln -sf /usr/bin/true /usr/lib/kernel/install.d/50-dracut.install

# install cachyos kernel
dnf -y copr enable bieszczaders/kernel-cachyos
dnf -y copr disable bieszczaders/kernel-cachyos
dnf -y --enablerepo copr:copr.fedorainfracloud.org:bieszczaders:kernel-cachyos install \
  kernel-cachyos \
  kernel-cachyos-devel-matched

# enable rpmfusion
dnf5 install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# packages
dnf -y install \
    android-tools \
    mangohud \
    steam \
    btop \
    waydroid \
    gnome-tweaks
    
# nbfc-linux official rpm
dnf5 install -y https://github.com/nbfc-linux/nbfc-linux/releases/download/0.3.19/fedora-nbfc-linux-0.3.19-1.x86_64.rpm

# copr repos
dnf -y copr enable bieszczaders/kernel-cachyos-addons
dnf -y copr enable mochaa/android-udev-rules

# copr packages
dnf -y install \
    scx-scheds-git \
    scx-manager \
    android-udev-rules \
    ananicy-cpp
    
# disable copr repos
dnf -y copr disable bieszczaders/kernel-cachyos-addons
dnf -y copr disable mochaa/android-udev-rules

#### Example for enabling a System Unit File
systemctl enable podman.socket
