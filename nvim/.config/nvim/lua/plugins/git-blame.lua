-- plugins/git-blame.lua
return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    current_line_blame = false, -- mặc định tắt (chúng ta sẽ toggle)
    current_line_blame_opts = {
      virt_text = true, -- hiện text ở cuối dòng (EOL)
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 500, -- ms trước khi hiển thị
      ignore_whitespace = false,
    },
    -- tùy chọn khác bạn có thể muốn bật
    signcolumn = true,
    numhl = false,
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = function(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- phím tắt hữu dụng
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, { desc = "Git: Blame line (floating)" })
      map(
        "n",
        "<leader>gB",
        gs.toggle_current_line_blame,
        { desc = "Git: Toggle current line blame (virt text)" }
      )
      map("n", "<leader>gp", gs.preview_hunk, { desc = "Git: Preview hunk" })
      map("n", "<leader>gd", gs.diffthis, { desc = "Git: Diff this file" })
    end,
  },
}
