#!/usr/bin/env bash

declare -r TMPDIR="$(mktemp -d)"
declare -r REPO_URL="https://github.com/Frontear/dotfiles"
declare -r OUTPUT="nixosConfigurations.LAPTOP-3DT4F02.config.system.build.toplevel"

declare -r NIX="@nix@"
declare -r NIX_SUPER="@nix_super@"
declare -r LIX="@lix@"

eval() {
  sudo "$1/bin/nix-daemon" --daemon &
  local pid=$!

  hyperfine "$1/bin/nix eval .#${OUTPUT}.drvPath --option eval-cache false"

  sudo kill ${pid}
}

sudo systemctl stop nix-daemon.service
sudo systemctl stop nix-daemon.socket

git clone --depth 1 "$REPO_URL" "$TMPDIR"
cd "$TMPDIR"

eval "${NIX}"
eval "${NIX_SUPER}"
eval "${LIX}"

cd "/" # just get out of the directory
rm -rf "$TMPDIR"

sudo systemctl restart nix-daemon.socket
sudo systemctl restart nix-daemon.service
