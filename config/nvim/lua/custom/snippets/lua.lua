-- Example custom snippet(s), loaded by the `loadfile` loop in lua/custom/snippets.lua.
-- Add more filetype-named files here (e.g. go.lua, rust.lua) for personal snippets.
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("lua", {
	s("req", {
		t('require("'),
		i(1),
		t('")'),
	}),
})
