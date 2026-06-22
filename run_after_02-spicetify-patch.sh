#!/bin/bash

# Load Homebrew environment variables
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo "🔍 Checking Spicetify deployment states..."

# 1. Verify Spicetify binary exists
if command -v spicetify &> /dev/null; then
    echo "  ✅ Spicetify binary found at: $(command -v spicetify)"
    SPICETIFY_READY=true
else
    echo "  ❌ Spicetify binary NOT found in execution PATH."
    SPICETIFY_READY=false
fi

# 2. Verify Spotify Flatpak is installed via native registry
if flatpak info com.spotify.Client &> /dev/null; then
    echo "  ✅ Spotify Flatpak is registered on the system."
    SPOTIFY_READY=true
else
    echo "  ❌ Spotify Flatpak NOT found via flatpak registry."
    SPOTIFY_READY=false
fi

# 3. Execute patch logic only if both checks passed
if [ "$SPICETIFY_READY" = true ] && [ "$SPOTIFY_READY" = true ]; then
    echo "🎵 Running Spicetify sandbox maintenance..."
    
    # Ensure the target preferences directory tree exists
    mkdir -p "$HOME/.var/app/com.spotify.Client/config/spotify"
    
    # Initialize base Spicetify config if it doesn't exist yet
    spicetify config || true
    
    # Force-map the correct Flatpak directory pathways
    spicetify config spotify_path "/var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify"
    spicetify config prefs_path "$HOME/.var/app/com.spotify.Client/config/spotify/prefs"
    
    # Only attempt sudo chmod if running interactively or if sudo credentials are cached
    if [ -t 0 ] || sudo -n true 2>/dev/null; then
        echo "🔐 Ensuring write permissions on Flatpak layers..."
        sudo chmod a+wr /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
        sudo chmod a+wr -R /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps
    else
        echo "🔒 Non-interactive environment detected. Skipping sudo chmod to protect background timers."
    fi
    
    # Inject themes with automated fallback mechanics
    echo "✨ Injecting custom theme layouts..."
    spicetify apply || spicetify backup apply 2>/dev/null || echo "⏭️ Customization skipped (requires interactive sudo)."
else
    echo "❌ Requirements check failed. Skipping Spicetify configuration."
fi