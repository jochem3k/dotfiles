#!/bin/bash

if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if command -v brew &> /dev/null; then
    echo "🚀 Initializing declarative Homebrew bundle installation..."
    brew bundle --global --file="${HOME}/.Brewfile"
else
    echo "⚠️ Homebrew not found in PATH. Skipping bundle installation."
fi