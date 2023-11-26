return {
  "AstroNvim/astrotheme",
  opts = {
    style = {
      transparent = true,           -- Bool value, toggles transparency.
      inactive = false,             -- Bool value, toggles inactive window color.
      float = false,                -- Bool value, toggles floating windows background colors.
      neotree = false,              -- Bool value, toggles neo-trees background color.
      border = true,                -- Bool value, toggles borders.
      title_invert = true,         -- Bool value, swaps text and background colors.
      italic_comments = true,       -- Bool value, toggles italic comments.
      simple_syntax_colors = false,  -- Bool value, simplifies the amounts of colors used for syntax highlighting.
    },
    termguicolors = true, -- Bool 
    terminal_color = true, -- Bool 
    palettes = {
      global = {             -- Globally accessible palettes, theme palettes take priority.
        my_color = "#999999"
      },    
    },
    highlights = {
      global = {             -- Add or modify hl groups globally, theme specific hl groups take priority.
        modify_hl_groups = function(hl, c)
          hl.PluginColor4 = {fg = c.my_grey, bg = c.block }
        end,
      },
    },
  },
}
