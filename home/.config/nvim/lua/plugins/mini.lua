return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		local map = vim.keymap.set

		-- Icons
		require("mini.icons").setup()

		-- Auto-paring
		require("mini.pairs").setup({
			mappings = {
				["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
				["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
				["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

				[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
				["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
				["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

				['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
				["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
				["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },

				-- Tags
				["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\<].", register = { cr = false } },
				[">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\<].", register = { cr = false } },

				-- For markdown and typst
				["*"] = { action = "closeopen", pair = "**", neigh_pattern = "[^*\\].", register = { cr = false } },
			},
		})

		-- Comment
		-- `gc` to comment visual selection
		-- `gcc` to comment current line
		require("mini.comment").setup()

		-- Statusline and its dependencies
		-- require("mini.statusline").setup()
		require("mini.git").setup()
		-- `gh` / `gH to apply / reset the hunk
		-- `[h` / `]h` to go to the next / previous hunk
		-- `[H` / `]H` to go to the first / last hunk
		require("mini.diff").setup()

		-- Notify
		require("mini.notify").setup()

		-- Surround
		-- Add surrounding with `sa` (in visual mode or on motion).
		-- Delete surrounding with `sd`.
		-- Replace surrounding with `sr.
		-- Find surrounding with sf or `sF` (move cursor right or left).
		-- Highlight surrounding with `sh`.
		require("mini.surround").setup()

		-- Move
		-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
		-- - left = '<M-h>',
		-- - right = '<M-l>',
		-- - down = '<M-j>',
		-- - up = '<M-k>',
		-- Move current line in Normal mode
		-- - line_left = '<M-h>',
		-- - line_right = '<M-l>',
		-- - line_down = '<M-j>',
		-- - line_up = '<M-k>',
		require("mini.move").setup()

		-- Starter
		require("mini.starter").setup()
	end,
}
