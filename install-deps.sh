#!/usr/bin/env bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/me/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install awscli bandwhich bash-completion bat bat-extras coreutils ctop eza fnm fzf gnu-tar grc git git-delta htop inetutils jq neovim ripgrep shellcheck starship tree zsh zsh-syntax-highlighting zstd

# macOS
if [[ "$(uname)" == "Darwin" ]]; then
	brew install --cask nikitabobko/tap/aerospace flameshot hiddenbar kap kitty raycast
	brew install --cask linearmouse --no-quarantine

	brew install iproute2mac rustup-init

	softwareupdate --install-rosetta
	sudo scutil --set HostName ricbook
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

