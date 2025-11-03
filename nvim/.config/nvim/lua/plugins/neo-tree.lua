return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- show hidden files
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      renderers = {
        file = {
          { "icon", highlight = "NeoTreeFileIcon" }, -- 🌈 icon có màu
          { "name", use_git_status_colors = true },
          { "diagnostics" },
          { "git_status" },
        },
      },
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          highlight = "NeoTreeFileIcon", -- <== 🔥 dòng này đảm bảo icon có màu
        },
      },
    },
  },
}
