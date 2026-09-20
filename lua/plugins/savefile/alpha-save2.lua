return{
"goolord/alpha-nvim",
event = "VimEnter",
config = function ()
  local alpha =require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  local function get_all_files_in_dir(dir)
    local files = {}
    local scan = vim.fn.globpath(dir, "**/*.lua", true, true)
    for _, file in ipairs(scan) do
      table.insert(files, file)
    end
    return files
  end

  local function load_random_header()
    math.randomseed(vim.loop.hrtime())
    local header_folder = vim.fn.stdpath("config") .. "/lua/plugins/header_img/"
    local files = get_all_files_in_dir(header_folder)
    
    if #files == 0 then
      return nil
    end

    local random_file = files[math.random(#files)]
    local relative_path = random_file:sub(#header_folder + 1)
    local module_name = "plugins.header_img." .. relative_path:gsub("/", "."):gsub("\\", "."):gsub("%.lua$", "")

    package.loaded[module_name] = nil

    local ok , module = pcall(require , module_name)
    if ok and module then
      return module
    else
      return nil
    end
  end

  local header = load_random_header()
  if header then
    dashboard.config.layout[2] = header
  else
    print("请提交img2art输出文件喵❤️")
  end 
  local function change_header() 
    local new_header = load_random_header()
    if new_header then 
     dashboard.config.layout[2] = new_header vim.cmd("AlphaRedraw")
    else
      print("请提交img2art输出文件喵❤️")
    end
  end

  vim.api.nvim_create_autocmd("User",{
      pattern = "AlphaReady",
      callback = function()
        change_header()
      end,
  })

  --button自定义
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


  dashboard.config.layout = {
   { type = "padding" , val = 3},
   header,
   { type = "padding" , val = 2},
  buttons,
   dashboard.section.footer,
 }

 vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    desc = "Add Alpha dashboard footer",
    once = true,
    callback = function()
      local stats = require("lazy").stats()
      local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
      dashboard.section.footer.val =
        { " ", " ", " ", " Loaded " .. stats.count .. " plugins  in " .. ms .. " ms " }
      dashboard.section.footer.opts.hl = "DashboardFooter"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
 
 alpha.setup(dashboard.config)
end,
}
