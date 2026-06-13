set -g fish_greeting
# ==============================================================================
# --- 1. Environment Variables ---
# ==============================================================================
# In Fish, 'set -gx' replaces 'export' (g = global, x = export)
set -gx EDITOR "fresh"
set -gx VISUAL "fresh"
set -gx BAT_THEME "tokyonight_night"

# Command substitution uses parentheses () instead of $()
if type -q vivid
    set -gx LS_COLORS (vivid generate ansi)
end

# ==============================================================================
# --- 2. Oh My Zsh Replacement Note ---
# ==============================================================================
# Note for Jochem: You do not need to source OMZ or plugins here!
# - zsh-autosuggestions: Built directly into Fish core.
# - zsh-syntax-highlighting: Built directly into Fish core.
# - git: Fish has native Git branch awareness in its default prompts.
# - docker: Tab-completions are natively provided by the Fish engine.

# ==============================================================================
# --- 3. Tool Initialization ---
# ==============================================================================
# Initialize Zoxide (eval is replaced by piping the initialization into source)
if type -q zoxide
    zoxide init fish --cmd cd | source
end

# Cleanly append Spicetify to your PATH without duplicating it on shell reload
fish_add_path /home/jochem/.spicetify

# ==============================================================================
# --- 4. Aliases ---
# ==============================================================================
# Core Replacements
alias f='fresh'
alias cat='bat'
alias df='duf'
alias du='dust'
alias ls='eza -alh --icons --group-directories-first --git --header --octal-permissions --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I --preserve-root'
alias mkdir='mkdir -p'
alias z='zeditor'
alias top='dgop'

# ==============================================================================
# --- 5. SSH & Ghostty ---
# ==============================================================================
# Fish uses 'string match' instead of double-bracket regex wildcards
if string match -q "*ghostty*" $TERM
    alias ssh="env TERM=xterm-256color ssh"
end

# Remote Server Aliases
alias d0='ssh docker@192.168.2.250'
alias hy='ssh hytale@192.168.2.240'
alias pmb='ssh protonmail-bridge@192.168.2.211'
alias tailsc='ssh tailscale@192.168.2.213'
alias dns='ssh dns@192.168.2.253'

# ==============================================================================
# --- 6. Eye Candy ---
# ==============================================================================
# This block only runs during interactive visual terminal sessions
if status is-interactive
    if type -q fastfetch
        fastfetch
    end
end