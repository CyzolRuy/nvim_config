return{
  {
    'anuvyklack/windows.nvim',
    event = "VeryLazy",
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim'
    },
    config =function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()

      --keymap
      vim.keymap.set("n", "<leader>m", "<cmd>WindowsMaximize<cr>")
      vim.keymap.set("n", "<leader>e", "<cmd>WindowsEqualize<cr>")
    end
  }
}
