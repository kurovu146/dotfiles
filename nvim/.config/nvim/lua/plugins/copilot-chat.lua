return {
  "CopilotC-Nvim/CopilotChat.nvim",
  keys = {
    {
      "<leader>ac",
      function()
        require("CopilotChat").ask(
          [[
From the current staged git diff:
Generate ONE concise Conventional Commit message.
Max 146 characters.
Focus on WHAT and WHY.
No markdown, no quotes.
      ]],
          {
            context = "git:staged",
            callback = function()
              -- Lấy buffer hiện tại (copilot-chat)
              local buf = vim.api.nvim_get_current_buf()
              local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

              -- Tìm dòng cuối cùng không rỗng (commit message)
              for i = #lines, 1, -1 do
                local line = vim.trim(lines[i])
                if line ~= "" then
                  vim.fn.setreg("+", line)
                  vim.fn.setreg('"', line)
                  vim.notify("✅ Commit message copied: " .. line)
                  return
                end
              end

              vim.notify(
                "❌ No commit message found to copy",
                vim.log.levels.ERROR
              )
            end,
          }
        )
      end,
      desc = "AI: Generate commit message",
      mode = { "n", "x" },
    },
  },
}
