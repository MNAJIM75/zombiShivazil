print("[Gundam] start executing.")
local classic = require'libs.classic'

local ent = {
	init = function() print("init entity") end,
	update = function() print("update entity") end,
	draw = function() print("draw entity") end,
}

local bindings = {
	initwindow = function(...) rl.InitWindow(...) end,
	windowshouldclose = function() return rl.WindowShouldClose() end,
	windowclose = function() rl.CloseWindow() end
}

local _graphics = {}
setmetatable(_graphics, {__index = bindings})

local queue = classic:extend()
function queue:new()
	self.list = {}
end

local q1 = {}
function q1:push(_item)
	table.insert(self, _item)
end
function q1:pop()
	local _return = self[1]
	assert(_return, "Error: Nothing to serve.")
	table.remove(self, 1)
	return _return
end

q1:push("Gundam")
q1:push("Is")
q1:push("Awesome")

print(q1:pop())
print(q1:pop())
print(q1:pop())
print(q1:pop())