-- json import
local jfile = io.open("scenes/scenes.json", 'r')
assert(jfile, "Couldn't open scene file")
local content = jfile:read("*all")
jfile:close()

-- scenes load
local m_scenesKey = libs.json.decode(content)
local m_scenesBasePath = "scenes."
local scenes = {}

for k, v in pairs(m_scenesKey) do
	scenes[k] = require(m_scenesBasePath .. k)
	scenes[v] = scenes[k]
	print('[Scenes] -> ' .. k .. " Scene is required.")
end

return scenes
