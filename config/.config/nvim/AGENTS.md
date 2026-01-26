# AGENTS.md - Neovim Configuration Guide for AI Agents

This document provides essential information for AI coding agents working in this Neovim configuration repository.

## Project Overview

**Type**: Neovim configuration (Lua-based)  
**Plugin Manager**: Neovim's built-in `vim.pack` (not lazy.nvim or packer)  
**Primary Language**: Lua  
**Working Directory**: `/Users/diego/dev/dotfiles/config/.config/nvim`

## Commands

### Validation & Testing

```bash
# Validate entire config (loads Neovim in headless mode)
just check

# Format all Lua files with stylua
just fmt

# Check formatting without modifying files
just fmt-check

# Run both validation and format check
just validate
```

### Health Checks

```vim
" Inside Neovim - check overall health
:checkhealth

" Check specific plugin or LSP health
:checkhealth vim.lsp
:checkhealth conform
```

### Plugin Management

```vim
" Update all plugins
:lua vim.pack.update()

" Delete a plugin (will prompt for name)
<leader>pd
```

## Code Structure

```
.
├── init.lua              # Entry point - sets leader keys, loads config & plugins
├── lua/
│   ├── config/           # Core configuration modules
│   │   ├── init.lua      # Loads all config modules
│   │   ├── options.lua   # Vim options (indentation, search, UI, etc.)
│   │   ├── keymaps.lua   # Key mappings
│   │   ├── lsp.lua       # LSP setup and keybindings
│   │   ├── autocmds.lua  # Autocommands
│   │   └── diagnostics.lua
│   └── plugins/          # Plugin configurations
│       ├── init.lua      # Loads all plugin modules
│       ├── blink.lua     # Completion plugin
│       ├── treesitter.lua
│       ├── conform.lua   # Formatter configuration
│       ├── fzf.lua       # Fuzzy finder
│       ├── oil.lua       # File explorer
│       └── ...
├── lsp/                  # LSP server-specific configurations
│   ├── vtsls.lua         # TypeScript/JavaScript
│   ├── lua_ls.lua        # Lua
│   ├── gopls.lua         # Go
│   └── ...
├── justfile              # Task runner (commands above)
└── stylua.toml           # Formatter configuration
```

## Code Style Guidelines

### Formatting (stylua.toml)

- **Indentation**: TABS (equivalent to 2 spaces)
- **Column width**: 120 characters max
- **Line endings**: Unix (LF)
- **Quote style**: Double quotes preferred (AutoPreferDouble)
- **Formatter**: stylua (run `just fmt` before committing)

### Lua Conventions

#### Imports/Requires

```lua
-- At the top of plugin files
vim.pack.add({ "https://github.com/username/plugin-name" })

-- Then require and setup
require("plugin-name").setup({ ... })

-- For local modules
require("config.module-name")
require("plugins.plugin-name")
```

#### Variable Naming

```lua
-- Snake_case for local variables
local my_variable = "value"
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Use descriptive names
local default_keymaps = { ... }  -- Good
local km = { ... }               -- Avoid abbreviations unless obvious
```

#### Functions

```lua
-- Use local functions when possible
local function my_function()
	-- Tab-indented function body
end

-- Anonymous functions for callbacks
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
```

#### Tables

```lua
-- Prefer vertical layout for readability
local config = {
	option1 = "value1",
	option2 = "value2",
	nested = {
		key = "value",
	},
}

-- Arrays can be more compact
local filetypes = { "lua", "javascript", "typescript" }
```

### LSP Configuration Pattern

LSP configs in `lsp/` directory must return a `vim.lsp.Config` table:

```lua
---@type vim.lsp.Config
return {
	cmd = { "language-server-binary" },
	filetypes = { "filetype1", "filetype2" },
	root_markers = { ".git", "package.json" },
	settings = {
		ServerName = {
			-- Server-specific settings
		},
	},
	-- Optional callbacks
	on_attach = function(client, bufnr)
		-- Buffer-specific setup
	end,
}
```

### Autocommand Pattern

```lua
vim.api.nvim_create_autocmd("EventName", {
	group = vim.api.nvim_create_augroup("unique_group_name", { clear = true }),
	pattern = { "*.pattern" },
	callback = function(event)
		-- Handler code
		-- Access buffer: event.buf
	end,
})
```

### Keymap Pattern

```lua
-- Alias for brevity
local map = vim.keymap.set

-- Always provide desc for discoverability
map("n", "<leader>key", ":Command<CR>", { desc = "Description of action" })

-- Multi-mode mappings
map({ "n", "v" }, "<leader>key", function()
	-- Action
end, { desc = "Description" })

-- With additional options
map("n", "key", "action", { silent = true, noremap = true, desc = "Description" })
```

### Error Handling

```lua
-- Use pcall for operations that might fail
local ok, result = pcall(require, "optional-module")
if ok then
	result.setup({ ... })
end

-- For UI operations
local success, err = pcall(some_function)
if not success and err then
	vim.notify(err, vim.log.levels.ERROR)
end
```

## Type Annotations

Use LuaLS annotations for better IDE support:

```lua
---@type vim.lsp.Config
---@param bufnr number
---@return boolean
```

## Comments

- Use clear, descriptive comments for non-obvious code
- Comments may appear in Portuguese or English
- Prefer self-documenting code over comments when possible

## Testing Changes

1. **Before committing**: Run `just validate` to ensure config validity and formatting
2. **After changes**: Restart Neovim or reload config with `:source %`
3. **Check for errors**: `:messages` to see any error messages
4. **LSP issues**: `:LspInfo` to check LSP client status

## Common Patterns

### Adding a New Plugin

1. Create file in `lua/plugins/plugin-name.lua`
2. Add `vim.pack.add()` call with plugin URL
3. Configure the plugin with `require("plugin-name").setup()`
4. Add require to `lua/plugins/init.lua`
5. Run `:lua vim.pack.update()` to install

### Adding LSP Server

1. Create config file in `lsp/server-name.lua` following the LSP pattern above
2. Add server name to `vim.lsp.enable()` list in `lua/config/lsp.lua`
3. Ensure LSP binary is installed on system

### Modifying Keymaps

- Edit `lua/config/keymaps.lua`
- Use consistent leader key patterns (already set to `<space>`)
- LSP keymaps go in `lua/config/lsp.lua` (applied on LspAttach)

## Important Notes

- **Never use spaces for indentation** - this codebase uses TABS
- **Always run `just fmt`** before committing changes
- **Test config validity** with `just check` after significant changes
- **Preserve existing patterns** - match the style of surrounding code
- **Type safety**: Use `---@type` annotations for complex tables
- **Plugin updates**: Use built-in `:lua vim.pack.update()` not external package managers
