# raijin

Configuración de Neovim dibangun dengan lazy.nvim..

## Instalación

Clonar el repositorio en `~/.config/nvim`:

```bash
git clone https://github.com/tu-usuario/raijin.git ~/.config/nvim
```

Iniciar Neovim. Lazy.nvim se instalará automáticamente en el primer lanzamiento.

## Estructura

```
nvim/
├── init.lua                 -- Punto de entrada
├── lua/raijin/
│   ├── lazy.lua             -- Bootstrap de lazy.nvim
│   ├── core/
│   │   ├── options.lua      -- Opciones del editor
│   │   ├── keymaps.lua      -- Atajos de teclado
│   │   └── init.lua         -- Carga del core
│   └── plugins/
│       ├── init.lua         -- Carga de plugins
│       ├── lsp/
│       │   ├── init.lua     -- Configuración LSP
│       │   ├── lspconfig.lua
│       │   └── mason.lua    -- Gestor de servidores LSP
│       └── *.lua            -- Plugins adicionales
```

## Características

- **Gestor de plugins**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP**: Configuración con `lspconfig` y `mason.nvim`
- **UI/UX**:
  - Tema: [tokyonight](https://github.com/folke/tokyonight.nvim)
  - Status line: [lualine](https://github.com/nvim-lualine/lualine.nvim)
  - Explorador de archivos: [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- **Navegación**: [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- **Syntaxis**: [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Git**: [gitsigns](https://github.com/lewis6991/gitsigns.nvim)

## Atajos de teclado

Tecla líder: `<Space>`

| Atajo | Acción |
|-------|--------|
| `jk` | Salir del modo insert |
| `<leader>nh` | Limpiar highlights de búsqueda |
| `<leader>sv` | Dividir verticalmente |
| `<leader>sh` | Dividir horizontalmente |
| `<leader>se` | Equalizar splits |
| `<leader>sx` | Cerrar split |
| `<leader>to` | Nueva pestaña |
| `<leader>tx` | Cerrar pestaña |
| `<leader>tn` | Siguiente pestaña |
| `<leader>tp` | Pestaña anterior |
| `<leader>tf` | Abrir buffer en nueva pestaña |
| `gR` | Referencias LSP (Telescope) |
| `gD` | Declaración LSP |
| `gd` | Definiciones LSP (Telescope) |
| `gi` | Implementaciones LSP |
| `gt` | Definiciones de tipos LSP |
| `<leader>ca` | Acciones de código |
| `<leader>rn` | Renombrar inteligente |
| `<leader>D` | Diagnósticos del buffer (Telescope) |
| `<leader>d` | Diagnósticos de línea |
| `[d` | Diagnostic anterior |
| `]d` | Siguiente diagnostic |
| `K` | Hover documentation |
| `<leader>rs` | Reiniciar LSP |
| `<leader>mp` | Formatear archivo/rango |
| `<leader>l` | Ejecutar linter |

## Formateadores y Linters

| Lenguaje | Formateador | Linter |
|----------|-------------|--------|
| Lua | stylua | — |
| Python | isort, black | pylint |
| JS/TS/Svelte | prettier | eslint_d |
| JSON/YAML/MD | prettier | — |

## Requisitos

- Neovim >= 0.9.0
- Git
- npm (para lenguajes JS/TS)
- Python con black e isort

## Configuración

Las opciones del editor se encuentran en `lua/raijin/core/options.lua`. Los atajos están en `lua/raijin/core/keymaps.lua`.