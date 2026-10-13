-- profiles/power.conf -> Lua. On-power profile: monitor + autostart bits.

hl.monitor({
    output   = "",
    mode     = "1920x1080@60",
    position = "auto",
    scale    = 1,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("notify-send 'On Power'")
    hl.exec_cmd("sleep 1 && pkill swww && swww init")
end)
