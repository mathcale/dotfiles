hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 5,
    border_size = 2,
    col = {
      active_border = "0xffcba6f7",
      inactive_border = "rgba(ffffffff)",
    },
    layout = "dwindle",
    allow_tearing = false,
  },

  decoration = {
    rounding = 8,
    active_opacity = 1.0,
    inactive_opacity = 0.8,
    fullscreen_opacity = 1.0,

    blur = {
      enabled = true,
      size = 12,
      passes = 4,
      new_optimizations = true,
      ignore_opacity = true,
      xray = true,
    },

    shadow = {
      enabled = true,
      range = 30,
      render_power = 5,
      offset = { 0, 5 },
      color = "rgba(00000070)",
    },
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    mfact = 0.5,
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    vrr = 1,
  },

  xwayland = {
    force_zero_scaling = true,
  },

  ecosystem = {
    no_update_news = true,
  },

  debug = {
    full_cm_proto = true,
    disable_logs = false,
  },
})

hl.animation({
  enabled = true,
  leaf = "windowsIn",
  speed = 3,
  bezier = "default"
})

hl.animation({
  enabled = true,
  leaf = "windowsOut",
  speed = 3,
  bezier = "default"
})

hl.animation({
  enabled = true,
  leaf = "windowsMove",
  speed = 4,
  bezier = "default"
})

hl.animation({
  enabled = true,
  leaf = "workspaces",
  speed = 5,
  bezier = "default"
})

hl.animation({
  enabled = true,
  leaf = "fade",
  speed = 3,
  bezier = "default"
})

hl.animation({
  enabled = true,
  leaf = "border",
  speed = 3,
  bezier = "default"
})
