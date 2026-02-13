# Agent Notes (Neovim config repo)

This repository is a Neovim configuration written in Lua and managed with `lazy.nvim`.
Use this file as the default playbook for agentic changes (edits, refactors, new plugins).

## Repo layout

- `init.lua`: bootstraps `lazy.nvim`, then loads `lua/vim-options.lua`, `lua/keymaps.lua`, and `require("lazy").setup("plugins")`.
- `lua/vim-options.lua`: editor defaults (notably `expandtab` + 2-space indents).
- `lua/keymaps.lua`: global keymaps and some helper functions.
- `lua/plugins/*.lua`: Lazy plugin specs (each file returns a plugin spec or a list of specs).
- `lazy-lock.json`: generated plugin lockfile; do not hand-edit.
- `.luarc.json`: LuaLS settings (declares `vim` global; disables some diagnostics).

## Build / lint / test commands

There is no traditional “build” or automated test suite for this repo.
The closest equivalent is “can Neovim start with this config” and “does formatting/linting pass”.

### Smoke checks (headless)

```bash
nvim --headless -u ./init.lua "+qa"
nvim --headless -u ./init.lua "+checkhealth" "+qa"
```

### Plugin install/update (lazy.nvim)

```bash
nvim --headless -u ./init.lua "+Lazy! sync" "+qa"
nvim --headless -u ./init.lua "+Lazy! restore" "+qa"
nvim --headless -u ./init.lua "+Lazy! clean" "+qa"  # destructive: removes unused plugins
```

### Formatting

This config is set up to auto-format-on-save via `conform.nvim` (see `lua/plugins/format-lint.lua`).
For repo-local Lua formatting from the CLI, use `stylua`.

```bash
stylua init.lua lua
stylua --check init.lua lua
```

In Neovim, you can format the current buffer with:

```vim
:lua require("conform").format({ async = false, lsp_fallback = true })
```

### Linting

This repo does not check in Lua lint configuration (no `.luacheckrc` / `selene.toml`).
For Lua, rely on LuaLS diagnostics (configured via `.luarc.json` and `lua/plugins/lsp-config.lua`).

The editor config also wires `nvim-lint` for some filetypes (JS/TS: `eslint_d`, Python: `pylint`).

### Tests (especially single-test)

This repo itself has no tests.
For projects you open using this Neovim config, tests are commonly run via `neotest`.

Neovim keymaps from `lua/plugins/neotest.lua`: `\<leader>tn` nearest, `\<leader>tf` file, `\<leader>ta` suite, `\<leader>td` stop, `\<leader>to` output, `\<leader>ts` summary.

Underlying CLI examples for “single test” (use when debugging outside Neovim):

```bash
# Jest (match a single test by name)
npm test -- path/to/foo.test.ts -t "test name"

# Maven Surefire (single class or even single method)
mvn -Dtest=MyTest test
mvn -Dtest=MyTest#testMethod test
```

## Code style guide (Lua)

### Formatting / layout

- Indentation: 2 spaces (see `lua/vim-options.lua`), no tabs.
- Keep lines reasonably short; prefer readability over cleverness.
- If aligning large tables is important, use `-- stylua: ignore` on that block (example: `lua/plugins/flash.lua`).
- Keep “setup” blocks shallow: extract helpers into locals instead of deeply nested anonymous functions.

### Imports (`require`) and module shape

- Prefer explicit locals; put `require(...)` calls at the top of a module or the top of a `config = function()` block.
- For optional deps, guard with `pcall(require, ...)` and `vim.notify(...)` on failure.
- Avoid `require(...)` inside hot paths (autocmd callbacks, tight loops) unless cached.

### Naming conventions

- Files under `lua/plugins/`: use kebab-case (`format-lint.lua`, `lsp-config.lua`).
- Modules under `lua/`: match the filename in `require("...")` (hyphens are used in this repo).
- Locals: `snake_case` or short conventional names (`opts`, `bufnr`, `client`).
- Functions: `snake_case` for locals; if something must be global, namespace it (prefer `local` or module exports instead).

### Types and LuaLS annotations

- Use LuaLS annotations for non-obvious structures and plugin option tables:
  - `---@type ...` for opts tables
  - `---@param ...` / `---@return ...` for helpers
- `.luarc.json` already declares `vim` as a global and disables `undefined-global`/`missing-fields`; still annotate important shapes.

### Error handling and safety

- Use `pcall(require, ...)` for optional dependencies and degrade gracefully.
- Prefer `vim.notify(msg, level)` over `print()` for important warnings/errors.
- Don’t swallow errors silently in startup code; make failures discoverable.

### Keymaps

- Prefer `vim.keymap.set()`.
- Always provide a `desc` (many Telescope/LSP keymaps depend on this for discoverability).
- Make mappings buffer-local when they depend on LSP attachment or a specific buffer.

### Autocmds

- Always create a named augroup; avoid heavy work on `BufEnter`/`InsertLeave`.

## Code style guide (lazy.nvim plugin specs)

- Each `lua/plugins/*.lua` should `return` a plugin spec (table) or a list of specs.
- Prefer `opts = {}` for simple configs; use `config = function()` only when imperative setup is required.
- Use Lazy’s `keys = { ... }` when bindings are plugin-specific.
- When adding an LSP server:
  - Add it to `ensure_installed` in `lua/plugins/mason.lua`.
  - Add/adjust its configuration in `lua/plugins/lsp-config.lua`.

## Security / secrets

- Do not introduce secrets into the repo.
- `lua/keymaps.lua` contains mappings that read `~/source/token` and `~/source/key` and copy to clipboard; never commit those files, never log their contents, and avoid expanding this pattern.

## Cursor / Copilot instruction files

- No `.cursorrules`, `.cursor/rules/*`, or `.github/copilot-instructions.md` are present in this repo.
- If any are added later, treat them as higher-priority behavioral rules than this file.
