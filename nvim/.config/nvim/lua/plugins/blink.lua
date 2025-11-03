return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next" },
      ["<S-Tab>"] = { "select_prev" },
      ["<C-y>"] = { "select_and_accept" },
    },
  },
}
