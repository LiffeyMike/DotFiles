-- land/general.conf -> Lua. Autostart, input, gestures, misc.

local d = require("land.defaults")

-- Long-running daemons (waybar, hyprpaper, hypridle, polkit agent, cliphist) are
-- systemd user units bound to graphical-session.target; see packages/units-user.txt.
-- Everything here is launched through uwsm so it lands in its own systemd scope.
local function app(cmd)
	hl.exec_cmd("uwsm app -- " .. cmd)
end

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
	app("wl-clip-persist --clipboard regular")
	app(d.SCRIPTS .. "/power-watch")

	app("nvidia-settings")
	app("vivaldi --class=MAIN_BROWSER --enable-features=UseOzonePlatform --ozone-platform=wayland")
	app("alacritty --class=MAIN_TERM -e " .. d.TMUX)
	app("blueman-manager")
	app("sh -c 'sleep 10; exec pavucontrol'") -- delayed so the headset finishes connecting first
end)

hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })

hl.config({
	input = {
		kb_layout = "ie",
		numlock_by_default = true,
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = d.NATURAL_SCROLL,
			disable_while_typing = true,
		},
	},
	xwayland = {
		force_zero_scaling = d.XWAYLAND_ZERO_SCALING,
	},
	cursor = {
		-- Auto (2) picks software cursors here because the NVIDIA GPU is present alongside
		-- the Intel iGPU that drives every display. Software cursors stutter; the outputs are
		-- on i915, which handles hardware cursors fine, so force them on.
		no_hardware_cursors = 0,
	},
	misc = {
		disable_hyprland_logo = d.DISABLE_HYPRLAND_LOGO,
		animate_manual_resizes = d.ANIMATE_RESIZE,
		animate_mouse_windowdragging = d.ANIMATE_DRAG,
	},
})
