-- Neovim's half of surviving a reboot. tmux-resurrect restarts Neovim panes as
-- `NVIM_RESTORE=1 nvim <original args>` (see @resurrect-processes in tmux.conf); when that
-- variable is set, load the persistence.nvim session for this directory.
--
-- persistence.nvim only saves on a clean exit (VimLeavePre), and a reboot kills Neovim instead
-- of quitting it, so also save shortly after the window/buffer layout changes.
local M = {}

local function has_real_buffer()
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[b].buflisted and vim.bo[b].buftype == "" and vim.api.nvim_buf_get_name(b) ~= "" then
			return true
		end
	end
	return false
end

function M.setup()
	local persistence = require("persistence")

	if vim.env.NVIM_RESTORE == "1" then
		vim.env.NVIM_RESTORE = nil -- don't leak into :terminal or other children
		if vim.uv.fs_stat(persistence.current()) then
			persistence.load()
		end
	end

	local timer = vim.uv.new_timer()
	vim.api.nvim_create_autocmd(
		{ "BufEnter", "BufWritePost", "WinNew", "WinClosed", "TabNew", "TabClosed", "FocusLost" },
		{
			group = vim.api.nvim_create_augroup("session_autosave", { clear = true }),
			callback = function()
				timer:start(2000, 0, vim.schedule_wrap(function()
					if persistence.active() and has_real_buffer() then
						persistence.save()
					end
				end))
			end,
		}
	)
end

return M
