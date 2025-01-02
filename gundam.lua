print("[Gundam] start executing.")

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
setmetatable(_graphics, {__index = bindings })

print(_graphics.initwindow)