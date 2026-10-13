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

hl.window_rule({
	name = "nvidia-settings-ws",
	match = { class = "^(nvidia-settings)$" },
	workspace = "9 silent",
})

hl.window_rule({
	name = "blueman-ws",
	match = { class = "^(blueman-manager)$" },
	workspace = "8 silent",
})

hl.window_rule({
	name = "pavucontrol-ws",
	match = { class = "^(org.pulseaudio.pavucontrol)$" },
	workspace = "8 silent",
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
