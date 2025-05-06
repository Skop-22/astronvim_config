return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
  },
  init = function ()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function ()
        Snacks.toggle.dim():map("<leader>lk")
      end
    })
  end
}
