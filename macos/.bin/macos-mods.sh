#!/bin/zsh

# Disable font smoothing (looks bad on regular HD displays)
defaults write -g AppleFontSmoothing -int 0
defaults write -g CGFontRenderingFontSmoothingDisabled -bool YES

# Disable mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1

