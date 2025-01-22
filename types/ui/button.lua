--[[
local button = types.ui.basenode:extend()

function button:new(_canvas, _x, _y, _text)
	button.super.new(self, _canvas, _x, _y, "UI Button")
end

function button:update(_dt)

end

function button:draw()
	
end

return button
]]