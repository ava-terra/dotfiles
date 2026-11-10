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

## Notes

- Tool-generated or third-party content is kept out of git via `.gitignore` files in the relevant packages. For example, tmux plugins are cloned by [TPM](https://github.com/tmux-plugins/tpm) into `tmux/dot-config/tmux/plugins/` and are not tracked.
- Editor swap files (`*.swp`, `*.swo`) and `.DS_Store` are ignored.
