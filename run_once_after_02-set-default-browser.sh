#!/bin/bash
# Set Zen Browser as the system default

DESKTOP_FILE="app.zen_browser.zen.desktop"

# Check if Flatpak has actually exported the Zen desktop file yet
if flatpak list | grep -q "app.zen_browser.zen"; then
    echo "🌐 Setting Zen Browser as the default..."
    xdg-settings set default-web-browser "$DESKTOP_FILE"
    xdg-mime default "$DESKTOP_FILE" x-scheme-handler/http x-scheme-handler/https text/html
    echo "☯️ Default browser configured!"
else
    echo "⚠️ Zen Browser is not fully installed yet. Skipping default browser setup."
    # Exit with an error code so Chezmoi knows this script failed and will retry it on the next 'chezmoi apply'
    exit 1
fi
