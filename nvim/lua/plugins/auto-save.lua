-- Auto-save on leaving insert mode / switching away — NOT on every keystroke:
-- Metro's Fast Refresh pushes each save to the phone, so keystroke-level saves
-- would ship half-typed code to the running app.
return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave" },
      cancel_deferred_save = { "InsertEnter" },
    },
  },
}
