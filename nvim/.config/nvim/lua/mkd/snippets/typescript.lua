local session = require "luasnip.session"

local env = session.config.snip_env
local s = env["s"]
local t = env["t"]
local i = env["i"]
local parse = env["parse"]

return {
  s({ trig = "try", name = "try-catch", dscr = "Insert a basic try-catch statement" }, {
    t { "try {", "\t" },
    i(1, "what"),
    t { "", "} catch (e) {", "}" },
  }),
}
