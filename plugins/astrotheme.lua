return {
  "AstroNvim/astrotheme",
  opts = {
    termguicolors = true, -- Bool 
    terminal_color = true, -- Bool 
    highlights = {
      astrodark = {
        modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
          hl.Normal.bg = c.black
        end,
      },
    },
  },
}
