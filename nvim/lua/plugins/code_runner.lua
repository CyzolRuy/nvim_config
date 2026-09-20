return{
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      filetype = {
        cpp = {
          "cd $dir && g++ -std=c++20 -Wall -Wextra -Wshadow -Wconversion $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt"
                  },
        c = {
          "cd $dir && gcc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt"
                  },
        python = {
          "cd $dir && python3 $fileName"
        },
      },
    })
  --按键映射
    vim.api.nvim_set_keymap('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false })
    vim.api.nvim_set_keymap('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
  end,
}
