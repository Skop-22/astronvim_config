return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- 1. Forzamos a AstroNvim a registrar ambos servidores
    servers = {
      "vue_ls",
      "vtsls",
    },
    -- 2. Configuramos los LSPs con el nuevo estándar
    config = {
      vtsls = {
        -- OBLIGATORIO: Le decimos a vtsls que también debe activarse al abrir archivos .vue
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                  languages = { "vue" },
                  configNamespace = "typescript",
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
        },
      },
    },
  },
}

