hl.window_rule({
	name = "term-ws",
	match = { class = "^(MAIN_TERM)$" },
	workspace = "1 silent",
})

hl.window_rule({
	name = "browser-ws",
	match = { class = "^(MAIN_BROWSER)$" },
	workspace = "2 silent",
})

-- Workspace 9 holds the system tools. Master layout places windows by opening order (not by
-- focus or mouse position), and scripts/tools-workspace opens them in a fixed order:
-- pavucontrol as master on the right, Blueman over NVIDIA Settings on the left.
hl.workspace_rule({
	workspace = "9",
	layout = "master",
	layout_opts = { orientation = "right" }, -- orientation is the only per-workspace option
})

-- Master split ratio is global; workspace 9 is the only master-layout workspace.
hl.config({ master = { mfact = 0.5 } })

hl.window_rule({
	name = "nvidia-settings-ws",
	match = { class = "^(nvidia-settings)$" },
	workspace = "9 silent",
})

hl.window_rule({
	name = "blueman-ws",
	match = { class = "^(blueman-manager)$" },
	workspace = "9 silent",
})

hl.window_rule({
	name = "pavucontrol-ws",
	match = { class = "^(org.pulseaudio.pavucontrol)$" },
	workspace = "9 silent",
})

hl.window_rule({
	name = "steam-ws",
	match = { class = "^(steam)$" },
	workspace = "4 silent",
})

hl.window_rule({
	name = "discord-ws",
	match = { class = "^(discord)$" },
	workspace = "5 silent",
})

hl.window_rule({
	name = "spotify-ws",
	match = { class = "^(Spotify)$" },
	workspace = "7 silent",
})

-- Keep the pointer inside the game window so it can't slide onto the other
-- monitors mid-game. Matches any Steam game (steam_app_<id>) and native Dota 2.
hl.window_rule({
	name = "game-confine-pointer",
	match = { class = "^(steam_app_[0-9]+|dota2)$" },
	confine_pointer = true,
})
