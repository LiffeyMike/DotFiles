-- land/defaults.conf -> Lua module of constants required by the other land modules.

local M = {}
local home = os.getenv("HOME")

M.HERE = home .. "/.config/hypr"
M.SCRIPTS = M.HERE .. "/scripts"

M.DRUN = "wofi --show drun"
M.SCREENSHOT = M.SCRIPTS .. "/screenshot"
M.LOCK = M.SCRIPTS .. "/lock"
M.TMUX = "sh -c 'tmux attach -t Main || tmux new-session -s Main; exec $SHELL'"
M.TERM = "alacritty --class=TERM -e " .. M.TMUX
M.PI_5_SSH = "alacritty -e ssh pi"
M.BROWSER = "vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland --class=BROWSER"
M.GEFORCE_NOW =
	"chromium --enable-features=UseOzonePlatform --ozone-platform=wayland --app=https://www.xbox.com/en-IE/play/games/forza-horizon-6-standard-edition/9N431PX143P8"

M.VOLINC = M.SCRIPTS .. "/buttons/volume+"
M.VOLRED = M.SCRIPTS .. "/buttons/volume-"
M.BRIGHTINC = M.SCRIPTS .. "/buttons/bright+"
M.BRIGHTRED = M.SCRIPTS .. "/buttons/bright-"
M.KBDBRIGHTINC = M.SCRIPTS .. "/buttons/kbdbacklight+"
M.KBDBRIGHTRED = M.SCRIPTS .. "/buttons/kbdbacklight-"

M.NATURAL_SCROLL = true
M.XWAYLAND_ZERO_SCALING = true
M.DISABLE_HYPRLAND_LOGO = true
M.ANIMATE_RESIZE = true
M.ANIMATE_DRAG = true

M.MOD1 = "SUPER"
M.MOD2 = "SUPER + SHIFT"

return M
