local function show_log_with_date(date)
  local log_file = "/var/log/apache2/access_api.log"

  -- Ejecutar el comando grep para filtrar por la fecha
  local command = string.format("grep '%s' %s | tail -n 1", date, log_file)
  local handle = io.popen(command)
  local line = handle:read("*a")
  handle:close()

  -- Mostrar el registro como una notificación
  if line == "" then
    line = "No se encontraron registros con la fecha especificada."..date
  end
  vim.notify(line, "info", { title = "Registro de Apache con Fecha" })
end

-- Crea un comando que permite ingresar una fecha específica
vim.api.nvim_create_user_command("LogApacheDate", function(opts)
  show_log_with_date(opts.args)
end, { nargs = 1 })
