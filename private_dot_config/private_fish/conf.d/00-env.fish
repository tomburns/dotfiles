# Fish Shell - Environment Variables
# ====================================
#
# Loads first (00 prefix) to ensure environment is set before other configs.

# XDG Base Directory Specification
# =================================
# Standard directories for config, data, cache, and state files.
# These variables help applications organize their files consistently.
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_STATE_HOME "$HOME/.local/state"

# Default Editor
# ==============
# Set Neovim as the default editor for all command-line operations.
# EDITOR: used by git, crontab, and other CLI tools
# VISUAL: used for full-screen editors (same as EDITOR for consistency)
set -gx EDITOR nvim
set -gx VISUAL nvim

# Homebrew Environment
# ====================
# Configure Homebrew paths and environment for Apple Silicon (M1/M2/M3).
# This adds /opt/homebrew/bin to PATH and sets HOMEBREW_* variables.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Node Version Manager (nvm.fish)
# ================================
# Prerequisite: install nvm.fish via Fisher
#   fisher install jorgebucaran/nvm.fish
#
# nvm.fish provides:
# - Automatic .nvmrc detection and Node version switching on directory change
# - nvm install <version> - install Node versions
# - nvm use <version> - switch Node versions manually
# - nvm list - list installed versions
#
# Configuration:
# - nvm_default_version: Node version to use when no .nvmrc is present
# - Set to 'lts' to automatically use the latest LTS release
set -gx nvm_default_version lts
