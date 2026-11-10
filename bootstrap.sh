#!/usr/bin/env bash
# Set up this dotfiles repo on a new machine. Safe to re-run.
#
#   DOTFILES_REPO=<repo-url> ./bootstrap.sh
#
# Clones the repo to ~/.dotfiles if it isn't already there, installs the base
# tools, links every package with stow, and installs the mise toolchain.
set -euo pipefail

DOTFILES="${DOTFILES_DIR:-$HOME/.dotfiles}"
REPO_URL="${DOTFILES_REPO:-}"

log() { printf '\n==> %s\n' "$*"; }
die() { printf 'error: %s\n' "$*" >&2; exit 1; }
have() { command -v "$1" >/dev/null 2>&1; }

install_base() {
  local pkgs=(git stow fish curl)
  if have pacman; then
    sudo pacman -S --needed "${pkgs[@]}"
  elif have apt-get; then
    sudo apt-get update
    sudo apt-get install -y "${pkgs[@]}"
  elif have dnf; then
    sudo dnf install -y "${pkgs[@]}"
  else
    die "unsupported package manager; install ${pkgs[*]} manually and re-run"
  fi
}

log "Base packages"
missing=()
for t in git stow fish curl; do have "$t" || missing+=("$t"); done
if [ "${#missing[@]}" -gt 0 ]; then
  echo "missing: ${missing[*]}"
  install_base
else
  echo "all present"
fi

log "Repository"
if [ ! -d "$DOTFILES/.git" ]; then
  [ -n "$REPO_URL" ] || die "$DOTFILES is not a checkout; set DOTFILES_REPO to clone it"
  git clone "$REPO_URL" "$DOTFILES"
else
  echo "using $DOTFILES"
fi
cd "$DOTFILES"

log "mise"
if ! have mise && [ ! -x "$HOME/.local/bin/mise" ]; then
  curl -fsSL https://mise.run | sh
fi
MISE="$(command -v mise || echo "$HOME/.local/bin/mise")"
[ -x "$MISE" ] || die "mise not found after install"

log "Linking packages with stow"
packages=()
for d in */; do
  d="${d%/}"
  [ -d "$d/dot-config" ] && packages+=("$d")
done
echo "packages: ${packages[*]}"
# stow applies nothing when any package conflicts, so a failure here changes nothing.
if ! stow --dotfiles -t "$HOME" --restow "${packages[@]}"; then
  die "stow reported conflicts (listed above). Move those files aside and re-run."
fi

log "mise tools"
"$MISE" install

log "Secrets"
AGE_KEY="${SOPS_AGE_KEY_FILE:-$HOME/.config/sops/age/keys.txt}"
if [ -f "$AGE_KEY" ]; then
  export SOPS_AGE_KEY_FILE="$AGE_KEY"
  decrypt() {
    local src="$1" dst="$2" tmp
    mkdir -p "$(dirname "$dst")"
    tmp="$(mktemp "$(dirname "$dst")/.decrypt.XXXXXX")"
    "$MISE" exec -- sops --decrypt "$src" > "$tmp"
    chmod 600 "$tmp"
    mv "$tmp" "$dst"
  }
  decrypt secrets/fabric.env "$HOME/.config/fabric/.env"
  echo "decrypted secrets/fabric.env -> ~/.config/fabric/.env"
else
  echo "no age key at $AGE_KEY; restore it from your vault and re-run ./bootstrap.sh"
fi

log "Done"
cat <<'EOF'
Manual steps still needed (see README, "Setting up a new machine"):
  - set fish as your shell:      chsh -s "$(command -v fish)"
  - Nix packages, if you use them
  - tmux plugins:                prefix + I inside tmux
  - Neovim plugins:              open nvim once
EOF
