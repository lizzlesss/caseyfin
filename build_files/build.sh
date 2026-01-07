#!/bin/bash

set -ouex pipefail

# enable rpmfusion
dnf5 install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# intel media driver and codecs
dnf -y install \
    mpv

# packages
dnf -y install \
    android-tools \
    mangohud \
    steam \
    btop \
    waydroid
    
# nbfc-linux official rpm
dnf5 install -y https://github.com/nbfc-linux/nbfc-linux/releases/download/0.3.19/fedora-nbfc-linux-0.3.19-1.x86_64.rpm

# legcord
dnf5 install -y https://github.com/Legcord/Legcord/releases/download/v1.1.6/Legcord-1.1.6-linux-x86_64.rpm

# copr repos
dnf -y copr enable bieszczaders/kernel-cachyos-addons
dnf -y copr enable mochaa/android-udev-rules

# copr packages
dnf -y install \
    scx-scheds-git \
    scx-manager \
    android-udev-rules
    
# disable copr repos
dnf -y copr disable bieszczaders/kernel-cachyos-addons
dnf -y copr disable mochaa/android-udev-rules

#### Example for enabling a System Unit File
systemctl enable podman.socket
