# Fish Shell - Custom Greeting
# ==============================
#
# Replaces Fish's default "Welcome to fish, the friendly interactive shell"
# with a one-line system info display using Catppuccin Mocha colors.

function fish_greeting
    # System information
    set -l hostname (hostname -s)
    set -l os_info (sw_vers -productName 2>/dev/null || echo "macOS")
    set -l os_version (sw_vers -productVersion 2>/dev/null || echo "unknown")
    set -l uptime_info (uptime | sed 's/.*up *//; s/, *[0-9]* user.*//')

    # Catppuccin Mocha colors
    # blue = #89b4fa (hostname)
    # green = #a6e3a1 (OS)
    # yellow = #f9e2af (uptime)
    # text = #cdd6f4 (separators)

    set_color 89b4fa
    echo -n $hostname
    set_color cdd6f4
    echo -n " | "
    set_color a6e3a1
    echo -n "$os_info $os_version"
    set_color cdd6f4
    echo -n " | up "
    set_color f9e2af
    echo -n $uptime_info
    set_color normal
    echo ""
end
