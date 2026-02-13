local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local logic = "// logic here"
local md_snippets = {
	s(
		"ts",
		fmt("```ts\n{}\n```", {
			i(0, logic),
		})
	),

	s(
		"js",
		fmt("```js\n{}\n```", {
			i(0, logic),
		})
	),
	s(
		"tsx",
		fmt("```tsx\n{}\n```", {
			i(0, logic),
		})
	),
	s(
		"bash",
		fmt("```bash\n{}\n```", {
			i(0, logic),
		})
	),
}

return md_snippets
