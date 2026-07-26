hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "intl",
    kb_model = "",
    kb_options = "caps:escape_shifted_capslock",
    kb_rules = "",
    numlock_by_default = true,
    follow_mouse = 1,
    sensitivity = -1,
    scroll_factor = 0.8,
    accel_profile = "adaptive",
    natural_scroll = false,
  },
  cursor = {
    no_hardware_cursors = false,
  },
})

hl.device({
  name = "logitech-g903-ls-1",
  sensitivity = -0.85,
})
