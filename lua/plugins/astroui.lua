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
    -- Colorscheme set on startup, a string that is used with `:colorscheme astrodark`
    colorscheme = "astrolight",
    -- Configure how folding works
    folding = {
      -- whether a buffer should have folding can be true/false for global enable/disable or fun(bufnr:integer):boolean
      enabled = function(bufnr) return require("astrocore.buffer").is_valid(bufnr) end,
      -- a priority list of fold methods to try using, available methods are "lsp", "treesitter", and "indent"
      methods = { "lsp", "treesitter", "indent" },
    },
    -- Override highlights in any colorscheme
    -- Keys can be:
    --   `init`: table of highlights to apply to all colorschemes
    --   `<colorscheme_name>` override highlights in the colorscheme with name: `<colorscheme_name>`
    highlights = {
      -- this table overrides highlights in all colorschemes
      init = {
        Normal = { bg = "#000000" },
      },
      -- a table of overrides/changes when applying astrotheme
      astrotheme = {
        Normal = { bg = "#000000" },
      },
    },
    -- A table of icons in the UI using NERD fonts
    icons = {
      GitAdd = "",
    },
    -- A table of only text "icons" used when icons are disabled
    text_icons = {
      GitAdd = "[+]",
    },
    -- Configuration options for the AstroNvim lines and bars built with the `status` API.
    status = {
      -- Configure attributes of components defined in the `status` API. Check the AstroNvim documentation for a complete list of color names, this applies to colors that have `_fg` and/or `_bg` names with the suffix removed (ex. `git_branch_fg` as attributes from `git_branch`).
      attributes = {
        git_branch = { bold = true },
      },
      -- Configure colors of components defined in the `status` API. Check the AstroNvim documentation for a complete list of color names.
      colors = {
        git_branch_fg = "#ABCDEF",
      },
      -- Configure which icons that are highlighted based on context
      icon_highlights = {
        -- enable or disable breadcrumb icon highlighting
        breadcrumbs = false,
        -- Enable or disable the highlighting of filetype icons both in the statusline and tabline
        file_icon = {
          tabline = function(self) return self.is_active or self.is_visible end,
          statusline = true,
        },
      },
      -- Configure characters used as separators for various elements
      separators = {
        none = { "", "" },
        left = { "", "  " },
        right = { "  ", "" },
        center = { "  ", "  " },
        tab = { "", "" },
        breadcrumbs = "  ",
        path = "  ",
      },
      -- Configure enabling/disabling of winbar
      winbar = {
        enabled = { -- whitelist buffer patterns
          filetype = { "gitsigns.blame" },
        },
        disabled = { -- blacklist buffer patterns
          buftype = { "nofile", "terminal" },
        },
      },
    },
    -- Configure theming of Lazygit, set to `false` to disable
    lazygit = {
      theme_path = vim.fs.normalize(vim.fn.stdpath "cache" .. "/lazygit-theme.yml"),
      theme = {
        [241] = { fg = "Special" },
        activeBorderColor = { fg = "MatchParen", bold = true },
        cherryPickedCommitBgColor = { fg = "Identifier" },
        cherryPickedCommitFgColor = { fg = "Function" },
        defaultFgColor = { fg = "Normal" },
        inactiveBorderColor = { fg = "FloatBorder" },
        optionsTextColor = { fg = "Function" },
        searchingActiveBorderColor = { fg = "MatchParen", bold = true },
        selectedLineBgColor = { bg = "Visual" },
        unstagedChangesColor = { fg = "DiagnosticError" },
      },
    },
  },
}
