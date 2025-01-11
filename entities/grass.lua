local grass = types.entity:extend()

function grass:new(_posx, _posy)
	grass.super.new(self, _posx, _posy, "grass"..tostring(_posx*_posy))
	self.static = true
	self.nobody = true
	self:setsprite('land', 'grass')
end

function grass:draw()
	graphics.drawsprite(self.sprite, self.spriteconf.rectsource, self.spriteconf.rectdest, self.spriteconf.origin, self.headangle, graphics.gettint(self.position.x, self.position.y))
	self:drawhealthbar()
end


return grass