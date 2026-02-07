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

These dotfiles are designed for macOS with [Homebrew](https://brew.sh/). Install Homebrew first if you don't have it:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install the required tools:

```sh
brew install chezmoi fish neovim starship ripgrep fd
brew install --cask ghostty font-fira-code-nerd-font
```

| Tool | Purpose |
|------|---------|
| [chezmoi](https://www.chezmoi.io/) | Dotfile manager |
| [Fish](https://fishshell.com/) | Shell |
| [Neovim](https://neovim.io/) | Editor |
| [Starship](https://starship.rs/) | Prompt |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Telescope live grep |
| [fd](https://github.com/sharkdp/fd) | Telescope file finder |
| [Ghostty](https://ghostty.org/) | Terminal emulator |
| [Fira Code Nerd Font](https://github.com/ryanoasis/nerd-fonts) | Font with coding ligatures and icons |

After applying the dotfiles, install [Fisher](https://github.com/jorgebucaran/fisher) (Fish plugin manager) and plugins:

```sh
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher update"
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
