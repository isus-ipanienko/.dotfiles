local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

ls.add_snippets("all", {
    s("ternary", {
        i(1, "cond", t " ? "), i(2, "then"), t(" : "), i(3, "else")
    })
})

ls.add_snippets("cpp", {
    s("class",
        fmt(
            [[
            class {}
            {{
            public:
                {}() = default;
                {}({}&&) = default;
                {}(const {}&) = default;
                {} &operator=({}&&) = default;
                {} &operator=(const {}&) = default;
                ~{}() = default;
            private:
                {}
            }};
            ]],
            {
                i(1),
                rep(1),
                rep(1), rep(1),
                rep(1), rep(1),
                rep(1), rep(1),
                rep(1), rep(1),
                rep(1),
                i(0),
            }
        )
    ),
})

ls.add_snippets("rust", {

    s("derive",
        fmt(
            [[
            #[derive({})]
            ]],
            {
                i(0, "Debug")
            }
        )
    ),

    s("print", { t { "println!(\"" }, i(1), t { " {" }, i(0), t { ":?}\");" } }),

    s("for",
        {
            t { "for " }, i(1), t { " in " }, i(2), t { " {", "" },
            i(0),
            t { "}", "" },
        }),

    s("struct",
        {
            t { "#[derive(Debug)]", "" },
            t { "struct " }, i(1), t { " {", "" },
            i(0),
            t { "}", "" },
        }),

    s("test",
        {
            t { "#[test]", "" },
            t { "fn " }, i(1), t { "() {", "" },
            t { "	assert" }, i(0), t { "", "" },
            t { "}" },
        }),

    s("testcfg",
        {
            t { "#[cfg(test)]", "" },
            t { "mod " }, i(1), t { " {", "" },
            t { "	#[test]", "" },
            t { "	fn " }, i(2), t { "() {", "" },
            t { "		assert" }, i(0), t { "", "" },
            t { "	}", "" },
            t { "}" },
        }),

    s("if",
        {
            t { "if " }, i(1), t { " {", "" },
            i(0),
            t { "}" },
        }),
})
