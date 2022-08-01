#!/usr/bin/env bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/me/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install awscli bat coreutils fnm fzf gnu-tar grc git-delta htop jq neovim ripgrep shellcheck starship tree zsh zsh-syntax-highlighting zstd

# macOS
if [[ "$(uname)" == "Darwin" ]]; then
	brew install --cask flameshot hiddenbar kap kitty raycast
	brew install --cask linearmouse --no-quarantine
	softwareupdate --install-rosetta
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

