#!/bin/bash -e

source ~/.profile
echo "Installing NixOps"
nix-install-package --non-interactive --url http://hydra.nixos.org/build/26740088/nix/pkg/nixops-1.3.1-x86_64-darwin.nixpkg