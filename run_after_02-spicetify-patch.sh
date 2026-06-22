#!/bin/bash

# Load Homebrew environment variables
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Only execute if spicetify and Spotify exist
if command -v spicetify &> /dev/null && [ -d "$HOME/.var/app/com.spotify.Client" ]; then
    echo "🎵 Running Spicetify sandbox maintenance..."
    
    # 1. Initialize base config if missing
    spicetify config || true
    
    # 2. Hard-code the Flatpak container targets
    spicetify config spotify_path "/var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify"
    spicetify config prefs_path "$HOME/.var/app/com.spotify.Client/config/spotify/prefs"
    
    # 3. Only attempt sudo chmod if we are in an interactive terminal or have cached credentials
    if [ -t 0 ] || sudo -n true 2>/dev/null; then
        echo "🔐 Ensuring write permissions on Flatpak layers..."
        sudo chmod a+wr /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
        sudo chmod a+wr -R /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps
    else
        echo "🔒 Non-interactive environment detected. Skipping sudo chmod to protect background timers."
    fi
    
    # 4. Inject theme (Succeeds silently if permissions are already fine)
    echo "✨ Injecting custom theme layouts..."
    spicetify apply || spicetify backup apply 2>/dev/null || echo "⏭️ Customization skipped (requires interactive sudo)."
else
    echo "⏭️ Spicetify or Spotify Flatpak not found. Skipping theme configuration."
fi