set -euo pipefail

cd ~/.config/nixos-config

# fix premissions for new files
sudo chown -R $(whoami):root dendrites/

sudo rm -fv /etc/nixos/flake.nix
sudo rm -fv /etc/nixos/nsenv.nix
sudo rm -rv /etc/nixos/dendrites/

sudo cp -v flake.nix /etc/nixos/
sudo cp -v nsenv.nix /etc/nixos/
sudo cp -rv dendrites/ /etc/nixos/

sudo chown root /etc/nixos/flake.nix
sudo chown root /etc/nixos/nsenv.nix
sudo chown -R root /etc/nixos/dendrites/
