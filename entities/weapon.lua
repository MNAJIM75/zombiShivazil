local weapon = types.entity:extend()
local timetoround = 0.1279317697228145

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
	self.bulletlength = 16
	self.headangle = 0

	-- weapon properties
	self.firecooldown = timetoround
	self.firetimer = 10
	self.mag = 20
	self.storage = 100

	--eventsystem:subscripe("buttonpressed", self)
	eventsystem:subscripe("buttonreleased", self)
end

function weapon:sethook(_player)	
	if _player then
		self.free = false
		self.player = _player
		self.skiploop = true
		audio:play("grab")
	else
		self.free = true
		self.player = nil
		self.skiploop = false
	end
end
function weapon:gethook() return not self.free end

function weapon:shoot()
	local _startpos = self.position + self.player.lookat * self.bulletlength
	local bullet = entities.bullet(_startpos.x, _startpos.y, self.player.lookat)
	world:addbody(bullet)
	audio:play("shoot")
	camera:shake(1, 1, 10)
	psys:emit(_startpos.x, _startpos.y)
end

function weapon:buttonreleased( _button )
	--print("[Weapon] " .. _button)
	if "right_shoulder" == _button then self.firetimer = 10 end
end


function weapon:updateshoot( _dt )
	if input:getactionvalue('fire') then
		if self.firetimer > self.firecooldown and self.mag > 0 then
			self:shoot()
			self.firetimer = 0
			self.mag = self.mag - 1
		end
		self.firetimer = self.firetimer + _dt
	end
end

function weapon:update(_dt)
	if self:gethook() then -- hook
		self.position.x = self.player.position.x + self.player.lookat.x * self.offsetlength
		self.position.y = self.player.position.y + self.player.lookat.y * self.offsetlength
		self.headangle = self.player.headangle
		self:updatesprite()

		self:updateshoot(_dt)
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