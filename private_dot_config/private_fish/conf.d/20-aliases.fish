# Fish Shell - Aliases
# =====================
#
# Aliases execute silently without expansion (you don't see the underlying command).
# Use aliases for simple command substitutions where expansion is not needed.

# Editor Aliases
# ==============
# Launch Neovim via v or vim without showing the expansion.
# These are aliases (not abbreviations) because:
# - Editor launch is a simple substitution, no benefit to seeing "nvim" expand
# - Keeps the command line clean when opening files
alias v='nvim'
alias vim='nvim'

# Claude Code Aliases
# ===================
# Launch claude with a specific model, medium effort, and the
# using-superpowers skill invoked up front, running in auto permission mode.
alias claude-opus='claude --model opus --effort medium "/superpowers:using-superpowers" --permission-mode auto'
alias claude-sonnet='claude --model sonnet --effort medium "/superpowers:using-superpowers" --permission-mode auto'
