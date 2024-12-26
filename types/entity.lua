local ent = phy.circle:extend()

function ent:new(_posx, _posy, _name)
	ent.super.new(self, _posx, _posy, 0, 0, 0, 0, 10, phy.getid())
	self.name = _name or "Entity"
	self._type = 'object'
	self.enable = true
	print(self.id)
end

function ent:settype(_type) self._type = _type end
function ent:gettype() return self._type end

function ent:setsprite(_spritetype, _spritename, _scale)
	self.sprite = res:getsprite(_spritetype, _spritename)
	self.spritescale = _scale or 1
	self.spriteconf = {
		rectsource = graphics.objects.rectangle(0, 0, self.sprite.width, self.sprite.height),
		rectdest = graphics.objects.rectangle(self.position.x, self.position.y, self.sprite.width/self.spritescale, self.sprite.height/self.spritescale),
		--origin = graphics.objects.vector(-self.sprite.width / self.spritescale*2, -self.sprite.height / self.spritescale*2),
		origin = graphics.objects.vector(16, 16),
	}
end

function ent:updatesprite()
	self.spriteconf.rectdest.x = self.position.x
	self.spriteconf.rectdest.y = self.position.y
end

function ent:setenable(_value) self.enable = _value end

--function ent:update(_dt) end
--function ent:draw() end

return ent