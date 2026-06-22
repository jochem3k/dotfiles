#!/bin/bash
# Set Zen Browser as the system default

echo "🌐 Setting Zen Browser as the default..."
xdg-settings set default-web-browser app.zen_browser.zen.desktop
xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/http x-scheme-handler/https text/html
echo "☯️ Default browser configured!"