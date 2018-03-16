#!/bin/bash
# import.sh
# copy files to current directory

wd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
homeDir=$HOME/
tmpDir=$wd/tmp/

# file declarations
declare -A files

files[aliases]="${homeDir}.config/aliases"
files[compton]="${homeDir}.config/compton.conf"
files[gnupg]="${homeDir}.gnupg/gpg.conf"
files[i3]="${homeDir}.i3/config"
files[nvidia_fan]=$(which nv-fan)
files[nvidia_rc]="${homeDir}.nvidia-settings-rc"
files[termite]="${homeDir}.config/termite"
files[vimrc]="/etc/vimrc"
files[xinit]="${homeDir}.xinitrc"
files[Xresources]="${homeDir}.Xresources"
files[zsh]="${homeDir}.zshrc"

function rmDir {
    if [ -d $1 ]
    then
        rm -r $1
    fi
}

function import {
    # remove existing $tmpDir
    rmDir $tmpDir
    rmDir $wd/home
    rmDir $wd/other

    # create new dirs
    mkdir $tmpDir $wd/other

    printf "Using directory ${wd}\n"

    for file in "${!files[@]}"
    do
        printf "=> Copying: $file\n"
        cp -r --parents ${files[$file]} $tmpDir
    done

    # move $wd/home/<user>/ to $wd/home
    mv ${tmpDir}home/* $wd/home

    # move all other files to 'other' dir
    find "${tmpDir}" -maxdepth 5 -type f -name '[^.]*' -exec mv {} $wd/other \;

    # clean up $tmpDir
    rm -r $tmpDir
}

# all systems go
import
