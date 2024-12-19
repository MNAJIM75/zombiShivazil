local ent = libs.classic:extend()

function ent:new(_posx, _posy, _name)
	self.position = libs.vector(_posx or 0, _posy or 0)
	self.name = _name or "Entity"
	self.enable = true
end

function ent:update(_dt) end
function ent:draw() end

return ent