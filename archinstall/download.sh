#!/bin/bash

mkdir -p /tmp/archinstall-configs
cd "$_" || exit
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_configuration.json
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_credentials.json
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_disk_layout.json
echo "edit $(pwd)/user_credentials.json to change password, then run bash ./install.sh"
