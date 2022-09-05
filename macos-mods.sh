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
defaults write com.apple.dock "mru-spaces" -bool "false"
restart dock
killall Dock

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

# do not show accent menu when long-pressing key
defaults write -g ApplePressAndHoldEnabled -bool false

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

# https://privacy.sexy — v0.11.4 — Sun, 21 Aug 2022 15:27:02 GMT
if [ "$EUID" -ne 0 ]; then
    script_path=$([[ "$0" = /* ]] && echo "$0" || echo "$PWD/${0#./}")
    sudo "$script_path" || (
        echo 'Administrator privileges are required.'
        exit 1
    )
    exit 0
fi


# Deactivate the Remote Management Service
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop

# Remove Apple Remote Desktop Settings
sudo rm -rf /var/db/RemoteManagement
sudo defaults delete /Library/Preferences/com.apple.RemoteDesktop.plist
defaults delete ~/Library/Preferences/com.apple.RemoteDesktop.plist
sudo rm -r /Library/Application\ Support/Apple/Remote\ Desktop/
rm -r ~/Library/Application\ Support/Remote\ Desktop/
rm -r ~/Library/Containers/com.apple.RemoteDesktop

# Disable "Ask Siri"
defaults write com.apple.assistant.support 'Assistant Enabled' -bool false

# Disable Siri voice feedback
defaults write com.apple.assistant.backedup 'Use device speaker for TTS' -int 3

# Disable Siri services (Siri and assistantd)
launchctl disable "user/$UID/com.apple.assistantd"
launchctl disable "gui/$UID/com.apple.assistantd"
sudo launchctl disable 'system/com.apple.assistantd'
launchctl disable "user/$UID/com.apple.Siri.agent"
launchctl disable "gui/$UID/com.apple.Siri.agent"
sudo launchctl disable 'system/com.apple.Siri.agent'
if [ $(/usr/bin/csrutil status | awk '/status/ {print $5}' | sed 's/\.$//') = "enabled" ]; then
    >&2 echo 'This script requires SIP to be disabled. Read more: https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection'
fi

# Disable use Siri prompt
defaults write com.apple.SetupAssistant 'DidSeeSiriSetup' -bool True

# Hide Siri from menu bar
defaults write com.apple.systemuiserver 'NSStatusItem Visible Siri' 0

# Hide Siri from status menu
defaults write com.apple.Siri 'StatusMenuVisible' -bool false
defaults write com.apple.Siri 'UserHasDeclinedEnable' -bool true

# Disable Siri telemetry
defaults write com.apple.assistant.support 'Siri Data Sharing Opt-In Status' -int 2

# Disable Remote Apple Events
sudo systemsetup -setremoteappleevents off

# Do not store docs on iCloud by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable AirDrop
defaults write com.apple.NetworkBrowser DisableAirDrop -bool true


# Disable Spotlight Indexing
sudo mdutil -i off -d /

## ---

# Disable font smoothing (looks bad on regular HD displays)
defaults write -g AppleFontSmoothing -int 0
defaults write -g CGFontRenderingFontSmoothingDisabled -bool YES

# Disable mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# Trackpad
# disable haptic feedback
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false
