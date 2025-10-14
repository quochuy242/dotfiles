return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		config = function()
			require("typst-preview").setup({})
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"tinymist",
				"lua_ls",
				"basedpyright",
				"omnisharp",
				"rust_analyzer",
				"gopls",
				"bashls",
				"sqlls",
			},
		},
	},

	-- [[ LSP Config ]]
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Optional: nvim-cmp capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if cmp_ok then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end
			local on_attach = function(client, bufnr)
				local map = vim.keymap.set
				local opts = { buffer = bufnr, remap = false }

				map("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = bufnr })
				map("n", "gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences", buffer = bufnr })
				map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = bufnr })
				map("n", "<leader>r", vim.lsp.buf.rename, { desc = "[R]ename symbol", buffer = bufnr })
				map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction", buffer = bufnr })
			end

			-- ======================
			-- Python
			-- ======================
			lspconfig["basedpyright"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = { debounce_text_changes = 150 },
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			-- ======================
			-- Lua
			-- ======================
			lspconfig["lua_ls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			-- ======================
			-- C#
			-- ======================
			lspconfig["omnisharp"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
			})

			-- ======================
			-- Go
			-- ======================
			lspconfig["gopls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
			})

			-- ======================
			-- Rust
			-- ======================
			lspconfig["rust_analyzer"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = { command = "clippy" },
					},
				},
			})

			-- ======================
			-- SQL
			-- ======================
			lspconfig["sqlls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- ======================
			-- Bash
			-- ======================
			lspconfig["bashls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "sh", "bash", "zsh" },
			})

			-- ======================
			-- Typst
			-- ======================
			lspconfig["tinymist"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					formatterMode = "typstyle",
					exportPdf = "onType",
					semanticTokens = "disable",
				},
			})
		end,
	},

	-- [[ Lazy dev tools ]]
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		pts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- [[ AI completion]]

	{
		"Exafunction/windsurf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},

	-- [[ Formatting ]]
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				go = { "gofmt" }, -- or 'goimports'
				html = { "prettier" },
				bash = { "shfmt" },
				markdown = { "prettier" },
				c_sharp = { "csharpier" }, -- dotnet tool
				rust = { "rustfmt" },
				sql = { "sqlfluff" },
				toml = { "taplo" }, -- TOML formatter
				yaml = { "prettier" },
				just = { "just" }, -- justfile formatter
				markdown_inline = { "prettier" },
			},
		},
	},

	-- [[ Diagnostics]]
	{

		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- Trouble is a pretty list for showing diagnostics, references, etc.
			-- It works as a better quickfix/location list replacement.
			-- Useful for navigating errors, warnings, TODOs, or LSP references.
			modes = {
				preview_float = {
					mode = "diagnostics",
					preview = {
						type = "float",
						relative = "editor",
						border = "rounded",
						title = "Preview",
						title_pos = "center",
						position = { 0, -2 },
						size = { width = 0.3, height = 0.3 },
						zindex = 200,
					},
				},
			},
		},
		keys = {
			-- Show diagnostics only for the current buffer
			{ "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[D]iagnostics for [B]uffer" },

			-- Show LSP references under the cursor
			{ "<leader>dr", "<cmd>Trouble lsp_references toggle<cr>", desc = "[D]iagnostics [R]eferences" },

			-- Show definitions, implementations, type definitions
			{ "<leader>dd", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "[D]iagnostics [D]efinitions" },
			{ "<leader>di", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "[D]iagnostics [I]mplementations" },
			{ "<leader>dt", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "[D]iagnostics [T]ype Definitions" },

			-- Show symbols from workspace or document
			{ "<leader>ds", "<cmd>Trouble lsp_document_symbols toggle focus=false<cr>", desc = "[D]ocument [S]ymbols" },
			{
				"<leader>ws",
				"<cmd>Trouble lsp_workspace_symbols toggle focus=false<cr>",
				desc = "[W]orkspace [S]ymbols",
			},

			-- Show TODOs, FIX, HACK, WARN, etc. if you use todo-comments.nvim
			{ "<leader>dtd", "<cmd>Trouble todo toggle<cr>", desc = "[T]ODOs" },
		},

		config = function()
			local config = require("fzf-lua.config")
			local actions = require("trouble.sources.fzf").actions

			config.defaults.actions.files["ctrl-t"] = actions.open
		end,
	},

	-- [[ Cmp ]]
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer", -- Completion from current buffer
			"hrsh7th/cmp-path", -- Completion from filesystem paths
			"hrsh7th/cmp-nvim-lsp", -- Completion from LSP
			"hrsh7th/cmp-nvim-lua", -- Completion from Neovim Lua API
			"hrsh7th/cmp-cmdline", -- Completion for command line
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				-- Keymaps for completion
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(), -- Next suggestion
					["<C-p>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
				}),

				-- Sources for completion
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP suggestions
					{ name = "buffer" }, -- Words from buffer
					{ name = "path" }, -- File paths
					{ name = "nvim_lua" }, -- Lua API for Neovim
					{ name = "codeium" }, -- AI completion
				}),

				-- Window appearance
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				-- Experimental ghost text (inline suggestion like VSCode)
				experimental = {
					ghost_text = true,
				},

				-- Formatting of completion items
				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							buffer = "[Buffer]",
							path = "[Path]",
							nvim_lua = "[Lua]",
							codeium = "[AI]",
						})[entry.source.name]
						return vim_item
					end,
				},
			})

			-- Completion for search `/` in buffer
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			-- Completion for command line `:`
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline" },
				}, {
					{ name = "path" },
				}),
			})
		end,
	},
}
