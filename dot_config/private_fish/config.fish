# ==============================================================================
# --- 0. Remove Fish Greeting ---
# ==============================================================================

set -g fish_greeting ""

# ==============================================================================
# --- 1. Dynamic Homebrew Initialization ---
# ==============================================================================
# Automatically detects and hooks Linuxbrew on your Fedora Atomic images, 
# while sleeping completely unnoticed if you are running on a bare Arch setup.
if test -d /home/linuxbrew/.linuxbrew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

# ==============================================================================
# --- 2. Environment Variables ---
# ==============================================================================
set -gx EDITOR "fresh"
set -gx VISUAL "fresh"
set -gx BAT_THEME "Catppuccin Mocha"

# Core dynamic terminal coloring engine wrapper
if type -q vivid
    set -gx LS_COLORS (vivid generate ansi)
end

# ==============================================================================
# --- 3. Tool Initialization ---
# ==============================================================================
# Initialize Zoxide using Fish-native piping mechanics
if type -q zoxide
    zoxide init fish --cmd cd | source
end

# Append third-party utilities cleanly to your active user path
fish_add_path /home/jochem/.spicetify

# ==============================================================================
# --- 4. Aliases ---
# ==============================================================================
# Core CLI Replacements
alias f='fresh'
alias cat='bat'
alias df='duf'
alias du='dust'
alias top='dgop'
alias z='zeditor'
alias ls='eza -lh --icons --group-directories-first --git --header --octal-permissions --color=auto'

# Defensive Safeguards
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I --preserve-root'
alias mkdir='mkdir -p'

# ==============================================================================
# --- 5. Ghostty Architecture ---
# ==============================================================================
# Ensures terminfo rules pass securely when connecting to remote hosts via Ghostty
if string match -q "*ghostty*" $TERM
    alias ssh="env TERM=xterm-256color ssh"
end

# ==============================================================================
# --- 6. Interactive Visuals ---
# ==============================================================================
if status is-interactive
    if type -q fastfetch
        fastfetch
    end
end