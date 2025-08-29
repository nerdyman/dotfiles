#!/bin/zsh

setopt VERBOSE

# @see https://daiderd.com/nix-darwin/manual/index.html
# @see https://gist.github.com/romanhaa/9804183f242991007b316a59c4ba5e5a

FALLBACK_HOSTNAME=$(hostname)
MOD_HOSTNAME=${1:-$FALLBACK_HOSTNAME}

echo "Using hostname: $MOD_HOSTNAME"

sudo scutil --set HostName "$MOD_HOSTNAME"

# Reset to defaults using `defaults delete -g <FEATURE>`

# dock
# position
defaults write com.apple.dock "orientation" -string "bottom"
# icon size
defaults write com.apple.dock "tilesize" -int "64"
# show recents
defaults write com.apple.dock "show-recents" -bool "false"
# minimize animation
defaults write com.apple.dock "mineffect" -string "genie"
# restart dock
killall Dock

# finder
# show "Quit" menu item - disabled, aerospace handles 'soft' closing finder pretty well
# defaults write com.apple.finder "QuitMenuItem" -bool "true"
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
# group windows so they scale correctly with Aerospace https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control
defaults write com.apple.dock expose-group-apps -bool true
restart dock
killall Dock

# dictation
# disable dictation
defaults write com.apple.HIToolbox AppleDictationAutoEnable -int 0

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

# disable Apple Intelligence
defaults write com.apple.CloudSubscriptionFeatures.optIn "device" -bool "false"
defaults write com.apple.CloudSubscriptionFeatures.optIn "auto_opt_in" -bool "false"

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

# Disable Spotlight Indexing
sudo mdutil -i off -d /

# Disable font smoothing (looks bad on regular HD displays)
#defaults write -g AppleFontSmoothing -int 1
#defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

# Disable mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# Trackpad
# disable haptic feedback
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false

# https://privacy.sexy — v0.13.8 — Tue, 17 Jun 2025 10:42:19 GMT
if [ "$EUID" -ne 0 ]; then
    script_path=$([[ "$0" = /* ]] && echo "$0" || echo "$PWD/${0#./}")
    sudo "$script_path" || (
        echo 'Administrator privileges are required.'
        exit 1
    )
    exit 0
fi


# Disable personalized advertisements and identifier tracking
echo '--- Disable personalized advertisements and identifier tracking'
defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.AdLib forceLimitAdTracking -bool true
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------------Disable Microsoft Office telemetry------------
# ----------------------------------------------------------
echo '--- Disable Microsoft Office telemetry'
defaults write com.microsoft.office DiagnosticDataTypePreference -string ZeroDiagnosticData
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Disable guest account login----------------
# ----------------------------------------------------------
echo '--- Disable guest account login'
sudo defaults write '/Library/Preferences/com.apple.loginwindow' 'GuestEnabled' -bool NO
if ! command -v 'sysadminctl' &> /dev/null; then
    echo 'Skipping because "sysadminctl" is not found.'
else
    sudo sysadminctl -guestAccount off
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# -----------Disable guest file sharing over SMB------------
# ----------------------------------------------------------
echo '--- Disable guest file sharing over SMB'
sudo defaults write '/Library/Preferences/SystemConfiguration/com.apple.smb.server' 'AllowGuestAccess' -bool NO
if ! command -v 'sysadminctl' &> /dev/null; then
    echo 'Skipping because "sysadminctl" is not found.'
else
    sudo sysadminctl -smbGuestAccess off
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# -----------Disable guest file sharing over AFP------------
# ----------------------------------------------------------
echo '--- Disable guest file sharing over AFP'
sudo defaults write '/Library/Preferences/com.apple.AppleFileServer' 'guestAccess' -bool NO
if ! command -v 'sysadminctl' &> /dev/null; then
    echo 'Skipping because "sysadminctl" is not found.'
else
    sudo sysadminctl -afpGuestAccess off
fi
sudo killall -HUP AppleFileServer
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------------Disable online spell correction--------------
# ----------------------------------------------------------
echo '--- Disable online spell correction'
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Disable remote Apple events----------------
# ----------------------------------------------------------
echo '--- Disable remote Apple events'
sudo systemsetup -setremoteappleevents off
# ----------------------------------------------------------


# ----------------------------------------------------------
# --Disable automatic storage of documents in iCloud Drive--
# ----------------------------------------------------------
echo '--- Disable automatic storage of documents in iCloud Drive'
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Disable AirDrop file sharing---------------
# ----------------------------------------------------------
echo '--- Disable AirDrop file sharing'
defaults write com.apple.NetworkBrowser DisableAirDrop -bool true
# ----------------------------------------------------------


# ----------------------------------------------------------
# ----------------Disable Spotlight indexing----------------
# ----------------------------------------------------------
echo '--- Disable Spotlight indexing'
sudo mdutil -i off -d /
# ----------------------------------------------------------


# ----------------------------------------------------------
# ------Disable participation in Siri data collection-------
# ----------------------------------------------------------
echo '--- Disable participation in Siri data collection'
defaults write com.apple.assistant.support 'Siri Data Sharing Opt-In Status' -int 2
# ----------------------------------------------------------


# ----------------------------------------------------------
# --------------------Disable "Ask Siri"--------------------
# ----------------------------------------------------------
echo '--- Disable "Ask Siri"'
defaults write com.apple.assistant.support 'Assistant Enabled' -bool false
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Disable Siri voice feedback----------------
# ----------------------------------------------------------
echo '--- Disable Siri voice feedback'
defaults write com.apple.assistant.backedup 'Use device speaker for TTS' -int 3
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------Disable Siri services (Siri and assistantd)--------
# ----------------------------------------------------------
echo '--- Disable Siri services (Siri and assistantd)'
launchctl disable "user/$UID/com.apple.assistantd"
launchctl disable "gui/$UID/com.apple.assistantd"
sudo launchctl disable 'system/com.apple.assistantd'
launchctl disable "user/$UID/com.apple.Siri.agent"
launchctl disable "gui/$UID/com.apple.Siri.agent"
sudo launchctl disable 'system/com.apple.Siri.agent'
if [ $(/usr/bin/csrutil status | awk '/status/ {print $5}' | sed 's/\.$//') = "enabled" ]; then
    >&2 echo 'This script requires SIP to be disabled. Read more: https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection'
fi
# ----------------------------------------------------------


# ----------------------------------------------------------
# -------Disable "Do you want to enable Siri?" pop-up-------
# ----------------------------------------------------------
echo '--- Disable "Do you want to enable Siri?" pop-up'
defaults write com.apple.SetupAssistant 'DidSeeSiriSetup' -bool True
# ----------------------------------------------------------


# ----------------------------------------------------------
# ----------------Remove Siri from menu bar-----------------
# ----------------------------------------------------------
echo '--- Remove Siri from menu bar'
defaults write com.apple.systemuiserver 'NSStatusItem Visible Siri' 0
# ----------------------------------------------------------


# ----------------------------------------------------------
# ---------------Remove Siri from status menu---------------
# ----------------------------------------------------------
echo '--- Remove Siri from status menu'
defaults write com.apple.Siri 'StatusMenuVisible' -bool false
defaults write com.apple.Siri 'UserHasDeclinedEnable' -bool true
# ----------------------------------------------------------
