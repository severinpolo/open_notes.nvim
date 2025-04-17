---@class CustomModule
local M = {}

M.config_open_note = function(notes_dir, default_note, default_note_function)
  print(notes_dir)
  print(default_note)
  print(default_note_function)
  print(default_note_function ~= "")

  local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, opts)


  -- Generate the notes file path dynamically based on the current date
  if notes_dir == "" then
    notes_dir = "~/notes/"
  end
  if default_note_function ~= "" then
    default_note = default_note_function()
  elseif default_note == "" then
    default_note = os.date("%Y-%m-%d") .. ".md"
  end
  local notes_path = vim.fn.expand(notes_dir .. default_note)

  vim.api.nvim_buf_set_name(buf, default_note)

  -- Save the current working directory
  local original_dir = vim.fn.getcwd()

  -- Set the correct root directory
  local root_dir = vim.fn.expand(notes_dir)
  vim.cmd("lcd " .. root_dir)

  -- Optional: Set buffer options
  --vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })
  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })

  vim.cmd("e " .. notes_path) -- Open the file in the buffer
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  -- Restore the original working directory when the buffer is closed
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    callback = function()
      vim.cmd("lcd " .. original_dir)
    end,
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(win),
    callback = function()
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  })
end

return M
