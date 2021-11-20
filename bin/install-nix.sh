#! /usr/bin/env bash

RELEASE="nix-2.4"
URL="https://releases.nixos.org/nix/$RELEASE/install"

[[ ! -z "$1" ]] && URL="$1"

if command -v nix >/dev/null; then
	echo "nix is already installed on this system."
else
	bash <(curl -L $URL) --daemon
fi

NIX_CONF_PATH=$HOME/.config/nix
if [[ ! -d $NIX_CONF_PATH ]]; then
	mkdir -p $NIX_CONF_PATH
fi

if [[ ! -f $NIX_CONF_PATH/nix.conf ]] || ! grep "experimental-features" <$NIX_CONF_PATH; then
	echo "experimental-features = nix-command flakes" | tee -a $NIX_CONF_PATH/nix.conf
fi
