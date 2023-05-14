#!/usr/bin/env bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/me/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install awscli bash-completion bat bat-extras coreutils fnm fzf gnu-tar grc git git-delta htop inetutils jq neovim prettier ripgrep shellcheck starship tree zsh zsh-syntax-highlighting zstd

# macOS
if [[ "$(uname)" == "Darwin" ]]; then
	brew install --cask flameshot hiddenbar kap kitty raycast
	brew install --cask linearmouse --no-quarantine

	brew install yulrizka/tap/pushtotalk
	ln -s /opt/homebrew/opt/pushtotalk/PushToTalk.app /Applications/PushToTalk.app

	brew install iproute2mac rustup-init

	softwareupdate --install-rosetta
	sudo scutil --set HostName ricbook
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

