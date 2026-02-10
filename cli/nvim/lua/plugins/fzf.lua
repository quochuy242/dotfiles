return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { 'nvim-tree/nvim-web-devicons' },
	-- or if using mini.icons/mini.nvim
	dependencies = { "nvim-mini/mini.icons" },
	opts = {},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			{
				"fzf-native",
			},
			winopts = {
				height = 0.6,
				width = 0.8,
				row = 0.3,
				col = 0.5,
			},
		})

		-- [[ Keymaps for fzf-lua ]]
		local map = vim.keymap.set
		map("n", "<leader><leader>", fzf.files, { desc = "[F]ind [F]iles" })
		map("n", "<leader>fg", fzf.live_grep_native, { desc = "[F]ind [G]rep" })
		map("n", "<leader>fh", fzf.help_tags, { desc = "[F]ind [H]elp" })
		map("n", "<leader>fw", fzf.grep_cword, { desc = "[F]ind [W]ord" })
		map("n", "<leader>fo", fzf.oldfiles, { desc = "[F]ind [O]ld" })
		map("n", "<leader>fb", fzf.buffers, { desc = "[F]ind [B]uffer" })
	end,
}
