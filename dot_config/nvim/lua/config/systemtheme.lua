-- Colourscheme from the system theme (`theme`, ~/.config/theme). The switcher renders the
-- active choice to ~/.local/state/theme/current/nvim.lua; this applies it at startup and
-- watches for switches, so every open Neovim recolours along with the desktop.
local M = {}

local state = (vim.env.XDG_STATE_HOME or (vim.env.HOME .. "/.local/state")) .. "/theme"
local fallback = { colorscheme = "tokyonight", background = "dark" }
local applied

local function read()
	local ok, t = pcall(dofile, state .. "/current/nvim.lua")
	return ok and type(t) == "table" and t or fallback
end

function M.apply()
	local t = read()
	if applied == t.colorscheme .. t.background then
		return
	end
	vim.o.background = t.background
	local ok, err = pcall(vim.cmd.colorscheme, t.colorscheme)
	if not ok then
		vim.notify("systemtheme: " .. err, vim.log.levels.WARN)
		vim.cmd.colorscheme(fallback.colorscheme)
	end
	applied = t.colorscheme .. t.background
end

-- `theme` swaps the `current` symlink with a rename, which shows up as an event on the
-- state directory. Debounced: one switch renames a couple of entries.
function M.watch()
	if M.watcher then
		return
	end
	local timer = vim.uv.new_timer()
	M.watcher = vim.uv.new_fs_event()
	M.watcher:start(state, {}, function(err, name)
		if err or (name ~= "current" and name ~= "active") then
			return
		end
		timer:start(100, 0, vim.schedule_wrap(M.apply))
	end)
end

return M
