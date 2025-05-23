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

return {
  s(
    { trig = "test", dscr = "UVM test class template" },
    fmta(
      [[

class <> extends uvm_test;
  `uvm_component_utils(<>);
  <>
  function new(string name = "<>", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  
endclass : <> 
      ]],
      {
        i(1),
        rep(1),
        i(0),
        rep(1), -- this node repeats insert node i(1)
        rep(1),
      }
    )
  ),
  s(
    { trig = "object", dscr = "UVM object class template" },
    fmta(
      [[

class <> extends uvm_object;
  `uvm_object_utils(<>);
  <>
  function new(string name = "<>");
    super.new(name);
  endfunction : new 

  
endclass : <> 
      ]],
      {
        i(1),
        rep(1),
        i(0),
        rep(1), -- this node repeats insert node i(1)
        rep(1),
      }
    )
  ),
  s(
    { trig = "sb", dscr = "UVM scoreboard class template" },
    fmta(
      [[

class <> extends uvm_scoreboard;
  `uvm_component_utils(<>);
  <>
  function new(string name = "<>", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  
endclass : <>
      ]],
      {
        i(1),
        rep(1),
        i(0),
        rep(1), -- this node repeats insert node i(1)
        rep(1),
      }
    )
  ),
  s(
    { trig = "ffa", dscr = "always_ff with async reset" },
    fmta(
      [[
      always_ff @(posedge clk or posedge rst) begin 
        if(rst) begin 
          <>
        end
        else begin
          <>
        end
      end
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    { trig = "comb", dscr = "combinational block" },
    fmta(
      [[
        always_comb begin 
          <>
        end
      ]],
      {
        i(1),
      }
    )
  ),
}
