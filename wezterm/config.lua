local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config = {
  check_for_updates = true,
  native_macos_fullscreen_mode = false,
  default_cursor_style = "SteadyBar",
  automatically_reload_config = true,

  -- Fonts
  font = wezterm.font("JetBrains Mono"),
  font_size = 16,

  -- Tab bar
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  show_new_tab_button_in_tab_bar = false,
  show_tab_index_in_tab_bar = false,
  tab_max_width = 100,

  -- Window
  window_close_confirmation = "NeverPrompt",
  adjust_window_size_when_changing_font_size = false,
  window_background_opacity = 0.7,
  window_decorations = "RESIZE",
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  macos_window_background_blur = 40,

  -- Keys
  keys = {
    {
      key = 'q',
      mods = 'CTRL',
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = '\'',
      mods = 'CTRL',
      action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
    },
  },

  -- Mouse
  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}

return config