-- land/general.conf -> Lua. Autostart, input, gestures, misc.

local d = require("land.defaults")
local home = os.getenv("HOME")

hl.on("hyprland.start", function()
	hl.exec_cmd(d.SCRIPTS .. "/powercheck")
	hl.exec_cmd(d.SCRIPTS .. "/portal.sh")
	hl.exec_cmd("hyprpolkitagent")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar -c " .. home .. "/.config/waybar/river/config -s " .. home .. "/.config/waybar/river/style.css")
	hl.exec_cmd("wl-paste --type text  --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("wl-clip-persist --clipboard regular")

	hl.exec_cmd("nvidia-settings")
	hl.exec_cmd("vivaldi --class=MAIN_BROWSER --enable-features=UseOzonePlatform --ozone-platform=wayland")
	hl.exec_cmd("alacritty --class=MAIN_TERM -e sh -c 'tmux attach -t Main || tmux new-session -s Main; exec $SHELL'")
	hl.exec_cmd("blueman-manager")
	hl.exec_cmd("sh -c 'sleep 10; exec pavucontrol'") -- delayed so the headset finishes connecting first

	hl.exec_cmd(
		"pkill swayidle; swayidle -w"
			.. " timeout 300 '"
			.. d.LOCK
			.. "'"
			.. " timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'"
			.. " before-sleep '"
			.. d.LOCK
			.. "'"
	)
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
