local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local logic = "// logic here"
local ts_snippets = {
  -- Arrow function
  s(
    "arrow",
    fmt("const {} = ({}) => {{\n\t{}\n}};", {
      i(1, "functionName"),
      i(2),
      i(3, logic),
    })
  ),
  s(
    "fun",
    fmt("function {}({}){{\n\t{}\n}}", {
      i(1, "functionName"),
      i(2),
      i(3, logic),
    })
  ),

  -- React.FC
  s(
    "rfc",
    fmt(
      "const {}: React.FC = () => {{\n\treturn (\n\t\t<div>\n\t\t\t{}\n\t\t</div>\n\t);\n}};\n\nexport default {};",
      {
        i(1, "ComponentName"),
        i(2, "content"),
        rep(1),
      }
    )
  ),

  -- useState Hook
  s(
    "us",
    fmt("const [{}, set{}] = useState({})", {
      i(1, "state"),
      f(function(args)
        local stateName = args[1][1] or ""
        return stateName:sub(1, 1):upper() .. stateName:sub(2)
      end, { 1 }),
      i(2, "initialValue"),
    })
  ),

  -- useEffect snippet
  s(
    "ue",
    fmt([[useEffect(() => {{{}}}, [{}]);]], {
      i(1, logic),             -- Effect logic
      i(2, "// dependencies"), -- Dependency array
    })
  ),
  -- Test file
  s(
    "desc",
    fmt(
      [[
		import {{ render, screen }} from "@testing-library/react";

		describe("{}", () => {{
			test("{}", () => {{
      render(<{} />);
      }});
		}});
	]],
      {
        i(1, "Component"),
        i(2, "it should"),
        i(3, "Component"),
      }
    )
  ),
  s(
    "test",
    fmt(
      [[test("{}", () => {{
          {}
}});]],
      { i(1, "it should"), i(2, logic) }
    )
  ),
  s("exp", fmt([[expect(screen.{}).toBeInTheDocument()]], { i(0) })),
  -- map snippet
  s("map", fmt([[{}.map(() => {});]], { i(1), i(0) })),
  s("cl", fmt("console.log({})", { i(1) })),
  s("tp", fmt("type {} = {{\n {} \n}}", { i(1, "typeName"), i(0, logic) })),
  s("dti", fmt("data-testid='{}'", { i(1, "testId") })),
  s("act", fmt("act(() => {{\n\t{}\n}});", { i(1, logic) })),
  s("cn", fmt('className="{}"', { i(0) })),
}

return ts_snippets
