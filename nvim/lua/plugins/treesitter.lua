require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "vim", "vimdoc", "python" },

  highlight = {
    enable = true,
    use_languagetree = true,
    add
  },
  indent = { enable = true },
}
