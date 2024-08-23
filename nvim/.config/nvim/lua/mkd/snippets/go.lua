local session = require "luasnip.session"

local env = session.config.snip_env
local s = env["s"]
local t = env["t"]
local i = env["i"]
local parse = env["parse"]

return {
  s({ trig = "pf", name = "Formatted Print", dscr = "Insert a formatted print statement" }, {
    t 'fmt.Printf("%#v\\n", ',
    i(1, "value"),
    t ")",
  }),

  parse(
    { trig = "ife", name = "If Err", dscr = "Insert a basic if err not nil statement" },
    [[
  if err != nil {
    return err
  }
  ]]
  ),

  parse(
    { trig = "ifel", name = "If Err Log Fatal", dscr = "Insert a basic if err not nil statement with log.Fatal" },
    [[
  if err != nil {
    log.Fatal(err)
  }
  ]]
  ),

  s({ trig = "ifew", name = "If Err Wrapped", dscr = "Insert a if err not nil statement with wrapped error" }, {
    t "if err != nil {",
    t { "", '  return fmt.Errorf("failed to ' },
    i(1, "message"),
    t ': %w", err)',
    t { "", "}" },
  }),
}
