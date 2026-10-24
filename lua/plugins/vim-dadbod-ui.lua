return {
  'kristijanhusak/vim-dadbod-ui',

  dependencies = {
    {
      'tpope/vim-dadbod',
      lazy = true,
    },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql', 'sqlite' },
      lazy = true,
    },
  },

  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
    'DBQueryTable',
  },

  keys = {
    {
      '<leader>Du',
      '<cmd>DBUIToggle<CR>',
      desc = 'Toggle DBUI',
    },
  },

  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_navigation = 1
    vim.g.db_ui_auto_execute_table_helpers = 1

    vim.g.dbs = {
      {
        name = 'tenant_db_Ecomers',
        url = vim.env.DBUI_DB_TIENDA_URL
          or 'mysql://root@127.0.0.1:3306/tenant_db_Ecomers',
      },
    }
  end,

  config = function()
    vim.api.nvim_create_user_command('DBQueryTable', function(opts)
        local input = vim.trim(opts.args)

        -- Separar el nombre de la base de datos de la consulta SQL.
        local database, query = input:match('^(%S+)%s+(.+)$')

        if not database or not query then
            vim.notify(
                'Uso: DBQueryTable <base_de_datos> <consulta SQL>',
                vim.log.levels.ERROR
            )
            return
        end

        -- Validar el nombre de la base de datos.
        if not database:match('^[%w_$%-]+$') then
            vim.notify(
                'Nombre de base de datos inválido',
                vim.log.levels.ERROR
            )
            return
        end

        -- Configuración MySQL.
        local db_user = 'root'
        local db_password = 'root'
        local db_host = 'localhost'
        local db_port = '3306'

        -- Construir la URL de conexión.
        local connection_url = string.format(
            'mysql://%s:%s@%s:%s/%s',
            db_user,
            db_password,
            db_host,
            db_port,
            database
        )

        -- Ejecutar la consulta mediante vim-dadbod.
        vim.cmd('DB ' .. connection_url .. ' ' .. query)
    end, {
        nargs = '+',
        desc = 'Ejecutar SQL indicando la base de datos',
    })
  end,
}
