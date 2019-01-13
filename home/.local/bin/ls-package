#!/bin/bash

# Find the executables for a package
# https://bbs.archlinux.org/viewtopic.php?pid=693938#p693938

for ARG in $(pacman -Qql $1); do [ ! -d $ARG ] && [ -x $ARG ] && echo $ARG; done
