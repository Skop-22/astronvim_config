local function replace_comment_block()
  -- Obtener la posición de inicio y fin de la selección visual
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Obtener el contenido de las líneas seleccionadas
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- Extraer el texto seleccionado
  if #lines == 1 then
    -- Si la selección está en una sola línea
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Si la selección está en múltiples líneas
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  -- Concatenar el texto seleccionado
  local selected_text = table.concat(lines, "\n")

  -- Imprimir el texto seleccionado
  print("Texto seleccionado:\n" .. selected_text,lines)

  -- Retornar el texto seleccionado (opcional)
  return selected_text

  -- Obtener el contenido del buffer actual
  -- local bufnr = vim.api.nvim_get_current_buf()
  -- local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Buscar el bloque de comentarios
  -- local start_idx, end_idx = nil, nil
  -- for i, line in ipairs(lines) do
  --   if line:match("^%s*/%*%*") then
  --     start_idx = i
  --   elseif line:match("^%s*%*/") and start_idx then
  --     end_idx = i
  --     break
  --   end
  -- end
  --
  -- -- Si encontramos el bloque de comentarios
  -- if start_idx and end_idx then
  --   -- Crear el texto nuevo
  --   local new_lines = {
  --     "/**",
  --     " * la solicitud tiene este contenido",
  --     " * json =[",
  --     " *  id: int,",
  --     " *  nombre: string,",
  --     " *  descripcion: string,",
  --     " *  otro: [",
  --     " *      id: int,",
  --     " *      nombre: string",
  --     " *  ]",
  --     " * ]",
  --     " * @return response 'ok'",
  --     " */",
  --     "$request->validate({",
  --     "    -- información dentro de los parámetros de json=",
  --     "});"
  --   }
  --
  --   -- Preguntar al usuario si desea reemplazar el texto
  --   local response = vim.fn.input("¿Deseas reemplazar el bloque de comentarios? (s/n): ")
  --
  --   -- Si el usuario responde "s", reemplazar el bloque de comentarios
  --   if response:lower() == "s" then
  --     vim.api.nvim_buf_set_lines(bufnr, start_idx-1, end_idx, false, new_lines)
  --     print("Bloque de comentarios reemplazado.")
  --   else
  --     print("Reemplazo cancelado.")
  --   end
  -- else
  --   print("No se encontró un bloque de comentarios.")
  -- end
end

local function process_comments()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    -- Comprobar si hay request y response
    local request_match = line:match("@param %$(request)")
    local response_match = line:match("@return response")

    if request_match then
      -- Extraer la estructura JSON
      local json_start = lines[i + 1]:match("json =%s*%[([^%]]+)%]")
      if json_start then
        -- Almacenar la estructura JSON
        local json_structure = json_start:match("%b[]") -- Extraer contenido entre []

        -- Encontrar el final del bloque de comentarios
        local end_comment = i + 1
        while not lines[end_comment]:match("%*/") do
          end_comment = end_comment + 1
        end

        -- Modificar el comentario
        local new_lines = {
          "$request->validate({",
          json_structure .. ",",
          "});"
        }

        -- Insertar las nuevas líneas al final del bloque de comentarios
        vim.api.nvim_buf_set_lines(bufnr, end_comment, end_comment, false, new_lines)

        -- Opcional: Eliminar o modificar la línea anterior de request
        -- lines[i] = line:gsub("@param %$(request)", "")
      end
    elseif response_match then
      -- Lógica para response puede ir aquí
      -- Por ejemplo, eliminar la línea @param si se encuentra
      -- lines[i - 1] = nil -- Eliminar la línea anterior que contiene $request
    end
  end

  -- Establecer las líneas modificadas en el buffer
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

-- Crear un comando de usuario para llamar a la función
vim.api.nvim_create_user_command('ProcessComments', process_comments, {})
-- Crear un comando que acepte rangos
vim.api.nvim_create_user_command('SelectRemplaseText', function(opts)
  replace_comment_block()
end, { range = true })

-- Asignar la combinación de teclas en modo visual
vim.api.nvim_set_keymap('v', '<leader>rc', ':SelectRemplaseText<CR>', { noremap = true, silent = true })
