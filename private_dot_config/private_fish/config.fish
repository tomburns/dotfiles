# Fish Shell - Main Configuration
# ================================
#
# This is the entry point for Fish shell configuration.
# All modular config lives in conf.d/ files which auto-load alphabetically.
#
# Files in conf.d/ load in order by prefix:
#   00-env.fish    → Environment variables (XDG, EDITOR, PATH)
#   10-abbr.fish   → Abbreviations (git, docker, node)
#   20-aliases.fish → Aliases (editor shortcuts)
#   90-greeting.fish → Custom greeting function

# Starship Prompt
# ===============
# Initialize Starship prompt with custom config from this repo.
# Note: Set STARSHIP_CONFIG environment variable to point to starship/starship.toml
# or symlink ~/.config/starship.toml to this repo's starship/starship.toml
starship init fish | source
