#!/bin/bash

TARGET_DIR="/tmp/archinstall-configs"

rm -rf $TARGET_DIR
mkdir -p $TARGET_DIR
pushd $TARGET_DIR
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_configuration.json -O
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_credentials.json -O
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/user_disk_layout.json -O
curl -fsSL https://raw.githubusercontent.com/nerdyman/dotfiles/main/archinstall/install.sh -O
echo "You might want to make some changes:"
echo "=> $(pwd)/user_configuration.json to change harddrives"
echo "=> $(pwd)/user_credentials.json to change password"
echo "=> $(pwd)/user_disk_layout.json to change install disk key"

zsh .
