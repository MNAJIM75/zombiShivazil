local enemy = types.entity:extend()

function enemy:new(_posx, _posy, _character, _index)
	enemy.super.new(self, _posx, _posy)
	self.index = _index
	
	self.character = _character
	self:settype("enemy")
	self:setsprite("enemy", self.character)
	
	-- for phy implementation
	self.radius = 20
	self.drag = 13
	
	self.speed = const.enemy_maxspeed
	self.aim = libs.vector(0, 0)
	self.aimLength = 200
	self.lookat = libs.vector(1, 0)
	world:addbody(self)
end

function enemy:updateaim()
	self.aim.x = herox - self.position.x
	self.aim.y = heroy - self.position.y
	self.lookat.x = self.aim.x
	self.lookat.y = self.aim.y
	self.lookat:norm()
	self.headangle = -self.lookat:heading() * rad2deg
end

function enemy:update(_dt)
	self:updateaim()
	self.velocity.x = self.lookat.x * self.speed
	self.velocity.y = self.lookat.y * self.speed
	self:updatesprite()
end

function enemy:draw()
	graphics.drawsprite(self.sprite, self.spriteconf.rectsource, self.spriteconf.rectdest, self.spriteconf.origin, self.headangle, graphics.colors.white)
end

return enemy