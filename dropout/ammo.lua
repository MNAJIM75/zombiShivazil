local ammo = entities.dropout:extend()

function ammo:new(_x, _y)
	ammo.super.new(self, _x, _y, "Ammo")
end

function ammo:draw()
	self:drawsprite(0)
end

return ammo