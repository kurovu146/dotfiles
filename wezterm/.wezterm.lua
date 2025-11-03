-- ~/.wezterm.lua
-- Cross-platform WezTerm config: macOS + Windows (works on Linux too)
local wezterm = require("wezterm")

-- Use config_builder when available (recommended)
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Detect platform
local target = wezterm.target_triple or ""
local is_windows = target:find("windows") ~= nil
local is_macos = target:find("darwin") ~= nil
local is_linux = not (is_windows or is_macos)

-- Define a "mod" key that's natural per-OS:
-- macOS -> "CMD", Windows -> "SUPER" (Windows key), Linux -> "SUPER"
local MOD = is_macos and "CMD" or "SUPER"

-- Font fallback list (choose fonts commonly available on each platform)
local font_fallback = {
	"Iosevka Nerd Font", -- prefer a nerd font if installed
	is_macos and "SF Mono" or nil,
	is_windows and "Consolas" or nil,
	"Fira Code",
	"Noto Color Emoji",
}

-- Remove nils
local function compact(tbl)
	local out = {}
	for _, v in ipairs(tbl) do
		if v then
			table.insert(out, v)
		end
	end
	return out
end

config.color_scheme = "Tokyonight" -- đổi theo ý bạn
config.font = wezterm.font_with_fallback(compact(font_fallback))
config.font_size = 14.0
config.initial_cols = 120
config.initial_rows = 30

-- Window look & feel
config.window_decorations = "RESIZE" -- hoặc "RESIZE|TITLE" nếu muốn titlebar
config.window_background_opacity = 0.90
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.adjust_window_size_when_changing_font_size = false
config.scrollback_lines = 5000

-- Default shell per platform
if is_macos or is_linux then
	config.default_prog = { "/bin/zsh", "-l" } -- hoặc {"/usr/bin/fish", "-l"}
else
	-- Windows: prefer pwsh if installed, fallback to cmd
	config.default_prog = { "pwsh.exe", "-NoLogo" }
	-- Alternative: { "cmd.exe" } or { "C:\\Windows\\System32\\wsl.exe" } to launch WSL
end

-- Keybindings (cross-platform sensible defaults)
local keys = {
	-- New tab / close tab
	{ key = "t", mods = MOD, action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "w", mods = MOD, action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },

	-- Splits
	{ key = "d", mods = MOD, action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{
		key = "D",
		mods = MOD .. "|SHIFT",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},

	-- Pane navigation (vim-style hjkl)
	{ key = "h", mods = MOD, action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = MOD, action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = MOD, action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = MOD, action = wezterm.action({ ActivatePaneDirection = "Right" }) },

	-- Resize panes (hold MOD+ALT to resize)
	{ key = "h", mods = MOD .. "|ALT", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "l", mods = MOD .. "|ALT", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "k", mods = MOD .. "|ALT", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "j", mods = MOD .. "|ALT", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },

	-- Copy/Paste behavior (use native CMD on macOS, SUPER on Windows)
	{ key = "c", mods = (is_macos and "CMD" or "CTRL|SHIFT"), action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = (is_macos and "CMD" or "CTRL|SHIFT"), action = wezterm.action.PasteFrom("Clipboard") },

	-- Quick select (mouse-less selection)
	{ key = "f", mods = MOD, action = wezterm.action.ActivateKeyTable({ name = "fzf-like-select", one_shot = true }) },

	-- Zoom / font size
	{ key = "=", mods = MOD, action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = MOD, action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = MOD, action = wezterm.action.ResetFontSize },

	-- Toggle full screen
	{ key = "Enter", mods = MOD .. "|SHIFT", action = wezterm.action.ToggleFullScreen },

	-- Close pane
	{ key = "x", mods = MOD .. "|SHIFT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
}

-- Add platform-specific extra keys (example: on Windows use WIN+... or map copy/paste differently)
if is_windows then
	-- Many Windows users expect Ctrl+Shift+C/V for copy/paste; already set above.
	-- Add quick launcher to open new WSL shell if available:
	table.insert(keys, {
		key = "w",
		mods = "CTRL|ALT",
		action = wezterm.action({ SpawnCommandInNewWindow = { args = { "wsl.exe", "~" } } }),
	})
end

config.keys = keys

-- Status and pane decorations (simple example)
config.enable_tab_bar = true
config.tab_bar_at_bottom = false

-- ⚡ Toàn màn hình khi khởi động
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- Return the final config
return config
