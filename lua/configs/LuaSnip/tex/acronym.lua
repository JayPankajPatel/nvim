local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
-- Include this `in_mathzone` function at the start of a snippets file...
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
local function is_in_align()
  return vim.fn["vimtex#syntax#in"] "texMathZoneEnv\\%(align\\|aligned\\|alignat\\|alignat\\*\\)" == 1
end
-- Then pass the table `{condition = in_mathzone}` to any snippet you want to
-- expand only in math contexts
--
return {
  s({ trig = "SJSU", snippetType = "autosnippet" }, {
    t "San Jose State University",
  })
}
