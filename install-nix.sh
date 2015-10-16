#!/bin/bash -e

DMG=~/NixStore.dmg

echo "Creating disk image"
hdiutil create -size 8G -fs "Case-sensitive HFS+" -volname NixStore $DMG
sudo mkdir -p /nix
sudo chown $USER /nix
hdiutil attach $DMG -mountpoint /nix

echo "Downloading and installing Nix"
curl https://nixos.org/nix/install | sh

RCFILE=~/.profile
echo "Adding environment variables to $RCFILE"
echo "
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ];
then
  source ~/.nix-profile/etc/profile.d/nix.sh
else
  if [ -e /nix ] && [ -e $DMG ];
    then
      hdiutil attach $DMG -mountpoint /nix;
      source ~/.nix-profile/etc/profile.d/nix.sh
  fi
fi
" >> $RCFILE

echo "Now logout and back in to use Nix, or source ~/.profile now."
