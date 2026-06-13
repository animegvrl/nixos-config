set -euo pipefail

cd /etc/nixos/
sudo nix flake update

cd ~/.config/nixos-config
sudo cp /etc/nixos/flake.lock .
sudo chown $(whoami):root flake.lock
