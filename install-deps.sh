#!/usr/bin/env bash

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

brew install awscli bat coreutils fzf gnu-tar grc git-delta htop jq neovim ripgrep shellcheck starship tree zsh zsh-syntax-highlighting zstd

# macOS
if [[ "$(uname)" == "Darwin" ]]; then
	brew install --cask flameshot hiddenbar kap kitty raycast
	brew install --cask linearmouse --no-quarantine
fi
