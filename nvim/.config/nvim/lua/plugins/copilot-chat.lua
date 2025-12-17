return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>ac",
      function()
        -- Lấy diff thật từ git diff --cached
        local diff = vim.fn.system({
          "git",
          "diff",
          "--cached",
          "--no-color",
          "--unified=3",
        })

        if diff == nil or diff == "" then
          vim.notify(
            "❌ No staged changes (git diff --cached is empty)",
            vim.log.levels.ERROR
          )
          return
        end

        require("CopilotChat").ask([[
From the following git diff, generate ONE concise Conventional Commit message.

Rules:
- Max 300 characters
- Focus on WHAT changed and WHY
- Summarize the dominant intent
- Do NOT guess
- No markdown, no quotes

Git diff:
]] .. diff, {
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
        })
      end,
      desc = "AI: Generate commit message (git diff --cached)",
      mode = { "n", "x" },
    },
  },
}
