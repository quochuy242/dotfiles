return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"markdown",
				"vim",
				"vimdoc",
				"python",
				"go",
				"html",
				"make",
				"just",
				"markdown_inline",
				"bash",
				"c_sharp",
				"rust",
				"sql",
				"latex",
				"toml",
				"typst",
				"yaml",
				"cpp",
				"regex",
				"hyprlang",
				"tmux",
				"toml",
				"dockerfile",
				"css",
				"json",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			autotag = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
			},
			playground = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		})
	end,
}
