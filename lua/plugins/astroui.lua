--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- ============================================================
      -- ICONOS
      -- ============================================================
      icons = {
        VimIcon = "",
        ScrollText = "",
        GitBranch = "",
        GitAdd = "",
        GitChange = "",
        GitDelete = "",
      },

      -- ============================================================
      -- STATUSLINE
      -- ============================================================
      status = {
        separators = {
          left = { "", "" },
          right = { " ", "" },
          tab = { "", "" },
        },

        colors = function(hl)
          local get_hlgroup = require("astroui").get_hlgroup

          local comment_fg = get_hlgroup("Comment").fg

          hl.git_branch_fg = comment_fg
          hl.git_added = comment_fg
          hl.git_changed = comment_fg
          hl.git_removed = comment_fg

          hl.blank_bg = get_hlgroup("Folded").fg
          hl.file_info_bg = get_hlgroup("Visual").bg
          hl.nav_icon_bg = get_hlgroup("String").fg
          hl.nav_fg = hl.nav_icon_bg
          hl.folder_icon_bg = get_hlgroup("Error").fg

          return hl
        end,

        attributes = {
          mode = {
            bold = true,
          },
        },

        icon_highlights = {
          file_icon = {
            statusline = false,
          },
        },
      },
    },
  },

  {
    "rebelot/heirline.nvim",

    opts = function(_, opts)
      local status = require("astroui.status")

      opts.statusline = {
        hl = {
          fg = "fg",
          bg = "bg",
        },

        status.component.mode({
          mode_text = {
            icon = {
              kind = "VimIcon",
              padding = {
                right = 1,
                left = 1,
              },
            },
          },

          surround = {
            separator = "left",

            color = function()
              return {
                main = status.hl.mode_bg(),
                right = "blank_bg",
              }
            end,
          },
        }),

        status.component.builder({
          {
            provider = "",
          },

          surround = {
            separator = "left",
            color = {
              main = "blank_bg",
              right = "file_info_bg",
            },
          },
        }),

        status.component.file_info({
          filename = {
            fallback = "Empty",
          },

          filetype = false,
          file_read_only = false,

          padding = {
            right = 1,
          },

          surround = {
            separator = "left",
            condition = false,
          },
        }),

        -- ==========================================================
        -- LARAVEL / PHP
        -- ==========================================================
        status.component.builder({

          -- --------------------------------------------------------
          -- LARAVEL
          -- --------------------------------------------------------
          {
            provider = function()
              if not _G.Laravel or not _G.Laravel.app then
                return ""
              end

              local ok, version = pcall(function()
                return Laravel.app("status"):get("laravel")
              end)

              if ok and version and version ~= false and tostring(version) ~= "" then
                return "  󰫐 " .. tostring(version)
              end

              return ""
            end,

            hl = {
              fg = "#F55247",
            },
          },

          -- --------------------------------------------------------
          -- PHP
          -- --------------------------------------------------------
          {
            provider = function()
              if not _G.Laravel or not _G.Laravel.app then
                return ""
              end

              local ok, version = pcall(function()
                return Laravel.app("status"):get("php")
              end)

              if ok and version and version ~= false and tostring(version) ~= "" then
                return "   " .. tostring(version) .. " "
              end

              return ""
            end,

            hl = {
              fg = "#AEB2D5",
            },
          },
        }),

        -- ==========================================================
        -- GIT BRANCH
        -- ==========================================================
        status.component.git_branch({
          git_branch = {
            padding = {
              left = 1,
            },
          },

          surround = {
            separator = "none",
          },
        }),

        -- ==========================================================
        -- GIT DIFF
        -- ==========================================================
        status.component.git_diff({
          padding = {
            left = 1,
          },

          surround = {
            separator = "none",
          },
        }),

        -- ==========================================================
        -- ESPACIO CENTRAL
        -- ==========================================================
        status.component.fill(),

        -- ==========================================================
        -- LSP
        -- ==========================================================
        status.component.lsp({
          lsp_client_names = false,

          surround = {
            separator = "none",
            color = "bg",
          },
        }),

        -- ==========================================================
        -- ESPACIO
        -- ==========================================================
        status.component.fill(),

        -- ==========================================================
        -- ESPACIO ANTES DE DIAGNÓSTICOS
        -- ==========================================================
        status.component.builder({
          {
            provider = "  ",
          },

          surround = {
            separator = "none",
            color = "bg",
          },
        }),

        -- ==========================================================
        -- DIAGNÓSTICOS
        -- ==========================================================
        status.component.diagnostics({
          surround = {
            separator = "right",
          },
        }),

        -- ==========================================================
        -- LSP
        -- ==========================================================
        status.component.lsp({
          lsp_progress = false,

          surround = {
            separator = "right",
          },
        }),

        -- ==========================================================
        -- DIRECTORIO ACTUAL
        -- ==========================================================
        {
          status.component.builder({
            {
              provider = require("astroui").get_icon("FolderClosed"),
            },

            padding = {
              right = 1,
            },

            hl = {
              fg = "bg",
            },

            surround = {
              separator = "right",
              color = "folder_icon_bg",
            },
          }),

          status.component.file_info({
            filename = {
              fname = function(nr)
                return vim.fn.getcwd(nr)
              end,

              padding = {
                left = 1,
              },
            },

            filetype = false,
            file_icon = false,
            file_modified = false,
            file_read_only = false,

            surround = {
              separator = "none",
              color = "file_info_bg",
              condition = false,
            },
          }),
        },

        {
          status.component.builder({
            {
              provider = require("astroui").get_icon("ScrollText"),
            },

            padding = {
              right = 1,
            },

            hl = {
              fg = "bg",
            },

            surround = {
              separator = "right",
              color = {
                main = "nav_icon_bg",
                left = "file_info_bg",
              },
            },
          }),

          status.component.nav({
            percentage = {
              padding = {
                right = 1,
              },
            },

            ruler = false,
            scrollbar = false,

            surround = {
              separator = "none",
              color = "file_info_bg",
            },
          }),
        },
      }
    end,
  },
}
