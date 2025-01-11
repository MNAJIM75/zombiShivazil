local player = types.entity:extend()

player.characters = {
	SOHIB = "sohib",
	TAMER = "tamer"
}

function player:new(_character)
	player.super.new(self, 0, 0, _character .. "_entity")
	self.character = _character
	self:settype("player")
	
	-- for phy implementation
	self.radius = 20
	self.drag = 13

	self:setsprite("player", self.character)
	
	self.speed = const.player_maxspeed
	self.aim = libs.vector(0, 0)
	self.aimLength = 200
	self.lookat = libs.vector(1, 0)
	world:addbody(self)

	-- weapon
	self.weapon = nil
end

function player:setscale(_scale)
	self.spritescale = _scale
	self.spriteconf.rectsource = graphics.objects.rectangle(0, 0, self.sprite.width, self.sprite.height)
	self.spriteconf.rectdest = graphics.objects.rectangle(0, 0, self.sprite.width/self.spritescale, self.sprite.height/self.spritescale)
	self.spriteconf.origin = graphics.objects.vector(self.sprite.width / self.spritescale*2, self.sprite.height / self.spritescale*2)
end

function player:updatePosition(_dt)
	local _rawVelocity = input:getactionvalue("move"):norm()
	if _rawVelocity:magSq() > 0 then
		self.velocity:set(_rawVelocity.x * self.speed, _rawVelocity.y * self.speed)
		--psys.dust:emit(self.position.x, self.position.y)
	end
	--player.super.update(self, _dt)
	--self.position.x = self.position.x + _dt * _rawVelocity.x * self.speed
	--self.position.y = self.position.y + _dt * _rawVelocity.y * self.speed
	herox = self.position.x
	heroy = self.position.y
	self:updatesprite()
end

function player:updateAim(_dt)
	local _rawAim = input:getactionvalue("aim")
	if _rawAim:getmag() > input.threshold.right then 
		self.lookat = _rawAim:norm():clone()
	end
	self.aim.x = self.position.x + self.lookat.x * self.aimLength
	self.aim.y = self.position.y + self.lookat.y * self.aimLength
	self.headangle = -self.lookat:heading() * rad2deg
end

function player:collide(_body)
	if _body:gettype() == 'weapon' and input:getactionvaluepressed("grab") then
		if self.weapon then --[[
			local _groundposition = _body.position:clone()
			local __body = self.weapon
			self.weapon:sethook(nil)
			__body.position = _groundposition
			self.weapon = _body
			self.weapon:sethook(self)
			]]
		else
			self.weapon = _body
			self.weapon:sethook(self)
		end
	end
end


function player:update(_dt)
	self:updatePosition(_dt)
	self:updateAim(_dt)
	smgr:setCameraPosition(self.position.x, self.position.y, self.lookat.x * 100, self.lookat.y * 100)
end

-- evt <- input
function player:fire(_b)
	
end

function player:draw()
	--graphics.beginmode2d(smgr.camera)
	--graphics.drawcircle(self.position.x, self.position.y, 20, RED)
	--graphics.drawline(self.position.x, self.position.y, self.aim.x, self.aim.y, GREEN)

	graphics.drawsprite(self.sprite, self.spriteconf.rectsource, self.spriteconf.rectdest, self.spriteconf.origin, self.headangle, graphics.gettint(herox, heroy))
	--graphics.print(tostring(self.headangle), self.position.x - 100, self.position.y - 100)
	--graphics.endmode2d()
end

return player