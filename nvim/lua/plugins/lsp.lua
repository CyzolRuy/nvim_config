-- lsp配置
vim.diagnostic.config ({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = false,
  })
-- 按键映射
vim.keymap.set('n','<leader>e',vim.diagnostic.open_float , {desc = "打开诊断信息" } )
vim.keymap.set('n','[d',vim.diagnostic.goto_prev,{desc = '上一个诊断'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = '下一个诊断' })


return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
	      "lua-language-server","clangd",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
    },
 {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

   -- example calling setup directly for each LSP
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    vim.lsp.config('lua_is',{
    	capabilities = capabilities
    })

    vim.lsp.enable('lua_ls')
    --Cpp
    vim.lsp.config('clangd',{capabilities = capabilities,
        --cmd = { "clangd", "--header-insertion=never", "--cross-file-rename" },
      })

    vim.lsp.enable('clangd')
  end,
 }    
}
