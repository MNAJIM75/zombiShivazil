local ent = phy.circle:extend()

function ent:new(_posx, _posy, _name)
	ent.super.new(self, _posx, _posy, 0, 0, 0, 0, phy.getid())
	self.name = _name or "Entity"
	self.enable = true
end

function ent:update(_dt) end
function ent:draw() end

return ent