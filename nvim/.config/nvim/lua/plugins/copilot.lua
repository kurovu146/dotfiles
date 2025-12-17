return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true, -- Bật inline ghost text
        auto_trigger = true,
        keymap = {
          accept = "<M-l>", -- Alt+l để accept
        },
      },
      panel = { enabled = false },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      },
    },
  },
  -- Tắt copilot-cmp để tránh conflict
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
  },
}
