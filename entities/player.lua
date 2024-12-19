local player = types.entity:extend()

player.characters = {
	SOHIB = "sohib",
	TAMER = "tamer"
}

function player:new(_character)
	player.super.new(self, 0, 0, _character .. "_entity")
	self.character = _character

	self.sprite = res:getSprite("player", self.character)
	self.spritescale = 5
	self.spriteconf = {
		rectsource = graphics.objects.rectangle(0, 0, self.sprite.width, self.sprite.height),
		rectdest = graphics.objects.rectangle(0, 0, self.sprite.width/self.spritescale, self.sprite.height/self.spritescale),
		origin = graphics.objects.vector(self.sprite.width / self.spritescale*2, self.sprite.height / self.spritescale*2),
	}

	self.speed = 100
	self.aim = libs.vector(0, 0)
	self.aimLength = 2000
	self.lookat = libs.vector(1, 0)
end

function player:setscale(_scale)
	self.spritescale = _scale
	self.spriteconf.rectsource = graphics.objects.rectangle(0, 0, self.sprite.width, self.sprite.height)
	self.spriteconf.rectdest = graphics.objects.rectangle(0, 0, self.sprite.width/self.spritescale, self.sprite.height/self.spritescale)
	self.spriteconf.origin = graphics.objects.vector(self.sprite.width / self.spritescale*2, self.sprite.height / self.spritescale*2)
end

function player:updatePosition(_dt)
	local _rawVelocity = input:getAction("move"):norm()
	self.position.x = self.position.x + _dt * _rawVelocity.x * self.speed
	self.position.y = self.position.y + _dt * _rawVelocity.y * self.speed
	self.spriteconf.rectdest.x = self.position.x
	self.spriteconf.rectdest.y = self.position.y
end

function player:updateAim(_dt)
	local _rawAim = input:getAction("aim")
	if _rawAim:getmag() > input.threshold.right then 
		self.lookat = _rawAim:norm():clone()
	end
	self.aim.x = self.position.x + self.lookat.x * self.aimLength
	self.aim.y = self.position.y + self.lookat.y * self.aimLength
end

function player:update(_dt)
	self:updatePosition(_dt)
	self:updateAim(_dt)
end

function player:draw()
	--graphics.beginmode2d(smgr.camera)
	
	graphics.drawcircle(self.position.x, self.position.y, 30, RED)
	graphics.drawsprite(self.sprite, self.spriteconf.rectsource, self.spriteconf.rectdest, self.spriteconf.origin, 0, graphics.colors.white)
	graphics.drawline(self.position.x, self.position.y, self.aim.x, self.aim.y, GREEN)
	graphics.endmode2d()
end

return player