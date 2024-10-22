local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Meta
config.automatically_reload_config = true

-- Rendering
config.freetype_load_flags = 'NO_HINTING'
config.freetype_load_target = "Light"
config.front_end = "WebGpu"
config.max_fps = 144
config.webgpu_preferred_adapter = {
  backend = 'Metal',
  device_type= "IntegratedGpu",
  name= "Apple M3 Pro",
}

-- Window
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
config.window_background_opacity = 0.975
config.macos_window_background_blur = 20

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
  saturation = 0.85,
  brightness = 0.85,
}

-- Fonts
config.harfbuzz_features = { 'zero', 'calt=1', 'clig=1', 'liga=1' }
config.font = wezterm.font('Hasklig', { weight = 'Medium' })
config.font_size = 14.5
config.line_height = 1.15
config.font_rules = {
  {
    italic = false,
    intensity = 'Half',
    font = wezterm.font('Hasklig', { weight = 'Regular' })
  },
  {
    italic = false,
    intensity = 'Normal',
    font = wezterm.font('Hasklig', { weight = 'Medium' })
  },
  {
    italic = false,
    intensity = 'Bold',
    font = wezterm.font('Hasklig', { weight = 'DemiBold' })
  },
  {
    italic = true,
    intensity = 'Normal',
    font = wezterm.font('Hasklig', { weight = 'Medium' })
   }
}

-- Cursor
config.cursor_blink_ease_in = 'Linear'
config.cursor_blink_ease_out = 'Linear'
config.cursor_blink_rate = 800

-- Colours
config.color_scheme_dirs = { '$HOME/.config/wezterm/colors' }
config.color_scheme = 'nerdyman'
config.colors = {
  tab_bar = {
    inactive_tab_edge = 'rgba(0% 0% 0% 0%)',
    background = 'rgba(0% 0% 0% 20%)',
    active_tab = {
      bg_color = '#b3a7fe',
      fg_color = '#5c4669',
      italic = true
    },
    inactive_tab = {
      bg_color = 'rgba(0% 0% 0% 25%)',
      fg_color = '#56507a'
    },
    new_tab = {
      bg_color = 'rgba(0% 0% 0% 25%)',
      fg_color = '#5c4669'
    }
  }
}

-- Mouse bindings
config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

-- Key bindings
config.enable_kitty_keyboard = true
config.leader = { key = 'a', mods = 'CTRL' }
config.keys = {
  {
    key = 'H',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'J',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Down', 5 },
  },
  {
    key = 'K',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Up', 5 }
  },
  {
    key = 'L',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
  -- Make cmd arrow left go to start of the line
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = wezterm.action { SendString = "\x1bOH" },
  },
  -- Make cmd arrow right go to start of line
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = wezterm.action { SendString = "\x1bOF" },
  },
   -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  {
    key = "LeftArrow",
    mods = "OPT",
    action = act{ SendString = "\x1bb" }
  },
   -- Make Option-Right equivalent to Alt-f; forward-word
  {
    key = "RightArrow",
    mods = "OPT",
    action = act{ SendString = "\x1bf" }
  },
  -- Set tab title
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Set tab name:',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  -- Open new pane
  {
    key = 'Enter',
    mods = 'SHIFT|CTRL',
    action = act.SplitVertical{ domain = 'CurrentPaneDomain' },
  },
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' },
  },
	{
    key = 'F1',
    action = act.TogglePaneZoomState,
  },
  -- Cycle pane forward
  {
    key = '}',
    mods = 'SHIFT|CTRL',
    action = act{ActivatePaneDirection="Next"},
  },
  -- Cycle pane backwards
  {
    key = '{',
    mods = 'SHIFT|CTRL',
    action = act{ActivatePaneDirection="Prev"},
  },
  -- Cycle tab forward
  {
    key = 'RightArrow',
    mods = 'SHIFT|CTRL',
    action = act{ActivateTabRelative=1},
  },
  -- Cycle tab backwards
  {
    key = 'LeftArrow',
    mods = 'SHIFT|CTRL',
    action = act{ActivateTabRelative=-1},
  },
  -- Quit tab
  {
    key = 'Q',
    mods = 'SHIFT|CTRL',
    action = act{CloseCurrentTab={confirm=false}},
  },
  -- Show command menu
  {
    key = 'P',
    mods = 'SHIFT|CTRL',
    action = act.ActivateCommandPalette,
  },
}

return config

-- vim: set expandtab shiftwidth=2 softtabstop=2:
