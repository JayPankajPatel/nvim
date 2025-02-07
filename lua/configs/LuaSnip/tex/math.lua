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
  -- Examples of Greek letter snippets, autotriggered for efficiency
  s({ trig = "ff", dscr = "Expands 'ff' into '\\frac{}{}'" }, fmta("\\frac{<>}{<>}", { i(1), i(2) })),
  s(
    { trig = "beg", dscr = "Expands into to begin/end enviorment" },
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),
  s({ trig = ";a", snippetType = "autosnippet" }, {
    t "\\alpha",
  }),
  s({ trig = "ne", snippetType = "autosnippet" }, {
    t "\\neq",
  }, { condition = in_mathzone }),
  s({ trig = "sub", snippetType = "autosnippet" }, {
    t "\\subset",
  }, { condition = in_mathzone }),
  s({ trig = ";b", snippetType = "autosnippet" }, {
    t "\\beta",
  }),
  s({ trig = ";s", snippetType = "autosnippet" }, {
    t "\\sigma",
  }),
  s({ trig = ";r", snippetType = "autosnippet" }, {
    t "\\rho",
  }),
  s({ trig = ";g", snippetType = "autosnippet" }, {
    t "\\gamma",
  }),
  s({ trig = "tan", snippetType = "autosnippet" }, {
    t "\\tan",
  }, { condition = in_mathzone }),
  s({ trig = "sin", snippetType = "autosnippet" }, {
    t "\\sin",
  }, { condition = in_mathzone }),
  s({ trig = "cos", snippetType = "autosnippet" }, {
    t "\\cos",
  }, { condition = in_mathzone }),
  s({ trig = "&", snippetType = "autosnippet" }, {
    t "&=",
  }, { condition = in_mathzone }),
  s({ trig = "isec", snippetType = "autosnippet" }, {
    t "\\cap",
  }, { condition = in_mathzone }),
  s({ trig = "uni", snippetType = "autosnippet" }, {
    t "\\cup",
  }, { condition = in_mathzone }),
  s({ trig = "noti", snippetType = "autosnippet" }, {
    t "\\notin",
  }, { condition = in_mathzone }),
  s({ trig = "ev", snippetType = "autosnippet" }, {
    t "\\mathbb{E}[X]",
  }, { condition = in_mathzone }),
  s({ trig = "cup", snippetType = "autosnippet" }, {
    t "\\cup",
  }, { condition = in_mathzone }),
  s({ trig = "cap", snippetType = "autosnippet" }, {
    t "\\cap",
  }, { condition = in_mathzone }),
  s({ trig = "|", snippetType = "autosnippet" }, {
    t "\\mid",
  }, { condition = in_mathzone }),
  s({ trig = "emp", snippetType = "autosnippet" }, {
    t "\\emptyset",
  }, { condition = in_mathzone }),

  s({ trig = "nsub", snippetType = "autosnippet" }, {
    t "\\nsubseteq",
  }, { condition = in_mathzone }),
  s(
    { trig = "id", snippetType = "autosnippet" },
    fmta("<> \\perp\\!\\!\\!\\perp <>", {
      i(1, "A"),
      i(2, "B"),
    })
  ),
  s({ trig = "var", snippetType = "autosnippet" }, {
    t "\\text{Var}(X)",
  }, { condition = in_mathzone }),
  s({ trig = "dev", snippetType = "autosnippet" }, {
    t "\\sigma_X",
  }, { condition = in_mathzone }),
  s({ trig = "cov", snippetType = "autosnippet" }, {
    t "\\text{Cov}(X, Y)",
  }, { condition = in_mathzone }),
  s({ trig = "corr", snippetType = "autosnippet" }, {
    t "\\rho_{X,Y}",
  }, { condition = in_mathzone }),
  s({ trig = "qu", dscr = "expands quad to \\quad which gives space" }, {
    t "\\quad",
  }),
  s(
    { trig = "squa", dscr = "expands 'squad' to delimitting \\quad" },
    fmta("\\quad<>\\quad", { d(1, get_visual) }, { condition = in_mathzone })
  ),
  s({ trig = ";z", snippetType = "autosnippet" }, {
    t "\\zeta",
  }),
  s({ trig = ";O", snippetType = "autosnippet" }, {
    t "\\Omega",
  }),
  s({ trig = "<=", snippetType = "autosnippet" }, {
    t "\\leq",
  }, { condition = in_mathzone }),
  s({ trig = ">=", snippetType = "autosnippet" }, {
    t "\\geq",
  }, { condition = in_mathzone }),
  s({ trig = "for", snippetType = "autosnippet" }, {
    t "\\text{for}",
  }, { condition = in_mathzone }),
  s(
    { trig = "[^%a]{", snippetType = "autosnippet", dscr = "Allows braces in mathzones" },
    fmta("<>\\{<>\\", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }, {
      condition = in_mathzone,
    })
  ),
  s({ trig = "fbox", dscr = "Expands 'box' into '\\boxed{}'" }, fmta("\\fbox{<>}", { d(1, get_visual) })),
  s({ trig = "box", dscr = "Expands 'box' into '\\boxed{}'" }, fmta("\\Aboxed{<>}", { d(1, get_visual) })),
  s({ trig = "emp", dscr = "Expands 'emp' into '\\emph{}'" }, fmta("\\emph{<>}", { d(1, get_visual) })),
  s({ trig = "tt", dscr = "Expands 'tt' into '\\texttt{}'" }, fmta("\\texttt{<>}", { d(1, get_visual) })),
  s({ trig = "text", dscr = "Expands 'text' into '\\text{}'" }, fmta("\\text{<>}", { d(1, get_visual) })),
  s(
    { trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
    fmta("\\textit{<>}", { d(1, get_visual) })
  ),
  s({ trig = "b", dscr = "Expands 'b' into '\\textbf{}'" }, fmta("\\textbf{<>}", { d(1, get_visual) })),
  s({ trig = "mm", dscr = "Expands 'mm' into '$$'" }, fmta("$ <> $", { d(1, get_visual) })),
  s({ trig = "=>", snippetType = "autosnippet" }, t "\\Rightarrow"),
  s({ trig = "->", snippetType = "autosnippet", dscr = "\\to is a righthand arrow" }, t "\\rightarrow"),
  s({ trig = "def", dscr = "expands 'def' to delta over equals" }, t "\\triangleq"),
  s(
    { trig = "l{", snippetType = "autosnippet" },
    fmta("\\left\\{ <> \\right\\", { i(1) }, { condition = in_mathzone })
  ),
  s({ trig = "l(", snippetType = "autosnippet" }, fmta("\\left( <> \\right", { i(1) }, { condition = in_mathzone })),
  s({ trig = "l[", snippetType = "autosnippet" }, fmta("\\left[ <> \\right", { i(1) }, { condition = in_mathzone })),
  s(
    { trig = "l[]", dscr = "Expands 'lan' to surround with angles." },
    fmta("\\left[ <> \\right", { i(1) }, { condition = in_mathzone })
  ),
  s(
    { trig = "lef", dscr = "Expands 'lan' to surround with angles." },
    fmta("\\left <> \\right", { i(1) }, { condition = in_mathzone })
  ),
  s(
    { trig = "lan", dscr = "Expands 'lan' to surround with angles." },
    fmta("\\langle <> \\rangle", { i(1) }, { condition = in_mathzone })
  ),
  s({ trig = "ff", dscr = "Expands 'ff' into '\\frac{}{}'" }, fmta("\\frac{<>}{<>}", { i(1), i(2) })),
  s(
    { trig = "([^%a])mm", snippetType = "autosnippet", regTrig = true, wordTrig = false },
    fmta([[<>$ <> $]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    })
  ),
  s(
    { trig = "([^%a])ff", snippetType = "autosnippet", regTrig = true, wordTrig = false },
    fmta([[<>\frac{<>}{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "([^%a])inf", dscr = "Expands 'inf' to \\infty" },
    fmta([[<>\infty]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { condition = in_mathzone })
  ),
  s(
    { trig = "pmartix", dscr = "Expands 'pmartix' into pmatrix enviorment" },

    fmta(
      [[
        \begin{pmatrix}
          <>
        \end{pmatrix}
      ]],
      { i(1) }
    )
  ),
  s(
    { trig = "eq", dscr = "Expands 'eq' into equation enviorment" },

    fmta(
      [[
        \begin{equation*}
          <>
        \end{equation*}
      ]],
      { i(1) }
    )
  ),
  s(
    { trig = "sb", dscr = "Expands 'sb' into subsection commmand" },
    fmta(
      [[
        \subsection{<>}
      ]],
      { i(1) }
    )
  ),
  s(
    { trig = "sbsb", dscr = "Expands 'sbsb' into subsubsection commmand" },
    fmta(
      [[
        \subsubsection{<>}
      ]],
      { i(1) }
    )
  ),
  s(
    { trig = "sbsbsb", dscr = "Expands 'sbsbsb' into subsubsection commmand" },
    fmta(
      [[
        \subsubsubsection{<>}
      ]],
      { i(1) }
    )
  ),
  s(
    { trig = "aa", dscr = "Expands 'aa' into aligned equation enviorment" },

    fmta(
      [[
        \begin{align*}
          <>
        \end{align*}
      ]],
      { i(1) }
    )
  ),
  s(
    { trig = "pdf", dscr = "Expands 'pdf' into aligned equation enviorment with pdf template" },

    fmta(
      [[
      \begin{align*}
        f_{X}\left(x\right) &= 
        \begin{cases}
        <>
        \end{cases}
      \end{align*}
      ]],
      { i(1) },
      { condition = in_mathzone }
    )
  ),
  s(
    { trig = "pmf", dscr = "Expands 'pmf' into aligned equation enviorment with pmf template" },

    fmta(
      [[
      \begin{align*}
        P \left( <> = <> \right) &= 
        \begin{cases}
        \end{cases}
      \end{align*}
      ]],
      { i(1), i(2) },
      { condition = in_mathzone }
    )
  ),
  -- s({trig = '([%a%)%]%}])00', snippetType="autosnippet", triggerType = "lua"},
  --   fmta(
  --     "<>_{<>}",
  --     {
  --       f( function(_, snip) return snip.captures[1] end ),
  --       t("0")
  --     }
  --   )
  -- ),
  s(
    { trig = "df", snippetType = "autosnippet" },
    fmta("<>\\diff{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "x"),
    }, { condition = in_mathzone })
  ),
  s(
    { trig = "bca", snippetType = "autosnippet" },
    fmta("<>\\bigcap_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "x"),
      i(2, "\\infty"),
    }, { condition = in_mathzone })
  ),
  s(
    { trig = "bcu", snippetType = "autosnippet" },
    fmta("<>\\bigcup_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "x"),
      i(2, "\\infty"),
    }, { condition = in_mathzone })
  ),
  s(
    { trig = "bigcap", dscr = "expands 'bigcap' to \\bigcap_{<> \\to <>}" },
    fmta("<>\\bigcap_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "x"),
      i(2, "\\infty"),
    })
  ),
  s(
    { trig = "bigcup", dscr = "expands 'bigcup' to \\bigcup_{<> \\to <>}" },
    fmta("<>\\bigcup_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "x"),
      i(2, "\\infty"),
    })
  ),
  s(
    { trig = "ll", snippetType = "autosnippet" },
    fmta("<>\\lim_{<> \\to <>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "x"),
      i(2, "\\infty"),
    })
  ),
  s(
    { trig = "([%w])%^(%w*)", regTrig = true, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        -- Return the base (number, letter, or combination) before the caret
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "[%w*]^", regTrig = true, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        -- Return the full sequence (digits + letter) before the caret
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%d*[%a])_", regTrig = true, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        -- Return the full sequence (digits + letter) before the underscore
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "int", triggerType = "lua" },
    fmta("<>\\int_{<>}^{<>}<>\\, dx", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "x"),
      i(2, "\\infty"),
      i(3),
    }, { condition = in_mathzone })
  ),
  s(
    { trig = "b|", triggerType = "lua" },
    fmta("<>\\bigg|_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }, { condition = in_mathzone })
  ),
  s(
    { trig = "sum", triggerType = "lua" },
    fmta("<>\\sum_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1, "x"),
      i(2, "\\infty"),
    }, { condition = in_mathzone })
  ),
}
