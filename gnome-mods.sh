#!/bin/bash

# Unbind defaults.
gsettings set org.gnome.mutter.keybindings switch-monitor						[]
gsettings set org.gnome.shell.keybindings switch-to-application-1		[]
gsettings set org.gnome.shell.keybindings switch-to-application-2		[]
gsettings set org.gnome.shell.keybindings switch-to-application-3		[]
gsettings set org.gnome.shell.keybindings switch-to-application-4		[]
gsettings set org.gnome.shell.keybindings switch-to-application-5		[]
gsettings set org.gnome.shell.keybindings switch-to-application-6		[]
gsettings set org.gnome.shell.keybindings switch-to-application-7		[]
gsettings set org.gnome.shell.keybindings switch-to-application-8		[]
gsettings set org.gnome.shell.keybindings switch-to-application-9		[]

# Window Placement.
gsettings set org.gnome.shell.keybindings auto-maximize	true
gsettings set org.gnome.shell.keybindings center-new-windows	true

# Set up workspaces.
gsettings set org.gnome.desktop.wm.preferences num-workspaces					10
gsettings set org.gnome.mutter dynamic-workspaces 										false
gsettings set org.gnome.shell.keybindings workspaces-only-on-primary	true

# Switch to workspace.
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1	"['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2	"['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3	"['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4	"['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5	"['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6	"['<Super>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7	"['<Super>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8	"['<Super>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9	"['<Super>9']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"

# Move window to workspace.
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1	"['<Super><Shift>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2	"['<Super><Shift>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3	"['<Super><Shift>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4	"['<Super><Shift>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5	"['<Super><Shift>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6	"['<Super><Shift>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7	"['<Super><Shift>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8	"['<Super><Shift>8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9	"['<Super><Shift>9']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"

# i3...ish bindings
gsettings set org.gnome.desktop.wm.keybindings always-on-top					"['<Shift><Super>a']"
gsettings set org.gnome.desktop.wm.keybindings close									"['<Shift><Super>q']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen			"['<Shift><Super>f']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized				"['<Super>f']"
