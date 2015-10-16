#!/bin/bash -e

DIST="`pwd`"
DMG=~/NixStore.dmg

echo "Creating disk image"
hdiutil create -size 8G -fs "Case-sensitive HFS+" -volname NixStore $DMG
sudo mkdir -p /nix
sudo chown $USER /nix
./attach-disk.sh

echo "Downloading and installing Nix"
sudo chown -R $USER /nix
curl https://nixos.org/nix/install | sh

echo "Adding environment variables to ~/.profile"
RCFILE=~/.profile
echo "source ~/.nix-profile/etc/profile.d/nix.sh" >> $RCFILE

echo "Now logout and back in to use Nix, or source ~/.profile now."
