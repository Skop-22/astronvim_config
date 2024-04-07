if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "astrodark",
      highlights = {
        init = {
          -- Normal = { bg = "#000000" },
        },
        astrotheme = {
          -- Normal = { bg = "#000000" },
        },
      },
      status = {
        icon_highlights = {
          breadcrumbs = false,
          file_icon = {
            tabline = function(self) return self.is_active or self.is_visible end,
            statusline = true,
          },
        },
        separators = {
          none = { "", "" },
          left = { "", "  " },
          right = { "  ", "" },
          center = { "  ", "  " },
          tab = { "", "" },
          breadcrumbs = "  ",
          path = "  ",
        },
      },
  }
}
