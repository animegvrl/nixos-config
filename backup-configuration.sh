set -euo pipefail

cd ~/.config/nixos-config

BACKUP_TIMESTAMP="$(date +'%Y-%m-%d_%H-%M-%S')"

echo "--- BACKING UP CONFIGURATION ---"

mkdir "backups/${BACKUP_TIMESTAMP}"

cp -v  flake.nix  "backups/${BACKUP_TIMESTAMP}"
cp -v  nsenv.nix  "backups/${BACKUP_TIMESTAMP}"
cp -rv dendrites/ "backups/${BACKUP_TIMESTAMP}"

echo "---           DONE           ---"
