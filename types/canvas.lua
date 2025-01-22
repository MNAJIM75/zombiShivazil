local canvas = libs.classic:extend()

function canvas:new()
	self.elements = {} -- ui elements
end

function canvas:adduielement(_uie)
	table.insert(self.elements, _uie)
end

function canvas:update(_uie, _dt)
	_uie:update(_dt)
end

function canvas:draw(_uie)
	_uie:draw()
end

function canvas:render(_dt)
	for _i, _uie in pairs(self.elements) do
		self:update(_uie, _dt)
		self:draw(_uie)
	end
end

function canvas:add(_type )
	
end

return canvas