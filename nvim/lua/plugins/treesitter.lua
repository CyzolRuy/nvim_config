return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.config').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, 
        },
        indent = { enable = true },
        auto_install = true,
        ensure_installed = {
          "c", "cpp", "markdown", "lua", "vim",
          "vimdoc", "query", "python", "bash","html","css",
          "json", "markdown_inline"
        },
      })
    end,
  }
}
