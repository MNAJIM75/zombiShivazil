local drop = types.entity:extend()

function drop:new(_x, _y, _droptype)
	drop.super.new(self, _x, _y, "Dropout_" .. _droptype)
	self:settype("Dropout")
	self:setsprite("dropout", _droptype)

	self.radius = self.sprite.width

	-- nobody
	self.nobody = true
	world:addbody(self)
end

function drop:update(_dt)

end

function drop:draw()

end

return drop