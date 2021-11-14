#! /usr/bin/env bash

RELEASE="nix-2.4"
URL="https://releases.nixos.org/nix/$RELEASE/install"

[[ ! -z "$1" ]] && URL="$1"

if command -v nix > /dev/null; then
    echo "nix is already installed on this system."
else
    bash <(curl -L $URL) --daemon
fi
