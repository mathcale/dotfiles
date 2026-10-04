-- Noctalia layer rules (see https://docs.noctalia.dev/noctalia/compositor-settings/hyprland/)
-- Enables blur for Noctalia's bar, panels, dock, and notifications, and disables
-- Hyprland's built-in layer animations for Noctalia so they don't fight its own animations.

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
