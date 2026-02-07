# Fish Shell - Abbreviations
# ===========================
#
# Abbreviations expand before command execution (you see the full command).
# This is different from aliases which hide the underlying command.
# Use abbreviations for commands where seeing the expansion is helpful.

# Git Abbreviations
# =================
# Core workflow commands - expand to show full git command before execution
abbr --add g git

# Status and inspection
abbr --add gs git status
abbr --add gd git diff
abbr --add gds git diff --staged
abbr --add gl git log
abbr --add glog git log --oneline --decorate --graph

# Staging and committing
abbr --add ga git add
abbr --add gaa git add --all
abbr --add gc git commit -v
abbr --add gcm git commit -m
abbr --add gca git commit -a -v
abbr --add gcam git commit -a -m

# Branching and checkout
abbr --add gco git checkout
abbr --add gcb git checkout -b

# Remote operations
abbr --add gp git push
abbr --add gpf git push --force-with-lease
abbr --add gpl git pull

# Stashing
abbr --add gst git stash
abbr --add gstp git stash pop

# Advanced operations
abbr --add grb git rebase
abbr --add grbi git rebase -i
abbr --add gm git merge
abbr --add gcp git cherry-pick

# Docker Abbreviations
# ====================
# Container and compose workflow commands
abbr --add d docker
abbr --add dc docker compose
abbr --add dps docker ps

# Node/npm Abbreviations
# ======================
# Common npm commands for package management and script running
abbr --add ni npm install
abbr --add nr npm run
abbr --add nt npm test

# Navigation Abbreviations
# ========================
# Quick directory navigation and listing
abbr --add .. cd ..
abbr --add ... cd ../..
abbr --add l ls
abbr --add ll ls -lh
abbr --add la ls -lah
