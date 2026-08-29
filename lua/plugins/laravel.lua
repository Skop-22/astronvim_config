return {
  "adalessa/laravel.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
  },
  ft = { "php", "blade" },
  event = { "BufEnter composer.json" },
  keys = {
    { "<leader>Ll", function() Laravel.pickers.laravel() end,                   desc = "Laravel: Picker" },
    { "<leader>La", function() Laravel.pickers.artisan() end,                   desc = "Laravel: Artisan Picker" },
    { "<leader>Lm", function() Laravel.pickers.make() end,                      desc = "Laravel: Make Picker" },
    { "<leader>Lc", function() Laravel.pickers.commands() end,                  desc = "Laravel: Custom Commands Picker" },
    { "<leader>Lo", function() Laravel.pickers.resources() end,                 desc = "Laravel: Resources Picker" },
    { "<leader>Lh", function() Laravel.run("artisan docs") end,                 desc = "Laravel: Documentation" },
    { "<leader>Lt", function() Laravel.commands.run("actions") end,             desc = "Laravel: Code Actions" },
    { "<leader>Lu", function() Laravel.commands.run("hub") end,                 desc = "Laravel: Artisan Hub" },
    { "<leader>Lp", function() Laravel.commands.run("command_center") end,      desc = "Laravel: Command Center" },
    { "<F9>",       function() Laravel.commands.run("view:finder") end,         desc = "Laravel: View Finder" },
    { "<F10>",      function() Laravel.pickers.routes() end,                    desc = "Laravel: Routes Picker" },
    { "<F4>",       function() Laravel.commands.run("tinker:open") end,         desc = "Laravel: Open command tinker open" },
  },
  opts = {
    features = {
      pickers = {
        provider = "snacks", -- telescope | fzf-lua | snacks | ui.select
      },
    },
  },
}
