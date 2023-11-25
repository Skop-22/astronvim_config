return {
  "AstroNvim/astrotheme",
  opts = {
      style = {
        transparent = true,         -- Bool value, toggles transparency.
        inactive = false,             -- Bool value, toggles inactive window color.
        float = false,                -- Bool value, toggles floating windows background colors.
        neotree = false,              -- Bool value, toggles neo-trees background color.
        border = false,               -- Bool value, toggles borders.
        title_invert = false,         -- Bool value, swaps text and background colors.
        italic_comments = false,      -- Bool value, toggles italic comments.
        simple_syntax_colors = false, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
      },
    termguicolors = true, -- Bool 
    terminal_color = false, -- Bool 
    plugin_default = "auto", -- Sets how all plugins will be loaded
                         -- "auto": Uses lazy / packer enabled plugins to load highlights.
                         -- true: Enables all plugins highlights.
                         -- false: Disables all plugins.
    highlights = {
      astrodark = {
        modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
          hl.Normal.bg = c.black
        end,
      },
    },
  },
}
