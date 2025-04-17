-- main module file
local module = require("open_notes.module")

---@class Config
---@field notes_dir string Your config option
---@field default_note string Your config option
---@field default_note_function function Your config option
local config = {
  notes_dir = "",
  default_note = "",
  default_note_function = ""
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end
print(config)

M.open_note = function()
  return module.config_open_note(M.config.notes_dir, M.config.default_note, M.config.default_note_function)
end

return M
