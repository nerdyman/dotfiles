#!/bin/bash

mkdir -p /tmp/archinstall-configs
pushd /tmp/archinstall-configs
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_configuration.json -O
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_credentials.json -O
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_disk_layout.json -O
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/install.sh -O
echo "edit $(pwd)/user_credentials.json to change password, then run bash ./install.sh"
