local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node

local lua_snippets = {
  s(
    "opts",
    fmt(
      [[
    local opts = {{ noremap = true, silent = true }}
    local keymap = vim.keymap.set
    ]],
      {}
    )
  ),
  s(
    "key",
    fmt('keymap("n", "{}", {}, vim.tbl_extend("force", opts, {{ desc = "{}" }}))', {
      i(1, "key"), -- Left-hand side of the mapping
      i(2, "map"), -- Mapping command or function
      i(3, "desc"), -- Description
    })
  ),
}

return lua_snippets
