# dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

| Config | Path | Description |
|--------|------|-------------|
| [Fish shell](https://fishshell.com/) | `~/.config/fish/` | Shell config, abbreviations, aliases, and environment variables |
| [Neovim](https://neovim.io/) | `~/.config/nvim/` | Editor config with lazy.nvim plugin manager |
| [Ghostty](https://ghostty.org/) | `~/.config/ghostty/` | Terminal emulator config |
| [Starship](https://starship.rs/) | `~/.config/starship.toml` | Cross-shell prompt theme |

Fish shell plugins (via [Fisher](https://github.com/jorgebucaran/fisher)):
- [Pure](https://github.com/pure-fish/pure) - prompt theme
- [nvm.fish](https://github.com/jorgebucaran/nvm.fish) - Node version manager

## Setup

### Prerequisites

Install chezmoi:

```sh
# macOS
brew install chezmoi

# or with a single binary install
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### Initialize

```sh
chezmoi init https://github.com/tomburns/dotfiles.git

# Preview changes
chezmoi diff

# Apply
chezmoi apply
```

## Daily Usage

```sh
# Pull latest changes and apply
chezmoi update

# Add a new dotfile
chezmoi add ~/.config/some/config

# Edit a managed file
chezmoi edit ~/.config/some/config

# See what would change
chezmoi diff

# Apply changes
chezmoi apply
```

## Useful Links

- [chezmoi Quick Start](https://www.chezmoi.io/quick-start/)
- [chezmoi User Guide](https://www.chezmoi.io/user-guide/command-overview/)
- [chezmoi Reference](https://www.chezmoi.io/reference/)
- [chezmoi GitHub](https://github.com/twpayne/chezmoi)
- [How chezmoi manages files](https://www.chezmoi.io/user-guide/manage-different-types-of-file/)
- [Using chezmoi across multiple machines](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/)
- [Templating with chezmoi](https://www.chezmoi.io/user-guide/templating/)
