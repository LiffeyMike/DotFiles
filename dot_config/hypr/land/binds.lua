-- land/binds.conf -> Lua keybindings.

local d = require("land.defaults")
local M1 = d.MOD1
local M2 = d.MOD2
local home = os.getenv("HOME")

-- Workspaces
for i = 1, 10 do
	local key = i % 10 -- 10 -> 0
	hl.bind(M1 .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(M2 .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(M2 .. " + bracketright", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(M2 .. " + bracketleft", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(M1 .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(M1 .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Core
hl.bind(M1 .. " + Q", hl.dsp.window.close())
-- hyprctl dispatch takes a Lua expression under the Lua config.
hl.bind(
	M2 .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(M1 .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(M1 .. " + R", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/dock-recover --force")) -- un-wedge monitors after a dock drop
hl.bind(M2 .. " + P", hl.dsp.window.pseudo())

-- Window navigation
hl.bind(M1 .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(M1 .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(M1 .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(M1 .. " + J", hl.dsp.focus({ direction = "d" }))

-- Window organisation
hl.bind(M2 .. " + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(M2 .. " + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(M2 .. " + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(M2 .. " + K", hl.dsp.window.move({ direction = "u" }))

-- Monitors
hl.bind(M1 .. " + comma", hl.dsp.focus({ monitor = "-1" }))
hl.bind(M1 .. " + period", hl.dsp.focus({ monitor = "+1" }))
hl.bind(M2 .. " + comma", hl.dsp.window.move({ monitor = "-1" }))
hl.bind(M2 .. " + period", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(M1 .. " + O", hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind(M2 .. " + O", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))

hl.bind(M1 .. " + G", hl.dsp.group.toggle())
hl.bind(M1 .. " + Tab", hl.dsp.group.next())
hl.bind(M1 .. " + F", hl.dsp.window.fullscreen())
hl.bind(M2 .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(M1 .. " + C", hl.dsp.window.center())

hl.bind(M1 .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(M1 .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(d.VOLRED), { repeating = true, locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(d.VOLINC), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && " .. d.SCRIPTS .. "/buttons/osd volume"), { locked = true })

-- Media
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(d.BRIGHTINC), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(d.BRIGHTRED), { repeating = true, locked = true })

-- Util
hl.bind("SUPER + space", hl.dsp.exec_cmd("pkill rofi || " .. d.DRUN))
hl.bind(M1 .. " + T", hl.dsp.exec_cmd("pkill rofi || " .. home .. "/.local/bin/theme menu")) -- theme picker
hl.bind(M2 .. " + Return", hl.dsp.exec_cmd(d.PI_5_SSH))
hl.bind(M1 .. " + Return", hl.dsp.exec_cmd(d.TERM))
hl.bind(M2 .. " + S", hl.dsp.exec_cmd(d.SCREENSHOT))
hl.bind(M1 .. " + X", hl.dsp.exec_cmd("wlogout"), { locked = true })
hl.bind("SUPER + V", hl.dsp.exec_cmd("pkill rofi || " .. d.CLIPBOARD))
hl.bind(M1 .. " + Escape", hl.dsp.exec_cmd(d.LOCK)) -- was M2+L, which collided with move-right

-- Applications
hl.bind(M1 .. " + B", hl.dsp.exec_cmd(d.BROWSER))
hl.bind(M2 .. " + B", hl.dsp.exec_cmd(d.GEFORCE_NOW))
hl.bind(M1 .. " + P", hl.dsp.exec_cmd("spotify-launcher"))
hl.bind(M1 .. " + S", hl.dsp.exec_cmd("prime-run steam")) -- games inherit NVIDIA offload
hl.bind(M1 .. " + D", hl.dsp.exec_cmd("discord"))
hl.bind(M2 .. " + D", hl.dsp.exec_cmd("flatpak run com.heroicgameslauncher.hgl"))

-- Dictation (voxtype)
-- Hold Right Alt (AltGr = ISO_Level3_Shift on the ie layout) to record; release to transcribe.
local dictate = home .. "/.config/hypr/scripts/dictation/dictation-record.sh"
hl.bind("ISO_Level3_Shift", hl.dsp.exec_cmd(dictate .. " start"), { ignore_mods = true })
hl.bind("ISO_Level3_Shift", hl.dsp.exec_cmd(dictate .. " stop"), { ignore_mods = true, release = true })
hl.bind(M2 .. " + I", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/dictation/dictation-daemon-toggle.sh"))
