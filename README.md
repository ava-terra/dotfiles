# dotfiles

Personal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Layout

Each top-level directory is a Stow package. Inside a package, files mirror their location relative to `$HOME`, with `dot-` standing in for a leading dot:

```
fish/
└── dot-config/
    └── fish/
        └── config.fish      ->  ~/.config/fish/config.fish
```

Stow is run with `--dotfiles`, which turns `dot-config` into `.config`.

## Requirements

- `stow` 2.3 or newer (for `--dotfiles`)

## Install

Clone the repository to `~/.dotfiles`, then stow the packages you want:

```sh
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
stow --dotfiles -t ~ fish nvim tmux starship
```

Preview changes first with `-n` (simulate) and `-v` (verbose):

```sh
stow -n -v --dotfiles -t ~ fish
```

## Adding a package

1. Create `<name>/dot-config/<name>/` and put the config files in it.
2. Run `stow --dotfiles -t ~ <name>`.

## Removing a package

```sh
stow -D --dotfiles -t ~ <name>
```

## Existing symlinks

Stow will not replace a file or symlink it does not own. If a target such as `~/.config/fish` is already a symlink created by hand, remove it before stowing:

```sh
rm ~/.config/fish
stow --dotfiles -t ~ fish
```

Only remove targets whose contents are already in the repository.

## Setting up a new machine

On a fresh machine, the quickest route is the bootstrap script:

```sh
DOTFILES_REPO=<repo-url> bash -c "$(curl -fsSL <raw-url-to-bootstrap.sh>)"
```

or, if you've already cloned the repo:

```sh
cd ~/.dotfiles && ./bootstrap.sh
```

The script is safe to re-run. It:

1. Installs `git`, `stow`, `fish` and `curl` if they're missing (pacman, apt or dnf).
2. Clones the repo to `~/.dotfiles` if it isn't already there.
3. Installs [mise](https://mise.jdx.dev) if it isn't present.
4. Links every package with `stow --dotfiles --restow`. If any file already exists in the way, stow stops and changes nothing, so move those files aside and re-run.
5. Runs `mise install`, which installs the toolchain pinned in `mise/dot-config/mise/config.toml`.

Steps the script doesn't do:

- **Shell:** `chsh -s "$(command -v fish)"`.
- **Nix packages:** install the same set as your other machine (see `nix profile list` there). They aren't tracked in the repo yet.
- **Docker:** install it and add yourself to the `docker` group if you use dagger.
- **tmux:** install TPM with `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`, then press `prefix + I` inside tmux.
- **Neovim:** open `nvim` once so lazy.nvim installs its plugins.
- **Age key:** restore `~/.config/sops/age/keys.txt` from your vault before running the bootstrap script, or secrets won't be decrypted (see [Secrets](#secrets)).
- **System config:** udev rules, systemd units and anything under `/etc` aren't in the repo. Kanata and kmonad may need input-device permissions set up separately.

To verify the setup:

```sh
mise doctor
ghostty +validate-config
stow -n -v --dotfiles -t ~ <package>   # no conflicts expected
```

## Secrets

Secrets are encrypted with [sops](https://github.com/getsops/sops) using an [age](https://github.com/FiloSottile/age) key. Encrypted files live in `secrets/` and are committed. Plaintext copies are never committed.

| Encrypted file | Decrypted to |
|---|---|
| `secrets/fabric.env` | `~/.config/fabric/.env` |

`.sops.yaml` holds the public key and the rule that matches files under `secrets/`. Sops encrypts only the values in dotenv files, so key names stay visible.

The age **private** key is at `~/.config/sops/age/keys.txt`. It isn't in the repo. Keep a copy in your password vault, because without it the encrypted files can't be read.

To edit a secret:

```sh
sops secrets/fabric.env          # opens the decrypted file in $EDITOR and re-encrypts on save
./bootstrap.sh                   # or: sops --decrypt secrets/fabric.env > ~/.config/fabric/.env
```

To add a new secret, add its path and target to the `decrypt` calls in `bootstrap.sh`.

To set up a new machine, copy `keys.txt` to `~/.config/sops/age/keys.txt` with mode 600, then run the bootstrap script.

## Notes

- Tool-generated or third-party content is kept out of git via `.gitignore` files in the relevant packages. For example, tmux plugins are cloned by [TPM](https://github.com/tmux-plugins/tpm) into `tmux/dot-config/tmux/plugins/` and are not tracked.
- Editor swap files (`*.swp`, `*.swo`) and `.DS_Store` are ignored.
