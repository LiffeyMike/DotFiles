-- profiles/battery.conf -> Lua. On-battery profile: monitor, autostart, animations off.

hl.monitor({
    output   = "",
    mode     = "1920x1080@60",
    position = "auto",
    scale    = 1,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("notify-send 'On Battery'")
    hl.exec_cmd("sleep 1 && pkill swww && swww init")
end)

hl.config({
    animations = { enabled = false },
})
