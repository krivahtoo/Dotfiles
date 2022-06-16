local ls = require 'luasnip'

-- local snippet = ls.s
-- local snippet_from_nodes = ls.sn

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
-- local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

local shared = require 'krivah.snippets'
local same = shared.same

ls.add_snippets('rust', {
  s(
    'main',
    fmt(
      [[
    fn main() {{
    }}
    ]],
      {}
    )
  ),

  s(
    'modtest',
    fmt(
      [[
      #[cfg(test)]
      mod test {{
          use super::*;
          {}
      }}
    ]],
      i(0)
    )
  ),

  s(
    'test',
    fmt(
      [[
      #[test]
      fn {}(){}{{
          {}
      }}
    ]],
      {
        i(1, 'testname'),
        c(2, {
          t '',
          t ' -> Result<()> ',
          -- fmt(" -> {}<()> ", { i(nil, "Result") }),
        }),
        i(0),
      }
    )
  ),

  s('eq', fmt('assert_eq!({}, {});{}', { i(1), i(2), i(0) })),

  s('enum', {
    c(1, {
      t 'enum ',
      t { '#[derive(Debug)]', 'enum ' },
    }),
    i(2, 'Name'),
    t { ' {', '  ' },
    i(0),
    t { '', '}' },
  }),

  s('struct', {
    t { '#[derive(Debug, PartialEq)]', 'struct ' },
    i(1, 'Name'),
    t { ' {', '    ' },
    i(0),
    t { '', '}' },
  }),

  s('pd', fmt([[println!("{}: {{:?}}", {});]], { same(1), i(1) })),
  -- _pd = {
  --   t [[println!("{:?}", ]],
  --   i(1),
  --   t [[);]],
  -- },
})
