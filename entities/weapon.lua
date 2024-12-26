local weapon = types.entity:extend()

function weapon:new(_x, _y, _weaponname)
	weapon.super.new(self, _x, _y, "weapon_" .. _weaponname)
	self:settype("weapon")
	self:setsprite("weapon", _weaponname)
	self.free = true

	self.radius = self.sprite.width
	self.player = nil

	-- nobody
	self.nobody = true -- no collision resolving
	world:addbody(self)

	self.offsetlength = 16
	self.headangle = 0
end

function weapon:sethook(_player)	
	if _player then
		self.free = false
		self.player = _player
		self.skiploop = true
	else
		self.free = true
		self.player = nil
		self.skiploop = false
	end
	print(self.player.position)
end
function weapon:gethook() return not self.free end

function weapon:update(_dt)
	if self:gethook() then -- hook
		self.position.x = self.player.position.x + self.player.lookat.x * self.offsetlength
		self.position.y = self.player.position.y + self.player.lookat.y * self.offsetlength
		self.headangle = self.player.headangle
		self:updatesprite()
	end
end

function weapon:collide(_body)
	--print("[Weapon] collided with " .. _body.id)
end

function weapon:draw()
	if self.free then
		graphics.drawsprite(self.sprite, self.spriteconf.rectsource, self.spriteconf.rectdest, self.spriteconf.origin, 0, graphics.colors.white)
		graphics.drawcircle(self.position.x, self.position.y, self.spriteconf.rectsource.width, graphics.colors.red, true)
	else
		graphics.drawline(self.position.x, self.position.y, self.player.aim.x, self.player.aim.y, graphics.colors.red)
		graphics.drawsprite(self.sprite, self.spriteconf.rectsource, self.spriteconf.rectdest, self.spriteconf.origin, self.headangle, graphics.colors.white)
	end
end

return weapon