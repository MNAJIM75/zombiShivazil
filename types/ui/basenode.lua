local uie = libs.classic:extend()

function uie:new(_canvas, _x, _y, _type)
	self.position = libs.vector(_x, _y)
	self.type = _type or "UI Element"
	self.canvas = _canvas
end

function uie:update(_dt)

end

function uie:draw()

end

return uie