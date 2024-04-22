-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Window
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"

-- Layout
config.initial_rows = 50
config.initial_cols = 200

-- Tabs
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.tab_max_width = 40
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

-- Fonts
config.freetype_load_flags = 'NO_HINTING'
config.freetype_interpreter_version = 40
config.freetype_load_target = 'Normal'
config.font = wezterm.font('Hasklig', { weight = 'Medium' })
config.font_size = 14.75
config.line_height = 1.25
config.font_rules = {
  {
    italic = false,
    intensity = 'Normal',
    font = wezterm.font('Hasklig', { weight = 'Medium' })
  },
  {
    italic = false,
    intensity = 'Bold',
    font = wezterm.font('Hasklig', { weight = 'Bold' })
  },
  {
    italic = true,
    intensity = 'Normal',
    font = wezterm.font('Hasklig', { weight = 'DemiBold' })
   }
}

-- Colours
config.colors = {
  tab_bar = {
    inactive_tab_edge = 'rgba(0% 0% 0% 0%)',
    background = 'rgba(0% 0% 0% 20%)',
    active_tab = {
      bg_color = '#c2fa88',
      fg_color = '#464669',
      italic = true
    },
    inactive_tab = {
      bg_color = 'rgba(0% 0% 0% 25%)',
      fg_color = '#505050'
    },
    new_tab = {
      bg_color = 'rgba(0% 0% 0% 25%)',
      fg_color = '#808080'
    }
  }
}

config.color_scheme = 'Duotone Dark'

-- Keybindings
config.enable_kitty_keyboard = true
config.keys = {
  -- Make Home go to the start of the line
  {
    key = "Home",
    mods = "NONE",
    action = wezterm.action{ SendString="\x1b[H" }
  },
  -- Make End go to the end of the line
  {
    key = "End",
    mods = "NONE",
    action = wezterm.action{ SendString = "\x1b[F" }
  },
   -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  {
    key = "LeftArrow",
    mods = "OPT",
    action = wezterm.action{ SendString = "\x1bb" }
  },
   -- Make Option-Right equivalent to Alt-f; forward-word
  {
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action{ SendString = "\x1bf" }
  },
  {
    key = 'Enter',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

return config
