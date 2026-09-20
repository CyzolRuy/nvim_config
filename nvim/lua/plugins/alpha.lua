ANIME = {
  { "test.txt",100 },
  {"2.txt"},
}

return{
  "goolord/alpha-nvim",
  opts = function ()
    local dashboard = require("alpha.themes.dashboard")
    require("alpha.term")
    require("math")

    local button = dashboard.button

    dashboard.opts.opts.noautocmd = false
    dashboard.section.terminal.opts.redraw = true
    math.randomseed(os.time())
    local idx = math.random(1,#ANIME)
    local info = ANIME[idx]
    local path = os.getenv "HOME" .. "/.config/nvim/lua/plugins/"

    dashboard.section.terminal.command = "/usr/bin/bash ".. path .. "sh/show.sh " .. path .. "header/" .. info[1]
    dashboard.section.terminal.width = 80
    dashboard.section.terminal.height = 35

    buttons = {
      type = "group",
      val = {
        dashboard.button("e", "  New file",              "<cmd> ene <CR>"),
        dashboard.button("SPC f f", "󰈞  Find file",       "<cmd> Telescope find_files <CR>"),
        dashboard.button("SPC f h", "󰊄  Recently opened files"),
        dashboard.button("SPC f r", "  Frecency/MRU"),
        dashboard.button("SPC f g", "󰈬  Find word"),
        dashboard.button("n", "  Neotree",               "<cmd> Neotree <CR>"),
        dashboard.button("c", "C  cd Plugins Path",       "<cmd> cd ~/.config/nvim/lua/plugins <CR>"),
        dashboard.button("p", "P  pipes",                 "<cmd> term pipes <CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <CR>"),
        dashboard.button("q", "󰅚  close",                 "<cmd> qa <CR>"),
      },
    }


    dashboard.opts.layout = {
      { type = "padding" , val = 1},
      {
        type = "group",
        --align = "center",
        val = {dashboard.section.terminal,},
      },
      { type = "padding" , val = 2},
      buttons,
      dashboard.section.footer,
    }

    return dashboard
  end,

  config = function(_,opts)
    require("alpha").setup(opts.config)

    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        desc = "Add Alpha dashboard footer",
        once = true,
        callback = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          opts.section.footer.val =
            { " ", " ", " ", " Loaded " .. stats.count .. " plugins  in " .. ms .. " ms " }
          opts.section.footer.opts.hl = "DashboardFooter"
          pcall(vim.cmd.AlphaRedraw)
        end,
    })
    
    local function setLaststatus()
      if vim.bo.filetype == "alpha" then
        if vim.opt.laststatus == 0 then return end
        --vim.opt.laststatus = 0
        vim.g.neovide_scale_factor = 0.75
      else
        if vim.opt.laststatus == 3 then return end
        vim.opt.laststatus = 3
        vim.g.neovide_scale_factor = 1
      end
    end
    setLaststatus()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      desc = "Hide statusline in Alpha",
      callback = setLaststatus,
    })

  end,
  
}
