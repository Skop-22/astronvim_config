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
  config = function(_, opts)
    require("laravel").setup(opts)

    local nio = require("nio")
    local app = require("laravel.core.app")

    local artisan_commands = {}

    -- Crear función async para cargar Artisan
    local load_artisan = nio.create(function()
      local loader = app("laravel.loaders.artisan_loader")

      local commands, err = loader:load()

      if err then
        vim.notify(
          "Error cargando comandos Artisan: " .. tostring(err),
          vim.log.levels.ERROR
        )
        return
      end

      artisan_commands = vim.tbl_map(function(command)
        return command.name
      end, commands)
    end)

    load_artisan()

    vim.api.nvim_create_user_command("Laravel", function(opts)
      Laravel.run(opts.args)
    end, {
      nargs = "+",

      complete = function(ArgLead, CmdLine, CursorPos)
        local partes = vim.split(CmdLine, "%s+")

        -- :Laravel <TAB>
        if #partes == 2 then
          return vim.iter({
            "artisan",
          })
            :filter(function(name)
              return vim.startswith(name, ArgLead)
            end)
            :totable()
        end

        -- :Laravel artisan <TAB>
        if partes[2] == "artisan" then
          return vim.iter(artisan_commands)
            :filter(function(name)
              return vim.startswith(name, ArgLead)
            end)
            :totable()
        end

        return {}
      end,
    })
  end,
}
