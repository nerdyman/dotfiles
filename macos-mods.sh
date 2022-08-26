#!/bin/zsh

setopt VERBOSE

# @see https://daiderd.com/nix-darwin/manual/index.html
# @see https://gist.github.com/romanhaa/9804183f242991007b316a59c4ba5e5a

# Reset to defaults using `defaults delete -g <FEATURE>`

# dock
# position
defaults write com.apple.dock "orientation" -string "right"
# icon size
defaults write com.apple.dock "tilesize" -int "64"
# show recents
defaults write com.apple.dock "show-recents" -bool "false"
# minimize animation
defaults write com.apple.dock "mineffect" -string "genie"
# restart dock
killall Dock

# finder
# show "Quit" menu item
defaults write com.apple.finder "QuitMenuItem" -bool "true"
# show all file extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# show hidden files
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
# do not show warning when changing file extensions
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
# do not use iCloud as default file storage destination
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false"
# remove delay when hovering title
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"
# restart finder
killall Finder

# mission control
# deactivate auto rearrange
# defaults write com.apple.dock "mru-spaces" -bool "false"
# restart dock
# killall Dock

# feedback assistant
# do not autogather large files when submitting a report
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"

# enable spring loading for Dock items
defaults write com.apple.dock "enable-spring-load-actions-on-all-items" -bool "true"
killall Dock

# disable "Application Downloaded from Internet" popup
defaults write com.apple.LaunchServices "LSQuarantine" -bool "false"

# expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# show accent menu when long-pressing key
# defaults write -g ApplePressAndHoldEnabled -bool true

# drag windows by holding CTRL + CMD and clicking anywhere in the window
# does not work with all applications
defaults write -g NSWindowShouldDragOnGesture -bool true

# navigate UI elements with keyboard (tab key)
# alternatively: System Preferences -> Keyboard -> Shortcuts -> check "Use keyboard navigation to move focus between controls"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# disable animation when opening the info window in finder (CMD + I)
# defaults write com.apple.finder DisableAllAnimations -bool true

# disable animations when opening an application from the dock
# defaults write com.apple.dock launchanim -bool false

# make all animations faster that are used by mission control
defaults write com.apple.dock expose-animation-duration -float 0.1

# automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en-GB"
# defaults write NSGlobalDomain AppleLocale -string "en_US@currency=GBP"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/London" > /dev/null

## ---

# Disable font smoothing (looks bad on regular HD displays)
defaults write -g AppleFontSmoothing -int 0
defaults write -g CGFontRenderingFontSmoothingDisabled -bool YES

# Disable mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# Trackpad
# disable haptic feedback
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false
