return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local c = require("vscode.colors")

      require("vscode").setup({
        -- ⚙️ Tùy chọn chính
        transparent = true, -- 🔥 Bật nền trong suốt
        italic_comments = true,
        disable_nvimtree_bg = true, -- giúp NvimTree cũng trong suốt

        -- 🎨 Nếu muốn tuỳ chỉnh thêm màu:
        color_overrides = {
          vscLineNumber = "#666666",
        },
        group_overrides = {
          -- Xóa background của các vùng hay bị tối màu
          Normal = { bg = "NONE", fg = c.vscFront },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          StatusLine = { bg = "NONE" },
          VertSplit = { bg = "NONE" },
          NvimTreeNormal = { bg = "NONE" },
          CursorLine = { bg = "NONE" },
        },
      })

      -- 🌙 Áp dụng theme
      require("vscode").load("dark")

      -- 🧼 Bảo đảm mọi vùng khác cũng trong suốt tuyệt đối
      local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "SignColumn",
        "LineNr",
        "CursorLineNr",
        "EndOfBuffer",
        "StatusLine",
        "StatusLineNC",
        "VertSplit",
        "TabLine",
        "TabLineFill",
        "TabLineSel",
      }
      for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
    end,
  },
}
