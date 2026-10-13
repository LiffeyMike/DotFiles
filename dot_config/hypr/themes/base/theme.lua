-- themes/base/theme.conf -> Lua. Border colors, blur, animations.

local home = os.getenv("HOME")

-- Was: exec=cp $THEME/colors $HOME/.config/hypr/themes/colors
-- ($THEME was never defined in the old configs — hard-coding the resolved path.)
hl.on("hyprland.start", function()
    hl.exec_cmd("cp " .. home .. "/.config/hypr/themes/base/colors "
                      .. home .. "/.config/hypr/themes/colors")
end)

hl.config({
    general = {
        col = {
            active_border   = { colors = {"0xffa3e49f", "0xff63b2b8", "0xff82599c"}, angle = 45 },
            inactive_border = "0xff6e738d",
        },
    },
    decoration = {
        blur = { enabled = true },
    },
    animations = { enabled = true },
})

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9},  {0.10, 1.05} } })
hl.curve("overshot", { type = "bezier", points = { {0.13, 0.99}, {0.29, 1.10} } })

-- Effective values after de-duplicating the original (later entries won there).
hl.animation({ leaf = "windows",     enabled = true, speed = 3,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "myBezier" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "myBezier" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 5,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 4,  bezier = "overshot", style = "slidevert" })
