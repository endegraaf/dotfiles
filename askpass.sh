#!/bin/sh
# source: https://wiki.archlinux.org/index.php/KDE_Wallet#Using_the_KDE_Wallet_to_store_ssh_key_passphrases
# also need to install ksshaskpass executable.
# ~/.config/plasma-workspace/env/askpass.sh
export GIT_ASKPASS='/usr/bin/ksshaskpass'
