# ==============================================================================
# --- 0. Remove Fish Greeting ---
# ==============================================================================

set -g fish_greeting ""

# ==============================================================================
# --- 1. Environment Variables ---
# ==============================================================================
set -gx EDITOR "fresh"
set -gx VISUAL "fresh"

# Core dynamic terminal coloring engine wrapper
if type -q vivid
    set -gx LS_COLORS (vivid generate ansi)
end

# ==============================================================================
# --- 2. Tool Initialization ---
# ==============================================================================
# Initialize Zoxide using Fish-native piping mechanics
if type -q zoxide
    zoxide init fish --cmd cd | source
end


# ==============================================================================
# --- 3. Aliases ---
# ==============================================================================
# Core CLI Replacements
alias f='fresh'
alias cat='bat'
alias df='duf'
alias du='dust'
alias z='zeditor'
alias ls='eza -alh --icons --group-directories-first --git --header --octal-permissions --color=auto'

# Defensive Safeguards
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I --preserve-root'
alias mkdir='mkdir -p'

# ==============================================================================
# --- 4. Ghostty Architecture ---
# ==============================================================================
# Ensures terminfo rules pass securely when connecting to remote hosts via Ghostty
if string match -q "*ghostty*" $TERM
    alias ssh="env TERM=xterm-256color ssh"
end

# ==============================================================================
# --- 5. Interactive Visuals ---
# ==============================================================================
if status is-interactive
    if type -q fastfetch
        fastfetch
    end
end