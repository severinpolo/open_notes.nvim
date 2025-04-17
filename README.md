# Open Notes as Float

_A simple plugin that opens my personal notes_

# Installation via Lazy 
```lua
{
  "severinpolo/open-notes.nvim", -- Change this to your actual repo if publishing
  lazy = true,
  cmd = "OpenNotes", -- Lazy load the plugin when `:OpenNotes` is run
  keys = {
    { '<leader>on', '<cmd>OpenNotes<cr>' },
  },
  opts = {
    notes_dir = "~/my_notes/",
    default_note = "my_note.md", -- defaults to test
    daily_note_function = function()
      return "daily_notes/daily_note_1.md"
    end
  }
}
```
