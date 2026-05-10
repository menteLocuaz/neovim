# Neovim Config — raijin

## Structure

- `init.lua` — entry point: bootstraps lazy.nvim, loads `raijin.core` and `raijin.lazy`
- `lua/raijin/lazy.lua` — plugin bootstrap & `lazy.setup()` call
- `lua/raijin/core/` — options and keymaps
- `lua/raijin/plugins/` — plugin configs (lazy.nvim spec format)
- `lua/raijin/plugins/lsp/` — LSP-related plugins

## Keymaps

Leader key: `<Space>`

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<leader>nh` | Clear search highlights |
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close split |
| `<leader>to/tx/tn/tp/tf` | Tab management |
| `gR` | LSP references (Telescope) |
| `gD` | LSP declaration |
| `gd` | LSP definitions (Telescope) |
| `gi` | LSP implementations |
| `gt` | LSP type definitions |
| `<leader>ca` | Code actions |
| `<leader>rn` | Smart rename |
| `<leader>D` | Buffer diagnostics (Telescope) |
| `<leader>d` | Line diagnostics |
| `[d` / `]d` | Prev/next diagnostic |
| `K` | Hover docs |
| `<leader>rs` | Restart LSP |
| `<leader>mp` | Format file/range |
| `<leader>l` | Trigger lint |

## Tools & Formatters

| File type | Formatter | Linter |
|-----------|-----------|--------|
| Lua | stylua | — |
| Python | isort, black | pylint |
| JS/TS/Svelte | prettier | eslint_d |
| JSON/YAML/MD | prettier | — |

Formatting and linting run on save.

## LSP Servers (mason.nvim)

Auto-installed: `ts_ls`, `html`, `cssls`, `tailwindcss`, `svelte`, `lua_ls`, `graphql`, `emmet_ls`, `prismals`, `pyright`

Lua LSP diagnostic globals include `vim`.

## Editor Settings

- `tabstop=2`, `shiftwidth=2`, `expandtab`
- Relative line numbers
- `termguicolors`, `background=dark`
- `clipboard=unnamedplus`
- `splitright`, `splitbelow`

## Plugin Manager

[lazy.nvim](https://github.com/folke/lazy.nvim) auto-installs itself on first Neovim launch. `lazy-lock.json` pins versions.
